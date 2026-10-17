# E-commerce Revenue & Customer Intelligence

**From raw transactions to actionable business decisions.**

**Python · Pandas · PostgreSQL · SQL · Power BI · DAX**

[Power BI Dashboard](dashboards/Ecommerce_Revenue_Profit_Intelligence.pbix) | [SQL Analysis](sql/) | [Python Pipeline](src/)

---

## The Business Challenge

An e-commerce business generates thousands of transactions, but raw sales records alone cannot answer critical questions:

- Which products and countries contribute the most revenue?
- How does revenue change over time?
- Who are the most valuable customers?
- Which customer groups offer opportunities for retention and re-engagement?

This project transforms transaction data into interactive revenue and customer intelligence dashboards.

## Performance Snapshot

| Metric | Dashboard Value |
|---|---:|
| Total Revenue | **20.48M** |
| Total Orders | **~40K** |
| Units Sold | **~11M** |
| Average Order Value | **510.92** |
| Total Customers | **~5.9K** |
| Customer Segments | **6** |
| Champions Share | **25.09%** |

*Metrics reflect the current Power BI report. Currency labels and calculations should be validated against the source data.*

## Dashboard Experience

### 01 — Executive Revenue Overview

A consolidated view of sales performance designed for business stakeholders.

**What it reveals**
- Monthly revenue trends and fluctuations
- Top 10 revenue-generating products
- Top 10 countries by revenue
- Order volume, units sold, and average order value

### 02 — Customer Segmentation & RFM Intelligence

A customer analytics dashboard using **Recency, Frequency, and Monetary (RFM)** analysis.

| Segment | Customers | Business Opportunity |
|---|---:|---|
| Champions | 1,475 | Retention and VIP engagement |
| Loyal Customers | 787 | Loyalty and repeat purchasing |
| Potential Loyalists | 1,841 | Conversion into loyal customers |
| At Risk | 89 | Win-back initiatives |
| Hibernating | 1,526 | Reactivation assessment |
| New Customers | 160 | Second-purchase engagement |

*Segment counts are based on the current dashboard and should be rechecked after data refresh.*

## Analytics Architecture

```text
E-commerce Transaction Data
           |
           v
    Python + Pandas
  Cleaning & Validation
           |
           v
      PostgreSQL
   Structured Data Storage
           |
           v
      SQL Analytics
 Revenue | Product | Customer
           |
           v
     RFM Segmentation
 Recency | Frequency | Monetary
           |
           v
      Power BI + DAX
 Interactive Business Dashboards
```

## Technical Implementation

| Component | Implementation |
|---|---|
| Data Preparation | Python and Pandas |
| Database | PostgreSQL |
| Analytical Queries | SQL |
| Customer Segmentation | RFM Analysis |
| Visualization | Power BI |
| KPI Calculations | DAX |
| Version Control | Git and GitHub |

## Business Insights

**01. Geographic revenue concentration**

The United Kingdom dominates the country revenue chart, highlighting the importance of understanding market concentration.

**02. High-value customer retention**

Champions represent approximately 25% of customers and lead revenue contribution among the RFM segments.

**03. Customer growth opportunity**

Potential Loyalists form the largest customer segment, making them a promising group for testing loyalty and repeat-purchase initiatives.

**04. Revenue variability**

Monthly revenue fluctuates significantly, suggesting the need to investigate seasonality, purchasing patterns, and reporting-period effects.

*These findings describe patterns in the data; they do not establish the causes of those patterns.*

## Project Structure

```text
ecommerce-revenue-profit-intelligence/
│
├── dashboards/
│   └── Ecommerce_Revenue_Profit_Intelligence.pbix
│
├── sql/
│   ├── schema.sql
│   ├── revenue_analysis.sql
│   ├── customer_analysis.sql
│   └── advanced_analytics.sql
│
├── src/
│   ├── inspect_data.py
│   ├── data_cleaning.py
│   ├── db_connection.py
│   ├── import_data.py
│   ├── kpi_analysis.py
│   └── rfm_segmentation.py
│
├── requirements.txt
├── .gitignore
└── README.md
```

## Getting Started

Clone the repository:

```bash
git clone https://github.com/SanjivaniChavan/ecommerce-revenue-profit-intelligence.git
cd ecommerce-revenue-profit-intelligence
```

Install Python dependencies:

```bash
pip install -r requirements.txt
```

Configure your PostgreSQL connection locally, review the Python and SQL scripts, and open the `.pbix` file in Power BI Desktop.

**Data availability:** Raw and processed datasets are excluded from the public repository. Reproducing the analysis requires an appropriate source dataset and database configuration.

## Future Enhancements

- Add screenshots of the redesigned Power BI dashboards.
- Validate and document KPI and DAX calculations.
- Introduce profitability and margin analysis when cost data is available.
- Add reproducible sample data and automated validation tests.

---

**Project Focus:** Business Intelligence · Revenue Analytics · Customer Segmentation · SQL · Python · Power BI