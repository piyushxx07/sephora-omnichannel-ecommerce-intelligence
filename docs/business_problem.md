# Business Problem

## Background

A modern beauty ecommerce company like Sephora operates across many customer touchpoints. Customers do not follow one simple path. They may discover products through search, recommendations, campaigns, reviews, loyalty offers, or product pages.

A customer journey may look like this:

```text
Ad Campaign → Website Visit → Search Query → Product Impression → Click → Cart → Purchase → Review → Repeat Purchase
```

Because this journey involves many systems, business performance cannot be understood from revenue alone.

The company needs a unified analytics system that connects customer behavior, product discovery, marketing, inventory, recommendations, and customer feedback.

---

## Core Business Problem

Leadership wants one system that answers:

```text
What is working?
What is not working?
Where are customers dropping?
Which products should be promoted?
Which campaigns are wasting money?
Which customers are most valuable?
Which inventory issues are causing lost revenue?
Which products have customer satisfaction risk?
```

Without this system, teams work in silos.

Marketing may optimize ad spend without knowing whether traffic converts.
Product teams may promote products without knowing review risk.
Inventory teams may track stock without knowing lost revenue impact.
Search teams may improve relevance without knowing revenue impact.
Leadership may see revenue but not understand why it increased or decreased.

---

## Business Pain Points

### 1. Executive KPI Visibility

Leadership needs to know whether the business is healthy.

Important questions:

* What is total revenue?
* How many orders were completed?
* How many sessions occurred?
* What is the conversion rate?
* What is the average order value?
* What is the return rate?
* What is the cart abandonment rate?

Revenue alone is not enough. A business can have high revenue and still have hidden issues such as weak conversion, high returns, or poor funnel performance.

---

### 2. Funnel Drop-off

Ecommerce teams need to know where customers leave the buying journey.

The funnel in this project is:

```text
Total Sessions
→ Sessions With Search
→ Sessions With Product Impression
→ Sessions With Click
→ Sessions With Cart
→ Sessions With Purchase
```

Key business questions:

* How many users reach each stage?
* Which stage has the biggest drop-off?
* Are users searching but not clicking?
* Are users clicking products but not adding to cart?
* Are users adding to cart but not purchasing?

In this project, the biggest drop-off happens at the cart stage. That means users are showing product interest but not moving strongly into purchase behavior.

---

### 3. Search and Product Discovery Problems

For a beauty retailer, search is one of the most important discovery tools.

Customers often search for:

* Ingredients
* Product types
* Brands
* Skin concerns
* Specific products

Examples:

* retinol
* toner
* niacinamide
* face mask
* moisturizer
* kosas
* kate somerville

Business questions:

* Which search queries generate the most revenue?
* Which queries have high CTR?
* Which queries convert into purchases?
* Which queries show zero-result issues?
* Which queries deserve ranking optimization?

A high zero-result rate means users are expressing demand but the search system is not satisfying that demand.

---

### 4. Product Ranking and Merchandising

Not every product should be treated the same.

Some products are strong performers and should be protected.
Some products are hidden opportunities and should be promoted.
Some products receive visibility but do not convert.
Some products have return or review risk.

This project segments products into:

| Segment                        | Meaning                                               |
| ------------------------------ | ----------------------------------------------------- |
| Hero Product                   | Strong visibility, conversion, and revenue            |
| Hidden Gem                     | Low visibility but strong conversion/rating potential |
| High Visibility Low Conversion | Product receives attention but does not convert       |
| Return / Review Risk           | Product may create customer dissatisfaction           |
| Stockout Revenue Risk          | Product has stockout-related revenue risk             |
| Normal                         | No special action required                            |

Business questions:

* Which products should be promoted?
* Which products should be demoted?
* Which products need better product-page content?
* Which products should be investigated because of return or review risk?
* Which products are high-potential but underexposed?

---

### 5. Brand Performance

Retail leaders also need to understand brand-level performance.

Business questions:

* Which brands generate the most revenue?
* Which brands have high CTR?
* Which brands convert well?
* Which brands have hidden opportunities?
* Which brands have customer experience risk?
* Which brands contain too many low-converting products?

Brand-level analysis helps category managers and merchandising teams make better commercial decisions.

---

