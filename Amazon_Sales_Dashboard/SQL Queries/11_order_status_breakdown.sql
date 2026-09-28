
SELECT 
    OrderStatus, 
    COUNT(*) AS num_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_total
FROM amazon_sales_clean
GROUP BY OrderStatus
ORDER BY num_orders DESC;