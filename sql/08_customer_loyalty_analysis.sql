
/*
Project: Sephora Omnichannel Ecommerce Intelligence Dashboard
File: 08_customer_loyalty_analysis.sql
Purpose:
    This script creates customer and loyalty segment analytics.

Output table:
    bi_customer_segments.csv
*/

-- ============================================================
-- CUSTOMER & LOYALTY SEGMENT ANALYSIS
-- ============================================================

WITH customer_sessions AS (
    SELECT
        customer_id,
        COUNT(DISTINCT session_id) AS sessions,
        AVG(session_duration_sec) AS avg_session_duration_sec
    FROM vw_fact_sessions_clean
    GROUP BY customer_id
),

customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS orders,
        SUM(net_revenue) AS revenue,
        AVG(net_revenue) AS avg_order_value
    FROM fact_orders
    WHERE order_status = 'completed'
    GROUP BY customer_id
),

customer_repeat AS (
    SELECT
        customer_id,
        CASE 
            WHEN COUNT(DISTINCT order_id) > 1 THEN 1 
            ELSE 0 
        END AS is_repeat_customer
    FROM fact_orders
    WHERE order_status = 'completed'
    GROUP BY customer_id
),

customer_base AS (
    SELECT
        c.customer_id,
        c.loyalty_status,
        c.preferred_channel,
        c.skin_type,

        COALESCE(cs.sessions, 0) AS sessions,
        COALESCE(cs.avg_session_duration_sec, 0) AS avg_session_duration_sec,
        COALESCE(co.orders, 0) AS orders,
        COALESCE(co.revenue, 0) AS revenue,
        COALESCE(co.avg_order_value, 0) AS avg_order_value,
        COALESCE(cr.is_repeat_customer, 0) AS is_repeat_customer

    FROM vw_dim_customer_clean c
    LEFT JOIN customer_sessions cs
        ON c.customer_id = cs.customer_id
    LEFT JOIN customer_orders co
        ON c.customer_id = co.customer_id
    LEFT JOIN customer_repeat cr
        ON c.customer_id = cr.customer_id
)

SELECT
    loyalty_status,
    preferred_channel,
    skin_type,

    COUNT(DISTINCT customer_id) AS customers,
    SUM(sessions) AS sessions,
    SUM(orders) AS orders,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(revenue) / NULLIF(SUM(orders), 0), 2) AS avg_order_value,

    ROUND(SUM(orders) * 100.0 / NULLIF(SUM(sessions), 0), 2) AS session_conversion_rate_pct,
    ROUND(SUM(revenue) / NULLIF(COUNT(DISTINCT customer_id), 0), 2) AS revenue_per_customer,
    ROUND(SUM(sessions) / NULLIF(COUNT(DISTINCT customer_id), 0), 2) AS sessions_per_customer,

    COUNT(DISTINCT CASE WHEN orders > 0 THEN customer_id END) AS purchasing_customers,
    COUNT(DISTINCT CASE WHEN is_repeat_customer = 1 THEN customer_id END) AS repeat_customers,

    ROUND(
        COUNT(DISTINCT CASE WHEN is_repeat_customer = 1 THEN customer_id END) * 100.0
        / NULLIF(COUNT(DISTINCT CASE WHEN orders > 0 THEN customer_id END), 0),
        2
    ) AS repeat_purchase_rate_pct,

    ROUND(AVG(avg_session_duration_sec), 2) AS avg_session_duration_sec,

    CASE
        WHEN SUM(orders) * 100.0 / NULLIF(SUM(sessions), 0) >= 5
             AND SUM(revenue) / NULLIF(COUNT(DISTINCT customer_id), 0) >= 3
            THEN 'High Conversion Segment'

        WHEN COUNT(DISTINCT CASE WHEN is_repeat_customer = 1 THEN customer_id END) * 100.0
             / NULLIF(COUNT(DISTINCT CASE WHEN orders > 0 THEN customer_id END), 0) >= 5
            THEN 'High Repeat Segment'

        WHEN SUM(revenue) / NULLIF(COUNT(DISTINCT customer_id), 0) >= 5
            THEN 'High Value Segment'

        WHEN SUM(orders) = 0
            THEN 'No Purchase Segment'

        ELSE 'Normal Segment'
    END AS customer_action_segment

FROM customer_base
GROUP BY
    loyalty_status,
    preferred_channel,
    skin_type
ORDER BY revenue DESC;
