CREATE OR REPLACE PROCEDURE sp_apply_category_discount(p_category TEXT, p_percent NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE products
    SET unit_price = GREATEST(unit_price * (1 - p_percent/100), 0.01)
    WHERE category = p_category
      AND active = TRUE;
END;
$$;
CALL sp_apply_category_discount('Electronics', 10);
SELECT product_name, category, unit_price
FROM products
WHERE category = 'Electronics';




select * from products