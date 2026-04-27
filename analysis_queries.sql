-- 1. Total revenue per product
SELECT 
    products.product_name,
    SUM(order_items.quantity * products.price) AS total_revenue
FROM order_items
INNER JOIN products
ON order_items.product_id = products.id
GROUP BY products.product_name
ORDER BY total_revenue DESC;


-- 2. Total revenue per customer
SELECT 
    customers.name,
    SUM(order_items.quantity * products.price) AS total_spent
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id
INNER JOIN order_items
ON orders.id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.id
GROUP BY customers.name
ORDER BY total_spent DESC;


-- 3. Revenue by category
SELECT 
    products.category,
    SUM(order_items.quantity * products.price) AS total_revenue
FROM order_items
INNER JOIN products
ON order_items.product_id = products.id
GROUP BY products.category
ORDER BY total_revenue DESC;


-- 4. Average order value
SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT 
        orders.id,
        SUM(order_items.quantity * products.price) AS order_total
    FROM orders
    INNER JOIN order_items
    ON orders.id = order_items.order_id
    INNER JOIN products
    ON order_items.product_id = products.id
    GROUP BY orders.id);


-- 5. High value customers (spent more than 500)
SELECT 
    customers.name,
    SUM(order_items.quantity * products.price) AS total_spent
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id
INNER JOIN order_items
ON orders.id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.id
GROUP BY customers.name
HAVING total_spent > 500
ORDER BY total_spent DESC;
