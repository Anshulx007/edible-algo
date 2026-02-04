#!/usr/bin/env python3
"""
RecipeAI Full Deployment Script
Handles: Backend restart -> Tunnel setup -> Frontend build -> Netlify deploy
"""

from __future__ import annotations

import logging
import os
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path


# ----------------------------
# Paths
# ----------------------------
ROOT_DIR = Path(__file__).resolve().parent
TOOLS_DIR = ROOT_DIR / "recipeai" / "tools"
FRONTEND_DIR = ROOT_DIR / "recipeai" / "frontend"
FRONTEND_ENV = FRONTEND_DIR / ".env.local"
FRONTEND_DIST = FRONTEND_DIR / "dist"
LOG_DIR = TOOLS_DIR / "logs"
LOG_FILE = LOG_DIR / "full_deploy.log"
TUNNEL_LOG = LOG_DIR / "tunnel.log"
URL_FILE = TOOLS_DIR / "cloudflare_url.txt"

LOG_DIR.mkdir(parents=True, exist_ok=True)

# ----------------------------
# Logging setup
# ----------------------------
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler(LOG_FILE, mode="a"),
    ],
)

logger = logging.getLogger("recipeai-deploy")

# ----------------------------
# Regex
# ----------------------------
URL_REGEX = re.compile(r"https://[-a-zA-Z0-9.]+\.trycloudflare\.com")


# ----------------------------
# Step 1: Restart Backend
# ----------------------------
def restart_backend() -> bool:
    logger.info("=" * 60)
    logger.info("STEP 1: Restarting Backend")
    logger.info("=" * 60)

    logger.info("Stopping existing backend...")
    subprocess.run(
        ["pkill", "-f", "uvicorn recipeai.api.main:app"],
        check=False,
    )
    time.sleep(1)

    python = ROOT_DIR / ".venv" / "bin" / "python"
    if not python.exists():
        logger.error("Python venv not found at %s", python)
        return False

    logger.info("Starting backend on port 8080...")
    subprocess.Popen(
        [
            str(python),
            "-m",
            "uvicorn",
            "recipeai.api.main:app",
            "--host",
            "0.0.0.0",
            "--port",
            "8080",
        ],
        cwd=str(ROOT_DIR),
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        start_new_session=True,
        env={**os.environ, "PYTHONPATH": str(ROOT_DIR)},
    )

    time.sleep(3)
    logger.info("Backend started")
    return True


# ----------------------------
# Step 2: Start Cloudflare Tunnel
# ----------------------------
def start_tunnel() -> str | None:
    logger.info("=" * 60)
    logger.info("STEP 2: Starting Cloudflare Tunnel")
    logger.info("=" * 60)

    logger.info("Checking for existing tunnel...")
    cloudflared = shutil.which("cloudflared")
    if not cloudflared:
        local_bin = TOOLS_DIR / "bin" / "cloudflared"
        if local_bin.exists():
            cloudflared = str(local_bin)
        else:
            logger.error(
                "cloudflared not found. Install with:\n"
                "  mkdir -p /workspaces/edible-algo/recipeai/tools/bin\n"
                "  curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/"
                "cloudflared-linux-amd64 -o /workspaces/edible-algo/recipeai/tools/bin/cloudflared\n"
                "  chmod +x /workspaces/edible-algo/recipeai/tools/bin/cloudflared"
            )
            return None

    subprocess.run(
        ["pkill", "-f", "cloudflared tunnel --url"],
        check=False,
    )
    time.sleep(2)

    logger.info("Starting tunnel...")
    with open(TUNNEL_LOG, "w") as log_file:
        subprocess.Popen(
            [cloudflared, "tunnel", "--url", "http://localhost:8080"],
            stdout=log_file,
            stderr=subprocess.STDOUT,
            start_new_session=True,
        )

    logger.info("Waiting for tunnel to initialize...")
    time.sleep(6)

    if not TUNNEL_LOG.exists():
        logger.error("Tunnel log not found")
        return None

    content = TUNNEL_LOG.read_text()
    match = URL_REGEX.search(content)
    if not match:
        logger.error("Failed to get tunnel URL")
        return None

    url = match.group(0)
    logger.info("Tunnel URL: %s", url)
    URL_FILE.write_text(f"{url}\n", encoding="utf-8")
    return url


