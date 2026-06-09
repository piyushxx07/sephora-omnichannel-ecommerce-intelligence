
/*
Project: Sephora Omnichannel Ecommerce Intelligence Dashboard
File: 11_review_sentiment.sql
Purpose:
    This script creates review and sentiment intelligence analytics.

Output table:
    bi_review_sentiment.csv
*/

-- ============================================================
-- REVIEW & SENTIMENT INTELLIGENCE
-- ============================================================

WITH review_base AS (
    SELECT
        r.review_id,
        r.product_id,
        r.customer_id,
        r.review_rating,
        r.review_text,
        r.review_title,
        r.review_date,
        r.skin_type,
        r.skin_tone,
        r.sentiment_label,

        p.product_name,
        p.brand_name,
        p.category,
        p.price,
        p.product_tier,
        p.rating AS catalog_rating,
        p.review_count AS catalog_review_count,
        p.loves_count

    FROM fact_reviews r
    LEFT JOIN vw_dim_product_clean p
        ON r.product_id = p.product_id
),

review_summary AS (
    SELECT
        product_id,
        product_name,
        brand_name,
        category,
        price,
        product_tier,
        catalog_rating,
        catalog_review_count,
        loves_count,

        COUNT(DISTINCT review_id) AS review_rows,
        COUNT(DISTINCT customer_id) AS reviewing_customers,
        AVG(review_rating) AS avg_review_rating,

        SUM(CASE WHEN sentiment_label = 'positive' THEN 1 ELSE 0 END) AS positive_reviews,
        SUM(CASE WHEN sentiment_label = 'neutral' THEN 1 ELSE 0 END) AS neutral_reviews,
        SUM(CASE WHEN sentiment_label = 'negative' THEN 1 ELSE 0 END) AS negative_reviews,

        SUM(CASE WHEN review_rating = 5 THEN 1 ELSE 0 END) AS five_star_reviews,
        SUM(CASE WHEN review_rating = 4 THEN 1 ELSE 0 END) AS four_star_reviews,
        SUM(CASE WHEN review_rating = 3 THEN 1 ELSE 0 END) AS three_star_reviews,
        SUM(CASE WHEN review_rating = 2 THEN 1 ELSE 0 END) AS two_star_reviews,
        SUM(CASE WHEN review_rating = 1 THEN 1 ELSE 0 END) AS one_star_reviews,

        COUNT(DISTINCT skin_type) AS skin_type_coverage,
        COUNT(DISTINCT skin_tone) AS skin_tone_coverage

    FROM review_base
    GROUP BY
        product_id,
        product_name,
        brand_name,
        category,
        price,
        product_tier,
        catalog_rating,
        catalog_review_count,
        loves_count
)

SELECT
    product_id,
    product_name,
    brand_name,
    category,
    price,
    product_tier,
    catalog_rating,
    catalog_review_count,
    loves_count,

    review_rows,
    reviewing_customers,
    ROUND(avg_review_rating, 2) AS avg_review_rating,

    positive_reviews,
    neutral_reviews,
    negative_reviews,

    ROUND(positive_reviews * 100.0 / NULLIF(review_rows, 0), 2) AS positive_review_pct,
    ROUND(neutral_reviews * 100.0 / NULLIF(review_rows, 0), 2) AS neutral_review_pct,
    ROUND(negative_reviews * 100.0 / NULLIF(review_rows, 0), 2) AS negative_review_pct,

    five_star_reviews,
    four_star_reviews,
    three_star_reviews,
    two_star_reviews,
    one_star_reviews,

    skin_type_coverage,
    skin_tone_coverage,

    CASE
        WHEN review_rows >= 100
             AND negative_reviews * 100.0 / NULLIF(review_rows, 0) >= 20
            THEN 'High Complaint Risk'

        WHEN review_rows >= 100
             AND positive_reviews * 100.0 / NULLIF(review_rows, 0) >= 85
            THEN 'Loved Product'

        WHEN review_rows < 20
             AND catalog_rating >= 4.5
            THEN 'Low Review Hidden Gem'

        WHEN avg_review_rating < 3.5
            THEN 'Low Satisfaction Product'

        ELSE 'Normal Review Profile'
    END AS review_action_segment

FROM review_summary
ORDER BY review_rows DESC, negative_review_pct DESC;
