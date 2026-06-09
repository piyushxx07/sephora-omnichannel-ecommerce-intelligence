# Data Dictionary

## Overview

This document explains the main datasets used in the **Sephora Omnichannel Ecommerce Intelligence Dashboard** project.

The project uses BI-ready summary tables generated from the original Sephora product/review dataset and industry-style ecommerce tables.

The final Power BI dashboard uses the following BI tables:

```text
bi_executive_kpis.csv
bi_funnel_session_summary.csv
bi_funnel_by_channel.csv
bi_funnel_by_traffic_source.csv
bi_search_performance.csv
bi_product_ranking.csv
bi_brand_performance.csv
bi_campaign_performance.csv
bi_customer_segments.csv
bi_inventory_risk.csv
bi_recommendation_performance.csv
bi_review_sentiment.csv
bi_dashboard_page_summary.csv
python_final_insights.csv
```

---

# 1. bi_executive_kpis.csv

## Purpose

Stores the high-level executive KPIs for the ecommerce business.

## Columns

| Column   | Meaning         |
| -------- | --------------- |
| `metric` | Name of the KPI |
| `value`  | KPI value       |

## Important Metrics

| Metric                  | Meaning                                     |
| ----------------------- | ------------------------------------------- |
| Total Sessions          | Total ecommerce sessions                    |
| Total Customers         | Total customers in the dataset              |
| Completed Orders        | Total completed orders                      |
| Total Revenue           | Revenue from completed orders               |
| Total Items Sold        | Number of items sold                        |
| Average Order Value     | Average revenue per completed order         |
| Conversion Rate %       | Completed orders divided by sessions        |
| Revenue Per Session     | Revenue divided by sessions                 |
| Repeat Purchase Rate %  | Share of customers with repeat purchases    |
| Return Rate %           | Share of returned orders                    |
| Cart Abandonment Rate % | Cart sessions that did not become purchases |

---

# 2. bi_funnel_session_summary.csv

## Purpose

Tracks the ecommerce funnel at session level.

## Columns

| Column                                | Meaning                                       |
| ------------------------------------- | --------------------------------------------- |
| `stage_order`                         | Funnel stage order                            |
| `stage_name`                          | Funnel stage name                             |
| `stage_count`                         | Number of sessions/users/events at that stage |
| `previous_stage_count`                | Count from previous stage                     |
| `stage_conversion_rate_pct`           | Conversion rate from previous stage           |
| `stage_dropoff_rate_pct`              | Drop-off rate from previous stage             |
| `overall_conversion_from_session_pct` | Conversion from total sessions to that stage  |

## Funnel Stages

```text
Total Sessions
Sessions With Search
Sessions With Product Impression
Sessions With Click
Sessions With Cart
Sessions With Purchase
```

---

# 3. bi_funnel_by_channel.csv

## Purpose

Compares funnel performance by channel.

## Columns

| Column                         | Meaning                                       |
| ------------------------------ | --------------------------------------------- |
| `channel`                      | User channel such as app, web, or store       |
| `sessions`                     | Total sessions                                |
| `sessions_with_search`         | Sessions where search happened                |
| `sessions_with_impression`     | Sessions with product impressions             |
| `sessions_with_click`          | Sessions with product clicks                  |
| `sessions_with_cart`           | Sessions with cart events                     |
| `sessions_with_purchase`       | Sessions with completed purchase              |
| `search_rate_pct`              | Search sessions divided by total sessions     |
| `impression_to_click_rate_pct` | Click sessions divided by impression sessions |
| `click_to_cart_rate_pct`       | Cart sessions divided by click sessions       |
| `cart_to_purchase_rate_pct`    | Purchase sessions divided by cart sessions    |
| `session_conversion_rate_pct`  | Purchase sessions divided by total sessions   |

---

# 4. bi_funnel_by_traffic_source.csv

## Purpose

Compares funnel performance by traffic source.

## Columns

| Column                         | Meaning                                                          |
| ------------------------------ | ---------------------------------------------------------------- |
| `traffic_source`               | Source of traffic such as paid search, organic, email, affiliate |
| `sessions`                     | Total sessions                                                   |
| `sessions_with_search`         | Sessions with search                                             |
| `sessions_with_impression`     | Sessions with impressions                                        |
| `sessions_with_click`          | Sessions with clicks                                             |
| `sessions_with_cart`           | Sessions with cart events                                        |
| `sessions_with_purchase`       | Sessions with purchases                                          |
| `search_rate_pct`              | Search rate                                                      |
| `impression_to_click_rate_pct` | Impression-to-click rate                                         |
| `click_to_cart_rate_pct`       | Click-to-cart rate                                               |
| `cart_to_purchase_rate_pct`    | Cart-to-purchase rate                                            |
| `session_conversion_rate_pct`  | Session-to-purchase conversion rate                              |

