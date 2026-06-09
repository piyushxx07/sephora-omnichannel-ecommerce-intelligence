
/*
Project: Sephora Omnichannel Ecommerce Intelligence Dashboard
File: 07_campaign_performance.sql
Purpose:
    This script creates campaign performance analytics for marketing analysis.

Output table:
    bi_campaign_performance.csv
*/

-- ============================================================
-- CAMPAIGN PERFORMANCE
-- ============================================================

WITH campaign_spend AS (
    SELECT
        campaign_id,
        SUM(ad_spend) AS ad_spend,
        SUM(ad_impressions) AS ad_impressions,
        SUM(ad_clicks) AS ad_clicks
    FROM fact_campaign_spend_daily
    GROUP BY campaign_id
),

campaign_sessions AS (
    SELECT
        campaign_id,
        COUNT(DISTINCT session_id) AS sessions,
        COUNT(DISTINCT customer_id) AS session_customers
    FROM vw_fact_sessions_clean
    WHERE campaign_id <> 'no_campaign'
    GROUP BY campaign_id
),

campaign_orders AS (
    SELECT
        COALESCE(campaign_id, 'no_campaign') AS campaign_id,
        COUNT(DISTINCT order_id) AS orders,
        COUNT(DISTINCT customer_id) AS purchasing_customers,
        SUM(net_revenue) AS revenue,
        AVG(net_revenue) AS avg_order_value
    FROM fact_orders
    WHERE order_status = 'completed'
      AND campaign_id IS NOT NULL
    GROUP BY COALESCE(campaign_id, 'no_campaign')
),

campaign_joined AS (
    SELECT
        c.campaign_id,
        c.campaign_name,
        c.traffic_source,
        c.campaign_objective,
        c.start_date,
        c.end_date,
        c.daily_budget,

        COALESCE(cs.ad_spend, 0) AS ad_spend,
        COALESCE(cs.ad_impressions, 0) AS ad_impressions,
        COALESCE(cs.ad_clicks, 0) AS ad_clicks,

        COALESCE(sess.sessions, 0) AS sessions,
        COALESCE(sess.session_customers, 0) AS session_customers,

        COALESCE(co.orders, 0) AS orders,
        COALESCE(co.purchasing_customers, 0) AS purchasing_customers,
        COALESCE(co.revenue, 0) AS revenue,
        COALESCE(co.avg_order_value, 0) AS avg_order_value

    FROM vw_dim_campaign_clean c
    LEFT JOIN campaign_spend cs
        ON c.campaign_id = cs.campaign_id
    LEFT JOIN campaign_sessions sess
        ON c.campaign_id = sess.campaign_id
    LEFT JOIN campaign_orders co
        ON c.campaign_id = co.campaign_id
)

SELECT
    campaign_id,
    campaign_name,
    traffic_source,
    campaign_objective,
    start_date,
    end_date,
    daily_budget,

    ROUND(ad_spend, 2) AS ad_spend,
    ad_impressions,
    ad_clicks,
    sessions,
    session_customers,
    orders,
    purchasing_customers,
    ROUND(revenue, 2) AS revenue,
    ROUND(avg_order_value, 2) AS avg_order_value,

    ROUND(ad_clicks * 100.0 / NULLIF(ad_impressions, 0), 2) AS ad_ctr_pct,
    ROUND(ad_spend / NULLIF(ad_clicks, 0), 2) AS cpc,
    ROUND(ad_spend / NULLIF(orders, 0), 2) AS cpa,
    ROUND(ad_spend / NULLIF(purchasing_customers, 0), 2) AS cac,
    ROUND(revenue / NULLIF(ad_spend, 0), 2) AS roas,
    ROUND(orders * 100.0 / NULLIF(sessions, 0), 2) AS campaign_conversion_rate_pct,
    ROUND(revenue / NULLIF(sessions, 0), 2) AS revenue_per_session,

    CASE
        WHEN ad_spend = 0 AND revenue = 0
            THEN 'No Paid Spend'

        WHEN revenue / NULLIF(ad_spend, 0) >= 2
             AND ad_spend / NULLIF(orders, 0) <= 50
            THEN 'Efficient Campaign'

        WHEN revenue / NULLIF(ad_spend, 0) < 1
             AND ad_spend > 0
            THEN 'Low ROAS Campaign'

        WHEN ad_spend / NULLIF(orders, 0) >= 200
            THEN 'High CPA Campaign'

        WHEN orders * 100.0 / NULLIF(sessions, 0) >= 5
            THEN 'High Conversion Campaign'

        ELSE 'Normal Campaign'
    END AS campaign_action_segment

FROM campaign_joined
ORDER BY revenue DESC;
