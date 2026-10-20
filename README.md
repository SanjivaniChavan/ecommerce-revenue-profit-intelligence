# E-Commerce Revenue & Customer Intelligence

### From Raw Transactions to Business Decisions

**End-to-End Data Analytics Case Study | Python · SQL · PostgreSQL · Power BI · DAX**

[Explore Power BI Dashboard](dashboards/Ecommerce_Revenue_Profit_Intelligence.pbix) | [SQL Analysis](sql/) | [Python Pipeline](src/)

---

## 01. Executive Overview

**The Business Problem**

E-commerce businesses generate large volumes of transactional data, but raw records alone cannot explain revenue performance, purchasing behavior, or customer retention opportunities.

This project transforms transactional sales data into actionable business intelligence using an end-to-end analytics workflow.

**The Solution**

I developed a data analytics solution that combines:

- Python-based data cleaning and transformation.
- PostgreSQL and SQL for structured analysis.
- RFM modeling for customer segmentation.
- Power BI and DAX for interactive business reporting.

**The Outcome**

Two interactive dashboards that help explore sales performance, identify high-value customers, and uncover opportunities for better business decisions.

---

## 02. Business Performance Snapshot

| Key Performance Indicator | Value |
|---|---:|
| Total Revenue | **20.48M** |
| Total Orders | **~40K** |
| Units Sold | **~11M** |
| Average Order Value | **510.92** |
| Total Customers | **~5.9K** |
| Customer Segments | **6** |
| Champions Share | **25.09%** |

*Values reflect the current Power BI dashboard. Monetary units and calculations should be validated against the source dataset.*

---

## 03. Dashboard Showcase

### Dashboard 01 — Executive Revenue Intelligence

**Business Question:** How is the business performing, and where is revenue generated?

The dashboard provides a consolidated view of e-commerce sales performance.

**Key Features**
- Revenue, orders, units sold, and average order value KPIs.
- Monthly revenue trends.
- Top 10 revenue-generating products.
- Top 10 countries by revenue.

**Key Observation**

The United Kingdom contributes the largest share of revenue among the displayed countries, indicating geographic revenue concentration.

### Dashboard 02 — Customer Segmentation & RFM Intelligence

**Business Question:** Which customer groups should the business prioritize?

Customers are segmented using **Recency, Frequency, and Monetary (RFM)** analysis.

**Key Features**
- Customer distribution across six RFM segments.
- Average customer monetary value by segment.
- Revenue contribution by customer segment.
- Interactive customer-segment filtering.

| Customer Segment | Customers | Business Opportunity |
|---|---:|---|
| Champions | 1,475 | VIP engagement and retention |
| Loyal Customers | 787 | Loyalty rewards and referrals |
| Potential Loyalists | 1,841 | Repeat-purchase campaigns |
| At Risk | 89 | Targeted win-back strategies |
| Hibernating | 1,526 | Reactivation assessment |
| New Customers | 160 | Second-purchase engagement |

*Segment counts are based on the current dashboard and should be rechecked after refreshing the data.*

---

## 04. End-to-End Analytics Architecture

```text
E-Commerce Transaction Data
            |
            v
      Python + Pandas
   Data Cleaning & Validation
            |
            v
         PostgreSQL
   Structured Data Storage
            |
            v
        SQL Analytics
 Revenue | Products | Customers
            |
            v
      RFM Segmentation
 Recency | Frequency | Monetary
            |
            v
       Power BI + DAX
 Interactive Business Dashboards
```

---

## 05. Technology Stack

| Technology | Application |
|---|---|
| Python | Data processing and analytics |
| Pandas | Data cleaning and transformation |
| PostgreSQL | Relational data storage |
| SQL | Revenue and customer analysis |
| RFM Analysis | Customer segmentation |
| Power BI | Interactive dashboard development |
| DAX | KPI and analytical measures |
| Git & GitHub | Version control and documentation |

---

## 06. Business Insights & Recommendations

### Insight 01 — Geographic Revenue Concentration

The United Kingdom dominates the country revenue ranking.

**Recommendation:** Investigate geographic concentration and evaluate opportunities in other markets.

### Insight 02 — High-Value Customer Retention

Champions represent approximately 25% of customers and lead revenue contribution among the customer segments.

**Recommendation:** Test VIP benefits, personalized offers, and retention initiatives.

### Insight 03 — Potential Loyalists Represent a Growth Opportunity

Potential Loyalists are the largest customer segment, with 1,841 customers.

**Recommendation:** Test targeted repeat-purchase and loyalty campaigns.

### Insight 04 — Monthly Revenue Fluctuations

Revenue varies considerably across the reporting period.

**Recommendation:** Investigate seasonality, customer purchasing patterns, and reporting-period effects.

*These observations describe patterns in the dataset and do not establish causal relationships.*

---

## 07. Project Structure

```text
ecommerce-revenue-profit-intelligence/
|
|-- dashboards/
|   |-- Ecommerce_Revenue_Profit_Intelligence.pbix
|
|-- sql/
|   |-- schema.sql
|   |-- revenue_analysis.sql
|   |-- customer_analysis.sql
|   |-- advanced_analytics.sql
|
|-- src/
|   |-- inspect_data.py
|   |-- data_cleaning.py
|   |-- db_connection.py
|   |-- import_data.py
|   |-- kpi_analysis.py
|   |-- rfm_segmentation.py
|
|-- requirements.txt
|-- .gitignore
|-- README.md
```

---

## 08. Getting Started

**Clone the repository**

```bash
git clone https://github.com/SanjivaniChavan/ecommerce-revenue-profit-intelligence.git
cd ecommerce-revenue-profit-intelligence
```

**Install dependencies**

```bash
python -m venv .venv
pip install -r requirements.txt
```

Activate the virtual environment using the command appropriate for your operating system.

**Configure the environment**

1. Prepare the source transaction dataset.
2. Configure PostgreSQL and database connection settings.
3. Review the Python scripts and SQL queries.
4. Open the Power BI `.pbix` file in Power BI Desktop.
5. Update the data-source connection before refreshing.

**Data Availability:** Raw and processed datasets are excluded from the public repository. Reproducing the analysis requires the appropriate source dataset and database configuration.

---

## 09. Future Enhancements

- [ ] Add high-resolution screenshots of both dashboards.
- [ ] Validate and document KPI and DAX calculations.
- [ ] Add automated data-quality tests.
- [ ] Introduce profitability and margin analysis when reliable cost data is available.
- [ ] Provide a reproducible sample dataset.

---

### Project Summary

**Domain:** E-Commerce Analytics  
**Focus:** Revenue Intelligence, Customer Segmentation, Business Intelligence  
**Core Skills:** Python, SQL, PostgreSQL, Power BI, DAX, RFM Analysis

**Turning transactional data into actionable business insights.**