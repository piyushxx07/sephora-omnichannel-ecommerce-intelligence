# Project Overview

## Project Name

**Sephora Omnichannel Ecommerce Intelligence Dashboard**

## One-Line Summary

This project is an end-to-end ecommerce analytics system that simulates how a Sephora-style retail business can monitor revenue, funnel performance, search quality, product discovery, campaigns, customers, inventory, recommendations, and review sentiment in one business intelligence dashboard.

---

## Project Context

Modern ecommerce companies do not operate from a single system. A business like Sephora collects data from many areas:

* Website sessions
* Mobile app sessions
* Product searches
* Product impressions
* Click events
* Cart events
* Orders
* Campaigns
* Paid ads
* Loyalty programs
* Inventory systems
* Product recommendations
* Customer reviews

The problem is that leadership cannot make strong decisions by looking at these systems separately. Revenue alone does not explain why users are dropping. Campaign spend alone does not show whether customers are converting. Reviews alone do not show whether a product should be promoted or demoted. Inventory alone does not show how much revenue is being lost because products are out of stock.

This project brings all these ecommerce signals into one analytics layer.

---

## Project Objective

The objective of this project is to build a complete business intelligence solution that helps ecommerce leadership answer:

* Is the business growing revenue efficiently?
* Where are users dropping in the customer journey?
* Which search queries generate revenue?
* Which search queries create zero-result problems?
* Which products should be promoted?
* Which products are receiving visibility but not converting?
* Which brands are strong and which need attention?
* Which campaigns are wasting money?
* Which customer segments are most valuable?
* Which products are creating inventory risk?
* Which recommendation placements drive purchases?
* Which products are loved or disliked by customers?

The final output is a Power BI dashboard supported by SQL-generated BI tables and Python-based insight analysis.

---

## Why This Project Is Important

Many portfolio dashboards only show revenue, sales, and basic category charts. This project goes deeper.

It connects ecommerce business performance with product discovery and customer experience. This makes it closer to how real ecommerce analytics teams work.

The project covers:

* Executive KPI reporting
* Funnel diagnostics
* Search performance
* Product ranking logic
* Brand-level performance
* Campaign ROAS
* Customer loyalty behavior
* Inventory risk
* Recommendation analytics
* Review sentiment intelligence

This makes the project useful for roles such as:

* Data Analyst
* Business Analyst
* Ecommerce Analyst
* Product Analyst
* BI Analyst
* Marketing Analyst
* Customer Insights Analyst

---

## Business Scenario

A Sephora-style ecommerce business wants to understand its omnichannel performance.

The company sells products across website, mobile app, and store-related channels. It also runs campaigns through paid search, paid social, affiliate, influencer, email, organic, and direct traffic sources.

Leadership wants to know:

1. How much revenue is the business generating?
2. How many users are converting?
3. Which traffic sources perform best?
4. Which products deserve better visibility?
5. Which search queries need optimization?
6. Which campaigns should receive more or less budget?
7. Which customer loyalty groups are most valuable?
8. Which inventory issues are causing lost revenue?
9. Which recommendations are helping customers discover products?
10. Which reviews reveal product satisfaction or complaint risk?

The dashboard is built to support these decisions.

---

## Data Source

The base dataset used for this project is the public Kaggle dataset:

**Sephora Products and Skincare Reviews**

The original dataset contains:

* Product information
* Product names
* Brand names
* Product categories
* Product prices
* Product ratings
* Review counts
* Customer review data
* Review text
* Review ratings
* Skin type and customer profile attributes

To make the project more realistic for ecommerce analytics, the dataset was extended into an industry-style analytical model using generated tables based on real product and review signals.

---

## Industry-Style Tables Created

The project includes the following analytical tables:

### Dimension Tables

* `dim_product`
* `dim_brand`
* `dim_customer`
* `dim_campaign`

### Fact Tables

* `fact_reviews`
* `fact_sessions`
* `fact_search_events`
* `fact_product_impressions`
* `fact_clicks`
* `fact_cart_events`
* `fact_orders`
* `fact_order_items`
* `fact_recommendation_events`
* `fact_inventory_daily`
* `fact_campaign_spend_daily`

### Quality Reports

* `dq_report`
* `ri_report`
* `business_rule_report`

These tables simulate the kind of data structure used in ecommerce companies.

---

## Final BI Tables

The SQL pipeline created dashboard-ready BI tables:

| BI Table                            | Purpose                                 |
| ----------------------------------- | --------------------------------------- |
| `bi_executive_kpis.csv`             | Executive KPI summary                   |
| `bi_funnel_session_summary.csv`     | Session-level funnel performance        |
| `bi_funnel_by_channel.csv`          | Funnel performance by channel           |
| `bi_funnel_by_traffic_source.csv`   | Funnel performance by traffic source    |
| `bi_search_performance.csv`         | Search query analytics                  |
| `bi_product_ranking.csv`            | Product ranking and action segmentation |
| `bi_brand_performance.csv`          | Brand-level performance                 |
| `bi_campaign_performance.csv`       | Marketing campaign efficiency           |
| `bi_customer_segments.csv`          | Customer and loyalty segment analytics  |
| `bi_inventory_risk.csv`             | Inventory and stockout risk             |
| `bi_recommendation_performance.csv` | Recommendation placement performance    |
| `bi_review_sentiment.csv`           | Review and sentiment analysis           |
| `bi_dashboard_page_summary.csv`     | Dashboard headline summary              |
| `python_final_insights.csv`         | Final Python-generated insight table    |

