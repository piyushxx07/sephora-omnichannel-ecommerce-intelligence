
/*
Project: Sephora Omnichannel Ecommerce Intelligence Dashboard
File: 04_funnel_analysis.sql
Purpose:
    This script creates funnel analysis tables for Power BI.

Output tables:
    1. bi_funnel_summary.csv
    2. bi_funnel_session_summary.csv
    3. bi_funnel_by_channel.csv
    4. bi_funnel_by_traffic_source.csv
*/

-- ============================================================
-- 1. EVENT-COUNT FUNNEL SUMMARY
-- ============================================================

WITH funnel_counts AS (
    SELECT
        1 AS stage_order,
        'Sessions' AS stage_name,
        COUNT(DISTINCT session_id) AS stage_count
    FROM vw_fact_sessions_clean

    UNION ALL

    SELECT
        2,
        'Searches',
        COUNT(DISTINCT search_event_id)
    FROM fact_search_events

    UNION ALL

    SELECT
        3,
        'Product Impressions',
        COUNT(DISTINCT impression_id)
    FROM fact_product_impressions

    UNION ALL

    SELECT
        4,
        'Clicks',
        COUNT(DISTINCT click_id)
    FROM fact_clicks

    UNION ALL

    SELECT
        5,
        'Cart Adds',
        COUNT(DISTINCT cart_event_id)
    FROM fact_cart_events

    UNION ALL

    SELECT
        6,
        'Purchases',
        COUNT(DISTINCT order_id)
    FROM fact_orders
    WHERE order_status = 'completed'
),

funnel_with_previous AS (
    SELECT
        stage_order,
        stage_name,
        stage_count,
        LAG(stage_count) OVER (ORDER BY stage_order) AS previous_stage_count
    FROM funnel_counts
)

SELECT
    stage_order,
    stage_name,
    stage_count,
    previous_stage_count,
    ROUND(stage_count * 100.0 / NULLIF(previous_stage_count, 0), 2) AS stage_conversion_rate_pct,
    ROUND((previous_stage_count - stage_count) * 100.0 / NULLIF(previous_stage_count, 0), 2) AS stage_dropoff_rate_pct,
    ROUND(stage_count * 100.0 / NULLIF((SELECT stage_count FROM funnel_counts WHERE stage_order = 1), 0), 2) AS overall_conversion_from_session_pct
FROM funnel_with_previous
ORDER BY stage_order;


-- ============================================================
-- 2. SESSION-LEVEL FUNNEL SUMMARY
-- ============================================================

WITH session_flags AS (
    SELECT
        s.session_id,

        CASE WHEN se.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_search,
        CASE WHEN pi.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_impression,
        CASE WHEN c.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_click,
        CASE WHEN ce.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_cart,
        CASE WHEN o.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_purchase

    FROM vw_fact_sessions_clean s

    LEFT JOIN (
        SELECT DISTINCT session_id
        FROM fact_search_events
    ) se
        ON s.session_id = se.session_id

    LEFT JOIN (
        SELECT DISTINCT session_id
        FROM fact_product_impressions
    ) pi
        ON s.session_id = pi.session_id

    LEFT JOIN (
        SELECT DISTINCT session_id
        FROM fact_clicks
    ) c
        ON s.session_id = c.session_id

    LEFT JOIN (
        SELECT DISTINCT session_id
        FROM fact_cart_events
    ) ce
        ON s.session_id = ce.session_id

    LEFT JOIN (
        SELECT DISTINCT session_id
        FROM fact_orders
        WHERE order_status = 'completed'
    ) o
        ON s.session_id = o.session_id
),

