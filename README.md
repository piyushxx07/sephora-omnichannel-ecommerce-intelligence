# Sephora Omnichannel Ecommerce Intelligence Dashboard

## Project Overview

This project is an end-to-end **omnichannel ecommerce intelligence dashboard** inspired by Sephora-style retail operations. It combines product catalog data, customer reviews, simulated ecommerce sessions, marketing campaigns, inventory movement, recommendation events, and customer loyalty behavior into one analytics system.

The goal of this project is to help business leaders understand:

* Executive ecommerce KPIs
* Funnel performance
* Search and product discovery quality
* Product and brand performance
* Campaign efficiency
* Customer and loyalty behavior
* Inventory and stockout risk
* Recommendation performance
* Review and sentiment intelligence

This project was built to demonstrate how SQL, Python, and Power BI can be used together to create a business-ready analytics solution for a modern ecommerce company.

---

## Business Problem

Large beauty and retail brands operate across multiple channels such as:

* Website
* Mobile app
* Stores
* Campaigns
* Loyalty programs
* Recommendation systems
* Product reviews
* Inventory systems

Leadership needs one unified view of business performance.

The main business questions are:

1. Are ecommerce revenue, conversion, and order metrics healthy?
2. Where are users dropping in the funnel?
3. Which search queries drive revenue and which create zero-result issues?
4. Which products should be promoted, protected, demoted, or investigated?
5. Which campaigns are wasting spend and which are efficient?
6. Which customer segments have the highest value?
7. Which products create the highest stockout or lost revenue risk?
8. Which recommendation placements drive engagement and purchases?
9. Which products are loved by customers and which have complaint risk?

---

## Tools Used

| Tool            | Purpose                                                   |
| --------------- | --------------------------------------------------------- |
| SQL / DuckDB    | Data cleaning, joins, KPI tables, BI-ready summary tables |
| Python          | EDA, validation, insight generation, advanced analysis    |
| Pandas          | Data manipulation and summary analysis                    |
| Matplotlib      | Notebook visualizations                                   |
| Power BI        | Interactive business dashboard                            |
| Kaggle Notebook | Data processing environment                               |
| GitHub          | Project documentation and portfolio publishing            |

---

## Dataset

This project uses the public Kaggle dataset:

**Sephora Products and Skincare Reviews**

The original dataset includes:

* Product information
* Brand details
* Product ratings
* Product prices
* Product categories
* Customer reviews
* Review ratings
* Skin type and profile information

To make the project more industry-style, additional ecommerce analytics tables were generated from the original data, including:

* Customer dimension
* Campaign dimension
* Session fact table
* Search events
* Product impressions
* Click events
* Cart events
* Orders
* Order items
* Recommendation events
* Inventory daily movement
* Campaign spend

Raw data is not stored directly in this repository due to file size. See `data/raw/README.md` for instructions.

---

## Project Workflow

```text
Raw Sephora Dataset
        ↓
Data Understanding
        ↓
Data Quality Checks
        ↓
Clean SQL Views
        ↓
BI-Ready SQL Tables
        ↓
Python EDA and Insight Analysis
        ↓
Power BI Dashboard
        ↓
Business Insights and Portfolio Documentation
```

---

## Dashboard Pages

The Power BI dashboard contains 9 pages:

| Page                             | Purpose                                                                   |
| -------------------------------- | ------------------------------------------------------------------------- |
| Executive Overview               | Revenue, orders, sessions, conversion, AOV, return rate, cart abandonment |
| Funnel & Channel Performance     | Funnel stages, channel conversion, traffic source performance             |
| Search & Product Discovery       | Search queries, CTR, zero-result rate, revenue per search                 |
| Product & Brand Performance      | Hero products, hidden gems, brand revenue, ranking opportunities          |
| Marketing & Campaign Performance | Ad spend, ROAS, CPA, campaign efficiency                                  |
| Customer & Loyalty Analytics     | Loyalty status, customer revenue, repeat purchase behavior                |
| Inventory & Stockout Risk        | Stockout risk, lost revenue risk, inventory action list                   |
| Recommendation Analytics         | Recommendation placement performance, CTR, CVR, purchases                 |
| Reviews & Sentiment Intelligence | Product review sentiment, loved products, complaint risk                  |

---

## Key Executive KPIs

| Metric                |        Value |
| --------------------- | -----------: |
| Total Revenue         | 1,173,053.30 |
| Completed Orders      |       16,248 |
| Total Sessions        |      350,000 |
| Conversion Rate       |        4.64% |
| Average Order Value   |        72.20 |
| Revenue per Session   |         3.35 |
| Cart Abandonment Rate |       58.97% |
| Return Rate           |        4.73% |
| Repeat Purchase Rate  |        1.95% |

---

## Key Business Insights

### 1. Funnel Drop-off

The biggest funnel drop-off occurs at the cart stage.

* Click to cart drop-off: **71.82%**
* Overall session-to-purchase conversion: **4.64%**

Business action:

Improve product-page-to-cart flow, cart trust, pricing clarity, delivery messaging, and checkout incentives.

---

### 2. Search & Product Discovery

Top revenue-generating search query:

* **retinol** generated **65,952.05** revenue.

Highest zero-result query:

