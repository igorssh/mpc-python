import pytest
from inventory import get_stock, reserve_stock, fulfill_order_by_id
from transactional_db import PRODUCTS_TABLE, ORDERS_TABLE


def test_get_stock_and_reserve():
    sku = "SKU300"
    # snapshot current stock
    start = get_stock(sku)
    assert start >= 0
    if start >= 1:
        ok = reserve_stock(sku, 1)
        assert ok is True
        assert get_stock(sku) == start - 1
    else:
        # nothing to reserve, ensure reserve_stock returns False
        ok = reserve_stock(sku, 1)
        assert ok is False


def test_reserve_insufficient():
    # pick a fake high quantity
    sku = "SKU300"
    current = get_stock(sku)
    ok = reserve_stock(sku, current + 1000)
    assert ok is False


def test_fulfill_order_by_id():
    oid = "ORD1015"  # contains SKU300
    order = ORDERS_TABLE[oid]
    # snapshot product stock
    sku = "SKU300"
    start = get_stock(sku)
    res = fulfill_order_by_id(order)
    assert isinstance(res, dict)
    assert sku in res
    # item should have been reserved if stock existed
    if start >= 1:
        assert res[sku] is True
        assert get_stock(sku) == start - 1
    else:
        assert res[sku] is False
