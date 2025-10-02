#!/usr/bin/env bash
# Start the MCP server using the project's virtualenv Python (foreground)
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
VENV_PY="$ROOT_DIR/.venv/bin/python"
if [[ ! -x "$VENV_PY" ]]; then
  echo "Virtualenv python not found or not executable at $VENV_PY"
  echo "Activate your venv or run: python $ROOT_DIR/main.py"
  exit 1
fi
exec "$VENV_PY" "$ROOT_DIR/main.py"
