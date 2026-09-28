
WITH monthly AS (
    SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS month, SUM(TotalAmount) AS revenue
    FROM amazon_sales_clean
    GROUP BY month
)
SELECT month, revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND((revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month) * 100, 2) AS mom_growth_pct
FROM monthly
ORDER BY month;