from __future__ import annotations

import os
import shutil
import signal
import subprocess
import sys
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent
FRONTEND_DIR = REPO_ROOT / "recipeai" / "frontend"


def _ensure_cmd(cmd: str) -> str:
    path = shutil.which(cmd)
    if not path:
        raise SystemExit(f"Required command not found: {cmd}")
    return path


def main() -> int:
    npm = _ensure_cmd("npm")

    env = os.environ.copy()
    env["PYTHONPATH"] = str(REPO_ROOT)

    backend_cmd = [
        sys.executable,
        "-m",
        "uvicorn",
        "recipeai.api.main:app",
        "--reload",
        "--port",
        "8080",
    ]
    frontend_cmd = [npm, "run", "dev"]

    backend = subprocess.Popen(backend_cmd, env=env, cwd=str(REPO_ROOT))
    frontend = subprocess.Popen(frontend_cmd, cwd=str(FRONTEND_DIR))

    def _shutdown(_sig: int, _frame) -> None:
        for proc in (frontend, backend):
            if proc.poll() is None:
                proc.terminate()
        for proc in (frontend, backend):
            try:
                proc.wait(timeout=10)
            except subprocess.TimeoutExpired:
                proc.kill()
        raise SystemExit(0)

    signal.signal(signal.SIGINT, _shutdown)
    signal.signal(signal.SIGTERM, _shutdown)

    backend_rc = backend.wait()
    frontend_rc = frontend.wait()
    return backend_rc or frontend_rc


if __name__ == "__main__":
    raise SystemExit(main())
