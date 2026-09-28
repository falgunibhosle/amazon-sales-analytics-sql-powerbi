
SELECT 
    State, 
    City, 
    SUM(TotalAmount) AS revenue, 
    COUNT(OrderID) AS num_orders
FROM amazon_sales_clean
GROUP BY State, City
ORDER BY revenue DESC
LIMIT 20;