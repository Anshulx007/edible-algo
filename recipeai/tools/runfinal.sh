#!/usr/bin/env bash
set -euo pipefail

TOOLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$TOOLS_DIR/../.." && pwd)"
FRONTEND_DIR="$REPO_ROOT/recipeai/frontend"
ENV_FILE="$FRONTEND_DIR/.env.local"
URL_FILE="$TOOLS_DIR/cloudflare_url.txt"

CLOUDFLARED="${CLOUDFLARED:-}"
if [[ -z "$CLOUDFLARED" ]]; then
  if command -v cloudflared >/dev/null 2>&1; then
    CLOUDFLARED="cloudflared"
  elif [[ -x "$TOOLS_DIR/bin/cloudflared" ]]; then
    CLOUDFLARED="$TOOLS_DIR/bin/cloudflared"
  else
    echo "Required command not found: cloudflared" >&2
    exit 1
  fi
fi

if ! command -v npx >/dev/null 2>&1; then
  echo "Required command not found: npx" >&2
  exit 1
fi

PYTHON="${PYTHON:-$REPO_ROOT/.venv/bin/python}"
if ! command -v "$PYTHON" >/dev/null 2>&1; then
  echo "Python not found at $PYTHON" >&2
  exit 1
fi

export PYTHONPATH="$REPO_ROOT"

echo "Starting backend on :8080..."
"$PYTHON" -m uvicorn recipeai.api.main:app --reload --port 8080 &
BACKEND_PID=$!

cleanup() {
  if [[ -n "${TUNNEL_PID:-}" ]]; then
    kill "$TUNNEL_PID" >/dev/null 2>&1 || true
  fi
  if [[ -n "${BACKEND_PID:-}" ]]; then
    kill "$BACKEND_PID" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT INT TERM

echo "Starting Cloudflare Tunnel..."
TUNNEL_LOG="$(mktemp)"
"$CLOUDFLARED" tunnel --url http://localhost:8080 >"$TUNNEL_LOG" 2>&1 &
TUNNEL_PID=$!

echo "Waiting for tunnel URL..."
for _ in {1..60}; do
  if grep -Eo 'https://[a-z0-9-]+\.trycloudflare\.com' "$TUNNEL_LOG" >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

TUNNEL_URL="$(grep -Eo 'https://[a-z0-9-]+\.trycloudflare\.com' "$TUNNEL_LOG" | head -n 1)"
if [[ -z "$TUNNEL_URL" ]]; then
  echo "Could not find Cloudflare Tunnel URL in output." >&2
  exit 1
fi

echo "Cloudflare Tunnel URL: $TUNNEL_URL"
echo "VITE_API_BASE_URL=$TUNNEL_URL" >"$ENV_FILE"
echo "$TUNNEL_URL" >"$URL_FILE"

echo "Building frontend..."
(cd "$FRONTEND_DIR" && npx npm install && npx npm run build)

echo "Deploying to Netlify (linked site)..."
(cd "$FRONTEND_DIR" && npx netlify deploy --prod --dir dist)

echo "Deploy complete. Backend + tunnel are running. Press Ctrl+C to stop."
wait "$BACKEND_PID"
