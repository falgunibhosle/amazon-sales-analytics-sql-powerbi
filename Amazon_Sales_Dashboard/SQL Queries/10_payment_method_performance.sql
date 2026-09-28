
SELECT 
    PaymentMethod,
    COUNT(OrderID) AS num_orders,
    ROUND(AVG(TotalAmount), 2) AS avg_order_value,
    ROUND(SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS cancellation_rate_pct
FROM amazon_sales_clean
GROUP BY PaymentMethod
ORDER BY num_orders DESC;