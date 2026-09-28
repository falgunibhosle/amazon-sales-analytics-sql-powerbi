
SELECT 
    Category,
    ROUND(AVG(Discount) * 100, 2) AS avg_discount_pct,
    SUM(Quantity) AS total_units,
    SUM(TotalAmount) AS total_revenue
FROM amazon_sales_clean
GROUP BY Category
ORDER BY avg_discount_pct DESC;