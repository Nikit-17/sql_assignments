-- Task C1: Scalar Function for Customer Lifetime Value
CREATE OR REPLACE FUNCTION fn_customer_lifetime_value(p_customer_id INT)
RETURNS NUMERIC AS $$
DECLARE
    lifetime_value NUMERIC;
BEGIN
    SELECT COALESCE(SUM(pay.amount), 0)
    INTO lifetime_value
    FROM payments pay
    JOIN orders o ON pay.order_id = o.order_id
    WHERE o.customer_id = p_customer_id
      AND o.status IN ('placed', 'shipped', 'delivered');

    RETURN lifetime_value;
END;
$$ LANGUAGE plpgsql;

-- Example: check for one customer
SELECT fn_customer_lifetime_value(2);

-- Or check for all customers
SELECT 
    c.customer_id,
    c.full_name,
    fn_customer_lifetime_value(c.customer_id) AS lifetime_value
FROM customers c;
