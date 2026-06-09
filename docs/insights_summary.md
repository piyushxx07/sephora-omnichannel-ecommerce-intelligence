# Insights Summary

## Overview

This document summarizes the key business insights found during the SQL, Python, and Power BI analysis for the **Sephora Omnichannel Ecommerce Intelligence Dashboard**.

The analysis covers:

* Executive KPIs
* Funnel performance
* Search and product discovery
* Product and brand performance
* Campaign efficiency
* Customer and loyalty behavior
* Inventory and stockout risk
* Recommendation performance
* Review and sentiment intelligence

The goal is to convert raw data into business actions that leadership and functional teams can use.

---

# 1. Executive Performance

## Key Metrics

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

## Insight

The business generated **1.17M revenue** from **350K sessions** with a **4.64% conversion rate**.

The conversion rate is reasonable for an ecommerce environment, but cart abandonment is high at **58.97%**. This means a large share of users are reaching the cart but not completing the purchase.

## Business Meaning

Revenue is healthy, but the funnel is leaking value. The main opportunity is not only attracting more traffic but converting existing interested users more efficiently.

## Recommended Actions

* Improve cart and checkout experience.
* Add trust signals near checkout.
* Improve delivery and return messaging.
* Use cart reminder campaigns.
* Test cart-level offers or free-shipping thresholds.
* Analyze why users leave after adding products to cart.

---

# 2. Funnel Performance

## Funnel Summary

| Stage                            |   Count | Stage Conversion | Drop-off |
| -------------------------------- | ------: | ---------------: | -------: |
| Total Sessions                   | 350,000 |                - |        - |
| Sessions With Search             | 168,730 |           48.21% |   51.79% |
| Sessions With Product Impression | 162,915 |           96.55% |    3.45% |
| Sessions With Click              | 126,320 |           77.54% |   22.46% |
| Sessions With Cart               |  35,592 |           28.18% |   71.82% |
| Sessions With Purchase           |  16,248 |           45.65% |   54.35% |

## Insight

The biggest funnel drop-off happens at the **cart stage**.

* Click to cart conversion: **28.18%**
* Click to cart drop-off: **71.82%**
* Overall session-to-purchase conversion: **4.64%**

## Business Meaning

Users are clicking products, which means product discovery is working at some level. However, many users do not add products to cart after clicking. This suggests product-page friction, pricing concern, weak product trust, poor offer visibility, or low purchase confidence.

## Recommended Actions

* Improve product detail page content.
* Make product benefits clearer.
* Highlight reviews, ratings, and social proof.
* Improve add-to-cart button visibility.
* Show stock availability and delivery promise.
* Test personalized offers on product pages.
* Compare clicked-but-not-carted products against product reviews and price.

---

# 3. Search & Product Discovery

## Search Findings

| Insight                       | Result          |
| ----------------------------- | --------------- |
| Top revenue query             | retinol         |
| Top revenue value             | 65,952.05       |
| Highest search volume query   | face mask       |
| Highest search volume         | 6,391           |
| Highest zero-result query     | kosas           |
| Highest zero-result rate      | 6.28%           |
| Best revenue per search query | kate somerville |
| Revenue per search            | 14.10           |

## Insight

Search is a strong revenue driver. The query **retinol** generated the highest revenue, while **face mask** had the highest search volume.

The query **kosas** had the highest zero-result rate, which shows a search coverage or matching issue.

## Business Meaning

Users are searching with clear product intent. High-intent skincare queries generate strong revenue. However, zero-result queries create missed revenue opportunities and poor user experience.

## Recommended Actions

* Boost high-revenue queries such as `retinol`.
* Review search results for high-volume queries such as `face mask`.
* Fix zero-result queries such as `kosas`.
* Add synonym mapping for product types, brands, and ingredients.
* Improve autocomplete suggestions for high-intent queries.
* Use revenue per search to prioritize search ranking improvements.

---

# 4. Product Discovery & Ranking

## Product Segment Summary

| Segment                        | Products |    Revenue | Avg Ranking Score | Avg CTR | Avg Purchase Rate | Avg Return Rate |
| ------------------------------ | -------: | ---------: | ----------------: | ------: | ----------------: | --------------: |
| Hero Product                   |    1,458 | 641,167.90 |              3.87 |  26.10% |            11.62% |           3.13% |
| Normal                         |    5,551 | 384,348.64 |              2.86 |  24.00% |             5.53% |           0.01% |
| Return / Review Risk           |      576 | 105,574.47 |              3.10 |  25.47% |             5.46% |          29.16% |
| Hidden Gem                     |      436 |  40,384.44 |              4.00 |  27.44% |            22.39% |           0.54% |
| Stockout Revenue Risk          |       13 |   1,577.85 |              2.91 |  15.13% |             8.07% |           0.00% |
| High Visibility Low Conversion |      460 |       0.00 |              2.29 |  19.22% |             0.00% |           5.33% |

## Insight

Hero Products drive the most revenue, but Hidden Gems have the strongest opportunity profile.

High Visibility Low Conversion products are receiving exposure but not generating revenue.

