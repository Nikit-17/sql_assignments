SELECT DISTINCT
    o.customer_id,
    FIRST_VALUE(p.category) OVER (
        PARTITION BY o.customer_id 
        ORDER BY o.order_date ASC
    ) AS first_category,
    FIRST_VALUE(p.category) OVER (
        PARTITION BY o.customer_id 
        ORDER BY o.order_date DESC
    ) AS last_category
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
ORDER BY o.customer_id;
