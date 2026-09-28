Amazon Sales Analytics | MySQL + Power BI

I took about 10,000 ecommerce orders from January 2020 to December 2024, cleaned them in MySQL, answered 14 business questions with SQL, and built a 5 page interactive Power BI dashboard. It covers revenue, products, customers, payments, fulfillment and sellers.

Author: Falguni Bhosle

LinkedIn: https://www.linkedin.com/in/falgunibhosle/

Email: falgunibhosle3001@gmail.com


__The business problem__

Imagine an online retailer that wants clear answers to four questions:

1. What sells? Which categories and products drive the most revenue?

2. Who buys? Who are the top customers, and how much revenue comes from people who come back?

3. How do customers pay? Which payment methods are used, and which ones lead to more cancellations?

4. Where does fulfillment break down? Which categories and sellers have the most cancellations and returns?


__The dataset__

The data comes from Kaggle: https://www.kaggle.com/datasets/rohiteng/amazon-sales-dataset

The original file has around 100K rows. I worked with a 9,999 row sample so it would run smoothly on a local MySQL setup. It has 20 columns covering orders, customers, products, pricing, payments, locations and sellers, and it runs from 1 January 2020 to 29 December 2024.

There are 6 categories: Books, Clothing, Electronics, Home & Kitchen, Sports & Outdoors, and Toys & Games. Orders end up as Delivered, Shipped, Pending, Cancelled or Returned. Customers pay with UPI, Credit Card, Debit Card, Net Banking, Amazon Pay or Cash on Delivery.

The full column list is in data/data_dictionary.md


__Tools I used__

MySQL 8 and MySQL Workbench for importing, cleaning and analysis. Power BI Desktop for the data model, DAX and the dashboard. GitHub for version control and documentation.


__How I did it__

Step 1, import and clean in MySQL.

I loaded the CSV into a raw table called amazon_sales and left it untouched as a backup. All the cleaning happened on a working copy called amazon_sales_clean.

I checked for missing values in the key columns (OrderID, CustomerID, TotalAmount, Category and OrderDate) and found none. I checked for duplicate OrderIDs and found none. Category, OrderStatus and PaymentMethod values were consistent, and the numeric columns already had the right types.

Two things did need fixing. First, an invisible byte order mark had attached itself to the first column name, so OrderID was not really called OrderID until I renamed it. Second, OrderDate came in as text in day, month, year order, so I converted it to a proper DATE type with STR_TO_DATE. I then confirmed the range ran from 1 January 2020 to 29 December 2024 with no day and month mix ups.

I also checked how Discount is stored. It is a decimal fraction between 0 and 0.30, not a whole number, which mattered when I built the discount bands.

Step 2, analyze in MySQL.

I wrote 14 queries using aggregations, CTEs, window functions (LAG, RANK and SUM OVER) and CASE WHEN logic. They are listed below.

Step 3, model and visualize in Power BI.

I connected Power BI straight to MySQL and built a date table with CALENDAR, linked to OrderDate, with Year, Month name and Month number so months sort properly.

I wrote DAX measures for Total Revenue, Total Orders, Avg Order Value, Total Customers, Cancellation Rate, Cancel/Return Rate, Total Units Sold, Avg Discount %, Total Sellers and Avg Revenue per Seller. I also added two calculated columns, Customer Type (repeat or one time) and Discount Band. The dashboard has slicers, Top N filters and navigation buttons between pages.


__The 14 SQL queries__

1. 01_monthly_revenue_trend.sql: revenue, orders and average order value by month.

2. 02_mom_growth.sql: month over month revenue growth, using LAG.

3. 03_sales_by_day_of_week.sql: which weekdays bring in the most revenue.

4. 04_category_brand_performance.sql: revenue versus order volume by category and brand, using RANK.

5. 05_top_10_products.sql: top 10 products by revenue and by units sold.

