-- Revenue case study | SQLite 3.25+ | all amounts are synthetic currency units
-- 01. KPI overview: use order-level aggregation to avoid inflating order counts
WITH order_values AS (
 SELECT o.order_id, o.customer_id, o.order_date, SUM(oi.quantity * oi.unit_price) AS revenue
 FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
 GROUP BY o.order_id, o.customer_id, o.order_date
)
SELECT COUNT(*) AS orders, ROUND(SUM(revenue),2) AS revenue,
       ROUND(AVG(revenue),2) AS average_order_value,
       COUNT(DISTINCT customer_id) AS active_customers
FROM order_values;

-- 02. Monthly performance and month-over-month change
WITH monthly AS (
 SELECT strftime('%Y-%m',o.order_date) AS month,
        COUNT(DISTINCT o.order_id) AS orders,
        SUM(oi.quantity * oi.unit_price) AS revenue
 FROM orders o JOIN order_items oi ON oi.order_id=o.order_id GROUP BY 1
), trend AS (
 SELECT *, LAG(revenue) OVER (ORDER BY month) AS previous_revenue FROM monthly
)
SELECT month, orders, revenue, ROUND(1.0*revenue/orders,2) AS average_order_value,
       ROUND(100.0*(revenue-previous_revenue)/NULLIF(previous_revenue,0),2) AS mom_growth_pct
FROM trend ORDER BY month;

-- 03. Product contribution (line price preserves historical transaction value)
SELECT p.product_name,p.category, SUM(oi.quantity) AS units,
       SUM(oi.quantity*oi.unit_price) AS revenue,
       ROUND(100.0*SUM(oi.quantity*oi.unit_price)/
             (SELECT SUM(quantity*unit_price) FROM order_items),2) AS revenue_share_pct
FROM order_items oi JOIN products p ON p.product_id=oi.product_id
GROUP BY p.product_id,p.product_name,p.category ORDER BY revenue DESC;

-- 04. Customer spend and activity; retain customers with zero orders
SELECT c.customer_id,c.market, COUNT(DISTINCT o.order_id) AS orders,
       COALESCE(SUM(oi.quantity*oi.unit_price),0) AS lifetime_revenue
FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id
LEFT JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY c.customer_id,c.market ORDER BY lifetime_revenue DESC, c.customer_id;

-- 05. Channel revenue (descriptive attribution only; not causal)
SELECT o.acquisition_channel,COUNT(DISTINCT o.order_id) AS orders,
       SUM(oi.quantity*oi.unit_price) AS revenue
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY o.acquisition_channel ORDER BY revenue DESC;

-- 06. Integrity checks: expected result = zero rows
SELECT o.order_id FROM orders o LEFT JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY o.order_id HAVING COUNT(oi.product_id)=0;
SELECT order_id,product_id,COUNT(*) AS duplicates FROM order_items
GROUP BY order_id,product_id HAVING COUNT(*)>1;
