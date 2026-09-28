
SELECT 
    Category, 
    Brand,
    COUNT(OrderID) AS num_orders,
    SUM(TotalAmount) AS revenue,
    RANK() OVER (ORDER BY SUM(TotalAmount) DESC) AS revenue_rank,
    RANK() OVER (ORDER BY COUNT(OrderID) DESC) AS volume_rank
FROM amazon_sales_clean
GROUP BY Category, Brand
ORDER BY revenue DESC;