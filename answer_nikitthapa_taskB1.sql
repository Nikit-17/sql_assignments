CREATE OR REPLACE VIEW vw_recent_orders_30d AS
SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status <> 'cancelled'
  AND o.order_date >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY o.order_id, o.customer_id, o.order_date, o.status
ORDER BY o.order_date DESC;
SELECT * FROM vw_recent_orders_30d;