---

# 5. bi_search_performance.csv

## Purpose

Analyzes search query performance.

## Columns

| Column                        | Meaning                                        |
| ----------------------------- | ---------------------------------------------- |
| `search_query`                | Search term entered by user                    |
| `total_searches`              | Number of searches for the query               |
| `zero_result_searches`        | Searches returning zero results                |
| `zero_result_rate_pct`        | Zero-result searches divided by total searches |
| `impressions`                 | Product impressions generated from the query   |
| `clicks`                      | Product clicks generated from the query        |
| `cart_adds`                   | Cart additions attributed to the query         |
| `purchases`                   | Purchases attributed to the query              |
| `revenue`                     | Revenue attributed to the query                |
| `search_ctr_pct`              | Clicks divided by impressions                  |
| `click_to_cart_rate_pct`      | Cart adds divided by clicks                    |
| `search_to_purchase_rate_pct` | Purchases divided by searches                  |
| `revenue_per_search`          | Revenue divided by searches                    |
| `avg_clicked_rank`            | Average rank position clicked                  |

---

# 6. bi_product_ranking.csv

## Purpose

Ranks products and assigns product action segments.

## Columns

| Column                       | Meaning                                         |
| ---------------------------- | ----------------------------------------------- |
| `product_id`                 | Unique product identifier                       |
| `product_name`               | Product name                                    |
| `brand_name`                 | Brand name                                      |
| `category`                   | Product category                                |
| `price`                      | Product price                                   |
| `product_tier`               | Price tier such as budget, mid, premium, luxury |
| `rating`                     | Product rating                                  |
| `review_count`               | Number of catalog reviews                       |
| `loves_count`                | Product love/favorite count                     |
| `impressions`                | Product impressions                             |
| `clicks`                     | Product clicks                                  |
| `cart_adds`                  | Cart additions                                  |
| `orders`                     | Completed orders                                |
| `units_sold`                 | Units sold                                      |
| `product_revenue`            | Product revenue                                 |
| `avg_result_rank`            | Average search/recommendation result rank       |
| `ctr_pct`                    | Product click-through rate                      |
| `click_to_cart_rate_pct`     | Click-to-cart rate                              |
| `click_to_purchase_rate_pct` | Click-to-purchase rate                          |
| `revenue_per_impression`     | Revenue divided by impressions                  |
| `return_rate_pct`            | Product return rate                             |
| `stockout_rate_pct`          | Product stockout rate                           |
| `positive_review_pct`        | Positive review percentage                      |
| `negative_review_pct`        | Negative review percentage                      |
| `avg_stock_on_hand`          | Average stock available                         |
| `ranking_score`              | Weighted product ranking score                  |
| `product_action_segment`     | Product action category                         |

## Product Action Segments

| Segment                        | Meaning                                             |
| ------------------------------ | --------------------------------------------------- |
| Hero Product                   | Strong performer by revenue, visibility, conversion |
| Hidden Gem                     | Strong potential but low visibility                 |
| High Visibility Low Conversion | High impressions but poor conversion                |
| Return / Review Risk           | High return or negative review risk                 |
| Stockout Revenue Risk          | Stock issue may hurt revenue                        |
| Normal                         | No special action needed                            |

---

# 7. bi_brand_performance.csv

## Purpose

Summarizes product and revenue performance by brand.

## Columns

| Column                                    | Meaning                                  |
| ----------------------------------------- | ---------------------------------------- |
| `brand_name`                              | Brand name                               |
| `total_products`                          | Number of products for the brand         |
| `impressions`                             | Product impressions                      |
| `clicks`                                  | Product clicks                           |
| `cart_adds`                               | Cart additions                           |
| `orders`                                  | Orders                                   |
| `units_sold`                              | Units sold                               |
| `revenue`                                 | Brand revenue                            |
| `brand_ctr_pct`                           | Brand CTR                                |
| `brand_click_to_cart_rate_pct`            | Brand click-to-cart rate                 |
| `brand_click_to_purchase_rate_pct`        | Brand click-to-purchase rate             |
| `revenue_per_impression`                  | Revenue divided by impressions           |
| `avg_price`                               | Average product price                    |
| `avg_product_rating`                      | Average product rating                   |
| `total_catalog_reviews`                   | Total catalog reviews                    |
| `total_loves`                             | Total loves/favorites                    |
| `avg_return_rate_pct`                     | Average product return rate              |
| `avg_stockout_rate_pct`                   | Average stockout rate                    |
| `avg_positive_review_pct`                 | Average positive review percentage       |
| `avg_negative_review_pct`                 | Average negative review percentage       |
| `avg_ranking_score`                       | Average ranking score                    |
| `hero_products`                           | Count of Hero Products                   |
| `hidden_gems`                             | Count of Hidden Gems                     |
| `high_visibility_low_conversion_products` | Count of low-converting visible products |
| `return_review_risk_products`             | Count of return/review risk products     |
| `stockout_revenue_risk_products`          | Count of stockout risk products          |
| `brand_action_segment`                    | Brand action category                    |

