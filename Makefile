.PHONY: help run run-bg test shell clean

VENV := .venv
PY := $(VENV)/bin/python
SCRIPTS := scripts

help:
	@echo "Makefile targets:"
	@echo "  make run       - run the server in foreground using $(PY)"
	@echo "  make run-bg    - run the server in background (logs -> mcp.log)"
	@echo "  make test      - run pytest using the venv-first PATH"
	@echo "  make shell     - open a shell with venv on PATH"
	@echo "  make clean     - remove mcp.log"

run:
	@if [ ! -x "$(PY)" ]; then \
		echo "Virtualenv python not found at $(PY). Activate your venv or run scripts/run-server.sh"; exit 1; \
	fi
	$(PY) main.py

run-bg:
	@if [ ! -x "$(PY)" ]; then \
		echo "Virtualenv python not found at $(PY)."; exit 1; \
	fi
	nohup $(PY) main.py > mcp.log 2>&1 &
	@echo "Server started (logs -> mcp.log)"

test:
	export PATH="$(VENV)/bin:$$PATH" && python -m pytest -q

shell:
	@echo "Launching a subshell with $(VENV)/bin first on PATH. Exit to return."
	PATH="$(VENV)/bin:$$PATH" bash --rcfile <(echo 'PS1="(venv-shell) $$PS1"')

clean:
	@rm -f mcp.log
