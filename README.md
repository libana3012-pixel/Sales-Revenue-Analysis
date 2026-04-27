# Sales Revenue Analysis (SQL Project)
## About
This project is a SQL analysis project focused on sales, revenue, products, customers, and order data.
I created this project to practice SQL in a more realistic business setting. The goal was not only to count orders, but also to analyze revenue, customer value, product performance, and sales trends.
This is a step up from a basic SQL project because it includes revenue calculations and more business-focused questions.
---
## Business Questions
In this project, I worked on questions such as:
- Which products generate the most revenue?
- Which customers spend the most money?
- Which product categories perform best?
- What is the average order value?
- Which customers are high-value customers?
- How many orders does each customer place?
- Which products are ordered most often?
---
## Tools Used
- SQL
- SQLite
- GitHub
---
## Data Structure
The project uses four tables:
### customers
- id
- name
- country
### products
- id
- product_name
- category
- price
### orders
- id
- customer_id
- order_date
### order_items
- id
- order_id
- product_id
- quantity
---
## SQL Skills Used
This project includes:
- SELECT
- WHERE
- INNER JOIN
- LEFT JOIN
- COUNT
- SUM
- AVG
- GROUP BY
- HAVING
- ORDER BY
- DISTINCT
- Basic revenue calculations
---
## Example Query
Find total revenue by product:

```sql
SELECT 
    products.product_name,
    SUM(order_items.quantity * products.price) AS total_revenue
FROM order_items
INNER JOIN products
ON order_items.product_id = products.id
GROUP BY products.product_name
ORDER BY total_revenue DESC;
