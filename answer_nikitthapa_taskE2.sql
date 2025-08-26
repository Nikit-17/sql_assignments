SELECT 
    c.full_name,
    p.category,
    COUNT(DISTINCT o.order_id) AS distinct_orders_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.full_name, p.category
ORDER BY c.full_name, distinct_orders_count DESC;
