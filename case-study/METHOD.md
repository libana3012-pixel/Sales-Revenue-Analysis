# Method explained | From transaction records to sales KPIs

[← Case introduction](START-HERE.md) · [Results](RESULTS.md) · [Data setup](schema-and-data.sql) · [Analysis SQL](analysis.sql) · [Checks](quality-checks.sql) · [Repository home](../README.md)

## Business question
When monthly sales value changes, is it because the shop receives more distinct orders, because each order is worth more, or because particular items account for more value? Total sales by itself does not distinguish these mechanisms.

## Why the data uses four tables
The sample separates customer attributes, products, order headers and order items. Each order may contain multiple items. Keeping quantity and **transaction-time unit price** on the item records allows sales value to be reconstructed without assuming that today's catalogue price equals the historical sale price.

## The reasoning behind each query
1. **Calculate line value:** quantity × unit price. An order with a 120 CU item and two 35 CU items has 120 + 2 × 35 = **190 CU**.
2. **Aggregate to the order level:** sum line values by order ID before averaging. This avoids treating an order with three lines as three different orders.
3. **Calculate headline KPIs:** sum order revenue for gross sales, count distinct orders, divide total by order count to obtain average order value, and count customers with at least one purchase.
4. **Compare months:** group transactions by month, then use `LAG` to retrieve the preceding month's revenue. The month-on-month percentage is (current − previous) ÷ previous × 100. The first month has no preceding value, so it is left blank.
5. **Examine product contribution:** link item records to products to understand where observed value comes from. This is not a profitability analysis because costs are absent.
6. **Keep inactive customers visible:** start from customers with a left join rather than selecting purchasers only.
7. **Treat acquisition labels descriptively:** a recorded source label does not prove that a channel caused a purchase.

## What the numbers say
| Month | Orders | Gross line value (CU) |
| --- | ---: | ---: |
| March | 3 | 460 |
| April | 3 | 505 |
| May | 3 | 450 |
| June | 3 | 605 |

All months contain three orders. June has the highest sales value, therefore **average order value differs** within this fictional sample; the observed difference is not due to an increase in order count. The complete twelve orders sum to **2,020 CU**, giving an average of 2,020 ÷ 12 = **168.33 CU**.

## Why validate independently?
An accidentally duplicated join can produce a convincing but incorrect total. The [quality checks](quality-checks.sql) look for expected counts and invalid records, while [verify.py](../verify.py) loads the synthetic source into an independent in-memory SQLite connection and checks stated results. The [GitHub workflow](../.github/workflows/verify.yml) runs that script automatically.

## Limits and next steps
These numbers are practice outputs, not actual employer sales, net revenue or profit. A real implementation would address refunds, taxes, discounts, currencies, missing values, date dimensions and product costs, then validate a Power BI report against the same SQL totals.

[← Results](RESULTS.md) · [Return to repository](../README.md).
