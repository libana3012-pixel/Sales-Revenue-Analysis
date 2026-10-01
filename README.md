# Sales Revenue Analysis
**SQL · SQLite · Revenue Analytics**

## Overview
A business-focused SQL case study examining revenue, product performance and customer value using relational sales data. The objective is to turn order records into interpretable commercial measures.

## Business questions
- Which products and categories contribute the most revenue?
- Which customers generate the highest sales value?
- What is the average order value?
- How do product sales and order frequency differ?

## Data model
| Table | Key fields | Purpose |
| --- | --- | --- |
| `customers` | `id`, `name`, `country` | Customer attributes |
| `products` | `id`, `product_name`, `category`, `price` | Product information and current price |
| `orders` | `id`, `customer_id`, `order_date` | Order headers |
| `order_items` | `id`, `order_id`, `product_id`, `quantity` | Items associated with orders |

## Analytical approach
The analysis uses relational joins, filtering and aggregation. SQL techniques include `INNER JOIN`, `LEFT JOIN`, `COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING` and `ORDER BY`.

### Example: revenue by product
```sql
SELECT
    p.product_name,
    SUM(oi.quantity * p.price) AS total_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.id
GROUP BY p.id, p.product_name
ORDER BY total_revenue DESC;
```

## KPI definitions
| Metric | Calculation |
| --- | --- |
| Revenue | Sum of item quantity multiplied by product price |
| Order count | Number of distinct order IDs |
| Average order value | Revenue divided by distinct order count |
| Customer value | Revenue aggregated by customer |
| Product revenue share | Product revenue divided by total revenue |

> **Results status:** Verified output values and conclusions will be added after the source data and queries are validated. No example values are presented as actual findings.

## Data considerations
This example calculates revenue from the price in the products table. If prices change, a historical price recorded on each order line is needed to reconstruct historical revenue accurately.

## Next steps
1. Validate row counts, join cardinality and revenue totals.
2. Document the dataset's observation period.
3. Add verified KPI outputs and three evidence-based findings.
4. Create a concise dashboard or results visual.

## Tools
SQL · SQLite · GitHub
