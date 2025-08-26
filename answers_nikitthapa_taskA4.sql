WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT
    product_id,
    product_name,
    total_revenue,
    NTILE(4) OVER (ORDER BY total_revenue DESC) AS revenue_quartile
FROM product_revenue
ORDER BY revenue_quartile, total_revenue DESC;
