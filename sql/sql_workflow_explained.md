# SQL Workflow Explained

## Overview

This document explains the SQL workflow used in the **Sephora Omnichannel Ecommerce Intelligence Dashboard** project.

The goal of the SQL layer is to convert raw ecommerce-style tables into clean, business-ready BI tables for Power BI.

Instead of directly connecting raw tables to Power BI, SQL was used to:

* Validate data quality
* Clean important fields
* Create reusable views
* Join fact and dimension tables
* Calculate KPIs
* Create funnel metrics
* Create product and brand performance tables
* Create campaign, customer, inventory, recommendation, and review analytics tables

This makes the Power BI dashboard faster, cleaner, and easier to understand.

---

# Why SQL Was Used

SQL was used because ecommerce data usually lives in relational tables.

A real ecommerce company has many tables:

* Products
* Customers
* Sessions
* Searches
* Clicks
* Cart events
* Orders
* Campaigns
* Inventory
* Reviews
* Recommendations

SQL is the best tool to connect these tables and create business metrics.

In this project, SQL answers questions such as:

* How many sessions happened?
* How many users searched?
* How many users clicked?
* How many users added products to cart?
* How many purchases happened?
* Which products generated revenue?
* Which campaigns had poor ROAS?
* Which products are out of stock?
* Which reviews show complaint risk?

---

# SQL File Flow

The SQL scripts are organized in this order:

```text
01_data_quality_checks.sql
        ↓
02_clean_views.sql
        ↓
03_executive_kpis.sql
        ↓
04_funnel_analysis.sql
        ↓
05_search_performance.sql
        ↓
06_product_brand_performance.sql
        ↓
07_campaign_performance.sql
        ↓
08_customer_loyalty_analysis.sql
        ↓
09_inventory_risk.sql
        ↓
10_recommendation_analysis.sql
        ↓
11_review_sentiment.sql
```

Each file builds one part of the final analytics system.

---

# 01_data_quality_checks.sql

## Purpose

This file checks whether the dataset is safe to use for analysis.

Before creating KPIs or dashboards, we need to confirm that the data does not have major quality problems.

## What It Checks

### 1. Row Counts

This checks how many rows exist in each table.

Example tables checked:

* `dim_product`
* `dim_brand`
* `dim_customer`
* `dim_campaign`
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

## Why This Is Important

Row counts help confirm that all tables loaded correctly.

If a table has 0 rows or fewer rows than expected, the analysis may be incomplete.

---

### 2. Duplicate Key Checks

This checks whether key columns are unique.

Examples:

| Table           | Key Column    |
| --------------- | ------------- |
| `dim_product`   | `product_id`  |
| `dim_customer`  | `customer_id` |
| `dim_campaign`  | `campaign_id` |
| `fact_sessions` | `session_id`  |
| `fact_orders`   | `order_id`    |
| `fact_reviews`  | `review_id`   |

## Why This Is Important

If a primary key has duplicates, joins can create wrong numbers.

For example, if `product_id` is duplicated in the product table, one order item can join to multiple product rows and inflate revenue.

---

### 3. Null Checks

This checks important columns for missing values.

Examples:

* Missing product IDs
* Missing product names
* Missing brand names
* Missing customer IDs
* Missing session IDs
* Missing traffic sources
* Missing campaign IDs

## Why This Is Important

Null values can break joins, filters, slicers, and KPI calculations.

---

### 4. Business Rule Checks

This validates whether values make business sense.

Examples:

| Check                      | Meaning                             |
| -------------------------- | ----------------------------------- |
| Product price <= 0         | Product price should be positive    |
| Product rating outside 0-5 | Rating should stay between 0 and 5  |
| Order total < 0            | Revenue should not be negative      |
| Inventory stock < 0        | Stock cannot be negative            |
| Session duration <= 0      | Session duration should be positive |
| Order item quantity <= 0   | Quantity should be positive         |

## Output

This SQL file does not create a Power BI table directly. It is used for validation before dashboard creation.

---

# 02_clean_views.sql

## Purpose

This file creates clean SQL views.

A view is like a saved SQL layer that cleans messy fields before analysis.

## Views Created

```text
vw_dim_product_clean
vw_dim_customer_clean
vw_fact_sessions_clean
vw_dim_campaign_clean
```

---

