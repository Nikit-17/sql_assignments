SELECT 
    oi.order_id,
    oi.product_id,
    (oi.quantity * oi.unit_price) AS item_revenue,
    SUM(oi.quantity * oi.unit_price) OVER (PARTITION BY oi.order_id) AS order_total,
    ROUND(
        (oi.quantity * oi.unit_price) 
        / SUM(oi.quantity * oi.unit_price) OVER (PARTITION BY oi.order_id),
        2
    ) AS revenue_share
FROM order_items oi
ORDER BY oi.order_id, oi.product_id;
