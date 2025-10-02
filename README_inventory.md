# Inventory helper and MCP tools

This adds:

- `inventory.py` - helper functions to query and reserve stock.
- Two MCP tools added to `main.py`:
  - `reserve_item(sku: str, quantity: int)`
  - `fulfill_order(order_id: str)`
- `tests/test_inventory.py` - unit tests for the helper logic.

Usage

Run tests:

```bash
.venv/bin/python -m pytest tests/test_inventory.py -q
```

Call via VS Code MCP client once server is running (stdio spawn):
- `reserve_item` with arguments `sku` and `quantity`
- `fulfill_order` with argument `order_id`
