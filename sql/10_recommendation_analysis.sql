
/*
Project: Sephora Omnichannel Ecommerce Intelligence Dashboard
File: 10_recommendation_analysis.sql
Purpose:
    This script creates recommendation placement performance analytics.

Output table:
    bi_recommendation_performance.csv
*/

-- ============================================================
-- RECOMMENDATION PERFORMANCE
-- ============================================================

WITH recommendation_base AS (
    SELECT
        r.recommendation_event_id,
        r.session_id,
        r.customer_id,
        r.product_id,
        r.placement,
        r.rec_rank,
        r.clicked,
        r.purchased,
        r.device_type,
        r.traffic_source,
        COALESCE(r.campaign_id, 'no_campaign') AS campaign_id,

        p.product_name,
        p.brand_name,
        p.category,
        p.price,
        p.product_tier,
        p.rating,
        p.review_count,
        p.loves_count

    FROM fact_recommendation_events r
    LEFT JOIN vw_dim_product_clean p
        ON r.product_id = p.product_id
),

recommendation_summary AS (
    SELECT
        placement,
        device_type,
        traffic_source,
        brand_name,
        category,

        COUNT(DISTINCT recommendation_event_id) AS recommendation_impressions,
        SUM(CASE WHEN clicked = TRUE THEN 1 ELSE 0 END) AS recommendation_clicks,
        SUM(CASE WHEN purchased = TRUE THEN 1 ELSE 0 END) AS recommendation_purchases,

        COUNT(DISTINCT session_id) AS sessions_reached,
        COUNT(DISTINCT customer_id) AS customers_reached,

        AVG(rec_rank) AS avg_rec_rank,
        AVG(price) AS avg_product_price,
        AVG(rating) AS avg_product_rating,
        SUM(loves_count) AS total_loves_signal

    FROM recommendation_base
    GROUP BY
        placement,
        device_type,
        traffic_source,
        brand_name,
        category
)

SELECT
    placement,
    device_type,
    traffic_source,
    brand_name,
    category,

    recommendation_impressions,
    recommendation_clicks,
    recommendation_purchases,
    sessions_reached,
    customers_reached,

    ROUND(
        recommendation_clicks * 100.0 / NULLIF(recommendation_impressions, 0),
        2
    ) AS recommendation_ctr_pct,

    ROUND(
        recommendation_purchases * 100.0 / NULLIF(recommendation_clicks, 0),
        2
    ) AS recommendation_cvr_pct,

    ROUND(
        recommendation_purchases * 100.0 / NULLIF(recommendation_impressions, 0),
        2
    ) AS recommendation_purchase_rate_pct,

    ROUND(avg_rec_rank, 2) AS avg_rec_rank,
    ROUND(avg_product_price, 2) AS avg_product_price,
    ROUND(avg_product_rating, 2) AS avg_product_rating,
    total_loves_signal,

    CASE
        WHEN recommendation_clicks * 100.0 / NULLIF(recommendation_impressions, 0) >= 20
             AND recommendation_purchases * 100.0 / NULLIF(recommendation_clicks, 0) >= 15
            THEN 'Strong Recommendation Segment'

        WHEN recommendation_clicks * 100.0 / NULLIF(recommendation_impressions, 0) >= 20
             AND recommendation_purchases * 100.0 / NULLIF(recommendation_clicks, 0) < 8
            THEN 'High Interest Low Purchase'

        WHEN recommendation_clicks * 100.0 / NULLIF(recommendation_impressions, 0) < 10
            THEN 'Low Engagement Recommendation'

        ELSE 'Normal Recommendation Segment'
    END AS recommendation_action_segment

FROM recommendation_summary
ORDER BY recommendation_purchases DESC, recommendation_ctr_pct DESC;
