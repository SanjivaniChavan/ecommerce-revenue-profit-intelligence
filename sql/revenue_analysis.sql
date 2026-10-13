
-- =====================================================
-- E-COMMERCE REVENUE & PROFIT INTELLIGENCE
-- File: revenue_analysis.sql
-- =====================================================

-- QUERY 1: Executive Revenue KPIs

SELECT
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT invoice_id) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(revenue) /
        NULLIF(COUNT(DISTINCT invoice_id), 0),
        2
    ) AS average_order_value
FROM sales_transactions;


-- QUERY 2: Monthly Sales Performance

SELECT
    DATE_TRUNC('month', invoice_date)::date AS month,
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT invoice_id) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(revenue) /
        NULLIF(COUNT(DISTINCT invoice_id), 0),
        2
    ) AS average_order_value
FROM sales_transactions
GROUP BY DATE_TRUNC('month', invoice_date)
ORDER BY month;


-- QUERY 3: Top 10 Products by Revenue

SELECT
    stockcode,
    description AS product_name,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_id) AS total_orders,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM sales_transactions
WHERE stockcode IS NOT NULL
  AND description IS NOT NULL
GROUP BY stockcode, description
ORDER BY total_revenue DESC
LIMIT 10;


-- QUERY 4: Top 10 Countries by Revenue

SELECT
    country,
    COUNT(DISTINCT invoice_id) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(
        SUM(revenue) /
        NULLIF(COUNT(DISTINCT invoice_id), 0),
        2
    ) AS average_order_value
FROM sales_transactions
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_revenue DESC
LIMIT 10;


-- QUERY 5: Month-over-Month Revenue Growth

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
    ROUND(
        previous_month_revenue, 2
    ) AS previous_month_revenue,
    ROUND(
        (
            (revenue - previous_month_revenue)
            / NULLIF(previous_month_revenue, 0)
        ) * 100,
        2
    ) AS mom_growth_percentage
FROM revenue_growth
ORDER BY month;


-- QUERY 6: Yearly Revenue Performance

SELECT
    EXTRACT(YEAR FROM invoice_date)::int AS sales_year,
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT invoice_id) AS total_orders,
    SUM(quantity) AS units_sold
FROM sales_transactions
GROUP BY EXTRACT(YEAR FROM invoice_date)
ORDER BY sales_year;


-- QUERY 7: Revenue by Day of Week

SELECT
    EXTRACT(ISODOW FROM invoice_date)::int AS day_number,
    TRIM(TO_CHAR(invoice_date, 'Day')) AS day_name,
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT invoice_id) AS total_orders
FROM sales_transactions
GROUP BY
    EXTRACT(ISODOW FROM invoice_date),
    TRIM(TO_CHAR(invoice_date, 'Day'))
ORDER BY day_number;


-- QUERY 8: Top 10 Best-Selling Products by Quantity

SELECT
    stockcode,
    description AS product_name,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_transactions
WHERE stockcode IS NOT NULL
  AND description IS NOT NULL
GROUP BY stockcode, description
ORDER BY total_units_sold DESC
LIMIT 10;


-- QUERY 9: Country Revenue Contribution

WITH country_sales AS (
    SELECT
        country,
        SUM(revenue) AS total_revenue
    FROM sales_transactions
    WHERE country IS NOT NULL
    GROUP BY country
)
SELECT
    country,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        total_revenue * 100 /
        NULLIF(SUM(total_revenue) OVER (), 0),
        2
    ) AS revenue_percentage
FROM country_sales
ORDER BY total_revenue DESC;
