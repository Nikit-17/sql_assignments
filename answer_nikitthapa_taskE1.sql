SELECT 
    c.city,
    AVG(oi.quantity * oi.unit_price) AS avg_order_value,
    COUNT(DISTINCT o.order_id) AS delivered_orders_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'delivered'
GROUP BY c.city
HAVING COUNT(DISTINCT o.order_id) >= 2
ORDER BY avg_order_value DESC;
