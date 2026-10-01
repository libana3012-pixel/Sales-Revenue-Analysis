-- Source checks for the standalone synthetic revenue case.
-- Expected: 8 customers, 6 products, 12 orders, 19 order lines, 28 units, 2020 CU.
SELECT 'customers' AS check_name, COUNT(*) AS actual, 8 AS expected,
 CASE WHEN COUNT(*)=8 THEN 'PASS' ELSE 'FAIL' END AS status FROM customers
UNION ALL SELECT 'products',COUNT(*),6,CASE WHEN COUNT(*)=6 THEN 'PASS' ELSE 'FAIL' END FROM products
UNION ALL SELECT 'orders',COUNT(*),12,CASE WHEN COUNT(*)=12 THEN 'PASS' ELSE 'FAIL' END FROM orders
UNION ALL SELECT 'order_lines',COUNT(*),19,CASE WHEN COUNT(*)=19 THEN 'PASS' ELSE 'FAIL' END FROM order_items
UNION ALL SELECT 'units',SUM(quantity),28,CASE WHEN SUM(quantity)=28 THEN 'PASS' ELSE 'FAIL' END FROM order_items
UNION ALL SELECT 'revenue',SUM(quantity*unit_price),2020,CASE WHEN SUM(quantity*unit_price)=2020 THEN 'PASS' ELSE 'FAIL' END FROM order_items;
-- Zero expected for each of these integrity checks.
SELECT 'orders_without_lines' AS check_name, COUNT(*) AS issues FROM orders o
WHERE NOT EXISTS (SELECT 1 FROM order_items oi WHERE oi.order_id=o.order_id);
SELECT 'invalid_line_values' AS check_name, COUNT(*) AS issues FROM order_items
WHERE quantity<=0 OR unit_price<0 OR unit_price IS NULL;
