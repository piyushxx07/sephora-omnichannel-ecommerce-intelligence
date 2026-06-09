# Limitations

## Overview

This document explains the limitations of the **Sephora Omnichannel Ecommerce Intelligence Dashboard** project.

Every analytics project has assumptions and limitations. This project is designed as a portfolio-level ecommerce analytics system using a public dataset and industry-style generated tables. The analysis is useful for demonstrating business thinking, SQL, Python, and Power BI skills, but it is not a production Sephora internal dataset.

---

# 1. Dataset Limitation

The original dataset used in this project is the public Kaggle dataset:

**Sephora Products and Skincare Reviews**

The original dataset mainly contains:

* Product information
* Product prices
* Product ratings
* Product categories
* Customer reviews
* Review ratings
* Skin type information
* Skin tone information

It does not contain complete real internal ecommerce data such as:

* Actual website session logs
* Real search logs
* Real clickstream events
* Real add-to-cart events
* Real orders
* Real campaign spend
* Real inventory movement
* Real recommendation impressions
* Real loyalty transactions

To make the project more realistic, additional industry-style ecommerce tables were generated from the available product and review signals.

---

# 2. Synthetic Table Limitation

Some tables in this project are generated to simulate ecommerce behavior.

Generated tables include:

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
* `dim_customer`
* `dim_campaign`

These tables are not official Sephora internal data. They are created for analytics simulation and portfolio demonstration.

## Why Synthetic Tables Were Used

The original dataset was not enough to build a complete omnichannel ecommerce intelligence dashboard.

A real ecommerce dashboard needs:

* Sessions
* Searches
* Clicks
* Cart events
* Orders
* Campaign spend
* Inventory
* Recommendations
* Loyalty behavior

Since the public dataset did not provide these tables, synthetic but realistic tables were created to simulate a business environment.

---

# 3. Accuracy Limitation

The dashboard reflects the logic of an ecommerce analytics system, but the results should not be interpreted as actual Sephora business performance.

For example:

* Revenue values are simulated.
* Campaign spend is simulated.
* Inventory lost revenue risk is estimated.
* Recommendation performance is simulated.
* Customer loyalty behavior is simulated.
* Session-level behavior is simulated.

The project demonstrates analytical structure and business reasoning, not official company performance.

---

# 4. Review Sentiment Limitation

The review sentiment analysis is based on simplified sentiment labels.

Sentiment categories include:

* positive
* neutral
* negative

In a production environment, review sentiment should ideally use a more advanced NLP pipeline, such as:

* Text preprocessing
* Sentiment scoring
* Topic modeling
* Complaint theme extraction
* Aspect-based sentiment analysis
* Product issue clustering
* Review authenticity checks

This project uses sentiment for business-level analysis, not deep NLP research.

---

# 5. Forecasting Limitation

Forecasting is not a major part of the final dashboard because complete date-level revenue, order, and session history was limited.

For stronger forecasting, the project would need:

* Daily revenue
* Daily orders
* Daily sessions
* Campaign calendar
* Seasonality events
* Holiday indicators
* Promotion dates
* Product launch dates
* Inventory availability by date

Without detailed time-series data, advanced forecasting would be less reliable.

---

# 6. Campaign Attribution Limitation

Campaign performance is based on simplified attribution.

In real ecommerce analytics, campaign attribution is more complex because users may interact with multiple channels before purchase.

Real attribution models may include:

* Last-click attribution
* First-click attribution
* Linear attribution
* Time-decay attribution
* Position-based attribution
* Data-driven attribution
* Multi-touch attribution

This project uses simplified campaign-level attribution to demonstrate marketing analytics.

---

# 7. Inventory Risk Limitation

Estimated lost revenue risk is a business approximation.

The project estimates risk using:

* Stockout behavior
* Product demand
* Product price
* Inventory availability

In a real business, lost revenue risk should also consider:

