
/*
Project: Sephora Omnichannel Ecommerce Intelligence Dashboard
File: 01_data_quality_checks.sql
Purpose:
    This script performs basic data quality checks on the final industry-style
    Sephora ecommerce dataset.

Checks included:
    1. Table row counts
    2. Primary key duplicate checks
    3. Null percentage checks
    4. Business rule checks
*/

-- ============================================================
-- 1. TABLE ROW COUNTS
-- ============================================================

SELECT 'dim_product' AS table_name, COUNT(*) AS row_count FROM dim_product
UNION ALL
SELECT 'dim_brand', COUNT(*) FROM dim_brand
UNION ALL
SELECT 'dim_customer', COUNT(*) FROM dim_customer
UNION ALL
SELECT 'dim_campaign', COUNT(*) FROM dim_campaign
UNION ALL
SELECT 'fact_reviews', COUNT(*) FROM fact_reviews
UNION ALL
SELECT 'fact_sessions', COUNT(*) FROM fact_sessions
UNION ALL
SELECT 'fact_search_events', COUNT(*) FROM fact_search_events
UNION ALL
SELECT 'fact_product_impressions', COUNT(*) FROM fact_product_impressions
UNION ALL
SELECT 'fact_clicks', COUNT(*) FROM fact_clicks
UNION ALL
SELECT 'fact_cart_events', COUNT(*) FROM fact_cart_events
UNION ALL
SELECT 'fact_orders', COUNT(*) FROM fact_orders
UNION ALL
SELECT 'fact_order_items', COUNT(*) FROM fact_order_items
UNION ALL
SELECT 'fact_recommendation_events', COUNT(*) FROM fact_recommendation_events
UNION ALL
SELECT 'fact_inventory_daily', COUNT(*) FROM fact_inventory_daily
UNION ALL
SELECT 'fact_campaign_spend_daily', COUNT(*) FROM fact_campaign_spend_daily;


-- ============================================================
-- 2. PRIMARY KEY DUPLICATE CHECKS
-- ============================================================

WITH key_checks AS (

    SELECT
        'dim_brand' AS table_name,
        'brand_id' AS key_column,
        COUNT(*) AS total_rows,
        COUNT(DISTINCT brand_id) AS unique_keys
    FROM dim_brand

    UNION ALL

    SELECT
        'dim_campaign',
        'campaign_id',
        COUNT(*),
        COUNT(DISTINCT campaign_id)
    FROM dim_campaign

    UNION ALL

    SELECT
        'dim_customer',
        'customer_id',
        COUNT(*),
        COUNT(DISTINCT customer_id)
    FROM dim_customer

    UNION ALL

    SELECT
        'dim_product',
        'product_id',
        COUNT(*),
        COUNT(DISTINCT product_id)
    FROM dim_product

    UNION ALL

    SELECT
        'fact_cart_events',
        'cart_event_id',
        COUNT(*),
        COUNT(DISTINCT cart_event_id)
    FROM fact_cart_events

    UNION ALL

    SELECT
        'fact_clicks',
        'click_id',
        COUNT(*),
        COUNT(DISTINCT click_id)
    FROM fact_clicks

    UNION ALL

    SELECT
        'fact_orders',
        'order_id',
        COUNT(*),
        COUNT(DISTINCT order_id)
    FROM fact_orders

    UNION ALL

    SELECT
        'fact_product_impressions',
        'impression_id',
        COUNT(*),
        COUNT(DISTINCT impression_id)
    FROM fact_product_impressions

    UNION ALL

    SELECT
        'fact_recommendation_events',
        'recommendation_event_id',
        COUNT(*),
        COUNT(DISTINCT recommendation_event_id)
    FROM fact_recommendation_events

    UNION ALL

    SELECT
        'fact_reviews',
        'review_id',
        COUNT(*),
        COUNT(DISTINCT review_id)
    FROM fact_reviews

    UNION ALL

    SELECT
        'fact_search_events',
        'search_event_id',
        COUNT(*),
        COUNT(DISTINCT search_event_id)
    FROM fact_search_events

    UNION ALL

    SELECT
        'fact_sessions',
        'session_id',
        COUNT(*),
        COUNT(DISTINCT session_id)
    FROM fact_sessions
)

SELECT
    table_name,
    key_column,
    total_rows,
    unique_keys,
    total_rows - unique_keys AS duplicate_keys,
    CASE
        WHEN total_rows = unique_keys THEN 'pass'
        ELSE 'fail'
    END AS status
FROM key_checks
ORDER BY table_name;


-- ============================================================
-- 3. IMPORTANT NULL CHECKS
-- ============================================================

SELECT
    'dim_product' AS table_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS null_product_name,
    SUM(CASE WHEN brand_name IS NULL THEN 1 ELSE 0 END) AS null_brand_name,
    SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price
FROM dim_product;

SELECT
    'dim_customer' AS table_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN loyalty_status IS NULL THEN 1 ELSE 0 END) AS null_loyalty_status,
    SUM(CASE WHEN preferred_channel IS NULL THEN 1 ELSE 0 END) AS null_preferred_channel
FROM dim_customer;

SELECT
    'fact_sessions' AS table_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN session_id IS NULL THEN 1 ELSE 0 END) AS null_session_id,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN channel IS NULL THEN 1 ELSE 0 END) AS null_channel,
    SUM(CASE WHEN traffic_source IS NULL THEN 1 ELSE 0 END) AS null_traffic_source
FROM fact_sessions;

SELECT
    'dim_campaign' AS table_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN campaign_id IS NULL THEN 1 ELSE 0 END) AS null_campaign_id,
    SUM(CASE WHEN traffic_source IS NULL THEN 1 ELSE 0 END) AS null_traffic_source,
    SUM(CASE WHEN campaign_objective IS NULL THEN 1 ELSE 0 END) AS null_campaign_objective,
    SUM(CASE WHEN daily_budget IS NULL THEN 1 ELSE 0 END) AS null_daily_budget
FROM dim_campaign;


-- ============================================================
-- 4. BUSINESS RULE CHECKS
-- ============================================================

SELECT
    'Product price <= 0' AS check_name,
    COUNT(*) AS bad_rows
FROM dim_product
WHERE price <= 0

UNION ALL

SELECT
    'Product rating outside 0-5',
    COUNT(*)
FROM dim_product
WHERE rating < 0 OR rating > 5

UNION ALL

SELECT
    'Order total < 0',
    COUNT(*)
FROM fact_orders
WHERE order_total < 0

UNION ALL

SELECT
    'Net revenue < 0',
    COUNT(*)
FROM fact_orders
WHERE net_revenue < 0

UNION ALL

SELECT
    'Inventory stock < 0',
    COUNT(*)
FROM fact_inventory_daily
WHERE stock_on_hand < 0

UNION ALL

SELECT
    'Session duration <= 0',
    COUNT(*)
FROM fact_sessions
WHERE session_duration_sec <= 0

UNION ALL

SELECT
    'Order item quantity <= 0',
    COUNT(*)
FROM fact_order_items
WHERE quantity <= 0

UNION ALL

SELECT
    'Order item unit price <= 0',
    COUNT(*)
FROM fact_order_items
WHERE unit_price <= 0;
