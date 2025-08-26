-- Task B4: Customers Without Delivered Orders
SELECT c.customer_id, c.full_name, c.city
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.status = 'delivered'
)
ORDER BY c.customer_id;
