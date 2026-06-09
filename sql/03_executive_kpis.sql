
/*
Project: Sephora Omnichannel Ecommerce Intelligence Dashboard
File: 03_executive_kpis.sql
Purpose:
    This script creates the executive KPI table used on the Power BI
    Executive Overview page.

Output table:
    bi_executive_kpis.csv
*/

-- ============================================================
-- EXECUTIVE KPI CALCULATION
-- ============================================================

WITH completed_orders AS (
    SELECT
        order_id,
        customer_id,
        net_revenue
    FROM fact_orders
    WHERE order_status = 'completed'
),

returned_orders AS (
    SELECT
        order_id
    FROM fact_orders
    WHERE order_status = 'returned'
),

session_counts AS (
    SELECT
        COUNT(DISTINCT session_id) AS total_sessions,
        COUNT(DISTINCT customer_id) AS session_customers
    FROM vw_fact_sessions_clean
),

order_counts AS (
    SELECT
        COUNT(DISTINCT order_id) AS completed_orders,
        COUNT(DISTINCT customer_id) AS purchasing_customers,
        SUM(net_revenue) AS total_revenue,
        AVG(net_revenue) AS average_order_value
    FROM completed_orders
),

item_counts AS (
    SELECT
        SUM(oi.quantity) AS total_items_sold
    FROM fact_order_items oi
    INNER JOIN completed_orders co
        ON oi.order_id = co.order_id
),

repeat_customers AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS customer_orders
    FROM completed_orders
    GROUP BY customer_id
),

repeat_summary AS (
    SELECT
        COUNT(DISTINCT CASE WHEN customer_orders > 1 THEN customer_id END) AS repeat_customers,
        COUNT(DISTINCT customer_id) AS purchasing_customers
    FROM repeat_customers
),

cart_sessions AS (
    SELECT
        COUNT(DISTINCT session_id) AS sessions_with_cart
    FROM fact_cart_events
),

purchase_sessions AS (
    SELECT
        COUNT(DISTINCT session_id) AS sessions_with_purchase
    FROM completed_orders co
    INNER JOIN fact_orders o
        ON co.order_id = o.order_id
),

return_summary AS (
    SELECT
        COUNT(DISTINCT ro.order_id) AS returned_orders
    FROM returned_orders ro
),

final_metrics AS (
    SELECT
        sc.total_sessions,
        sc.session_customers AS total_customers,
        oc.completed_orders,
        oc.total_revenue,
        ic.total_items_sold,
        oc.average_order_value,

        ROUND(
            oc.completed_orders * 100.0 / NULLIF(sc.total_sessions, 0),
            2
        ) AS conversion_rate_pct,

        ROUND(
            oc.total_revenue / NULLIF(sc.total_sessions, 0),
            2
        ) AS revenue_per_session,

        ROUND(
            rs.repeat_customers * 100.0 / NULLIF(rs.purchasing_customers, 0),
            2
        ) AS repeat_purchase_rate_pct,

        ROUND(
            rts.returned_orders * 100.0 / NULLIF(oc.completed_orders + rts.returned_orders, 0),
            2
        ) AS return_rate_pct,

        ROUND(
            (cs.sessions_with_cart - ps.sessions_with_purchase) * 100.0 
            / NULLIF(cs.sessions_with_cart, 0),
            2
        ) AS cart_abandonment_rate_pct

    FROM session_counts sc
    CROSS JOIN order_counts oc
    CROSS JOIN item_counts ic
    CROSS JOIN repeat_summary rs
    CROSS JOIN cart_sessions cs
    CROSS JOIN purchase_sessions ps
    CROSS JOIN return_summary rts
)

SELECT 'Total Sessions' AS metric, total_sessions AS value FROM final_metrics
UNION ALL
SELECT 'Total Customers', total_customers FROM final_metrics
UNION ALL
SELECT 'Completed Orders', completed_orders FROM final_metrics
UNION ALL
SELECT 'Total Revenue', ROUND(total_revenue, 2) FROM final_metrics
UNION ALL
SELECT 'Total Items Sold', total_items_sold FROM final_metrics
UNION ALL
SELECT 'Average Order Value', ROUND(average_order_value, 2) FROM final_metrics
UNION ALL
SELECT 'Conversion Rate %', conversion_rate_pct FROM final_metrics
UNION ALL
SELECT 'Revenue Per Session', revenue_per_session FROM final_metrics
UNION ALL
SELECT 'Repeat Purchase Rate %', repeat_purchase_rate_pct FROM final_metrics
UNION ALL
SELECT 'Return Rate %', return_rate_pct FROM final_metrics
UNION ALL
SELECT 'Cart Abandonment Rate %', cart_abandonment_rate_pct FROM final_metrics;
