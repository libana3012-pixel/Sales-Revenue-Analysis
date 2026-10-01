# Start here: how this sales analysis works

You do not need to know SQL to understand the story.

[← Repository home](../README.md) · [Why the method was chosen](METHOD.md) · [Results](RESULTS.md) · [Source data](schema-and-data.sql)

## The story
Imagine a small shop with a notebook of orders. Each order says **who bought something, when, which products, how many and at what price**. We want to answer: Is the shop selling more because it gets more orders, or because each order is bigger?

## The four files and what they do
- `schema-and-data.sql`: builds the imaginary shop and fills it with example purchases. Think of it as setting up four linked Excel sheets.
- `analysis.sql`: asks the database questions and calculates answers.
- `RESULTS.md`: explains the answers without programming jargon.
- `START-HERE.md`: this guide.

## Learn five terms
| Term | Plain-language meaning |
| --- | --- |
| SQL | A language for asking a database questions |
| Table | A sheet of information, like an Excel sheet |
| JOIN | Connecting information from two sheets using a shared ID |
| KPI | A number used to track something important, such as sales |
| Average order value | Total sales divided by number of orders |

## Follow one number
The first order has a desk lamp (1 × 120 CU) and two bottles (2 × 35 CU). Its total is **190 CU**. The same calculation is performed for all twelve orders. Added together, their value is **2,020 CU**. Divided by twelve orders, the average is **168.33 CU**.

## Understand the main finding
March, April, May and June each have three orders. June is still the strongest month by sales value. This tells us that counting orders alone would hide an important change: some baskets are worth more than others. It does **not** tell us whether profits rose, because costs are absent.

## If you want to try it yourself
1. Install SQLite (or use an environment with the `sqlite3` command).
2. Open a terminal inside this repository.
3. Run `sqlite3 revenue.db < case-study/schema-and-data.sql`.
4. Run `sqlite3 -header -column revenue.db < case-study/analysis.sql`.
5. Compare the numbers to [RESULTS.md](RESULTS.md).
6. Change one quantity in the sample data, rebuild the database from scratch and see what changes.

**Interview explanation:** “I modelled transactions, calculated sales KPIs, compared monthly performance and checked that joining order items did not accidentally increase the order count.”

**Important:** The entire dataset is invented for practice and the results are not real business performance.