* **kosas** with **6.28%** zero-result rate.

Business action:

Boost high-revenue queries and fix zero-result search gaps for important brand/product terms.

---

### 3. Product Performance

Hero Products generated the highest revenue.

* Hero Product revenue: **641,167.90**
* Hidden Gems: **436 products**
* High Visibility Low Conversion products: **460 products**

Business action:

Protect Hero Products, promote Hidden Gems, and investigate products receiving visibility but not converting.

---

### 4. Campaign Efficiency

Affiliate traffic had the best overall ROAS among paid channels.

* Best ROAS source: **affiliate**
* Highest spend source: **paid_search**
* Lowest ROAS campaign: **Sephora Campaign 0033**

Business action:

Review paid search budget efficiency and reallocate spend toward better-performing channels.

---

### 5. Customer & Loyalty

Insiders generate the most total revenue, but Rouge customers are the highest-value segment.

* Top revenue group: **insider**
* Best conversion group: **rouge**
* Best revenue per customer group: **rouge**

Business action:

Use loyalty nudges and personalized offers to move customers toward Rouge-like behavior.

---

### 6. Inventory Risk

Inventory is one of the biggest business risks in the project.

* Products currently out of stock: **732**
* Estimated lost revenue risk: **20,041,341.30**
* Top risk product: **Touch Home Permanent Hair Removal Device**

Business action:

Prioritize replenishment for high-risk products and categories with stockout-driven lost revenue.

---

### 7. Recommendation Performance

Product-detail-page recommendations drive the most purchases.

* Top placement by purchases: **pdp_similar**
* Best CTR placement: **cart_cross_sell**
* Best CVR placement: **pdp_similar**

Business action:

Use PDP recommendations for conversion and cart recommendations for engagement.

---

### 8. Reviews & Sentiment

Loved Products have strong satisfaction, while complaint-risk products need investigation.

* Total review rows: **1,301,136**
* Loved Product average positive sentiment: **90.45%**
* High Complaint Risk average negative sentiment: **26.97%**

Business action:

Use review signals to boost loved products and investigate complaint-risk products.

---

## Repository Structure

```text
sephora-omnichannel-ecommerce-intelligence/
│
├── README.md
├── requirements.txt
├── .gitignore
│
├── data/
│   ├── raw/
│   ├── processed/
│       ├── dataset_generate
│   └── bi_tables/
│
├── sql/
│   ├── 01_data_quality_checks.sql
│   ├── 02_clean_views.sql
│   ├── 03_executive_kpis.sql
│   ├── 04_funnel_analysis.sql
│   ├── 05_search_performance.sql
│   ├── 06_product_brand_performance.sql
│   ├── 07_campaign_performance.sql
│   ├── 08_customer_loyalty_analysis.sql
│   ├── 09_inventory_risk.sql
│   ├── 10_recommendation_analysis.sql
│   └── 11_review_sentiment.sql
│
├── notebooks/
│
├── powerbi/
│   ├── Sephora_Ecommerce_Intelligence_Dashboard.pbix
│   ├── sephora_chart_only_theme.json
│   └── screenshots/
│
├── docs/
│   ├── project_overview.md
│   ├── data_dictionary.md
│   ├── business_problem.md
│   ├── dashboard_pages.md
│   ├── insights_summary.md
│   └── limitations.md
│
└── assets/
```

---

## How to Run

### 1. Download Raw Dataset

Download the Sephora Products and Skincare Reviews dataset from Kaggle and place the raw files inside:

```text
data/raw/
```

### 2. Generate BI Tables

Run the SQL generation notebook:

```text
notebooks/02_sql_bi_table_generation.ipynb
```

This creates the BI-ready CSV files inside:

```text
data/bi_tables/
```

### 3. Run Python Analysis

Run:

```text
notebooks/03_python_insight_analysis.ipynb
```

This creates:

```text
python_final_insights.csv
```

### 4. Open Power BI Dashboard

Open:

```text
powerbi/Sephora_Ecommerce_Intelligence_Dashboard.pbix
```

Apply the theme:

```text
powerbi/sephora_chart_only_theme.json
```

---

## Skills Demonstrated

* Business KPI design
* Ecommerce funnel analysis
* Search and discovery analytics
* Product ranking analysis
* Customer segmentation
* Campaign ROAS analysis
* Inventory risk modeling
* Recommendation performance analysis
* Review sentiment analysis
* SQL data modeling
* Python EDA
* Power BI dashboard design
* Business storytelling

---

## Business Impact

This project simulates how a modern ecommerce company can use analytics to improve:

* Revenue performance
* Funnel conversion
* Search quality
* Recommendation effectiveness
* Campaign ROI
* Customer retention
* Inventory availability
* Product trust and satisfaction

---

## Limitations

* Some ecommerce behavior tables are industry-style synthetic extensions created from the original Sephora dataset.
* Raw transaction/session data was not available in the original dataset.
* Forecasting is limited unless date-level revenue/session/order tables are available.
* The dashboard is designed for portfolio and analytics demonstration purposes.

---

## Author

**Piyush Kumar**

Data Analyst Portfolio Project
Focus Area: Ecommerce Analytics, Product Discovery, Power BI, SQL, Python
