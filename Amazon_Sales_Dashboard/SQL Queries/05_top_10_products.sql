
SELECT ProductName, SUM(TotalAmount) AS revenue, SUM(Quantity) AS units_sold
FROM amazon_sales_clean
GROUP BY ProductName
ORDER BY revenue DESC
LIMIT 10;

-- By units sold
SELECT ProductName, SUM(Quantity) AS units_sold, SUM(TotalAmount) AS revenue
FROM amazon_sales_clean
GROUP BY ProductName
ORDER BY units_sold DESC
LIMIT 10;