
/*
Project: Sephora Omnichannel Ecommerce Intelligence Dashboard
File: 09_inventory_risk.sql
Purpose:
    This script creates inventory and stockout risk analytics.

Output table:
    bi_inventory_risk.csv
*/

-- ============================================================
-- INVENTORY & STOCKOUT RISK ANALYSIS
-- ============================================================

WITH sales_metrics AS (
    SELECT
        oi.product_id,
        SUM(oi.quantity) AS units_sold,
        SUM(oi.net_item_revenue) AS revenue,
        COUNT(DISTINCT o.order_id) AS orders
    FROM fact_order_items oi
    INNER JOIN fact_orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'completed'
    GROUP BY oi.product_id
),

impression_metrics AS (
    SELECT
        product_id,
        COUNT(DISTINCT impression_id) AS impressions
    FROM fact_product_impressions
    GROUP BY product_id
),

click_metrics AS (
    SELECT
        product_id,
        COUNT(DISTINCT click_id) AS clicks
    FROM fact_clicks
    GROUP BY product_id
),

inventory_metrics AS (
    SELECT
        product_id,
        COUNT(*) AS inventory_days,
        AVG(stock_on_hand) AS avg_stock_on_hand,
        MIN(stock_on_hand) AS min_stock_on_hand,
        MAX(stock_on_hand) AS max_stock_on_hand,
        SUM(replenishment_units) AS total_replenishment_units,
        SUM(units_reserved) AS total_units_reserved,
        SUM(CASE WHEN is_stockout = TRUE THEN 1 ELSE 0 END) AS stockout_days,
        AVG(units_reserved) AS avg_daily_demand
    FROM fact_inventory_daily
    GROUP BY product_id
),

latest_inventory AS (
    SELECT
        product_id,
        inventory_date AS latest_inventory_date,
        stock_on_hand AS latest_stock_on_hand,
        is_stockout AS latest_is_stockout
    FROM (
        SELECT
            *,
            ROW_NUMBER() OVER (
                PARTITION BY product_id 
                ORDER BY inventory_date DESC
            ) AS rn
        FROM fact_inventory_daily
    )
    WHERE rn = 1
),

inventory_joined AS (
    SELECT
        p.product_id,
        p.product_name,
        p.brand_name,
        p.category,
        p.price,
        p.product_tier,
        p.rating,
        p.review_count,
        p.loves_count,

        COALESCE(sm.units_sold, 0) AS units_sold,
        COALESCE(sm.revenue, 0) AS revenue,
        COALESCE(sm.orders, 0) AS orders,

        COALESCE(im.impressions, 0) AS impressions,
        COALESCE(cm.clicks, 0) AS clicks,

        COALESCE(inv.inventory_days, 0) AS inventory_days,
        COALESCE(inv.avg_stock_on_hand, 0) AS avg_stock_on_hand,
        COALESCE(inv.min_stock_on_hand, 0) AS min_stock_on_hand,
        COALESCE(inv.max_stock_on_hand, 0) AS max_stock_on_hand,
        COALESCE(inv.total_replenishment_units, 0) AS total_replenishment_units,
        COALESCE(inv.total_units_reserved, 0) AS total_units_reserved,
        COALESCE(inv.stockout_days, 0) AS stockout_days,
        COALESCE(inv.avg_daily_demand, 0) AS avg_daily_demand,

        li.latest_inventory_date,
        COALESCE(li.latest_stock_on_hand, 0) AS latest_stock_on_hand,
        COALESCE(li.latest_is_stockout, FALSE) AS latest_is_stockout

    FROM vw_dim_product_clean p
    LEFT JOIN sales_metrics sm
        ON p.product_id = sm.product_id
    LEFT JOIN impression_metrics im
        ON p.product_id = im.product_id
    LEFT JOIN click_metrics cm
        ON p.product_id = cm.product_id
    LEFT JOIN inventory_metrics inv
        ON p.product_id = inv.product_id
    LEFT JOIN latest_inventory li
        ON p.product_id = li.product_id
)

SELECT
    product_id,
    product_name,
    brand_name,
    category,
    price,
    product_tier,
    rating,
    review_count,
    loves_count,

    units_sold,
    ROUND(revenue, 2) AS revenue,
    orders,
    impressions,
    clicks,

    ROUND(avg_stock_on_hand, 2) AS avg_stock_on_hand,
    min_stock_on_hand,
    max_stock_on_hand,
    latest_inventory_date,
    latest_stock_on_hand,
    latest_is_stockout,

    total_replenishment_units,
    total_units_reserved,
    ROUND(avg_daily_demand, 2) AS avg_daily_demand,
    stockout_days,
    inventory_days,

    ROUND(stockout_days * 100.0 / NULLIF(inventory_days, 0), 2) AS stockout_rate_pct,
    ROUND(clicks * 100.0 / NULLIF(impressions, 0), 2) AS ctr_pct,

    ROUND(latest_stock_on_hand / NULLIF(avg_daily_demand, 0), 2) AS days_of_supply,

    ROUND(
        CASE 
            WHEN stockout_days > 0 
            THEN stockout_days * avg_daily_demand * price
            ELSE 0
        END,
        2
    ) AS estimated_lost_revenue_risk,

    CASE
        WHEN latest_is_stockout = TRUE THEN 'Currently Out of Stock'

        WHEN latest_stock_on_hand <= 10 
             AND avg_daily_demand >= 1
            THEN 'Critical Low Stock'

        WHEN latest_stock_on_hand <= 25 
             AND avg_daily_demand >= 1
            THEN 'Low Stock'

        WHEN stockout_days * 100.0 / NULLIF(inventory_days, 0) >= 15
             AND price * avg_daily_demand * stockout_days >= 5000
            THEN 'High Stockout Revenue Risk'

        WHEN avg_stock_on_hand >= 200 
             AND units_sold <= 5
            THEN 'Overstock Risk'

        WHEN impressions >= 100 
             AND latest_stock_on_hand <= 20
            THEN 'High Demand Low Stock'

        ELSE 'Normal'
    END AS inventory_action_segment

FROM inventory_joined
ORDER BY estimated_lost_revenue_risk DESC, revenue DESC;