6. 06_discount_by_category.sql: average discount against units and revenue by category.

7. 07_top_20_customers.sql: top 20 customers by lifetime spend.

8. 08_repeat_vs_onetime_customers.sql: repeat versus one time customers and their share of revenue, using a CTE.

9. 09_revenue_by_location.sql: revenue by state and city.

10. 10_payment_method_performance.sql: payment method usage, average order value and cancellation rate.

11. 11_order_status_breakdown.sql: share of orders by status.

12. 12_cancel_return_rate_by_category.sql: cancellation and return rate by category and brand.

13. 13_discount_band_vs_revenue.sql: revenue by discount band.

14. 14_seller_performance.sql: top sellers by revenue, with their cancel and return rate.


__The dashboard__

1. Executive Summary: how is the business doing overall? (queries 01, 02 and 11)

2. Product and Category: what sells? (queries 04, 05 and 06)

3. Customer Insights: who buys? (queries 07, 08 and 09)

4. Payments and Fulfillment: how do orders get paid and fulfilled? (queries 10, 12 and 13)

5. Seller Performance: which sellers drive revenue and returns? (query 14)


__What I found__

1. Revenue is stable, not growing. Monthly revenue stays between roughly 125K and 176K across all 60 months, with no clear upward or downward trend. Month over month swings are usually somewhere between 5% and 30%, in either direction.

2. Category revenue is closely bunched. Total revenue is about 9.13M across the six categories. Electronics leads at about 1.57M and Home & Kitchen is lowest at about 1.46M, a gap of roughly 7%, so no single category dominates.

3. Discounting is almost uniform. The average discount is between 7.2% and 7.7% in every category. Electronics earns the most revenue while sitting at the low end of discount depth (7.2%), which suggests demand, not discount depth, is what drives the revenue differences.

4. Repeat customers: [FILL IN from query 08, for example "Repeat customers make up X% of customers and bring in Y% of revenue."]

5. Payments: [FILL IN from query 10, which payment method has the highest cancellation rate and which has the highest average order value.]

6. Order outcomes: [FILL IN from queries 11 and 12, the share of Delivered versus Cancelled and Returned orders, and the category with the highest cancel and return rate.]

7. The seller base is very fragmented. The top seller by revenue handled only 11 orders, so revenue is spread across a large number of small sellers. Cancellation rates for individual sellers (0% to about 17% among the top 15) rest on so few orders that they are too noisy to judge anyone on. Cancellation analysis is more reliable at category or payment method level.


__What I would recommend__

1. [FILL IN: an action tied to your cancel and return finding, for example look into the category or payment method with the highest rate.]

2. Rethink blanket discounting. Discount depth is almost identical across categories but revenue is not, so it is worth testing targeted discounts instead of uniform ones.

3. Judge sellers on volume adjusted metrics. Only look at cancellation rates once a seller passes a minimum number of orders.


__Limitations__

1. This is a 10K row sample, so results may look different on the full dataset.

2. The data looks synthetic. There is no strong seasonality or growth, and revenue is fairly even across categories.

3. There is no cost or profit column, so I could not analyze profitability.

4. There are no ship or delivery dates, so delivery time analysis was not possible.


__How to reproduce it__

1. Download the dataset from Kaggle and load it into MySQL, in a database called amazon_project, in a table called amazon_sales.

2. Run sql/00_data_cleaning.sql to build amazon_sales_clean.

3. Run the queries in the sql folder in order.

4. Open dashboard/Amazon_Sales_Dashboard.pbix in Power BI Desktop. You will need the MySQL connector installed, and you may have to point the data source at your own local server.


__What I would do next__

1. Add customer segmentation with RFM analysis.

2. Run the same analysis on the full 100K row dataset.

3. Add a profitability view if cost data becomes available.


I would love feedback, and I am open to remote data analyst roles. You can connect with me on LinkedIn: https://www.linkedin.com/in/falgunibhosle/
