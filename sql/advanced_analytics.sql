
-- Month-over-Month Revenue Growth

WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', invoice_date)::date AS month,
        SUM(revenue) AS revenue
    FROM sales_transactions
    GROUP BY 1
),
revenue_growth AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    month,
    ROUND(revenue, 2) AS monthly_revenue,
    ROUND(previous_month_revenue, 2)
        AS previous_month_revenue,
    ROUND(
        100.0 * (revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS mom_growth_percentage
FROM revenue_growth
ORDER BY month;
