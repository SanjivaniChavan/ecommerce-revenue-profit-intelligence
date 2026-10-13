
-- =====================================================
-- E-COMMERCE REVENUE & PROFIT INTELLIGENCE
-- File: schema.sql
-- Database: ecommerce_analytics
-- =====================================================

-- 1. Sales Transactions Table
CREATE TABLE IF NOT EXISTS sales_transactions (
    transaction_id BIGSERIAL PRIMARY KEY,
    invoice_id VARCHAR(50),
    stockcode VARCHAR(50),
    description TEXT,
    quantity INTEGER,
    invoice_date TIMESTAMP,
    unit_price NUMERIC(15, 2),
    customer_id BIGINT,
    country VARCHAR(100),
    revenue NUMERIC(15, 2)
);

-- 2. Customer RFM Table
CREATE TABLE IF NOT EXISTS customer_rfm (
    customer_id BIGINT PRIMARY KEY,
    recency INTEGER,
    frequency INTEGER,
    monetary NUMERIC(15, 2),
    r_score INTEGER,
    f_score INTEGER,
    m_score INTEGER,
    rfm_score VARCHAR(3),
    segment VARCHAR(50)
);

-- 3. Indexes
CREATE INDEX IF NOT EXISTS idx_sales_invoice_date
ON sales_transactions(invoice_date);

CREATE INDEX IF NOT EXISTS idx_sales_customer_id
ON sales_transactions(customer_id);

CREATE INDEX IF NOT EXISTS idx_sales_stockcode
ON sales_transactions(stockcode);

CREATE INDEX IF NOT EXISTS idx_sales_country
ON sales_transactions(country);

CREATE INDEX IF NOT EXISTS idx_rfm_segment
ON customer_rfm(segment);

-- 4. Verify Tables
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

-- 5. Verify Record Counts
SELECT
    'sales_transactions' AS table_name,
    COUNT(*) AS total_records
FROM sales_transactions

UNION ALL

SELECT
    'customer_rfm' AS table_name,
    COUNT(*) AS total_records
FROM customer_rfm;
