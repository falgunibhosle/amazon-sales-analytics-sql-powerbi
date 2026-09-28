
SELECT 
    Category, 
    Brand,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN OrderStatus IN ('Cancelled','Returned') THEN 1 ELSE 0 END) AS cancelled_or_returned,
    ROUND(100.0 * SUM(CASE WHEN OrderStatus IN ('Cancelled','Returned') THEN 1 ELSE 0 END) / COUNT(*), 2) AS cancel_return_rate_pct
FROM amazon_sales_clean
GROUP BY Category, Brand
ORDER BY cancel_return_rate_pct DESC;