session_funnel AS (
    SELECT
        1 AS stage_order,
        'Total Sessions' AS stage_name,
        COUNT(DISTINCT session_id) AS stage_count
    FROM session_flags

    UNION ALL

    SELECT
        2,
        'Sessions With Search',
        COUNT(DISTINCT CASE WHEN has_search = 1 THEN session_id END)
    FROM session_flags

    UNION ALL

    SELECT
        3,
        'Sessions With Product Impression',
        COUNT(DISTINCT CASE WHEN has_impression = 1 THEN session_id END)
    FROM session_flags

    UNION ALL

    SELECT
        4,
        'Sessions With Click',
        COUNT(DISTINCT CASE WHEN has_click = 1 THEN session_id END)
    FROM session_flags

    UNION ALL

    SELECT
        5,
        'Sessions With Cart',
        COUNT(DISTINCT CASE WHEN has_cart = 1 THEN session_id END)
    FROM session_flags

    UNION ALL

    SELECT
        6,
        'Sessions With Purchase',
        COUNT(DISTINCT CASE WHEN has_purchase = 1 THEN session_id END)
    FROM session_flags
),

session_funnel_with_previous AS (
    SELECT
        stage_order,
        stage_name,
        stage_count,
        LAG(stage_count) OVER (ORDER BY stage_order) AS previous_stage_count
    FROM session_funnel
)

SELECT
    stage_order,
    stage_name,
    stage_count,
    previous_stage_count,
    ROUND(stage_count * 100.0 / NULLIF(previous_stage_count, 0), 2) AS stage_conversion_rate_pct,
    ROUND((previous_stage_count - stage_count) * 100.0 / NULLIF(previous_stage_count, 0), 2) AS stage_dropoff_rate_pct,
    ROUND(stage_count * 100.0 / NULLIF((SELECT stage_count FROM session_funnel WHERE stage_order = 1), 0), 2) AS overall_conversion_from_session_pct
FROM session_funnel_with_previous
ORDER BY stage_order;


-- ============================================================
-- 3. FUNNEL BY CHANNEL
-- ============================================================

WITH session_flags AS (
    SELECT
        s.session_id,
        s.channel,

        CASE WHEN se.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_search,
        CASE WHEN pi.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_impression,
        CASE WHEN c.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_click,
        CASE WHEN ce.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_cart,
        CASE WHEN o.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_purchase

    FROM vw_fact_sessions_clean s

    LEFT JOIN (SELECT DISTINCT session_id FROM fact_search_events) se
        ON s.session_id = se.session_id

    LEFT JOIN (SELECT DISTINCT session_id FROM fact_product_impressions) pi
        ON s.session_id = pi.session_id

    LEFT JOIN (SELECT DISTINCT session_id FROM fact_clicks) c
        ON s.session_id = c.session_id

    LEFT JOIN (SELECT DISTINCT session_id FROM fact_cart_events) ce
        ON s.session_id = ce.session_id

    LEFT JOIN (
        SELECT DISTINCT session_id
        FROM fact_orders
        WHERE order_status = 'completed'
    ) o
        ON s.session_id = o.session_id
)

SELECT
    channel,
    COUNT(DISTINCT session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN has_search = 1 THEN session_id END) AS sessions_with_search,
    COUNT(DISTINCT CASE WHEN has_impression = 1 THEN session_id END) AS sessions_with_impression,
    COUNT(DISTINCT CASE WHEN has_click = 1 THEN session_id END) AS sessions_with_click,
    COUNT(DISTINCT CASE WHEN has_cart = 1 THEN session_id END) AS sessions_with_cart,
    COUNT(DISTINCT CASE WHEN has_purchase = 1 THEN session_id END) AS sessions_with_purchase,

    ROUND(COUNT(DISTINCT CASE WHEN has_search = 1 THEN session_id END) * 100.0 / NULLIF(COUNT(DISTINCT session_id), 0), 2) AS search_rate_pct,
    ROUND(COUNT(DISTINCT CASE WHEN has_click = 1 THEN session_id END) * 100.0 / NULLIF(COUNT(DISTINCT CASE WHEN has_impression = 1 THEN session_id END), 0), 2) AS impression_to_click_rate_pct,
    ROUND(COUNT(DISTINCT CASE WHEN has_cart = 1 THEN session_id END) * 100.0 / NULLIF(COUNT(DISTINCT CASE WHEN has_click = 1 THEN session_id END), 0), 2) AS click_to_cart_rate_pct,
    ROUND(COUNT(DISTINCT CASE WHEN has_purchase = 1 THEN session_id END) * 100.0 / NULLIF(COUNT(DISTINCT CASE WHEN has_cart = 1 THEN session_id END), 0), 2) AS cart_to_purchase_rate_pct,
    ROUND(COUNT(DISTINCT CASE WHEN has_purchase = 1 THEN session_id END) * 100.0 / NULLIF(COUNT(DISTINCT session_id), 0), 2) AS session_conversion_rate_pct

