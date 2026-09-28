
SELECT 
    CASE 
        WHEN Discount = 0 THEN '0%'
        WHEN Discount BETWEEN 0.001 AND 0.10 THEN '1-10%'
        WHEN Discount BETWEEN 0.101 AND 0.25 THEN '11-25%'
        ELSE '25%+' 
    END AS discount_band,
    COUNT(*) AS num_orders,
    SUM(TotalAmount) AS revenue,
    ROUND(AVG(TotalAmount), 2) AS avg_order_value
FROM amazon_sales_clean
GROUP BY discount_band
ORDER BY discount_band;