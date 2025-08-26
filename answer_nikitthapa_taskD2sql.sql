CREATE OR REPLACE PROCEDURE sp_cancel_order(p_order_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Only cancel if order is not delivered
    UPDATE orders
    SET status = 'cancelled'
    WHERE order_id = p_order_id
      AND status <> 'delivered';

    -- Delete unpaid payments
    DELETE FROM payments
    WHERE order_id = p_order_id
      AND (amount IS NULL OR amount = 0);
END;
$$;


-- Cancel order with ID 6
CALL sp_cancel_order(6);

SELECT * FROM orders WHERE order_id = 6;
SELECT * FROM payments WHERE order_id = 6;
