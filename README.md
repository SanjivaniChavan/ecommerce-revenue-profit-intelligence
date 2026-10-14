# E-commerce Revenue & Customer Intelligence

### End-to-End Data Analytics | Python • SQL • PostgreSQL • Power BI • DAX

An end-to-end e-commerce analytics project designed to transform transactional sales data into actionable business insights using Python, SQL, and Power BI.

The project covers data cleaning, revenue analysis, product performance, geographic sales trends, and RFM-based customer segmentation.

## Project Objectives

- Analyze revenue trends and order performance.
- Identify top-performing products and countries.
- Understand customer purchasing behavior.
- Segment customers using Recency, Frequency, and Monetary (RFM) analysis.
- Build interactive Power BI dashboards to support business decisions.

## Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data cleaning, preprocessing, and analysis |
| Pandas | Data transformation and aggregation |
| PostgreSQL | Relational database and SQL analytics |
| SQL | Revenue analysis, customer analytics, and advanced queries |
| Power BI | Interactive dashboards and visualization |
| DAX | KPI measures and customer segment calculations |
| Git & GitHub | Version control and project documentation |

## Dashboard Overview

### 1. Revenue Overview Dashboard

An interactive dashboard providing a consolidated view of e-commerce sales performance.

**Key Performance Indicators**
- Total Revenue: 20.48M
- Total Orders: Approximately 40K
- Units Sold: Approximately 11M
- Average Order Value: 510.92

**Visualizations**
- Monthly Revenue Trend
- Top 10 Products by Revenue
- Top 10 Countries by Revenue

### 2. Customer Segmentation & RFM Analysis

A customer intelligence dashboard built around RFM segmentation.

**Key Metrics**
- Total Customers: Approximately 5.9K
- Customer Segments: 6
- Champions Percentage: 25.09%

**Customer Segments**
- Champions
- Loyal Customers
- Potential Loyalists
- At Risk
- Hibernating
- New Customers

**Visualizations**
- Customer Distribution by RFM Segment
- Average Customer Monetary Value by Segment
- Revenue Contribution by Customer Segment
- Interactive Customer Segment Filter

## Analytics Workflow

1. **Data Preparation:** Clean and transform transactional sales records using Python.
2. **Database Management:** Organize analytical data using PostgreSQL.
3. **SQL Analysis:** Analyze revenue, product performance, customer behavior, and sales trends.
4. **RFM Segmentation:** Classify customers using purchasing recency, frequency, and monetary value.
5. **Power BI Reporting:** Develop interactive dashboards with DAX measures and customer filters.

## Preliminary Business Insights

- Champions represent approximately 25% of customers, making them an important segment for retention analysis.
- Champions contribute the largest revenue share among the six customer segments.
- Revenue performance varies across products, countries, and monthly periods.
- RFM segmentation provides a framework for targeted retention and re-engagement strategies.

## Repository Structure

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
|   |-- data_cleaning.py
|   |-- db_connection.py
|   |-- import_data.py
|   |-- inspect_data.py
|   |-- kpi_analysis.py
|   |-- rfm_segmentation.py
|
|-- README.md
|-- requirements.txt
|-- .gitignore
```

## Getting Started

1. Clone the repository.
2. Create a Python virtual environment.
3. Install dependencies using `pip install -r requirements.txt`.
4. Configure the PostgreSQL database connection for your local environment.
5. Review the Python and SQL scripts.
6. Open the `.pbix` file using Power BI Desktop.

**Note:** Source datasets are excluded from the public repository. Reproducing the analysis requires access to the appropriate dataset and local database configuration.

## Future Improvements

- Add dashboard screenshots and detailed business recommendations.
- Validate and document key metrics and DAX calculations.
- Expand profitability analysis with cost data where available.
- Improve reproducibility with sample data and automated tests.

---

**Project Focus:** Data Analytics | Business Intelligence | SQL | Python | Power BI | Customer Segmentation