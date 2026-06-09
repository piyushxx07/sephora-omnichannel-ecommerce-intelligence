# Dashboard Pages Documentation

## Overview

The Power BI dashboard contains 9 pages. Each page is designed to answer a specific business question for a Sephora-style omnichannel ecommerce business.

The dashboard is not only a visual report. It is designed as a business decision system that helps leadership understand performance across revenue, funnel, search, products, brands, campaigns, customers, inventory, recommendations, and reviews.

---

# Page 1: Executive Overview

## Page Purpose

The Executive Overview page gives leadership a fast summary of overall ecommerce health.

It answers:

* How much revenue was generated?
* How many orders were completed?
* How many sessions occurred?
* What is the conversion rate?
* What is the average order value?
* How high is cart abandonment?
* What is the return rate?
* How healthy is the overall funnel?

## Main Dataset Used

* `bi_executive_kpis.csv`
* `bi_funnel_session_summary.csv`

## Main KPIs

| KPI                   |        Value |
| --------------------- | -----------: |
| Total Revenue         | 1,173,053.30 |
| Completed Orders      |       16,248 |
| Total Sessions        |      350,000 |
| Conversion Rate       |        4.64% |
| Average Order Value   |        72.20 |
| Cart Abandonment Rate |       58.97% |
| Return Rate           |        4.73% |

## Visuals Used

| Visual                         | Purpose                                                                       |
| ------------------------------ | ----------------------------------------------------------------------------- |
| KPI Cards                      | Show revenue, orders, sessions, conversion, AOV, abandonment, return rate     |
| Executive Efficiency Bar Chart | Compare conversion, revenue/session, repeat purchase, return, and abandonment |
| Funnel Chart                   | Show journey from sessions to purchases                                       |

## Business Interpretation

The page shows that the business has a realistic ecommerce conversion rate of 4.64%, but cart abandonment is high at 58.97%. This means users are reaching the cart but many are not completing the journey.

## Business Action

Leadership should focus on improving the cart-to-purchase flow through:

* Better checkout experience
* Clearer delivery and return messaging
* Cart-level offers
* Trust indicators
* Payment flexibility
* Cart reminder campaigns

---

# Page 2: Funnel & Channel Performance

## Page Purpose

This page explains how users move through the funnel and how performance differs by channel and traffic source.

It answers:

* Where are users dropping in the funnel?
* Which channel converts best?
* Which traffic source converts best?
* How many users move from search to click to cart to purchase?

## Main Dataset Used

* `bi_funnel_session_summary.csv`
* `bi_funnel_by_channel.csv`
* `bi_funnel_by_traffic_source.csv`

## Main Funnel Stages

```text
Total Sessions
→ Sessions With Search
→ Sessions With Product Impression
→ Sessions With Click
→ Sessions With Cart
→ Sessions With Purchase
```

## Main KPIs

| KPI                    |   Value |
| ---------------------- | ------: |
| Total Sessions         | 350,000 |
| Sessions With Search   | 168,730 |
| Sessions With Click    | 126,320 |
| Sessions With Cart     |  35,592 |
| Sessions With Purchase |  16,248 |

## Visuals Used

| Visual                       | Purpose                                              |
| ---------------------------- | ---------------------------------------------------- |
| Funnel Chart                 | Shows user movement across stages                    |
| Conversion by Channel        | Compares app, web, and store conversion              |
| Conversion by Traffic Source | Compares paid, organic, affiliate, email, influencer |
| Drop-off Rate by Stage       | Identifies the biggest leakage point                 |

## Key Insight

The largest drop-off occurs before cart addition.

* Click to cart conversion: 28.18%
* Click to cart drop-off: 71.82%

This means many users show interest by clicking products but do not add products to cart.

## Business Action

Improve product-page experience:

* Better product descriptions
* Better product images
* Clear pricing and offer messaging
* Stock availability visibility
* Stronger reviews and trust signals
* Recommendation improvements
* Add-to-cart placement and UX optimization

---

# Page 3: Search & Product Discovery

## Page Purpose

This page analyzes search behavior and product discovery quality.

It answers:

