WITH category_revenue AS (
    SELECT 
        c.city,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.city, p.category
),
ranked_categories AS (
    SELECT
        city,
        category,
        total_revenue,
        RANK() OVER (PARTITION BY city ORDER BY total_revenue DESC) AS rank_in_city
    FROM category_revenue
)
SELECT city, category, total_revenue
FROM ranked_categories
WHERE rank_in_city = 1
ORDER BY city;