### 6. Campaign Efficiency

Marketing teams spend money across paid and organic sources.

Traffic sources include:

* paid_search
* paid_social
* affiliate
* influencer
* email
* direct
* organic

Business questions:

* Which campaigns generate the most revenue?
* Which campaigns have the best ROAS?
* Which traffic source has the highest spend?
* Which campaigns have low ROAS?
* Which campaigns should receive more budget?
* Which campaigns should be reduced or optimized?

A campaign can generate revenue but still be inefficient if the spend is too high.

This project shows that paid search has the highest spend but weak ROAS, while affiliate performs better by ROAS.

---

### 7. Customer and Loyalty Segmentation

Customer behavior differs by loyalty status and preferred channel.

Loyalty groups include:

* non_member
* insider
* vib
* rouge

Business questions:

* Which loyalty group generates the most revenue?
* Which group converts best?
* Which group has the highest revenue per customer?
* Which group has stronger repeat purchase behavior?
* Which preferred channel performs better?

In this project, Insiders generate the most total revenue because they are the largest group. Rouge customers are more valuable because they have better conversion and revenue per customer.

---

### 8. Inventory and Stockout Risk

Inventory problems can directly cause lost revenue.

A product can have strong demand but fail to generate sales if it is out of stock.

Business questions:

* Which products are currently out of stock?
* Which products have high stockout rates?
* Which products have low days of supply?
* Which categories have the highest stockout risk?
* Which products create the highest estimated lost revenue risk?

This project estimates lost revenue risk using inventory, demand, and price signals.

Inventory risk is one of the strongest business problems in the project because 732 products are currently out of stock and estimated lost revenue risk is over 20M.

---

### 9. Recommendation Performance

Recommendations are important for ecommerce discovery.

Recommendation placements include:

* home_recs
* pdp_similar
* cart_cross_sell
* email_recs

Business questions:

* Which placement gets the most impressions?
* Which placement gets the most clicks?
* Which placement drives the most purchases?
* Which placement has the best CTR?
* Which placement has the best CVR?
* Which brands perform well in recommendations?

This project shows that PDP similar recommendations drive the most purchases, while cart cross-sell has the best CTR.

---

### 10. Review and Sentiment Risk

Customer reviews reveal product trust and satisfaction.

Business questions:

* Which products are loved?
* Which products have high complaint risk?
* Which products have low satisfaction?
* Which products have high review volume?
* Which products have high negative sentiment?
* Which products should be boosted or investigated?

Review sentiment is important because a product may have strong visibility but weak customer satisfaction.

This project identifies Loved Products, High Complaint Risk products, Low Satisfaction Products, and Low Review Hidden Gems.

---

## Final Business Problem Statement

Sephora-style ecommerce leadership needs a unified intelligence dashboard that connects sales, funnel behavior, search performance, product discovery, campaign efficiency, loyalty behavior, inventory risk, recommendation performance, and review sentiment into one decision-making system.

The dashboard should help teams:

* Increase conversion
* Reduce funnel drop-off
* Improve search quality
* Promote better products
* Reduce campaign waste
* Grow high-value customer segments
* Prevent stockout-related revenue loss
* Optimize recommendation placements
* Improve product trust and customer satisfaction

---

## Business Impact Expected

If this system were used by a real ecommerce team, it could help improve:

| Area              | Business Impact                           |
| ----------------- | ----------------------------------------- |
| Funnel            | Reduce drop-off and improve conversion    |
| Search            | Improve result quality and search revenue |
| Product Discovery | Promote high-potential products           |
| Marketing         | Reduce wasted ad spend                    |
| Customers         | Improve loyalty and repeat purchase       |
| Inventory         | Reduce stockout-driven revenue loss       |
| Recommendations   | Improve cross-sell and discovery          |
| Reviews           | Identify satisfaction and complaint risk  |

---

## Why This Project Is Strong for Portfolio

This project is not only a dashboard. It shows a complete analytics thinking process:

```text
Business Problem
→ Dataset Understanding
→ Data Model Creation
→ SQL KPI Generation
→ Python Insight Analysis
→ Power BI Dashboard
→ Business Recommendations
```

This makes the project more realistic and more valuable for data analyst, BI analyst, ecommerce analyst, and product analyst roles.
