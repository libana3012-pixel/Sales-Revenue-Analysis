# Revenue case study — results and interpretation

**Source:** deliberately synthetic sample transactions; not actual company performance. **Period:** 2026-03-03 to 2026-06-22. **Unit:** synthetic currency units (CU). The analysis is reproducible with `schema-and-data.sql` and `analysis.sql`.

| Metric | Result |
| --- | ---: |
| Total revenue | 2,020 CU |
| Orders | 12 |
| Average order value | 168.33 CU |
| Active customers | 7 of 8 |
| Units sold | 28 |
| Order lines | 19 |

## Monthly view
| Month | Orders | Revenue | Month-over-month |
| --- | ---: | ---: | ---: |
| March | 3 | 460 | — |
| April | 3 | 505 | +9.78% |
| May | 3 | 450 | -10.89% |
| June | 3 | 605 | +34.44% |

## Findings
1. June delivered the highest monthly revenue (605 CU), while order volume was constant at three per month. The change is attributable to average basket value in this sample, not order count.
2. Desk lamp contributed 600 CU (29.70% of total revenue). Table light followed at 480 CU (23.76%). Together they represent 53.47% of sales value.
3. Customer C001 generated 620 CU (30.69% of total revenue) over three orders. Customer C008 had no orders.
4. The sample has just 12 orders and four months of observations. It is useful for testing query logic, not for forecasting commercial demand.

## Checks and caveats
- Transaction-time `unit_price` is stored in `order_items`; current catalogue prices are not used to reconstruct historical revenue.
- Distinct orders are counted separately from 19 order lines, avoiding join-driven inflation.
- No costs, returns, discounts or taxes are modeled; *revenue* is gross line value.
- Acquisition channel labels are descriptive, not evidence that a channel caused a sale.
- Recalculate metrics from the data before changing any reported result.

## Reproduce
```bash
sqlite3 revenue.db < case-study/schema-and-data.sql
sqlite3 -header -column revenue.db < case-study/analysis.sql
```
