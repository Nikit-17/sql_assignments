# E-commerce SQL Assignment

This repository contains SQL scripts and functions for the E-commerce Training Dataset assignment. It demonstrates usage of PostgreSQL features including **window functions, views, functions, procedures, joins, and aggregations**.

## Schema

The database schema `training_ecom` includes the following tables:

- `customers`: Customer details (ID, name, city, signup date, email)
- `products`: Product details (ID, name, category, unit price, active status)
- `orders`: Customer orders (ID, customer ID, order date, status)
- `order_items`: Items within orders (order ID, product ID, quantity, unit price)
- `payments`: Payments made for orders (payment ID, order ID, amount, method, timestamp)

## Assignments

### Task A: Window Functions
1. **Monthly Customer Rank by Spend** – rank customers by monthly spend using `RANK()`.
2. **Share of Basket per Item** – compute each item's revenue share in an order.
3. **Time Between Orders (per Customer)** – calculate days since previous order using `LAG()` and `AGE()`.
4. **Product Revenue Quartiles** – assign quartiles to total product revenue using `NTILE(4)`.
5. **First and Last Purchase Category per Customer** – determine first and most recent category using `FIRST_VALUE` and `LAST_VALUE`.

### Task B: Views & Subqueries
1. **View `vw_recent_orders_30d`** – orders from the last 30 days (excluding cancelled).
2. **Products Never Ordered** – list products not in any order.
3. **Top Category by City** – highest revenue category per city.
4. **Customers Without Delivered Orders** – customers with no delivered orders.

### Task C: Functions
1. **Scalar Function `fn_customer_lifetime_value(customer_id)`** – total paid amount for delivered/shipped/placed orders.
2. **Table Function `fn_recent_orders(p_days INT)`** – orders in the last `p_days`.
3. **Utility Function `fn_title_case_city(text)`** – converts city names to title case.

### Task D: Procedures
1. **`sp_apply_category_discount(p_category, p_percent)`** – reduce unit price for active products in a category.
2. **`sp_cancel_order(p_order_id)`** – cancel order if not delivered; optionally remove unpaid payments.
3. **`sp_reprice_stale_products(p_days, p_increase)`** – increase unit price for products not ordered in last `p_days`.

### Task E: Joins, Grouping, Set Operations
1. **Average Order Value by City (Delivered Only)** – average order value and delivered order count by city.
2. **Category Mix per Customer** – count of distinct orders per category per customer.
3. **Set Ops: Overlapping Customers** – UNION, INTERSECT, EXCEPT for customers who bought Electronics vs Fitness.

## How to Use

1. Create a PostgreSQL database and run the schema and seed scripts in `ecommerce_assignment.sql`.
2. Execute the functions, views, and procedures as required for analysis.
3. Explore outputs using `SELECT` statements.


