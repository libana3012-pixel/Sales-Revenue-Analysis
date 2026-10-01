# Sales Revenue Analysis
**A small business question answered with SQL**

Imagine a shop owner asks: *What sold, how much did we earn, and who bought from us?* This project turns a set of sample purchases into an understandable report.

## The result in 30 seconds
The new, self-contained case study uses **made-up shop data** covering March–June 2026. These are exercise results, not figures from an employer.

| What we measured | Result | In plain English |
| --- | ---: | --- |
| Sales value | 2,020 CU | The sum of all items sold |
| Orders | 12 | Twelve separate purchases |
| Average order | 168.33 CU | Sales value divided by 12 orders |
| Items sold | 28 | Total units, including multiples of the same product |
| Active customers | 7 | Seven people made at least one purchase |

**One finding:** June produced the highest sales value (605 CU), even though every month had three orders. The difference came from the size of the purchases, not from more orders.

*CU = an imaginary currency unit used for the exercise.*

## Explore the project
1. [Read the findings](case-study/RESULTS.md) — what happened, why it matters and what we cannot conclude.
2. [See the sample data](case-study/schema-and-data.sql) — eight customers, six products, twelve orders.
3. [See the analysis](case-study/analysis.sql) — SQL used to calculate the answers.
4. [Follow the plain-language guide](case-study/START-HERE.md) — no prior SQL knowledge required.

## How to run it
With SQLite installed, from the repository root:
```bash
sqlite3 revenue.db < case-study/schema-and-data.sql
sqlite3 -header -column revenue.db < case-study/analysis.sql
```
The first command creates the practice database. The second prints the analysis.

## Skills shown
Connecting tables (JOIN), grouping results (GROUP BY), business measures (KPIs), month-to-month comparisons (LAG), and quality checks to avoid counting an order twice.

## A note on scope
This repository also contains earlier practice material. The `case-study/` folder is a separate, reproducible example with its own tables and transaction-time prices. Its results should not be assumed to come from any earlier exercise in the repository. Source data is synthetic; prices, costs and taxes are simplified.