---

# 8. bi_campaign_performance.csv

## Purpose

Analyzes campaign and marketing efficiency.

## Columns

| Column                         | Meaning                       |
| ------------------------------ | ----------------------------- |
| `campaign_id`                  | Unique campaign ID            |
| `campaign_name`                | Campaign name                 |
| `traffic_source`               | Traffic source                |
| `campaign_objective`           | Campaign objective            |
| `start_date`                   | Campaign start date           |
| `end_date`                     | Campaign end date             |
| `daily_budget`                 | Daily campaign budget         |
| `ad_spend`                     | Total ad spend                |
| `ad_impressions`               | Ad impressions                |
| `ad_clicks`                    | Ad clicks                     |
| `sessions`                     | Sessions from campaign        |
| `session_customers`            | Customers reached             |
| `orders`                       | Orders attributed to campaign |
| `purchasing_customers`         | Customers who purchased       |
| `revenue`                      | Campaign revenue              |
| `avg_order_value`              | Average order value           |
| `ad_ctr_pct`                   | Ad click-through rate         |
| `cpc`                          | Cost per click                |
| `cpa`                          | Cost per acquisition/order    |
| `cac`                          | Customer acquisition cost     |
| `roas`                         | Return on ad spend            |
| `campaign_conversion_rate_pct` | Campaign conversion rate      |
| `revenue_per_session`          | Campaign revenue per session  |
| `campaign_action_segment`      | Campaign action category      |

---

# 9. bi_customer_segments.csv

## Purpose

Analyzes customer and loyalty segments.

## Columns

| Column                        | Meaning                          |
| ----------------------------- | -------------------------------- |
| `loyalty_status`              | Loyalty group                    |
| `preferred_channel`           | Preferred shopping channel       |
| `skin_type`                   | Customer skin type               |
| `customers`                   | Number of customers              |
| `sessions`                    | Number of sessions               |
| `orders`                      | Number of orders                 |
| `revenue`                     | Segment revenue                  |
| `avg_order_value`             | Average order value              |
| `session_conversion_rate_pct` | Session-to-order conversion rate |
| `revenue_per_customer`        | Revenue divided by customers     |
| `sessions_per_customer`       | Sessions divided by customers    |
| `purchasing_customers`        | Customers who purchased          |
| `repeat_customers`            | Customers with repeat purchases  |
| `repeat_purchase_rate_pct`    | Repeat customer percentage       |
| `avg_session_duration_sec`    | Average session duration         |
| `customer_action_segment`     | Customer segment category        |

---

# 10. bi_inventory_risk.csv

## Purpose

Analyzes stockout, low-stock, and lost revenue risk.

## Columns

| Column                        | Meaning                                   |
| ----------------------------- | ----------------------------------------- |
| `product_id`                  | Product ID                                |
| `product_name`                | Product name                              |
| `brand_name`                  | Brand name                                |
| `category`                    | Product category                          |
| `price`                       | Product price                             |
| `product_tier`                | Product tier                              |
| `rating`                      | Product rating                            |
| `review_count`                | Review count                              |
| `loves_count`                 | Loves count                               |
| `units_sold`                  | Units sold                                |
| `revenue`                     | Product revenue                           |
| `orders`                      | Product orders                            |
| `impressions`                 | Product impressions                       |
| `clicks`                      | Product clicks                            |
| `avg_stock_on_hand`           | Average stock                             |
| `min_stock_on_hand`           | Minimum stock                             |
| `max_stock_on_hand`           | Maximum stock                             |
| `latest_inventory_date`       | Most recent inventory date                |
| `latest_stock_on_hand`        | Latest stock level                        |
| `latest_is_stockout`          | Whether product is currently out of stock |
| `total_replenishment_units`   | Total replenishment units                 |
| `total_units_reserved`        | Reserved units                            |
| `avg_daily_demand`            | Average daily demand                      |
| `stockout_days`               | Number of stockout days                   |
| `inventory_days`              | Inventory tracking days                   |
| `stockout_rate_pct`           | Stockout days divided by inventory days   |
| `ctr_pct`                     | Product CTR                               |
| `days_of_supply`              | Current stock divided by demand           |
| `estimated_lost_revenue_risk` | Estimated revenue risk from stockout      |
| `inventory_action_segment`    | Inventory action category                 |

