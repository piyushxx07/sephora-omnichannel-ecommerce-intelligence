
/*
Project: Sephora Omnichannel Ecommerce Intelligence Dashboard
File: 05_search_performance.sql
Purpose:
    This script creates search query performance analytics.

Output table:
    bi_search_performance.csv
*/

-- ============================================================
-- SEARCH QUERY PERFORMANCE
-- ============================================================

WITH search_base AS (
    SELECT
        search_event_id,
        session_id,
        customer_id,
        search_query,
        COALESCE(zero_results, FALSE) AS zero_results,
        COALESCE(results_count, 0) AS results_count,
        device_type,
        traffic_source,
        COALESCE(campaign_id, 'no_campaign') AS campaign_id
    FROM fact_search_events
),

impression_metrics AS (
    SELECT
        search_event_id,
        COUNT(DISTINCT impression_id) AS impressions
    FROM fact_product_impressions
    GROUP BY search_event_id
),

click_metrics AS (
    SELECT
        pi.search_event_id,
        COUNT(DISTINCT c.click_id) AS clicks,
        AVG(c.result_rank) AS avg_clicked_rank
    FROM fact_clicks c
    INNER JOIN fact_product_impressions pi
        ON c.impression_id = pi.impression_id
    GROUP BY pi.search_event_id
),

cart_metrics AS (
    SELECT
        pi.search_event_id,
        COUNT(DISTINCT ce.cart_event_id) AS cart_adds
    FROM fact_cart_events ce
    INNER JOIN fact_clicks c
        ON ce.click_id = c.click_id
    INNER JOIN fact_product_impressions pi
        ON c.impression_id = pi.impression_id
    GROUP BY pi.search_event_id
),

purchase_metrics AS (
    SELECT
        pi.search_event_id,
        COUNT(DISTINCT o.order_id) AS purchases,
        SUM(o.net_revenue) AS revenue
    FROM fact_orders o
    INNER JOIN fact_clicks c
        ON o.session_id = c.session_id
    INNER JOIN fact_product_impressions pi
        ON c.impression_id = pi.impression_id
    WHERE o.order_status = 'completed'
    GROUP BY pi.search_event_id
),

search_joined AS (
    SELECT
        sb.search_query,
        sb.search_event_id,
        sb.zero_results,

        COALESCE(im.impressions, 0) AS impressions,
        COALESCE(cm.clicks, 0) AS clicks,
        COALESCE(cm.avg_clicked_rank, NULL) AS avg_clicked_rank,
        COALESCE(cam.cart_adds, 0) AS cart_adds,
        COALESCE(pm.purchases, 0) AS purchases,
        COALESCE(pm.revenue, 0) AS revenue

    FROM search_base sb
    LEFT JOIN impression_metrics im
        ON sb.search_event_id = im.search_event_id
    LEFT JOIN click_metrics cm
        ON sb.search_event_id = cm.search_event_id
    LEFT JOIN cart_metrics cam
        ON sb.search_event_id = cam.search_event_id
    LEFT JOIN purchase_metrics pm
        ON sb.search_event_id = pm.search_event_id
)

SELECT
    search_query,
    COUNT(DISTINCT search_event_id) AS total_searches,
    SUM(CASE WHEN zero_results = TRUE THEN 1 ELSE 0 END) AS zero_result_searches,

    ROUND(
        SUM(CASE WHEN zero_results = TRUE THEN 1 ELSE 0 END) * 100.0
        / NULLIF(COUNT(DISTINCT search_event_id), 0),
        2
    ) AS zero_result_rate_pct,

    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    SUM(cart_adds) AS cart_adds,
    SUM(purchases) AS purchases,
    ROUND(SUM(revenue), 2) AS revenue,

    ROUND(SUM(clicks) * 100.0 / NULLIF(SUM(impressions), 0), 2) AS search_ctr_pct,
    ROUND(SUM(cart_adds) * 100.0 / NULLIF(SUM(clicks), 0), 2) AS click_to_cart_rate_pct,
    ROUND(SUM(purchases) * 100.0 / NULLIF(COUNT(DISTINCT search_event_id), 0), 2) AS search_to_purchase_rate_pct,
    ROUND(SUM(revenue) / NULLIF(COUNT(DISTINCT search_event_id), 0), 2) AS revenue_per_search,
    ROUND(AVG(avg_clicked_rank), 2) AS avg_clicked_rank

FROM search_joined
GROUP BY search_query
ORDER BY total_searches DESC;
