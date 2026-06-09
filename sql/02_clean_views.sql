
/*
Project: Sephora Omnichannel Ecommerce Intelligence Dashboard
File: 02_clean_views.sql
Purpose:
    This script creates clean SQL views used by the BI table generation scripts.

Views created:
    1. vw_dim_product_clean
    2. vw_dim_customer_clean
    3. vw_fact_sessions_clean
    4. vw_dim_campaign_clean
*/

-- ============================================================
-- 1. CLEAN PRODUCT VIEW
-- ============================================================

CREATE OR REPLACE VIEW vw_dim_product_clean AS
SELECT
    product_id,

    CASE
        WHEN product_name IS NULL 
          OR LOWER(TRIM(CAST(product_name AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown product'
        ELSE TRIM(CAST(product_name AS VARCHAR))
    END AS product_name,

    brand_id,

    CASE
        WHEN brand_name IS NULL 
          OR LOWER(TRIM(CAST(brand_name AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown brand'
        ELSE TRIM(CAST(brand_name AS VARCHAR))
    END AS brand_name,

    CASE
        WHEN category IS NULL 
          OR LOWER(TRIM(CAST(category AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE TRIM(CAST(category AS VARCHAR))
    END AS category,

    COALESCE(price, 0) AS price,

    CASE
        WHEN price < 25 THEN 'budget'
        WHEN price >= 25 AND price < 50 THEN 'mid'
        WHEN price >= 50 AND price < 100 THEN 'premium'
        ELSE 'luxury'
    END AS product_tier,

    COALESCE(rating, 0) AS rating,
    COALESCE(review_count, 0) AS review_count,
    COALESCE(loves_count, 0) AS loves_count,

    COALESCE(online_only, FALSE) AS online_only,
    COALESCE(out_of_stock, FALSE) AS out_of_stock,
    COALESCE(limited_edition, FALSE) AS limited_edition,
    COALESCE(is_new, FALSE) AS is_new,
    COALESCE(sephora_exclusive, FALSE) AS sephora_exclusive,

    COALESCE(real_product_strength, 'unknown') AS real_product_strength

FROM dim_product;


-- ============================================================
-- 2. CLEAN CUSTOMER VIEW
-- ============================================================

CREATE OR REPLACE VIEW vw_dim_customer_clean AS
SELECT
    customer_id,

    CASE 
        WHEN skin_type IS NULL 
          OR LOWER(TRIM(CAST(skin_type AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(skin_type AS VARCHAR)))
    END AS skin_type,

    CASE 
        WHEN skin_tone IS NULL 
          OR LOWER(TRIM(CAST(skin_tone AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(skin_tone AS VARCHAR)))
    END AS skin_tone,

    CASE 
        WHEN eye_color IS NULL 
          OR LOWER(TRIM(CAST(eye_color AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(eye_color AS VARCHAR)))
    END AS eye_color,

    CASE 
        WHEN hair_color IS NULL 
          OR LOWER(TRIM(CAST(hair_color AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(hair_color AS VARCHAR)))
    END AS hair_color,

    signup_date,

    CASE 
        WHEN loyalty_status IS NULL 
          OR LOWER(TRIM(CAST(loyalty_status AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(loyalty_status AS VARCHAR)))
    END AS loyalty_status,

    CASE 
        WHEN preferred_channel IS NULL 
          OR LOWER(TRIM(CAST(preferred_channel AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(preferred_channel AS VARCHAR)))
    END AS preferred_channel,

    COALESCE(country, 'unknown') AS country,
    COALESCE(state, 'unknown') AS state

FROM dim_customer;


-- ============================================================
-- 3. CLEAN SESSION VIEW
-- ============================================================

CREATE OR REPLACE VIEW vw_fact_sessions_clean AS
SELECT
    session_id,
    customer_id,
    session_start_ts,

    CASE
        WHEN channel IS NULL 
          OR LOWER(TRIM(CAST(channel AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(channel AS VARCHAR)))
    END AS channel,

    CASE
        WHEN device_type IS NULL 
          OR LOWER(TRIM(CAST(device_type AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(device_type AS VARCHAR)))
    END AS device_type,

    CASE
        WHEN traffic_source IS NULL 
          OR LOWER(TRIM(CAST(traffic_source AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(traffic_source AS VARCHAR)))
    END AS traffic_source,

    COALESCE(campaign_id, 'no_campaign') AS campaign_id,

    CASE
        WHEN preferred_channel IS NULL 
          OR LOWER(TRIM(CAST(preferred_channel AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(preferred_channel AS VARCHAR)))
    END AS preferred_channel,

    COALESCE(session_duration_sec, 0) AS session_duration_sec,
    COALESCE(is_bounced, FALSE) AS is_bounced

FROM fact_sessions;


-- ============================================================
-- 4. CLEAN CAMPAIGN VIEW
-- ============================================================

CREATE OR REPLACE VIEW vw_dim_campaign_clean AS
SELECT
    campaign_id,

    CASE
        WHEN campaign_name IS NULL 
          OR LOWER(TRIM(CAST(campaign_name AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown campaign'
        ELSE TRIM(CAST(campaign_name AS VARCHAR))
    END AS campaign_name,

    CASE
        WHEN traffic_source IS NULL 
          OR LOWER(TRIM(CAST(traffic_source AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(traffic_source AS VARCHAR)))
    END AS traffic_source,

    CASE
        WHEN campaign_objective IS NULL 
          OR LOWER(TRIM(CAST(campaign_objective AS VARCHAR))) IN ('nan', 'none', '', 'null')
        THEN 'unknown'
        ELSE LOWER(TRIM(CAST(campaign_objective AS VARCHAR)))
    END AS campaign_objective,

    start_date,
    end_date,
    COALESCE(daily_budget, 0) AS daily_budget

FROM dim_campaign;