---

## Tools Used

| Tool            | Usage                                             |
| --------------- | ------------------------------------------------- |
| SQL / DuckDB    | Data cleaning, joins, validations, KPI generation |
| Python          | EDA, validation, insight analysis                 |
| Pandas          | Data manipulation and aggregations                |
| NumPy           | Numeric operations                                |
| Matplotlib      | Notebook visuals                                  |
| Power BI        | Dashboard design and storytelling                 |
| Kaggle Notebook | Data processing environment                       |
| GitHub          | Portfolio publishing                              |

---

## Project Workflow

```text
1. Understand raw Sephora dataset
2. Create industry-style ecommerce tables
3. Perform data quality checks
4. Validate referential integrity
5. Build clean SQL views
6. Generate BI-ready summary tables
7. Perform Python EDA and insight analysis
8. Build Power BI dashboard
9. Create documentation for GitHub portfolio
```

---

## Dashboard Pages

The final Power BI dashboard contains 9 pages.

### 1. Executive Overview

Tracks:

* Revenue
* Orders
* Sessions
* Conversion rate
* Average order value
* Cart abandonment rate
* Return rate
* Funnel stage health

### 2. Funnel & Channel Performance

Tracks:

* Session funnel
* Stage conversion
* Drop-off rate
* Channel conversion
* Traffic source conversion

### 3. Search & Product Discovery

Tracks:

* Search volume
* Search CTR
* Zero-result rate
* Revenue per search
* High-value queries
* Search-to-purchase performance

### 4. Product & Brand Performance

Tracks:

* Hero products
* Hidden gems
* High visibility low conversion products
* Brand revenue
* Brand action segments
* Product ranking score

### 5. Marketing & Campaign Performance

Tracks:

* Campaign revenue
* Ad spend
* ROAS
* CPA
* CAC
* Campaign conversion
* Campaign action segments

### 6. Customer & Loyalty Analytics

Tracks:

* Customer count
* Revenue by loyalty group
* Repeat purchase rate
* Revenue per customer
* Customer micro-segments
* Preferred channel behavior

### 7. Inventory & Stockout Risk

Tracks:

* Out-of-stock products
* Low-stock products
* Days of supply
* Stockout rate
* Estimated lost revenue risk

### 8. Recommendation Analytics

Tracks:

* Recommendation impressions
* Recommendation clicks
* Recommendation purchases
* Recommendation CTR
* Recommendation CVR
* Placement performance

### 9. Reviews & Sentiment Intelligence

Tracks:

* Total reviews
* Average review rating
* Loved products
* Complaint-risk products
* Positive and negative review percentages

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

## Key Business Findings

### Funnel

The largest funnel drop-off happens at the cart stage.

* Click to cart drop-off: 71.82%
* Overall session-to-purchase conversion: 4.64%

This shows that users are reaching products but many are not adding items to the cart.

### Search

The top revenue query is:

* `retinol` with 65,952.05 revenue

The highest zero-result query is:

* `kosas` with 6.28% zero-result rate

This shows that high-intent skincare queries are valuable, but some brand queries need better search coverage.

### Product Discovery

Hero Products generated the highest revenue.

* Hero Product revenue: 641,167.90
* Hidden Gems: 436 products
* High Visibility Low Conversion products: 460 products

This shows clear ranking and merchandising opportunities.

### Campaigns

Affiliate had the best ROAS among paid sources, while paid search had the highest spend.

This suggests that the marketing budget should be reviewed and shifted toward more efficient sources.

### Customers

Insider customers generated the most total revenue because they had the largest customer base.

Rouge customers had the strongest value quality:

* Highest conversion
* Highest revenue per customer
* Higher repeat behavior

This shows that loyalty maturity improves ecommerce value.

### Inventory

Inventory risk is a major issue.

* Products currently out of stock: 732
* Estimated lost revenue risk: 20,041,341.30

This shows that product availability can create a major revenue leak.

### Recommendations

PDP similar recommendations drove the most purchases.

Cart cross-sell recommendations had the best CTR.

This shows that recommendation placement should be optimized based on funnel intent.

### Reviews

Loved Products have strong positive sentiment.

High Complaint Risk products show much higher negative sentiment and need investigation.

---

## Skills Demonstrated

This project demonstrates:

* Business problem framing
* SQL data modeling
* Data quality checks
* KPI design
* Funnel analysis
* Search analytics
* Product segmentation
* Campaign ROAS analysis
* Customer segmentation
* Inventory risk scoring
* Recommendation analytics
* Review sentiment analysis
* Power BI dashboard design
* Python EDA
* Business storytelling
* GitHub project documentation

---

## Final Outcome

The final output is a complete ecommerce analytics portfolio project that shows how raw product and review data can be converted into a decision-ready business intelligence system.

This project is designed to demonstrate both technical ability and business thinking.
