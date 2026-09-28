
SELECT 
    DAYNAME(OrderDate) AS day_of_week,
    COUNT(OrderID) AS num_orders,
    SUM(TotalAmount) AS revenue
FROM amazon_sales_clean
GROUP BY day_of_week
ORDER BY revenue DESC;