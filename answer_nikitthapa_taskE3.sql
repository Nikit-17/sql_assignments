-- Electronics customers
WITH electronics AS (
    SELECT DISTINCT o.customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.category = 'Electronics'
),

-- Fitness customers
fitness AS (
    SELECT DISTINCT o.customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.category = 'Fitness'
)

-- UNION: Customers who bought either Electronics or Fitness
SELECT 'UNION' AS operation, customer_id
FROM (
    SELECT customer_id FROM electronics
    UNION
    SELECT customer_id FROM fitness
) AS union_set
UNION ALL

-- INTERSECT: Customers who bought both Electronics and Fitness
SELECT 'INTERSECT' AS operation, customer_id
FROM (
    SELECT customer_id FROM electronics
    INTERSECT
    SELECT customer_id FROM fitness
) AS intersect_set
UNION ALL

-- EXCEPT: Customers who bought Electronics but NOT Fitness
SELECT 'EXCEPT' AS operation, customer_id
FROM (
    SELECT customer_id FROM electronics
    EXCEPT
    SELECT customer_id FROM fitness
) AS except_set
ORDER BY operation, customer_id;
