
WITH cust_orders AS (
    SELECT CustomerID, COUNT(OrderID) AS orders, SUM(TotalAmount) AS spend
    FROM amazon_sales_clean
    GROUP BY CustomerID
)
SELECT 
    CASE WHEN orders > 1 THEN 'Repeat' ELSE 'One-time' END AS customer_type,
    COUNT(*) AS num_customers,
    SUM(spend) AS total_revenue,
    ROUND(100.0 * SUM(spend) / SUM(SUM(spend)) OVER (), 2) AS pct_of_revenue
FROM cust_orders
GROUP BY customer_type;