## 1. vw_dim_product_clean

This view cleans product data.

It handles:

* Missing product names
* Missing brand names
* Missing categories
* Missing prices
* Product tier creation
* Boolean field cleanup

## Product Tier Logic

Products are grouped into price tiers:

| Price Range   | Product Tier |
| ------------- | ------------ |
| Less than 25  | budget       |
| 25 to 49.99   | mid          |
| 50 to 99.99   | premium      |
| 100 and above | luxury       |

## Why This Is Useful

Power BI can use `product_tier` for slicers and analysis.

It helps answer:

* Do luxury products convert better?
* Which price tier drives revenue?
* Are budget products more common in cart events?

---

## 2. vw_dim_customer_clean

This view cleans customer profile data.

It handles missing or invalid values in:

* `skin_type`
* `skin_tone`
* `eye_color`
* `hair_color`
* `loyalty_status`
* `preferred_channel`

Missing values are replaced with:

```text
unknown
```

## Why This Is Useful

Instead of showing blank values in Power BI slicers, the dashboard shows `unknown`.

This improves dashboard usability.

---

## 3. vw_fact_sessions_clean

This view cleans session data.

It standardizes:

* Channel
* Device type
* Traffic source
* Campaign ID
* Preferred channel
* Session duration
* Bounce flag

## Why This Is Useful

Session data is used in funnel analysis.

If session fields are messy, funnel charts and traffic-source analysis become unreliable.

---

## 4. vw_dim_campaign_clean

This view cleans campaign data.

It standardizes:

* Campaign name
* Traffic source
* Campaign objective
* Daily budget

## Why This Is Useful

Campaign analysis needs clean campaign fields to calculate ROAS, CPA, CAC, and conversion.

---

# 03_executive_kpis.sql

## Purpose

This file creates the high-level executive KPI table.

Output:

```text
bi_executive_kpis.csv
```

## Main Metrics Created

| Metric                  | Meaning                                               |
| ----------------------- | ----------------------------------------------------- |
| Total Sessions          | Total ecommerce sessions                              |
| Total Customers         | Customers with sessions                               |
| Completed Orders        | Orders with completed status                          |
| Total Revenue           | Net revenue from completed orders                     |
| Total Items Sold        | Total quantity sold                                   |
| Average Order Value     | Revenue divided by completed orders                   |
| Conversion Rate %       | Completed orders divided by sessions                  |
| Revenue Per Session     | Revenue divided by sessions                           |
| Repeat Purchase Rate %  | Customers with more than one order                    |
| Return Rate %           | Returned orders divided by total completed + returned |
| Cart Abandonment Rate % | Cart sessions that did not become purchase sessions   |

## Why This File Matters

This file powers the **Executive Overview** dashboard page.

It gives leadership a fast view of business health.

## Example Business Question Answered

```text
Is the ecommerce business performing well overall?
```

---

# 04_funnel_analysis.sql

## Purpose

This file creates funnel analysis tables.

Outputs:

```text
bi_funnel_summary.csv
bi_funnel_session_summary.csv
bi_funnel_by_channel.csv
bi_funnel_by_traffic_source.csv
```

---

## Funnel Logic

The funnel follows this path:

```text
Total Sessions
→ Sessions With Search
→ Sessions With Product Impression
→ Sessions With Click
→ Sessions With Cart
→ Sessions With Purchase
```

## Metrics Created

| Metric                              | Meaning                                 |
| ----------------------------------- | --------------------------------------- |
| stage_count                         | Number of sessions at each funnel stage |
| previous_stage_count                | Count from previous stage               |
| stage_conversion_rate_pct           | Conversion from previous stage          |
| stage_dropoff_rate_pct              | Drop-off from previous stage            |
| overall_conversion_from_session_pct | Conversion from total sessions          |

## Why Session-Level Funnel Is Used

A raw event-count funnel can be misleading because one session can create multiple impressions or clicks.

Session-level funnel is cleaner because it asks:

```text
Did this session reach this stage or not?
```

This avoids inflated funnel counts.

---

## Funnel by Channel

This compares funnel performance by:

* app
* web
* store

It helps answer:

```text
Which channel converts better?
```

---

## Funnel by Traffic Source

This compares funnel performance by:

* affiliate
* influencer
* paid_search
* direct
* organic
* paid_social
* email

