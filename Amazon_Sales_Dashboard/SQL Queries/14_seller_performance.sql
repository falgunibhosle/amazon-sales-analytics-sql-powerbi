
SELECT 
    SellerID,
    COUNT(OrderID) AS num_orders,
    SUM(TotalAmount) AS total_revenue,
    ROUND(SUM(CASE WHEN OrderStatus IN ('Cancelled','Returned') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS cancel_return_rate_pct
FROM amazon_sales_clean
GROUP BY SellerID
ORDER BY total_revenue DESC
LIMIT 15;