## Business Meaning

The product ranking system should not treat all products equally. Some products deserve protection, some deserve promotion, and some need investigation or demotion.

## Recommended Actions

* Protect Hero Products in search and recommendation placements.
* Promote Hidden Gems because they show strong conversion quality.
* Investigate High Visibility Low Conversion products.
* Reduce ranking weight for products that receive impressions but do not convert.
* Check product-page content for low-converting products.
* Monitor Return / Review Risk products before increasing visibility.

---

# 5. Brand Performance

## Insight

Brand-level performance shows which brands generate revenue, which brands have hidden opportunity, and which brands may have conversion or customer experience risk.

Some brands have many Hero Products, while others have many Return / Review Risk or High Visibility Low Conversion products.

## Business Meaning

Brand analysis helps merchandising and category managers make better decisions. A brand may generate revenue but still have customer satisfaction risk. Another brand may have lower revenue but high-potential hidden gems.

## Recommended Actions

* Promote brands with strong conversion and low return risk.
* Investigate brands with high return or review risk.
* Improve visibility for brands with multiple hidden gems.
* Monitor brand-level CTR and purchase rate together.
* Use brand action segments for merchandising planning.

---

# 6. Campaign Efficiency

## Traffic Source Summary

| Traffic Source | Campaigns |     Ad Spend |    Revenue | Orders | Overall ROAS |
| -------------- | --------: | -----------: | ---------: | -----: | -----------: |
| affiliate      |         3 |   113,023.90 |  87,518.09 |  1,187 |         0.77 |
| paid_social    |        14 |   622,236.38 | 197,821.78 |  2,702 |         0.32 |
| email          |        12 |   470,141.21 | 144,739.71 |  1,998 |         0.31 |
| paid_search    |        18 | 1,206,034.80 | 239,676.92 |  3,363 |         0.20 |
| influencer     |         9 |   597,625.26 |  79,334.49 |  1,135 |         0.13 |

## Key Findings

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

## Insight

Paid search has the highest spend but weak ROAS. Affiliate has the strongest ROAS among paid channels.

## Business Meaning

The channel receiving the most spend is not the most efficient. This creates a marketing budget optimization opportunity.

## Recommended Actions

* Review paid search campaign targeting.
* Reduce budget for low-ROAS campaigns.
* Scale affiliate campaigns if quality remains stable.
* Improve campaign landing pages.
* Track ROAS by objective and channel.
* Add margin-based ROAS if product margin data becomes available.

---

# 7. Customer & Loyalty Analytics

## Loyalty Summary

| Loyalty Group | Customers | Sessions | Orders |    Revenue | Avg Conversion | Avg Revenue / Customer | Avg Repeat Purchase |
| ------------- | --------: | -------: | -----: | ---------: | -------------: | ---------------------: | ------------------: |
| insider       |   211,616 |  135,644 |  5,943 | 423,712.29 |          4.27% |                   1.96 |               1.38% |
| vib           |    85,604 |   84,742 |  4,310 | 311,788.08 |          5.09% |                   3.52 |               2.31% |
| non_member    |   175,793 |   84,872 |  3,542 | 259,439.02 |          4.13% |                   1.50 |               0.71% |
| rouge         |    30,203 |   44,742 |  2,453 | 178,113.91 |          5.47% |                   5.99 |               4.10% |

## Key Findings

| Insight                      | Result                      |
| ---------------------------- | --------------------------- |
| Top loyalty group by revenue | insider                     |
| Best conversion group        | rouge                       |
| Best revenue/customer group  | rouge                       |
| Top micro-segment            | insider + web + combination |

## Insight

Insider customers generate the most total revenue because they are the largest group. Rouge customers are the highest-value segment because they have the best conversion rate and revenue per customer.

## Business Meaning

Customer value increases with loyalty maturity. The business should not only acquire customers but also move customers toward higher loyalty tiers.

## Recommended Actions

* Create loyalty upgrade campaigns.
* Personalize offers for Insider and VIB customers.
* Use Rouge behavior as a benchmark for high-value targeting.
* Improve repeat purchase campaigns.
* Use skin type and preferred channel for personalization.

---

# 8. Inventory & Stockout Risk

## Inventory Segment Summary

| Inventory Segment      | Products |    Revenue | Avg Stockout Rate | Avg Days of Supply | Lost Revenue Risk |
| ---------------------- | -------: | ---------: | ----------------: | -----------------: | ----------------: |
| Currently Out of Stock |      732 |  19,267.22 |            85.86% |              34.05 |     17,494,979.94 |
| Normal                 |    6,289 | 920,597.63 |             1.05% |              42.83 |      2,099,648.84 |
| Low Stock              |    1,194 | 185,251.83 |             0.95% |              10.43 |        360,219.49 |
| Critical Low Stock     |      279 |  47,936.62 |             1.03% |               3.82 |         86,493.03 |

## Key Findings