It helps answer:

```text
Which traffic source brings better converting users?
```

---

# 05_search_performance.sql

## Purpose

This file creates search query performance analytics.

Output:

```text
bi_search_performance.csv
```

## Main Metrics Created

| Metric                      | Meaning                                        |
| --------------------------- | ---------------------------------------------- |
| total_searches              | Number of searches for a query                 |
| zero_result_searches        | Searches with no result                        |
| zero_result_rate_pct        | Zero-result searches divided by total searches |
| impressions                 | Product impressions after search               |
| clicks                      | Product clicks after search                    |
| cart_adds                   | Cart additions after search                    |
| purchases                   | Purchases attributed to search                 |
| revenue                     | Revenue attributed to search                   |
| search_ctr_pct              | Clicks divided by impressions                  |
| click_to_cart_rate_pct      | Cart adds divided by clicks                    |
| search_to_purchase_rate_pct | Purchases divided by searches                  |
| revenue_per_search          | Revenue divided by searches                    |
| avg_clicked_rank            | Average clicked product rank                   |

## Why This File Matters

Search is very important in ecommerce.

A customer who searches has intent. This file helps understand whether search is helping customers find and buy products.

## Business Questions Answered

* Which queries generate the most revenue?
* Which queries have zero-result problems?
* Which queries have high CTR?
* Which queries convert to purchases?
* Which queries deserve ranking improvements?

---

# 06_product_brand_performance.sql

## Purpose

This file creates product and brand performance analytics.

Outputs:

```text
bi_product_ranking.csv
bi_brand_performance.csv
```

---

## Product Performance Logic

The product table combines:

* Product catalog data
* Impressions
* Clicks
* Cart additions
* Orders
* Revenue
* Returns
* Reviews
* Inventory stockout
* Ranking score

## Main Product Metrics

| Metric                     | Meaning                         |
| -------------------------- | ------------------------------- |
| impressions                | Times product was shown         |
| clicks                     | Times product was clicked       |
| cart_adds                  | Times product was added to cart |
| orders                     | Orders containing product       |
| product_revenue            | Revenue from product            |
| ctr_pct                    | Clicks divided by impressions   |
| click_to_cart_rate_pct     | Cart adds divided by clicks     |
| click_to_purchase_rate_pct | Orders divided by clicks        |
| return_rate_pct            | Return behavior                 |
| stockout_rate_pct          | Stockout behavior               |
| positive_review_pct        | Positive sentiment              |
| negative_review_pct        | Negative sentiment              |
| ranking_score              | Weighted product score          |

---

## Product Action Segments

Products are grouped into action segments:

| Segment                        | Meaning                                        |
| ------------------------------ | ---------------------------------------------- |
| Hero Product                   | Strong revenue, conversion, and ranking score  |
| Hidden Gem                     | Low visibility but strong conversion potential |
| High Visibility Low Conversion | Shown often but not converting                 |
| Return / Review Risk           | High returns or negative reviews               |
| Stockout Revenue Risk          | Stockouts may hurt revenue                     |
| Normal                         | No special action required                     |

## Why This Matters

This helps teams decide:

* Which products to promote
* Which products to demote
* Which products need investigation
* Which products need better product-page content
* Which products should not be promoted due to risk

---

## Brand Performance Logic

Brand performance rolls product metrics up to the brand level.

It helps answer:

* Which brands drive revenue?
* Which brands convert well?
* Which brands have hidden gems?
* Which brands have customer experience risk?
* Which brands have stockout risk?

---

# 07_campaign_performance.sql

## Purpose

This file creates campaign performance analytics.

Output:

```text
bi_campaign_performance.csv
```

## Main Metrics Created

| Metric                       | Meaning                             |
| ---------------------------- | ----------------------------------- |
| ad_spend                     | Total campaign spend                |
| ad_impressions               | Ad impressions                      |
| ad_clicks                    | Ad clicks                           |
| sessions                     | Sessions from campaign              |
| orders                       | Orders from campaign                |
| revenue                      | Campaign revenue                    |
| ad_ctr_pct                   | Ad clicks divided by ad impressions |
| cpc                          | Cost per click                      |
| cpa                          | Cost per order                      |
| cac                          | Cost per purchasing customer        |
| roas                         | Revenue divided by ad spend         |
| campaign_conversion_rate_pct | Orders divided by sessions          |
| revenue_per_session          | Revenue divided by sessions         |

