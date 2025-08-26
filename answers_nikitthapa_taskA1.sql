WITH monthly_spend AS (
    SELECT
        TO_CHAR(o.order_date, 'YYYY-MM') AS month,
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_monthly_spend
    FROM training_ecom.orders o
    JOIN training_ecom.order_items oi ON o.order_id = oi.order_id
    GROUP BY TO_CHAR(o.order_date, 'YYYY-MM'), o.customer_id
)
SELECT
    month,
    customer_id,
    total_monthly_spend,
    RANK() OVER (
        PARTITION BY month
        ORDER BY total_monthly_spend DESC
    ) AS rank_in_month
FROM monthly_spend
ORDER BY month, rank_in_month;