FROM session_flags
GROUP BY channel
ORDER BY sessions DESC;


-- ============================================================
-- 4. FUNNEL BY TRAFFIC SOURCE
-- ============================================================

WITH session_flags AS (
    SELECT
        s.session_id,
        s.traffic_source,

        CASE WHEN se.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_search,
        CASE WHEN pi.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_impression,
        CASE WHEN c.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_click,
        CASE WHEN ce.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_cart,
        CASE WHEN o.session_id IS NOT NULL THEN 1 ELSE 0 END AS has_purchase

    FROM vw_fact_sessions_clean s

    LEFT JOIN (SELECT DISTINCT session_id FROM fact_search_events) se
        ON s.session_id = se.session_id

    LEFT JOIN (SELECT DISTINCT session_id FROM fact_product_impressions) pi
        ON s.session_id = pi.session_id

    LEFT JOIN (SELECT DISTINCT session_id FROM fact_clicks) c
        ON s.session_id = c.session_id

    LEFT JOIN (SELECT DISTINCT session_id FROM fact_cart_events) ce
        ON s.session_id = ce.session_id

    LEFT JOIN (
        SELECT DISTINCT session_id
        FROM fact_orders
        WHERE order_status = 'completed'
    ) o
        ON s.session_id = o.session_id
)

SELECT
    traffic_source,
    COUNT(DISTINCT session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN has_search = 1 THEN session_id END) AS sessions_with_search,
    COUNT(DISTINCT CASE WHEN has_impression = 1 THEN session_id END) AS sessions_with_impression,
    COUNT(DISTINCT CASE WHEN has_click = 1 THEN session_id END) AS sessions_with_click,
    COUNT(DISTINCT CASE WHEN has_cart = 1 THEN session_id END) AS sessions_with_cart,
    COUNT(DISTINCT CASE WHEN has_purchase = 1 THEN session_id END) AS sessions_with_purchase,

    ROUND(COUNT(DISTINCT CASE WHEN has_search = 1 THEN session_id END) * 100.0 / NULLIF(COUNT(DISTINCT session_id), 0), 2) AS search_rate_pct,
    ROUND(COUNT(DISTINCT CASE WHEN has_click = 1 THEN session_id END) * 100.0 / NULLIF(COUNT(DISTINCT CASE WHEN has_impression = 1 THEN session_id END), 0), 2) AS impression_to_click_rate_pct,
    ROUND(COUNT(DISTINCT CASE WHEN has_cart = 1 THEN session_id END) * 100.0 / NULLIF(COUNT(DISTINCT CASE WHEN has_click = 1 THEN session_id END), 0), 2) AS click_to_cart_rate_pct,
    ROUND(COUNT(DISTINCT CASE WHEN has_purchase = 1 THEN session_id END) * 100.0 / NULLIF(COUNT(DISTINCT CASE WHEN has_cart = 1 THEN session_id END), 0), 2) AS cart_to_purchase_rate_pct,
    ROUND(COUNT(DISTINCT CASE WHEN has_purchase = 1 THEN session_id END) * 100.0 / NULLIF(COUNT(DISTINCT session_id), 0), 2) AS session_conversion_rate_pct

FROM session_flags
GROUP BY traffic_source
ORDER BY session_conversion_rate_pct DESC;