## Campaign Action Segments

| Segment                  | Meaning                           |
| ------------------------ | --------------------------------- |
| Efficient Campaign       | Strong ROAS and reasonable CPA    |
| Low ROAS Campaign        | Spend is high compared to revenue |
| High CPA Campaign        | Cost per acquisition is high      |
| High Conversion Campaign | Converts well                     |
| No Paid Spend            | No campaign spend                 |
| Normal Campaign          | No special action                 |

## Why This Matters

Marketing teams need to know whether budget is creating value.

This file helps identify:

* Efficient campaigns
* Wasteful campaigns
* High-cost campaigns
* Campaigns worth scaling
* Campaigns needing optimization

---

# 08_customer_loyalty_analysis.sql

## Purpose

This file creates customer and loyalty segment analytics.

Output:

```text
bi_customer_segments.csv
```

## Customer Segments Used

Customers are grouped by:

* Loyalty status
* Preferred channel
* Skin type

## Main Metrics Created

| Metric                      | Meaning                                          |
| --------------------------- | ------------------------------------------------ |
| customers                   | Number of customers                              |
| sessions                    | Total sessions                                   |
| orders                      | Total orders                                     |
| revenue                     | Segment revenue                                  |
| avg_order_value             | Revenue divided by orders                        |
| session_conversion_rate_pct | Orders divided by sessions                       |
| revenue_per_customer        | Revenue divided by customers                     |
| sessions_per_customer       | Sessions divided by customers                    |
| purchasing_customers        | Customers with purchases                         |
| repeat_customers            | Customers with repeat purchases                  |
| repeat_purchase_rate_pct    | Repeat customers divided by purchasing customers |
| avg_session_duration_sec    | Average session duration                         |

## Customer Action Segments

| Segment                 | Meaning                                |
| ----------------------- | -------------------------------------- |
| High Conversion Segment | Strong conversion and revenue/customer |
| High Repeat Segment     | Strong repeat behavior                 |
| High Value Segment      | High revenue per customer              |
| No Purchase Segment     | Has customers but no purchases         |
| Normal Segment          | No special action                      |

## Why This Matters

Customer analytics helps understand which loyalty groups and customer profiles are most valuable.

This supports personalization, loyalty campaigns, and customer retention.

---

# 09_inventory_risk.sql

## Purpose

This file creates inventory and stockout risk analytics.

Output:

```text
bi_inventory_risk.csv
```

## Main Metrics Created

| Metric                      | Meaning                                 |
| --------------------------- | --------------------------------------- |
| avg_stock_on_hand           | Average stock level                     |
| min_stock_on_hand           | Lowest stock level                      |
| max_stock_on_hand           | Highest stock level                     |
| latest_stock_on_hand        | Most recent stock                       |
| latest_is_stockout          | Whether currently out of stock          |
| avg_daily_demand            | Average reserved units per day          |
| stockout_days               | Days product was out of stock           |
| inventory_days              | Total inventory tracking days           |
| stockout_rate_pct           | Stockout days divided by inventory days |
| days_of_supply              | Current stock divided by demand         |
| estimated_lost_revenue_risk | Estimated revenue risk from stockout    |

## Inventory Action Segments

| Segment                    | Meaning                           |
| -------------------------- | --------------------------------- |
| Currently Out of Stock     | Latest stock is zero              |
| Critical Low Stock         | Very low stock and demand exists  |
| Low Stock                  | Low stock and demand exists       |
| High Stockout Revenue Risk | Stockout has major revenue impact |
| Overstock Risk             | High stock but low sales          |
| High Demand Low Stock      | Demand exists but stock is low    |
| Normal                     | No special action                 |

## Why This Matters

Inventory problems can destroy revenue even when demand is strong.

This file helps prioritize replenishment.

---

# 10_recommendation_analysis.sql

## Purpose

This file creates recommendation performance analytics.

Output:

```text
bi_recommendation_performance.csv
```

## Recommendation Placements

| Placement       | Meaning                                 |
| --------------- | --------------------------------------- |
| home_recs       | Recommendations on homepage             |
| pdp_similar     | Similar products on product detail page |
| cart_cross_sell | Cross-sell recommendations in cart      |
| email_recs      | Email recommendation module             |

