CREATE OR REPLACE FUNCTION fn_recent_orders(p_days INT)
RETURNS TABLE (
    order_id INT,
    customer_id INT,
    order_date DATE,  -- keep DATE
    status VARCHAR,
    order_total NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        o.order_id,
        o.customer_id,
        o.order_date::DATE,   -- CAST here
        o.status,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_date >= NOW() - (p_days || ' days')::INTERVAL
      AND o.status IN ('placed', 'shipped', 'delivered')
    GROUP BY o.order_id, o.customer_id, o.order_date, o.status
    ORDER BY o.order_date DESC;
END;
$$ LANGUAGE plpgsql;
SELECT * FROM fn_recent_orders(60);
