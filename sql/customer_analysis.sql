
-- =====================================================
-- E-COMMERCE REVENUE & PROFIT INTELLIGENCE
-- File: customer_analysis.sql
-- =====================================================

-- QUERY 1: Top 10 Customers by Revenue

SELECT
    customer_id,
    COUNT(DISTINCT invoice_id) AS total_orders,
    ROUND(SUM(revenue), 2) AS total_spend,
    ROUND(
        SUM(revenue) /
        NULLIF(COUNT(DISTINCT invoice_id), 0),
        2
    ) AS average_order_value,
    MAX(invoice_date)::date AS last_purchase_date
FROM sales_transactions
WHERE customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 10;


-- QUERY 2: Customer Segmentation Performance

SELECT
    segment,
    COUNT(*) AS total_customers,
    ROUND(SUM(monetary), 2) AS total_revenue,
    ROUND(AVG(monetary), 2) AS avg_customer_value,
    ROUND(AVG(frequency), 2) AS avg_purchase_frequency,
    ROUND(AVG(recency), 2) AS avg_recency_days
FROM customer_rfm
GROUP BY segment
ORDER BY total_revenue DESC;


-- QUERY 3: Customer Segment Distribution

SELECT
    segment,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 /
        NULLIF(SUM(COUNT(*)) OVER (), 0),
        2
    ) AS customer_percentage
FROM customer_rfm
GROUP BY segment
ORDER BY customer_count DESC;


-- QUERY 4: RFM Customer Details

SELECT
    customer_id,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    rfm_score,
    segment
FROM customer_rfm
ORDER BY monetary DESC
LIMIT 20;


-- QUERY 5: Average Customer Lifetime Spend
-- Observed historical spend, not predictive CLV.

SELECT
    COUNT(*) AS total_customers,
    ROUND(AVG(monetary), 2) AS avg_customer_spend,
    ROUND(SUM(monetary), 2) AS total_customer_revenue,
    ROUND(MAX(monetary), 2) AS highest_customer_spend
FROM customer_rfm;


-- QUERY 6: At-Risk Customer Analysis

SELECT
    customer_id,
    recency,
    frequency,
    monetary,
    rfm_score,
    segment
FROM customer_rfm
WHERE segment = 'At Risk'
ORDER BY monetary DESC;


-- QUERY 7: Champions and Loyal Customers

SELECT
    customer_id,
    frequency,
    monetary,
    recency,
    segment
FROM customer_rfm
WHERE segment IN ('Champions', 'Loyal Customers')
ORDER BY monetary DESC
LIMIT 20;


-- QUERY 8: Customer Revenue Contribution

WITH segment_revenue AS (
    SELECT
        segment,
        COUNT(*) AS customers,
        SUM(monetary) AS revenue
    FROM customer_rfm
    GROUP BY segment
)
SELECT
    segment,
    customers,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        revenue * 100 /
        NULLIF(SUM(revenue) OVER (), 0),
        2
    ) AS revenue_contribution_percentage
FROM segment_revenue
ORDER BY revenue DESC;


-- QUERY 9: Purchase Frequency Distribution

SELECT
    CASE
        WHEN frequency = 1 THEN '1 Order'
        WHEN frequency BETWEEN 2 AND 5 THEN '2-5 Orders'
        WHEN frequency BETWEEN 6 AND 10 THEN '6-10 Orders'
        WHEN frequency BETWEEN 11 AND 20 THEN '11-20 Orders'
        ELSE '21+ Orders'
    END AS frequency_group,
    COUNT(*) AS total_customers
FROM customer_rfm
GROUP BY 1
ORDER BY
    MIN(
        CASE
            WHEN frequency = 1 THEN 1
            WHEN frequency BETWEEN 2 AND 5 THEN 2
            WHEN frequency BETWEEN 6 AND 10 THEN 3
            WHEN frequency BETWEEN 11 AND 20 THEN 4
            ELSE 5
        END
    );


-- QUERY 10: Customer Spending Ranking

SELECT
    customer_id,
    segment,
    monetary,
    DENSE_RANK() OVER (
        ORDER BY monetary DESC
    ) AS spending_rank
FROM customer_rfm
ORDER BY spending_rank
LIMIT 20;