# ----------------------------
# Step 3: Update Frontend .env
# ----------------------------
def update_frontend_env(tunnel_url: str) -> bool:
    logger.info("=" * 60)
    logger.info("STEP 3: Updating Frontend .env.local")
    logger.info("=" * 60)

    lines: list[str] = []
    if FRONTEND_ENV.exists():
        lines = FRONTEND_ENV.read_text().splitlines(keepends=True)

    found = False
    for i, line in enumerate(lines):
        if line.startswith("VITE_API_BASE_URL="):
            lines[i] = f"VITE_API_BASE_URL={tunnel_url}\n"
            found = True
            break

    if not found:
        lines.append(f"VITE_API_BASE_URL={tunnel_url}\n")

    FRONTEND_ENV.write_text("".join(lines), encoding="utf-8")
    logger.info("Updated .env.local with tunnel URL")
    return True


# ----------------------------
# Step 4: Build Frontend
# ----------------------------
def build_frontend() -> bool:
    logger.info("=" * 60)
    logger.info("STEP 4: Building Frontend")
    logger.info("=" * 60)

    logger.info("Running npm build...")
    result = subprocess.run(
        ["npm", "run", "build"],
        cwd=str(FRONTEND_DIR),
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        logger.error("Build failed:\n%s", result.stderr)
        return False

    logger.info(result.stdout)
    logger.info("Frontend built successfully")
    if FRONTEND_DIST.exists():
        logger.info("Build output: %s", FRONTEND_DIST)
    return True


# ----------------------------
# Step 5: Deploy to Netlify
# ----------------------------
def deploy_netlify() -> bool:
    logger.info("=" * 60)
    logger.info("STEP 5: Deploying to Netlify")
    logger.info("=" * 60)

    logger.info("Deploying with Netlify CLI...")
    result = subprocess.run(
        ["npx", "netlify", "deploy", "--prod", "--dir", "dist"],
        cwd=str(FRONTEND_DIR),
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        logger.error("Netlify deploy failed:\n%s", result.stderr)
        return False

    logger.info(result.stdout)
    logger.info("Netlify deployment complete")
    return True


# ----------------------------
# Test Backend
# ----------------------------
def test_backend(tunnel_url: str) -> bool:
    logger.info("=" * 60)
    logger.info("STEP 6: Testing Backend")
    logger.info("=" * 60)

    logger.info("Testing health endpoint: %s/health", tunnel_url)

    try:
        result = subprocess.run(
            ["curl", "-s", f"{tunnel_url}/health"],
            capture_output=True,
            text=True,
            timeout=10,
        )

        if result.returncode == 0 and "healthy" in result.stdout:
            logger.info("Backend health check passed")
            return True
        logger.warning("Health check response: %s", result.stdout.strip())
        return False
    except Exception as exc:
        logger.warning("Health check failed: %s", exc)
        return False


# ----------------------------
# Main Flow
# ----------------------------
def main() -> int:
    logger.info("")
    logger.info("=" * 60)
    logger.info("RECIPEAI FULL DEPLOYMENT STARTED")
    logger.info("=" * 60)
    logger.info("")

    try:
        if not restart_backend():
            raise RuntimeError("Backend restart failed")

        tunnel_url = start_tunnel()
        if not tunnel_url:
            raise RuntimeError("Tunnel startup failed")

        if not update_frontend_env(tunnel_url):
            raise RuntimeError("Frontend .env update failed")

        if not build_frontend():
            raise RuntimeError("Frontend build failed")

        if not deploy_netlify():
            raise RuntimeError("Netlify deployment failed")

        test_backend(tunnel_url)

        logger.info("")
        logger.info("=" * 60)
        logger.info("DEPLOYMENT SUCCESSFUL")
        logger.info("=" * 60)
        logger.info("")

        logger.info("Deployment Summary:")
        logger.info("  Backend:    Running on localhost:8080")
        logger.info("  Tunnel:     %s", tunnel_url)
        logger.info("  Frontend:   Built at %s", FRONTEND_DIST)
        logger.info("  Logs:       %s", LOG_DIR)
        logger.info("")

        return 0

    except Exception as exc:
        logger.error("")
        logger.error("=" * 60)
        logger.error("DEPLOYMENT FAILED: %s", str(exc))
        logger.error("=" * 60)
        logger.error("")
        return 1


if __name__ == "__main__":
    sys.exit(main())