## Main Metrics Created

| Metric                           | Meaning                              |
| -------------------------------- | ------------------------------------ |
| recommendation_impressions       | Recommendation events shown          |
| recommendation_clicks            | Recommendation events clicked        |
| recommendation_purchases         | Purchases after recommendation       |
| sessions_reached                 | Sessions reached by recommendations  |
| customers_reached                | Customers reached by recommendations |
| recommendation_ctr_pct           | Clicks divided by impressions        |
| recommendation_cvr_pct           | Purchases divided by clicks          |
| recommendation_purchase_rate_pct | Purchases divided by impressions     |
| avg_rec_rank                     | Average recommendation rank          |
| avg_product_price                | Average product price                |
| avg_product_rating               | Average product rating               |
| total_loves_signal               | Sum of product loves/favorites       |

## Recommendation Action Segments

| Segment                       | Meaning                        |
| ----------------------------- | ------------------------------ |
| Strong Recommendation Segment | High CTR and high CVR          |
| High Interest Low Purchase    | High clicks but weak purchases |
| Low Engagement Recommendation | Low CTR                        |
| Normal Recommendation Segment | No special issue               |

## Why This Matters

Recommendation modules should be measured separately because each placement has a different job.

For example:

* PDP recommendations may drive conversion.
* Cart cross-sell may drive basket expansion.
* Email recommendations may drive re-engagement.

---

# 11_review_sentiment.sql

## Purpose

This file creates review and sentiment intelligence.

Output:

```text
bi_review_sentiment.csv
```

## Main Metrics Created

| Metric              | Meaning                                   |
| ------------------- | ----------------------------------------- |
| review_rows         | Total reviews for product                 |
| reviewing_customers | Customers who reviewed                    |
| avg_review_rating   | Average customer review rating            |
| positive_reviews    | Count of positive reviews                 |
| neutral_reviews     | Count of neutral reviews                  |
| negative_reviews    | Count of negative reviews                 |
| positive_review_pct | Positive reviews divided by total reviews |
| negative_review_pct | Negative reviews divided by total reviews |
| five_star_reviews   | Count of 5-star reviews                   |
| one_star_reviews    | Count of 1-star reviews                   |
| skin_type_coverage  | Number of skin types represented          |
| skin_tone_coverage  | Number of skin tones represented          |

## Review Action Segments

| Segment                  | Meaning                          |
| ------------------------ | -------------------------------- |
| High Complaint Risk      | High negative review percentage  |
| Loved Product            | High positive review percentage  |
| Low Review Hidden Gem    | Low review count but high rating |
| Low Satisfaction Product | Low average rating               |
| Normal Review Profile    | No major issue                   |

## Why This Matters

Reviews are customer truth.

They help identify:

* Products customers love
* Products with complaint risk
* Products with low satisfaction
* Hidden products with strong ratings
* Products that should or should not be promoted

---

# Final SQL Layer Summary

The SQL layer turns raw ecommerce-style tables into decision-ready BI tables.

## What SQL Does in This Project

| SQL Task                | Business Value                             |
| ----------------------- | ------------------------------------------ |
| Data quality checks     | Prevents wrong analysis                    |
| Clean views             | Standardizes messy fields                  |
| Executive KPIs          | Shows leadership health metrics            |
| Funnel analysis         | Finds user journey drop-offs               |
| Search analysis         | Finds query opportunities                  |
| Product ranking         | Finds Hero Products and Hidden Gems        |
| Brand analysis          | Helps merchandising teams                  |
| Campaign analysis       | Improves marketing spend                   |
| Customer analysis       | Supports loyalty strategy                  |
| Inventory analysis      | Reduces stockout revenue risk              |
| Recommendation analysis | Improves product discovery                 |
| Review sentiment        | Identifies satisfaction and complaint risk |

---

# Simple Explanation for Non-Technical Readers

This SQL workflow works like a factory.

```text
Raw data enters
        ↓
Data is checked
        ↓
Data is cleaned
        ↓
Tables are joined
        ↓
Metrics are calculated
        ↓
Business-ready tables are created
        ↓
Power BI dashboard uses those tables
```

The SQL layer is the engine behind the dashboard.

Power BI shows the results, but SQL creates the trusted numbers.