---

# 11. bi_recommendation_performance.csv

## Purpose

Analyzes recommendation performance by placement, device, source, brand, and category.

## Columns

| Column                             | Meaning                                     |
| ---------------------------------- | ------------------------------------------- |
| `placement`                        | Recommendation placement                    |
| `device_type`                      | Device type                                 |
| `traffic_source`                   | Traffic source                              |
| `brand_name`                       | Brand name                                  |
| `category`                         | Product category                            |
| `recommendation_impressions`       | Recommendation impressions                  |
| `recommendation_clicks`            | Recommendation clicks                       |
| `recommendation_purchases`         | Recommendation purchases                    |
| `sessions_reached`                 | Sessions reached                            |
| `customers_reached`                | Customers reached                           |
| `recommendation_ctr_pct`           | Recommendation click-through rate           |
| `recommendation_cvr_pct`           | Recommendation click-to-purchase conversion |
| `recommendation_purchase_rate_pct` | Purchase rate from impressions              |
| `avg_rec_rank`                     | Average recommendation rank                 |
| `avg_product_price`                | Average product price                       |
| `avg_product_rating`               | Average product rating                      |
| `total_loves_signal`               | Total product love signal                   |
| `recommendation_action_segment`    | Recommendation action category              |

---

# 12. bi_review_sentiment.csv

## Purpose

Analyzes customer review sentiment and product satisfaction.

## Columns

| Column                  | Meaning                                 |
| ----------------------- | --------------------------------------- |
| `product_id`            | Product ID                              |
| `product_name`          | Product name                            |
| `brand_name`            | Brand name                              |
| `category`              | Product category                        |
| `price`                 | Product price                           |
| `product_tier`          | Product tier                            |
| `catalog_rating`        | Catalog rating                          |
| `catalog_review_count`  | Catalog review count                    |
| `loves_count`           | Product love/favorite count             |
| `review_rows`           | Number of review rows                   |
| `reviewing_customers`   | Customers who reviewed                  |
| `avg_review_rating`     | Average review rating                   |
| `positive_reviews`      | Positive review count                   |
| `neutral_reviews`       | Neutral review count                    |
| `negative_reviews`      | Negative review count                   |
| `positive_review_pct`   | Positive review percentage              |
| `neutral_review_pct`    | Neutral review percentage               |
| `negative_review_pct`   | Negative review percentage              |
| `five_star_reviews`     | Five-star review count                  |
| `four_star_reviews`     | Four-star review count                  |
| `three_star_reviews`    | Three-star review count                 |
| `two_star_reviews`      | Two-star review count                   |
| `one_star_reviews`      | One-star review count                   |
| `skin_type_coverage`    | Number of skin types covered by reviews |
| `skin_tone_coverage`    | Number of skin tones covered by reviews |
| `review_action_segment` | Review action category                  |

---

# 13. bi_dashboard_page_summary.csv

## Purpose

Stores headline KPIs for each dashboard page.

## Columns

| Column             | Meaning                   |
| ------------------ | ------------------------- |
| `dashboard_page`   | Dashboard page name       |
| `page_focus`       | Main focus of the page    |
| `headline_value_1` | First headline KPI value  |
| `headline_label_1` | First headline KPI label  |
| `headline_value_2` | Second headline KPI value |
| `headline_label_2` | Second headline KPI label |
| `headline_value_3` | Third headline KPI value  |
| `headline_label_3` | Third headline KPI label  |

---

# 14. python_final_insights.csv

## Purpose

Final Python-generated business insight table.

## Columns

| Column            | Meaning            |
| ----------------- | ------------------ |
| `area`            | Business area      |
| `key_insight`     | Main insight       |
| `business_action` | Recommended action |

---

# Notes

* Percentage fields are stored as percentage-point values, not decimals.
* Example: `4.64` means `4.64%`, not `0.0464`.
* Revenue fields are stored as numeric values.
* Some synthetic tables were generated to simulate real ecommerce operations.
* BI tables are already aggregated and optimized for Power BI reporting.