* Product margin
* Substitute products
* Customer backorders
* Demand elasticity
* Supplier lead time
* Replenishment frequency
* Promotion calendar
* Seasonality
* Store-level inventory

So the inventory risk score should be treated as directional, not exact.

---

# 8. Recommendation Analytics Limitation

Recommendation performance is simulated and does not come from a real recommendation engine.

A production recommendation system would require:

* User-item interaction history
* Real-time clickstream data
* Recommendation algorithm outputs
* A/B test results
* Ranking position logs
* Personalization features
* User embeddings
* Product embeddings

This project uses recommendation events to simulate how recommendation performance can be measured.

---

# 9. Customer Segmentation Limitation

Customer segmentation is based on generated customer profiles and loyalty status.

In a real business, customer segmentation would be stronger with:

* Customer lifetime value
* Historical purchases
* Visit frequency
* Loyalty points
* Recency, frequency, monetary analysis
* Churn probability
* Customer acquisition source
* Promotion sensitivity
* Product affinity
* Location
* Demographic attributes if legally and ethically usable

This project uses customer segmentation for dashboard demonstration and business analysis.

---

# 10. Product Ranking Limitation

The product ranking score is a weighted analytical score created for this project.

It uses signals such as:

* CTR
* Conversion
* Revenue
* Rating
* Stock availability

In a real ecommerce platform, ranking would likely include many more factors:

* Personalization
* Query relevance
* Semantic similarity
* Availability
* Price competitiveness
* Margin
* Delivery speed
* Return risk
* Review sentiment
* Customer segment
* Business rules
* Sponsored products
* A/B testing results

The score in this project is designed for analytics explanation, not production ranking deployment.

---

# 11. Power BI Limitation

The Power BI dashboard uses BI-ready summary tables rather than a full star schema connected to raw fact tables.

This was done intentionally to:

* Improve dashboard speed
* Keep the model simple
* Make the project easier to understand
* Reduce file size
* Avoid unnecessary relationship complexity

In a production environment, the Power BI semantic model could include:

* Star schema
* Date dimension
* Product dimension
* Customer dimension
* Campaign dimension
* Fact tables
* Incremental refresh
* Row-level security
* Certified metrics layer

---

# 12. GitHub File Size Limitation

The raw dataset is large, so raw files should not be committed directly to GitHub.

Instead:

* Raw files should be downloaded from Kaggle.
* Raw files should be placed in `data/raw/`.
* BI-ready summary tables can be stored in `data/bi_tables/`.
* Large files should be excluded using `.gitignore`.

---

# 13. Ethical and Branding Note

This project is inspired by Sephora-style ecommerce analytics and uses a public dataset containing Sephora product and review information.

This is not an official Sephora internal dashboard.

The project is for:

* Portfolio demonstration
* Data analysis practice
* Business intelligence learning
* Ecommerce analytics simulation

It should not be represented as official Sephora business data.

---

# 14. Final Limitation Summary

| Limitation Area | Explanation                                           |
| --------------- | ----------------------------------------------------- |
| Data Source     | Public dataset, not internal company data             |
| Transactions    | Orders and sessions are simulated                     |
| Campaigns       | Spend and attribution are simulated                   |
| Inventory       | Stockout and lost revenue risk are estimated          |
| Recommendations | Recommendation events are simulated                   |
| Sentiment       | Simplified sentiment classification                   |
| Forecasting     | Limited by lack of full time-series data              |
| Power BI Model  | Uses BI summary tables instead of full semantic model |

---

# Final Note

Despite these limitations, the project successfully demonstrates how a data analyst can turn product, review, and ecommerce-style data into a complete business intelligence solution.

The main value of the project is not that it represents exact Sephora internal numbers. The value is that it shows a realistic analytics workflow:

```text
Business problem
→ Data model
→ SQL analysis
→ Python validation
→ BI dashboard
→ Business recommendations
```

This makes the project suitable for a data analyst, BI analyst, ecommerce analyst, or product analyst portfolio.
