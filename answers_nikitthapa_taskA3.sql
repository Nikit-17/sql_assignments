SELECT
    customer_id,
    order_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date,
    EXTRACT(DAY FROM AGE(order_date, LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date))) AS days_since_previous
FROM orders
ORDER BY customer_id, order_date;