* Which queries are searched most?
* Which queries generate the most revenue?
* Which queries have high CTR?
* Which queries have zero-result issues?
* Which queries are high-value opportunities?

## Main Dataset Used

* `bi_search_performance.csv`
* `bi_product_ranking.csv`

## Main KPIs

| KPI                      |                              Value |
| ------------------------ | ---------------------------------: |
| Total Searches           |                            168,730 |
| Average Search CTR       |                             24.91% |
| Average Zero Result Rate |                              3.43% |
| Search Revenue           | Based on search-attributed revenue |

## Important Search Findings

| Insight                     | Result          |
| --------------------------- | --------------- |
| Top revenue query           | retinol         |
| Top revenue value           | 65,952.05       |
| Highest search volume query | face mask       |
| Highest search volume       | 6,391           |
| Highest zero-result query   | kosas           |
| Highest zero-result rate    | 6.28%           |
| Best revenue/search query   | kate somerville |
| Revenue per search          | 14.10           |

## Visuals Used

| Visual                              | Purpose                                         |
| ----------------------------------- | ----------------------------------------------- |
| Top Search Queries by Revenue       | Finds the strongest revenue-driving queries     |
| Search CTR vs Purchase Rate Scatter | Identifies query quality and intent             |
| Highest Zero Result Queries         | Finds search failure points                     |
| Search Volume vs Revenue per Search | Compares popularity vs value                    |
| Product Discovery Segment Treemap   | Shows Hero Products, Hidden Gems, risk segments |

## Business Interpretation

High-intent skincare searches such as `retinol` generate strong revenue. Some brand queries such as `kosas` show zero-result issues, meaning users are expressing demand but the system may not be satisfying that demand.

## Business Action

* Boost high-revenue queries
* Fix zero-result queries
* Improve synonym mapping
* Improve brand/product keyword coverage
* Promote high-value low-volume queries
* Use search data to improve product ranking

---

# Page 4: Product & Brand Performance

## Page Purpose

This page helps product, merchandising, and brand teams understand which products and brands are performing well and which need action.

It answers:

* Which products generate the most revenue?
* Which products are Hero Products?
* Which products are Hidden Gems?
* Which products have high visibility but low conversion?
* Which brands are strong?
* Which brands have customer experience or conversion risks?

## Main Dataset Used

* `bi_product_ranking.csv`
* `bi_brand_performance.csv`

## Product Segments

| Segment                        | Meaning                                                 |
| ------------------------------ | ------------------------------------------------------- |
| Hero Product                   | Strong visibility, conversion, and revenue              |
| Hidden Gem                     | Low visibility but strong score or conversion potential |
| High Visibility Low Conversion | Receives impressions but does not convert               |
| Return / Review Risk           | High return or negative review risk                     |
| Stockout Revenue Risk          | Revenue risk due to stockout                            |
| Normal                         | No special action                                       |

## Product Segment Summary

| Segment                        | Products |    Revenue |
| ------------------------------ | -------: | ---------: |
| Hero Product                   |    1,458 | 641,167.90 |
| Normal                         |    5,551 | 384,348.64 |
| Return / Review Risk           |      576 | 105,574.47 |
| Hidden Gem                     |      436 |  40,384.44 |
| Stockout Revenue Risk          |       13 |   1,577.85 |
| High Visibility Low Conversion |      460 |       0.00 |

## Visuals Used

| Visual                                 | Purpose                                       |
| -------------------------------------- | --------------------------------------------- |
| Product Segment Treemap                | Shows distribution of product action segments |
| Top Brands by Revenue                  | Finds highest revenue brands                  |
| Product Revenue vs Conversion Scatter  | Compares revenue and conversion quality       |
| Top Products by Revenue                | Shows highest revenue products                |
| Brand Action Segment Mix               | Shows brand-level action categories           |
| Brand CTR vs Purchase Rate Combo Chart | Compares engagement and conversion            |

## Key Insight

Hero Products generate most revenue, while Hidden Gems show strong opportunity but lower visibility. High Visibility Low Conversion products indicate wasted exposure.

## Business Action

* Protect Hero Products in ranking
* Promote Hidden Gems in search and recommendations
* Investigate High Visibility Low Conversion products
* Review product-page content for poor performers
* Monitor return/review risk products before increasing visibility

