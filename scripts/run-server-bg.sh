#!/usr/bin/env bash
# Start the MCP server in the background and redirect logs to mcp.log
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
VENV_PY="$ROOT_DIR/.venv/bin/python"
LOG_FILE="$ROOT_DIR/mcp.log"
if [[ ! -x "$VENV_PY" ]]; then
  echo "Virtualenv python not found or not executable at $VENV_PY"
  exit 1
fi
nohup "$VENV_PY" "$ROOT_DIR/main.py" > "$LOG_FILE" 2>&1 &
echo "Server started (logs -> $LOG_FILE)"
