from typing import Dict
from transactional_db import PRODUCTS_TABLE


def get_stock(sku: str) -> int:
    """Return the current stock for a SKU (0 if unknown)."""
    product = PRODUCTS_TABLE.get(sku)
    return product.get("stock", 0) if product else 0


def reserve_stock(sku: str, quantity: int = 1) -> bool:
    """
    Attempt to reserve `quantity` units of `sku`.
    If there is sufficient stock, decrement and return True.
    If not, do nothing and return False.

    Note: This modifies in-memory PRODUCTS_TABLE. For a real DB replace
    this logic with an atomic update.
    """
    if quantity <= 0:
        return False
    product = PRODUCTS_TABLE.get(sku)
    if not product:
        return False
    if product["stock"] >= quantity:
        product["stock"] -= quantity
        return True
    return False


def fulfill_order_by_id(order: Dict[str, any]) -> Dict[str, bool]:
    """
    Given an order dict (with "items": list of skus), attempt to reserve
    one unit of each SKU. Return a map sku->bool indicating success per sku.
    """
    results = {}
    for sku in order.get("items", []):
        ok = reserve_stock(sku, 1)
        results[sku] = ok
    return results
