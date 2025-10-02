#!/usr/bin/env bash
# Run tests using the project's virtualenv (ensures spawned "python" resolves to venv)
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$ROOT_DIR/.venv/bin:$PATH"
cd "$ROOT_DIR"
python -m pytest -q "$@"
