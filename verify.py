"""Rebuild synthetic retail data and assert documented KPIs (Python 3 stdlib).

Usage: python3 verify.py
"""
from pathlib import Path
import sqlite3

db = sqlite3.connect(":memory:")
db.execute("PRAGMA foreign_keys=ON")
base = Path(__file__).parent / "case-study"
db.executescript((base / "schema-and-data.sql").read_text(encoding="utf-8"))


def check(label, query, wanted):
    actual = db.execute(query).fetchone()[0]
    assert actual == wanted, f"{label}: expected {wanted}, got {actual}"
    print(f"PASS {label}: {actual}")


check("Customers", "SELECT COUNT(*) FROM customers", 8)
check("Products", "SELECT COUNT(*) FROM products", 6)
check("Orders", "SELECT COUNT(*) FROM orders", 12)
check("Order lines", "SELECT COUNT(*) FROM order_items", 19)
check("Units", "SELECT SUM(quantity) FROM order_items", 28)
check("Gross sales value", "SELECT SUM(quantity * unit_price) FROM order_items", 2020)
check("Active customers", "SELECT COUNT(DISTINCT customer_id) FROM orders", 7)
for month, expected in [("2026-03", 460), ("2026-04", 505), ("2026-05", 450), ("2026-06", 605)]:
    check(month + " revenue", """SELECT SUM(i.quantity*i.unit_price)
        FROM orders o JOIN order_items i ON i.order_id=o.order_id
        WHERE substr(o.order_date,1,7)=?""".replace("=?", f"='{month}'"), expected)
check("Orphan order lines", """SELECT COUNT(*) FROM order_items i
    LEFT JOIN orders o ON i.order_id=o.order_id WHERE o.order_id IS NULL""", 0)
print("Revenue case checks passed.")