---

# Page 5: Marketing & Campaign Performance

## Page Purpose

This page analyzes campaign efficiency and marketing spend performance.

It answers:

* Which campaigns generate the most revenue?
* Which traffic sources have the best ROAS?
* Which traffic sources have the highest spend?
* Which campaigns have poor CPA or ROAS?
* Which campaigns should be scaled or optimized?

## Main Dataset Used

* `bi_campaign_performance.csv`

## Main KPIs

| KPI                      | Purpose                              |
| ------------------------ | ------------------------------------ |
| Campaign Revenue         | Revenue attributed to campaigns      |
| Ad Spend                 | Total marketing spend                |
| ROAS                     | Revenue divided by ad spend          |
| CPA                      | Cost per acquisition/order           |
| Campaign Conversion Rate | Campaign session-to-order conversion |

## Campaign Findings

| Insight                     | Result                |
| --------------------------- | --------------------- |
| Best traffic source by ROAS | affiliate             |
| Best ROAS value             | 0.77                  |
| Highest spend source        | paid_search           |
| Paid search spend           | 1,206,034.80          |
| Top revenue campaign        | Sephora Campaign 0026 |
| Top campaign revenue        | 30,092.56             |
| Lowest ROAS campaign        | Sephora Campaign 0033 |
| Lowest ROAS value           | 0.06                  |

## Visuals Used

| Visual                          | Purpose                                        |
| ------------------------------- | ---------------------------------------------- |
| Revenue vs Ad Spend Combo Chart | Shows efficiency gap between spend and revenue |
| ROAS Gauge                      | Shows ROAS against target                      |
| Top Campaigns by Revenue        | Finds best revenue campaigns                   |
| Campaign Segment Mix Donut      | Shows campaign quality categories              |
| CPA by Traffic Source           | Shows acquisition cost by channel              |
| ROAS by Campaign Objective      | Compares campaign objective efficiency         |

## Business Interpretation

Paid search has the highest spend but weak ROAS. Affiliate performs better by ROAS. This means the highest-spend channel is not necessarily the most efficient.

## Business Action

* Review paid search strategy
* Reduce spend on very low ROAS campaigns
* Scale efficient affiliate campaigns
* Improve campaign landing pages
* Improve audience targeting
* Track ROAS by campaign objective

---

# Page 6: Customer & Loyalty Analytics

## Page Purpose

This page analyzes customer value by loyalty group, preferred channel, and skin type.

It answers:

* Which loyalty group generates the most revenue?
* Which loyalty group converts best?
* Which group has the highest revenue per customer?
* Which customer micro-segments are strongest?
* How do preferred channels affect conversion?

## Main Dataset Used

* `bi_customer_segments.csv`

## Main Loyalty Groups

| Loyalty Status | Meaning                             |
| -------------- | ----------------------------------- |
| non_member     | Customer without loyalty membership |
| insider        | Entry loyalty group                 |
| vib            | Mid-tier loyalty group              |
| rouge          | Highest-value loyalty group         |

## Loyalty Summary

| Loyalty Group | Customers |    Revenue | Avg Conversion Rate | Avg Revenue / Customer |
| ------------- | --------: | ---------: | ------------------: | ---------------------: |
| insider       |   211,616 | 423,712.29 |               4.27% |                   1.96 |
| vib           |    85,604 | 311,788.08 |               5.09% |                   3.52 |
| non_member    |   175,793 | 259,439.02 |               4.13% |                   1.50 |
| rouge         |    30,203 | 178,113.91 |               5.47% |                   5.99 |

## Visuals Used

| Visual                                    | Purpose                                     |
| ----------------------------------------- | ------------------------------------------- |
| Revenue by Loyalty Status                 | Shows revenue contribution by loyalty group |
| Customer Mix Donut                        | Shows customer base composition             |
| Conversion by Preferred Channel           | Shows channel preference performance        |
| Revenue by Skin Type Treemap              | Shows customer profile revenue              |
| Loyalty Revenue vs Conversion Combo Chart | Compares size vs quality                    |
| Customer Segment Performance              | Shows action segments                       |

