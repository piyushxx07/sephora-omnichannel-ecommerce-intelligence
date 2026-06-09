
/*
Project: Sephora Omnichannel Ecommerce Intelligence Dashboard
File: 06_product_brand_performance.sql
Purpose:
    This script creates product ranking and brand performance analytics.

Output tables:
    1. bi_product_ranking.csv
    2. bi_brand_performance.csv
*/

-- ============================================================
-- 1. PRODUCT RANKING / PRODUCT PERFORMANCE
-- ============================================================

WITH impression_metrics AS (
    SELECT
        product_id,
        COUNT(DISTINCT impression_id) AS impressions,
        AVG(result_rank) AS avg_result_rank
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

cart_metrics AS (
    SELECT
        product_id,
        COUNT(DISTINCT cart_event_id) AS cart_adds
    FROM fact_cart_events
    GROUP BY product_id
),

sales_metrics AS (
    SELECT
        oi.product_id,
        COUNT(DISTINCT o.order_id) AS orders,
        SUM(oi.quantity) AS units_sold,
        SUM(oi.net_item_revenue) AS product_revenue,
        SUM(CASE WHEN o.order_status = 'returned' THEN 1 ELSE 0 END) AS returned_orders
    FROM fact_order_items oi
    INNER JOIN fact_orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status IN ('completed', 'returned')
    GROUP BY oi.product_id
),

review_metrics AS (
    SELECT
        product_id,
        COUNT(DISTINCT review_id) AS actual_review_rows,
        AVG(review_rating) AS avg_review_rating,
        SUM(CASE WHEN sentiment_label = 'positive' THEN 1 ELSE 0 END) AS positive_reviews,
        SUM(CASE WHEN sentiment_label = 'negative' THEN 1 ELSE 0 END) AS negative_reviews
    FROM fact_reviews
    GROUP BY product_id
),

inventory_metrics AS (
    SELECT
        product_id,
        AVG(stock_on_hand) AS avg_stock_on_hand,
        SUM(CASE WHEN is_stockout = TRUE THEN 1 ELSE 0 END) AS stockout_days,
        COUNT(*) AS inventory_days
    FROM fact_inventory_daily
    GROUP BY product_id
),

product_base AS (
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

        COALESCE(im.impressions, 0) AS impressions,
        COALESCE(im.avg_result_rank, NULL) AS avg_result_rank,
        COALESCE(cm.clicks, 0) AS clicks,
        COALESCE(cam.cart_adds, 0) AS cart_adds,
        COALESCE(sm.orders, 0) AS orders,
        COALESCE(sm.units_sold, 0) AS units_sold,
        COALESCE(sm.product_revenue, 0) AS product_revenue,
        COALESCE(sm.returned_orders, 0) AS returned_orders,

        COALESCE(rm.actual_review_rows, 0) AS actual_review_rows,
        COALESCE(rm.avg_review_rating, 0) AS avg_review_rating,
        COALESCE(rm.positive_reviews, 0) AS positive_reviews,
        COALESCE(rm.negative_reviews, 0) AS negative_reviews,

        COALESCE(inv.avg_stock_on_hand, 0) AS avg_stock_on_hand,
        COALESCE(inv.stockout_days, 0) AS stockout_days,
        COALESCE(inv.inventory_days, 0) AS inventory_days

    FROM vw_dim_product_clean p
    LEFT JOIN impression_metrics im
        ON p.product_id = im.product_id
    LEFT JOIN click_metrics cm
        ON p.product_id = cm.product_id
    LEFT JOIN cart_metrics cam
        ON p.product_id = cam.product_id
    LEFT JOIN sales_metrics sm
        ON p.product_id = sm.product_id
    LEFT JOIN review_metrics rm
        ON p.product_id = rm.product_id
    LEFT JOIN inventory_metrics inv
        ON p.product_id = inv.product_id
),

product_scored AS (
    SELECT
        *,

        ROUND(clicks * 100.0 / NULLIF(impressions, 0), 2) AS ctr_pct,
        ROUND(cart_adds * 100.0 / NULLIF(clicks, 0), 2) AS click_to_cart_rate_pct,
        ROUND(orders * 100.0 / NULLIF(clicks, 0), 2) AS click_to_purchase_rate_pct,
        ROUND(product_revenue / NULLIF(impressions, 0), 2) AS revenue_per_impression,

        ROUND(returned_orders * 100.0 / NULLIF(orders + returned_orders, 0), 2) AS return_rate_pct,

        ROUND(stockout_days * 100.0 / NULLIF(inventory_days, 0), 2) AS stockout_rate_pct,

        ROUND(positive_reviews * 100.0 / NULLIF(actual_review_rows, 0), 2) AS positive_review_pct,
        ROUND(negative_reviews * 100.0 / NULLIF(actual_review_rows, 0), 2) AS negative_review_pct,

        ROUND(
            (
                COALESCE(clicks * 100.0 / NULLIF(impressions, 0), 0) * 0.20
                + COALESCE(orders * 100.0 / NULLIF(clicks, 0), 0) * 0.30
                + COALESCE(product_revenue / NULLIF(impressions, 0), 0) * 0.20
                + COALESCE(rating, 0) * 0.20
                + CASE 
                    WHEN COALESCE(stockout_days * 100.0 / NULLIF(inventory_days, 0), 0) < 5 THEN 5 
                    ELSE 2 
                  END * 0.10
            ),
            2
        ) AS ranking_score

    FROM product_base
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

    impressions,
    clicks,
    cart_adds,
    orders,
    units_sold,
    ROUND(product_revenue, 2) AS product_revenue,
    ROUND(avg_result_rank, 2) AS avg_result_rank,

    ctr_pct,
    click_to_cart_rate_pct,
    click_to_purchase_rate_pct,
    revenue_per_impression,
    return_rate_pct,
    stockout_rate_pct,
    COALESCE(positive_review_pct, 0) AS positive_review_pct,
    COALESCE(negative_review_pct, 0) AS negative_review_pct,
    avg_stock_on_hand,
    ranking_score,

    CASE
        WHEN product_revenue >= 1000
             AND click_to_purchase_rate_pct >= 10
             AND ranking_score >= 3.5
            THEN 'Hero Product'

        WHEN impressions < 100
             AND click_to_purchase_rate_pct >= 15
             AND ranking_score >= 3.5
            THEN 'Hidden Gem'

        WHEN impressions >= 500
             AND click_to_purchase_rate_pct = 0
            THEN 'High Visibility Low Conversion'

        WHEN return_rate_pct >= 20
             OR negative_review_pct >= 20
            THEN 'Return / Review Risk'

        WHEN stockout_rate_pct >= 15
             AND product_revenue >= 500
            THEN 'Stockout Revenue Risk'

        ELSE 'Normal'
    END AS product_action_segment

FROM product_scored
ORDER BY ranking_score DESC, product_revenue DESC;


-- ============================================================
-- 2. BRAND PERFORMANCE
-- ============================================================

WITH product_performance AS (
    SELECT *
    FROM (
        WITH impression_metrics AS (
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

        cart_metrics AS (
            SELECT
                product_id,
                COUNT(DISTINCT cart_event_id) AS cart_adds
            FROM fact_cart_events
            GROUP BY product_id
        ),

        sales_metrics AS (
            SELECT
                oi.product_id,
                COUNT(DISTINCT o.order_id) AS orders,
                SUM(oi.quantity) AS units_sold,
                SUM(oi.net_item_revenue) AS product_revenue,
                SUM(CASE WHEN o.order_status = 'returned' THEN 1 ELSE 0 END) AS returned_orders
            FROM fact_order_items oi
            INNER JOIN fact_orders o
                ON oi.order_id = o.order_id
            WHERE o.order_status IN ('completed', 'returned')
            GROUP BY oi.product_id
        ),

        review_metrics AS (
            SELECT
                product_id,
                COUNT(DISTINCT review_id) AS actual_review_rows,
                SUM(CASE WHEN sentiment_label = 'positive' THEN 1 ELSE 0 END) AS positive_reviews,
                SUM(CASE WHEN sentiment_label = 'negative' THEN 1 ELSE 0 END) AS negative_reviews
            FROM fact_reviews
            GROUP BY product_id
        ),

        inventory_metrics AS (
            SELECT
                product_id,
                AVG(stock_on_hand) AS avg_stock_on_hand,
                SUM(CASE WHEN is_stockout = TRUE THEN 1 ELSE 0 END) AS stockout_days,
                COUNT(*) AS inventory_days
            FROM fact_inventory_daily
            GROUP BY product_id
        ),

        base AS (
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

                COALESCE(im.impressions, 0) AS impressions,
                COALESCE(cm.clicks, 0) AS clicks,
                COALESCE(cam.cart_adds, 0) AS cart_adds,
                COALESCE(sm.orders, 0) AS orders,
                COALESCE(sm.units_sold, 0) AS units_sold,
                COALESCE(sm.product_revenue, 0) AS product_revenue,
                COALESCE(sm.returned_orders, 0) AS returned_orders,
                COALESCE(rm.actual_review_rows, 0) AS actual_review_rows,
                COALESCE(rm.positive_reviews, 0) AS positive_reviews,
                COALESCE(rm.negative_reviews, 0) AS negative_reviews,
                COALESCE(inv.avg_stock_on_hand, 0) AS avg_stock_on_hand,
                COALESCE(inv.stockout_days, 0) AS stockout_days,
                COALESCE(inv.inventory_days, 0) AS inventory_days
            FROM vw_dim_product_clean p
            LEFT JOIN impression_metrics im
                ON p.product_id = im.product_id
            LEFT JOIN click_metrics cm
                ON p.product_id = cm.product_id
            LEFT JOIN cart_metrics cam
                ON p.product_id = cam.product_id
            LEFT JOIN sales_metrics sm
                ON p.product_id = sm.product_id
            LEFT JOIN review_metrics rm
                ON p.product_id = rm.product_id
            LEFT JOIN inventory_metrics inv
                ON p.product_id = inv.product_id
        )

        SELECT
            *,
            ROUND(clicks * 100.0 / NULLIF(impressions, 0), 2) AS ctr_pct,
            ROUND(cart_adds * 100.0 / NULLIF(clicks, 0), 2) AS click_to_cart_rate_pct,
            ROUND(orders * 100.0 / NULLIF(clicks, 0), 2) AS click_to_purchase_rate_pct,
            ROUND(product_revenue / NULLIF(impressions, 0), 2) AS revenue_per_impression,
            ROUND(returned_orders * 100.0 / NULLIF(orders + returned_orders, 0), 2) AS return_rate_pct,
            ROUND(stockout_days * 100.0 / NULLIF(inventory_days, 0), 2) AS stockout_rate_pct,
            ROUND(positive_reviews * 100.0 / NULLIF(actual_review_rows, 0), 2) AS positive_review_pct,
            ROUND(negative_reviews * 100.0 / NULLIF(actual_review_rows, 0), 2) AS negative_review_pct,
            ROUND(
                (
                    COALESCE(clicks * 100.0 / NULLIF(impressions, 0), 0) * 0.20
                    + COALESCE(orders * 100.0 / NULLIF(clicks, 0), 0) * 0.30
                    + COALESCE(product_revenue / NULLIF(impressions, 0), 0) * 0.20
                    + COALESCE(rating, 0) * 0.20
                    + CASE 
                        WHEN COALESCE(stockout_days * 100.0 / NULLIF(inventory_days, 0), 0) < 5 THEN 5 
                        ELSE 2 
                      END * 0.10
                ),
                2
            ) AS ranking_score
        FROM base
    )
),

product_segments AS (
    SELECT
        *,
        CASE
            WHEN product_revenue >= 1000
                 AND click_to_purchase_rate_pct >= 10
                 AND ranking_score >= 3.5
                THEN 'Hero Product'

            WHEN impressions < 100
                 AND click_to_purchase_rate_pct >= 15
                 AND ranking_score >= 3.5
                THEN 'Hidden Gem'

            WHEN impressions >= 500
                 AND click_to_purchase_rate_pct = 0
                THEN 'High Visibility Low Conversion'

            WHEN return_rate_pct >= 20
                 OR negative_review_pct >= 20
                THEN 'Return / Review Risk'

            WHEN stockout_rate_pct >= 15
                 AND product_revenue >= 500
                THEN 'Stockout Revenue Risk'

            ELSE 'Normal'
        END AS product_action_segment
    FROM product_performance
),

brand_summary AS (
    SELECT
        brand_name,
        COUNT(DISTINCT product_id) AS total_products,

        SUM(impressions) AS impressions,
        SUM(clicks) AS clicks,
        SUM(cart_adds) AS cart_adds,
        SUM(orders) AS orders,
        SUM(units_sold) AS units_sold,
        SUM(product_revenue) AS revenue,

        ROUND(SUM(clicks) * 100.0 / NULLIF(SUM(impressions), 0), 2) AS brand_ctr_pct,
        ROUND(SUM(cart_adds) * 100.0 / NULLIF(SUM(clicks), 0), 2) AS brand_click_to_cart_rate_pct,
        ROUND(SUM(orders) * 100.0 / NULLIF(SUM(clicks), 0), 2) AS brand_click_to_purchase_rate_pct,
        ROUND(SUM(product_revenue) / NULLIF(SUM(impressions), 0), 2) AS revenue_per_impression,

        ROUND(AVG(price), 2) AS avg_price,
        ROUND(AVG(rating), 2) AS avg_product_rating,
        SUM(review_count) AS total_catalog_reviews,
        SUM(loves_count) AS total_loves,

        ROUND(AVG(return_rate_pct), 2) AS avg_return_rate_pct,
        ROUND(AVG(stockout_rate_pct), 2) AS avg_stockout_rate_pct,
        ROUND(AVG(positive_review_pct), 2) AS avg_positive_review_pct,
        ROUND(AVG(negative_review_pct), 2) AS avg_negative_review_pct,
        ROUND(AVG(ranking_score), 2) AS avg_ranking_score,

        SUM(CASE WHEN product_action_segment = 'Hero Product' THEN 1 ELSE 0 END) AS hero_products,
        SUM(CASE WHEN product_action_segment = 'Hidden Gem' THEN 1 ELSE 0 END) AS hidden_gems,
        SUM(CASE WHEN product_action_segment = 'High Visibility Low Conversion' THEN 1 ELSE 0 END) AS high_visibility_low_conversion_products,
        SUM(CASE WHEN product_action_segment = 'Return / Review Risk' THEN 1 ELSE 0 END) AS return_review_risk_products,
        SUM(CASE WHEN product_action_segment = 'Stockout Revenue Risk' THEN 1 ELSE 0 END) AS stockout_revenue_risk_products

    FROM product_segments
    GROUP BY brand_name
)

SELECT
    *,
    CASE
        WHEN revenue >= 10000 
             AND brand_click_to_purchase_rate_pct >= 8
             AND avg_return_rate_pct < 10
            THEN 'Strong Brand'

        WHEN hidden_gems >= 3
             AND revenue < 5000
            THEN 'Hidden Opportunity Brand'

        WHEN high_visibility_low_conversion_products >= 3
            THEN 'Conversion Problem Brand'

        WHEN return_review_risk_products >= 3
             OR avg_negative_review_pct >= 15
            THEN 'Customer Experience Risk Brand'

        WHEN stockout_revenue_risk_products >= 1
            THEN 'Stockout Risk Brand'

        ELSE 'Normal Brand'
    END AS brand_action_segment

FROM brand_summary
ORDER BY revenue DESC;
