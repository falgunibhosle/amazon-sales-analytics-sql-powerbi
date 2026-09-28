
SELECT 
    CustomerID, 
    CustomerName, 
    COUNT(OrderID) AS num_orders, 
    SUM(TotalAmount) AS lifetime_spend
FROM amazon_sales_clean
GROUP BY CustomerID, CustomerName
ORDER BY lifetime_spend DESC
LIMIT 20;