## Key Insight

Insider customers generate the most revenue because they have the largest customer base. Rouge customers are the highest-quality segment because they have the best conversion and revenue per customer.

## Business Action

* Move Insider and VIB customers toward Rouge-like behavior
* Create loyalty upgrade campaigns
* Personalize offers by preferred channel
* Use skin type personalization for product discovery
* Retain Rouge customers with premium experiences

---

# Page 7: Inventory & Stockout Risk

## Page Purpose

This page identifies inventory problems that may create revenue loss.

It answers:

* Which products are currently out of stock?
* Which products have the highest lost revenue risk?
* Which categories have the highest stockout rate?
* Which products have low days of supply?
* Which inventory issues should be prioritized?

## Main Dataset Used

* `bi_inventory_risk.csv`

## Inventory Segment Summary

| Segment                | Products |    Revenue | Lost Revenue Risk |
| ---------------------- | -------: | ---------: | ----------------: |
| Currently Out of Stock |      732 |  19,267.22 |     17,494,979.94 |
| Normal                 |    6,289 | 920,597.63 |      2,099,648.84 |
| Low Stock              |    1,194 | 185,251.83 |        360,219.49 |
| Critical Low Stock     |      279 |  47,936.62 |         86,493.03 |

## Key Inventory Findings

| Insight                           | Result                                   |
| --------------------------------- | ---------------------------------------- |
| Products currently out of stock   | 732                                      |
| Total estimated lost revenue risk | 20,041,341.30                            |
| Top lost revenue risk product     | Touch Home Permanent Hair Removal Device |
| Top product lost revenue risk     | 270,298                                  |
| Highest stockout category         | Mini Size                                |

## Visuals Used

| Visual                            | Purpose                            |
| --------------------------------- | ---------------------------------- |
| Lost Revenue Risk Treemap         | Shows risk by inventory segment    |
| Stockout Rate by Category         | Finds high-risk categories         |
| Top Products by Lost Revenue Risk | Prioritizes replenishment          |
| Days of Supply Gauge              | Tracks stock health                |
| Demand vs Stock Scatter           | Shows high demand / low stock risk |
| Inventory Action Table            | Gives product-level action list    |

## Business Interpretation

Inventory is a major business risk. Products currently out of stock create most of the estimated lost revenue risk.

## Business Action

* Prioritize replenishment for high lost-revenue products
* Monitor Mini Size category stockouts
* Improve demand forecasting
* Align marketing campaigns with inventory availability
* Avoid promoting out-of-stock products

---

# Page 8: Recommendation Analytics

## Page Purpose

This page analyzes recommendation performance by placement, device, source, category, and brand.

It answers:

* Which recommendation placement drives the most purchases?
* Which placement has the best CTR?
* Which placement has the best CVR?
* Which brands perform best in recommendations?
* Which recommendation segments need action?

## Main Dataset Used

* `bi_recommendation_performance.csv`

## Recommendation Placements

| Placement       | Meaning                                       |
| --------------- | --------------------------------------------- |
| home_recs       | Recommendations shown on homepage             |
| pdp_similar     | Similar products shown on product detail page |
| cart_cross_sell | Cross-sell recommendations in cart            |
| email_recs      | Product recommendations in email              |

## Placement Summary

| Placement       | Impressions | Clicks | Purchases | Overall CTR | Overall CVR |
| --------------- | ----------: | -----: | --------: | ----------: | ----------: |
| pdp_similar     |     181,234 | 30,555 |     5,258 |      16.86% |      17.21% |
| home_recs       |     158,701 | 27,025 |     4,488 |      17.03% |      16.61% |
| cart_cross_sell |      96,047 | 16,443 |     2,772 |      17.12% |      16.86% |
| email_recs      |      95,397 | 16,319 |     2,749 |      17.11% |      16.85% |

## Key Recommendation Findings

| Insight                    | Result             |
| -------------------------- | ------------------ |
| Top placement by purchases | pdp_similar        |
| Best placement by CTR      | cart_cross_sell    |
| Best placement by CVR      | pdp_similar        |
| Top recommended brand      | SEPHORA COLLECTION |

## Visuals Used

