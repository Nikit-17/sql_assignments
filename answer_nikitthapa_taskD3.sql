-- Procedure: sp_reprice_stale_products
CREATE OR REPLACE PROCEDURE sp_reprice_stale_products(p_days INT, p_increase NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Update products that were NOT ordered in the last p_days
    UPDATE products p
    SET unit_price = ROUND(unit_price * (1 + p_increase / 100), 2)
    WHERE active = TRUE
      AND NOT EXISTS (
          SELECT 1
          FROM order_items oi
          JOIN orders o ON oi.order_id = o.order_id
          WHERE oi.product_id = p.product_id
            AND o.order_date >= NOW() - (p_days || ' days')::INTERVAL
      );
END;
$$;


-- Increase price by 10% for products not ordered in last 30 days
CALL sp_reprice_stale_products(30, 10);

SELECT product_id, product_name, unit_price, active
FROM products
WHERE active = TRUE
ORDER BY product_id;
