# mcp-python (local test harness)

This repository contains a simple MCP server implementation for testing.

Helper scripts

- `scripts/run-server.sh` — run the server in the foreground using the project's `.venv` Python.
- `scripts/run-server-bg.sh` — start the server in the background and redirect logs to `mcp.log`.
- `scripts/run-tests.sh` — run pytest with the `.venv` first on PATH so subprocess `python` resolves to the venv Python.

Usage examples

Run server in foreground:

```bash
scripts/run-server.sh
```

Run server in background:

```bash
scripts/run-server-bg.sh
# check logs
tail -f mcp.log
```

Run tests:

```bash
scripts/run-tests.sh
# Or run a single test
scripts/run-tests.sh tests/test_server.py::test_mcp_server_connection -q
```