| Insight                           | Result                                   |
| --------------------------------- | ---------------------------------------- |
| Products currently out of stock   | 732                                      |
| Total estimated lost revenue risk | 20,041,341.30                            |
| Top risk product                  | Touch Home Permanent Hair Removal Device |
| Top product lost revenue risk     | 270,298                                  |
| Highest stockout category         | Mini Size                                |

## Insight

The biggest operational risk is inventory. Out-of-stock products create the majority of estimated lost revenue risk.

## Business Meaning

Even if search, recommendations, and campaigns perform well, revenue can still be lost if products are not available. Inventory availability is directly connected to ecommerce revenue.

## Recommended Actions

* Prioritize replenishment for high-risk products.
* Avoid running campaigns for products with low stock.
* Monitor stockout-prone categories.
* Connect inventory data with search and recommendation systems.
* Build early warning alerts for low days of supply.
* Improve demand forecasting for high-value products.

---

# 9. Recommendation Performance

## Placement Summary

| Placement       | Impressions | Clicks | Purchases | Overall CTR | Overall CVR |
| --------------- | ----------: | -----: | --------: | ----------: | ----------: |
| pdp_similar     |     181,234 | 30,555 |     5,258 |      16.86% |      17.21% |
| home_recs       |     158,701 | 27,025 |     4,488 |      17.03% |      16.61% |
| cart_cross_sell |      96,047 | 16,443 |     2,772 |      17.12% |      16.86% |
| email_recs      |      95,397 | 16,319 |     2,749 |      17.11% |      16.85% |

## Key Findings

| Insight                    | Result             |
| -------------------------- | ------------------ |
| Top placement by purchases | pdp_similar        |
| Best placement by CTR      | cart_cross_sell    |
| Best placement by CVR      | pdp_similar        |
| Top recommended brand      | SEPHORA COLLECTION |

## Insight

PDP similar recommendations drive the most purchases and have the best CVR. Cart cross-sell has the best CTR.

## Business Meaning

Different recommendation placements have different jobs. PDP similar recommendations are stronger for conversion, while cart cross-sell is stronger for engagement.

## Recommended Actions

* Use PDP recommendations for conversion-focused strategy.
* Use cart cross-sell for engagement and basket expansion.
* Test recommendation ranking by placement.
* Monitor recommendation performance by device and traffic source.
* Increase visibility for high-performing brands in recommendation modules.

---

# 10. Reviews & Sentiment

## Review Segment Summary

| Segment                  | Products | Total Reviews | Avg Rating | Avg Positive % | Avg Negative % | Negative Reviews |
| ------------------------ | -------: | ------------: | ---------: | -------------: | -------------: | ---------------: |
| Normal Review Profile    |    1,299 |       665,435 |       4.18 |         77.91% |         13.44% |           84,063 |
| Loved Product            |      643 |       545,612 |       4.56 |         90.45% |          4.51% |           27,954 |
| High Complaint Risk      |      147 |        86,201 |       3.66 |         62.44% |         26.97% |           22,920 |
| Low Satisfaction Product |      124 |         2,857 |       3.04 |         43.20% |         42.34% |            1,134 |
| Low Review Hidden Gem    |      138 |         1,031 |       4.79 |         95.28% |          2.57% |               33 |

## Key Findings

| Insight                         | Result                                     |
| ------------------------------- | ------------------------------------------ |
| Most reviewed product           | Lip Sleeping Mask                          |
| Most reviewed brand             | LANEIGE                                    |
| Highest negative review product | Clean Lip Balm & Scrub                     |
| Highest negative review rate    | 64.65%                                     |
| Top loved product               | Equilibrium Resurfacing Retinoid Treatment |
| Total review rows               | 1,301,136                                  |

## Insight

Loved Products show very strong positive sentiment. High Complaint Risk and Low Satisfaction products show clear customer experience issues.

## Business Meaning

Review sentiment can be used as a ranking and merchandising signal. A product with high negative sentiment should not be promoted aggressively without investigation.

## Recommended Actions

* Boost Loved Products in search and recommendations.
* Investigate High Complaint Risk products.
* Improve product descriptions where expectations are mismatched.
* Use review sentiment as an input in ranking logic.
* Monitor negative review spikes by product and brand.

---

# Final Executive Story

The business is generating healthy revenue and has a realistic ecommerce conversion rate, but several optimization opportunities stand out:

1. Cart abandonment is high.
2. Search has high-value queries but some zero-result gaps.
3. Hero Products drive revenue, while Hidden Gems need more visibility.
4. Paid search spend is high but ROAS is weak.
5. Rouge customers are the highest-value loyalty group.
6. Inventory stockouts create major estimated revenue loss.
7. PDP recommendations are strong conversion drivers.
8. Review sentiment can help improve ranking and product trust.

## Final Recommendation

The business should focus on four priority areas:

| Priority  | Action                                          |
| --------- | ----------------------------------------------- |
| Funnel    | Reduce cart-stage drop-off                      |
| Campaigns | Improve paid search ROAS                        |
| Inventory | Fix high-risk stockouts                         |
| Discovery | Promote Hidden Gems and fix zero-result queries |

These actions can improve revenue, customer experience, product discovery, and operational efficiency.
