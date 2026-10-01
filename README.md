# Sales Revenue Analysis

[Complete project workflow](WORKFLOW.md)

[How the work was carried out, with tools and calculations](WORKFLOW.md)

[![Verify SQL case study](https://github.com/libana3012-pixel/Sales-Revenue-Analysis/actions/workflows/verify.yml/badge.svg)](https://github.com/libana3012-pixel/Sales-Revenue-Analysis/actions/workflows/verify.yml)
### A small retail case study, from transactions to commercial decisions

**SQL / SQLite** · Transaction modelling · KPI design · Reproducible reporting

> **The business question:** Sales figures tell us what happened. Can we explain *where the money came from*, whether bigger orders drove the difference between months, and which parts of the catalogue deserve a closer look?

This repository includes earlier SQL exercises and an independent, end-to-end `case-study/` with an explicitly **synthetic** retail dataset. The figures below are exercise outputs, not employer results.

## About the analyst

I'm Liban Yusuf, with a background in marketing and sales management and experience working with digital analytics and business reporting. This project develops the SQL side of that work: getting reliable commercial measures from transactional records and explaining what the figures do — and do not — show.

**Related work:** [Customer purchasing patterns](https://github.com/libana3012-pixel/Customer-Sales-Analysis) · [GitHub profile](https://github.com/libana3012-pixel)

**Suggested reading route:** [Start here](case-study/START-HERE.md) → [Why I chose each analytical step](case-study/METHOD.md) → [Results](case-study/RESULTS.md) → [SQL](case-study/analysis.sql) → [Automated checks](.github/workflows/verify.yml).

## Repository map

| Location | Purpose |
| --- | --- |
| [`case-study/`](case-study/) | Featured, self-contained analysis and data |
| [`case-study/METHOD.md`](case-study/METHOD.md) | Why each query and modelling choice was made |
| [`case-study/START-HERE.md`](case-study/START-HERE.md) | Simple explanation for non-technical readers |
| [`case-study/RESULTS.md`](case-study/RESULTS.md) | Calculated KPIs and interpretation |
| [`case-study/quality-checks.sql`](case-study/quality-checks.sql) | Reconciliation and data checks |
| [`archive/early-exercises/`](archive/early-exercises/) | Original SQL exercises preserved separately |

---

## The story in 30 seconds

| Measure | Result | Why it matters |
|:--|--:|:--|
| Revenue | 2,020 CU | Gross value of items sold |
| Orders | 12 | Number of distinct purchases |
| Average order value | 168.33 CU | How much an order is worth on average |
| Units sold | 28 | Total quantity across all order lines |
| Active customers | 7 of 8 | Customers with at least one order |

CU is a fictional currency unit.

### Monthly revenue

| Month | Revenue | Orders | Change in revenue |
|:--|--:|--:|--:|
| March | 460 | 3 | — |
| April | 505 | 3 | +9.78% |
| May | 450 | 3 | −10.89% |
| June | 605 | 3 | +34.44% |

**Interpretation:** Each month has three orders, yet June generated the most revenue. Here, order *value* changed rather than order *volume*. That is a useful distinction to investigate in a business review; four months and twelve fictional orders are not enough to forecast a real company.

## Read it your way

| If you have… | Open |
|:--|:--|
| 1 minute | [Results and limitations](case-study/RESULTS.md) |
| 5 minutes | [Plain-English walkthrough](case-study/START-HERE.md) |
| 10 minutes | [SQL queries](case-study/analysis.sql) |
| Time to reproduce the work | [Database setup](case-study/schema-and-data.sql) and [validation checks](case-study/quality-checks.sql) |

## How the work is structured

```text
case-study/
  schema-and-data.sql   build the sample database
  analysis.sql          answer the business questions
  quality-checks.sql    check important source assumptions
  RESULTS.md            report verified sample outputs and cautions
  START-HERE.md         explain the project without SQL jargon
```

The source uses four connected tables: **customers → orders → order_items ← products**. Order lines carry the transaction-time price, so a later change to a product's catalogue price does not rewrite earlier revenue.

## Run the case

```bash
sqlite3 revenue.db < case-study/schema-and-data.sql
sqlite3 -header -column revenue.db < case-study/quality-checks.sql
sqlite3 -header -column revenue.db < case-study/analysis.sql
```

Use a fresh database for the setup command. The validation script documents the expected values. Compare the calculated outputs with the results document rather than trusting a screenshot.

## What this demonstrates

**Technical:** joins, aggregations, CTEs, window functions, distinct counts, historical line prices and data checks.

**Analytical:** choosing measures, separating order count from order lines, explaining an observed change, and making the limitations of a result visible.

**Next iteration:** publish a Power BI report built from these four tables, with checked DAX measures and a real screenshot after validation.