| Visual                                       | Purpose                                      |
| -------------------------------------------- | -------------------------------------------- |
| Impressions vs CTR Combo Chart               | Compares scale and engagement                |
| CTR by Device Type                           | Shows device-level recommendation engagement |
| Top Brands from Recommendations              | Finds best brand recommendation outcomes     |
| Recommendation Segment Mix                   | Shows action categories                      |
| Recommendation Purchases by Category         | Shows category contribution                  |
| Recommendation Rank vs Purchase Rate Scatter | Analyzes ranking effectiveness               |
| Recommendation Action Table                  | Shows non-normal recommendation segments     |

## Business Interpretation

PDP similar recommendations drive the most purchases and best CVR. Cart cross-sell has the strongest CTR.

## Business Action

* Use PDP recommendations for conversion
* Use cart cross-sell for engagement
* Test recommendation ranking by placement
* Increase exposure for strong brands and categories
* Investigate low engagement recommendation segments

---

# Page 9: Reviews & Sentiment Intelligence

## Page Purpose

This page analyzes product review quality, customer satisfaction, and complaint risk.

It answers:

* Which products have the most reviews?
* Which products are loved?
* Which products have complaint risk?
* Which products have high negative sentiment?
* Which brands or categories need satisfaction improvement?

## Main Dataset Used

* `bi_review_sentiment.csv`

## Review Segment Summary

| Segment                  | Products | Total Reviews | Avg Rating | Avg Positive % | Avg Negative % |
| ------------------------ | -------: | ------------: | ---------: | -------------: | -------------: |
| Normal Review Profile    |    1,299 |       665,435 |       4.18 |         77.91% |         13.44% |
| Loved Product            |      643 |       545,612 |       4.56 |         90.45% |          4.51% |
| High Complaint Risk      |      147 |        86,201 |       3.66 |         62.44% |         26.97% |
| Low Satisfaction Product |      124 |         2,857 |       3.04 |         43.20% |         42.34% |
| Low Review Hidden Gem    |      138 |         1,031 |       4.79 |         95.28% |          2.57% |

## Key Review Findings

| Insight                         | Result                                     |
| ------------------------------- | ------------------------------------------ |
| Most reviewed product           | Lip Sleeping Mask                          |
| Most reviewed brand             | LANEIGE                                    |
| Highest negative review product | Clean Lip Balm & Scrub                     |
| Highest negative review rate    | 64.65%                                     |
| Top loved product               | Equilibrium Resurfacing Retinoid Treatment |
| Total review rows               | 1,301,136                                  |

## Visuals Used

| Visual                                    | Purpose                                   |
| ----------------------------------------- | ----------------------------------------- |
| Review Segment Donut                      | Shows product review action mix           |
| Star Rating Distribution                  | Shows review rating structure             |
| Top Loved Products                        | Highlights products with strong sentiment |
| Highest Negative Review Products          | Identifies complaint risk                 |
| Review Volume vs Rating Scatter           | Compares popularity and satisfaction      |
| Positive vs Negative Review Rate by Brand | Shows brand-level sentiment balance       |
| Review Action Table                       | Shows product-level review actions        |

## Business Interpretation

Loved Products show very strong positive sentiment and should be boosted. Complaint-risk and low-satisfaction products need investigation before being promoted.

## Business Action

* Boost Loved Products in search and recommendations
* Investigate high negative review products
* Improve product content where expectations are mismatched
* Use review signals in product ranking
* Monitor complaint-risk products before campaigns

---

# Dashboard Design Principles

The dashboard follows these design principles:

* Consistent Sephora-inspired visual identity
* Dark premium background
* Blush-pink chart accents
* Clear KPI cards
* Simple, readable visual types
* No unnecessary chart complexity
* Each page answers one business question
* Tables are used only when product-level action is needed
* Visual consistency across pages

---

# Final Dashboard Story

The dashboard tells one connected story:

```text
The business has healthy revenue and conversion,
but cart abandonment, campaign efficiency, inventory stockout risk,
and product discovery optimization are the biggest opportunities.
```

This makes the dashboard useful for leadership, marketing, merchandising, search/recommendation, inventory, and customer teams.
