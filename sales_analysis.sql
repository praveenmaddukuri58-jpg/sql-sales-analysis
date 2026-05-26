-- ============================================
-- SALES TREND ANALYSIS
-- Analysis Queries
-- Author: [Your Name]
-- ============================================


-- ============================================
-- SECTION 1: MONTHLY REVENUE TRENDS
-- Business Question: Which months drove the most revenue?
-- ============================================

SELECT
    strftime('%Y-%m', order_date)       AS month,
    COUNT(order_id)                      AS total_orders,
    ROUND(SUM(total_amount), 2)          AS total_revenue,
    ROUND(AVG(total_amount), 2)          AS avg_order_value
FROM orders
GROUP BY strftime('%Y-%m', order_date)
ORDER BY month;


-- ============================================
-- SECTION 2: QUARTERLY REVENUE BREAKDOWN
-- Business Question: Which quarter performed best?
-- ============================================

SELECT
    CASE
        WHEN strftime('%m', order_date) IN ('01','02','03') THEN 'Q1'
        WHEN strftime('%m', order_date) IN ('04','05','06') THEN 'Q2'
        WHEN strftime('%m', order_date) IN ('07','08','09') THEN 'Q3'
        ELSE 'Q4'
    END                                  AS quarter,
    COUNT(order_id)                      AS total_orders,
    ROUND(SUM(total_amount), 2)          AS total_revenue,
    ROUND(SUM(total_amount) * 100.0 /
        (SELECT SUM(total_amount) FROM orders), 1) AS pct_of_annual_revenue
FROM orders
GROUP BY quarter
ORDER BY quarter;


-- ============================================
-- SECTION 3: TOP 5 BEST-SELLING PRODUCTS
-- Business Question: Which products drive the most volume and revenue?
-- ============================================

SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity)                     AS total_units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue,
    ROUND(SUM(oi.quantity * oi.unit_price) * 100.0 /
        (SELECT SUM(quantity * unit_price) FROM order_items), 1) AS pct_of_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 5;


-- ============================================
-- SECTION 4: REGIONAL PERFORMANCE
-- Business Question: Which regions are underperforming?
-- ============================================

SELECT
    c.region,
    COUNT(DISTINCT o.order_id)           AS total_orders,
    ROUND(SUM(o.total_amount), 2)        AS total_revenue,
    ROUND(AVG(o.total_amount), 2)        AS avg_order_value,
    ROUND(SUM(o.total_amount) * 100.0 /
        (SELECT SUM(total_amount) FROM orders), 1) AS pct_of_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_revenue DESC;


-- ============================================
-- SECTION 5: CUSTOMER SEGMENT ANALYSIS
-- Business Question: How do B2B vs Retail customers differ?
-- ============================================

SELECT
    c.segment,
    COUNT(DISTINCT c.customer_id)        AS total_customers,
    COUNT(o.order_id)                    AS total_orders,
    ROUND(SUM(o.total_amount), 2)        AS total_revenue,
    ROUND(AVG(o.total_amount), 2)        AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.segment
ORDER BY total_revenue DESC;


-- ============================================
-- SECTION 6: CATEGORY REVENUE BREAKDOWN
-- Business Question: Which product categories lead revenue?
-- ============================================

SELECT
    p.category,
    SUM(oi.quantity)                     AS total_units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue,
    ROUND(AVG(oi.unit_price), 2)         AS avg_unit_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


-- ============================================
-- SECTION 7: TOP CUSTOMERS BY REVENUE
-- Business Question: Who are our highest-value customers?
-- ============================================

SELECT
    c.customer_name,
    c.segment,
    c.region,
    COUNT(o.order_id)                    AS total_orders,
    ROUND(SUM(o.total_amount), 2)        AS lifetime_value,
    ROUND(AVG(o.total_amount), 2)        AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.segment, c.region
ORDER BY lifetime_value DESC
LIMIT 5;
