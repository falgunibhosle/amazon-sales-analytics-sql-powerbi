
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS month,
    COUNT(DISTINCT OrderID) AS total_orders,
    SUM(TotalAmount) AS total_revenue,
    ROUND(SUM(TotalAmount) / COUNT(DISTINCT OrderID), 2) AS avg_order_value
FROM amazon_sales_clean
GROUP BY month
ORDER BY month;