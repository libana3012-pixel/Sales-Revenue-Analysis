# How the revenue-analysis answer was reached

[Repository home](README.md) | [Plain-language introduction](case-study/START-HERE.md) | [Detailed SQL reasoning](case-study/METHOD.md) | [Results](case-study/RESULTS.md)

## Tools used
- **SQLite / SQL:** defines customers, products, orders and item-level transactions, then calculates commercial KPIs.
- **SQLite command-line tool:** runs setup, analysis and quality-check SQL.
- **Python 3 `sqlite3`:** independently recreates and verifies headline results via [verify.py](verify.py).
- **GitHub Actions:** checks that the published figures still agree with the fictional source through [verify.yml](.github/workflows/verify.yml).

## The sequence of decisions

**1. Define the business problem.** Total sales might increase because there are more purchases or because purchases have greater value. To separate those explanations, I calculate order count and order value independently.

**2. Model the transactions.** A customer can place multiple orders, and an order can contain several items. Four linked tables reflect these different relationships. Item records store the unit price at the time of purchase because the current product price may change later.

**3. Calculate at item level, then order level.** Each item line contributes quantity × transaction-time unit price. For instance, 1 × 120 + 2 × 35 = **190 CU** for a fictional order. Sum lines per order before calculating the average order value; otherwise, orders with several lines would be counted more than once.

**4. Group by month and compare.** The [SQL analysis](case-study/analysis.sql) groups order-level totals by month, then uses a window function to compare with the previous observed month. Every month has three orders, yet gross sample sales vary: March 460, April 505, May 450 and June 605 CU.

**5. Explain the finding.** Since monthly order count remains at three, differences in the monthly average basket value explain the differences in this small sample's total sales. Across twelve orders, gross line value is 2,020 CU, so average order value is 2,020 / 12 = **168.33 CU**.

**6. Validate instead of trusting a displayed figure.** [Quality-check SQL](case-study/quality-checks.sql) documents assumptions. The [Python verification](verify.py) loads the same fictional source in an in-memory SQLite database and checks counts, totals and months. The [workflow](.github/workflows/verify.yml) runs that check on GitHub.

**7. Record the limits.** This is gross item value in fictional currency units. Costs, refunds, discounts and taxes are not represented, so these results cannot establish profit. Four months and twelve purchases are insufficient for forecasting.

## Reproduce from a fresh checkout
```bash
sqlite3 revenue.db < case-study/schema-and-data.sql
sqlite3 -header -column revenue.db < case-study/quality-checks.sql
sqlite3 -header -column revenue.db < case-study/analysis.sql
python3 verify.py
```
Use a new database for setup to prevent previously loaded values from changing the example.
