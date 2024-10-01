-- create schema retailshop;

use retailshop;


DESCRIBE online_retail;
-- -- Distribution of Order Values Across All Customers: calculate the total order value for each customer using:
SELECT CustomerID, SUM(Quantity * UnitPrice) AS TotalOrderValue
FROM online_retail
GROUP BY CustomerID;


--  To find the number of unique products each customer has purchased
SELECT CustomerID, COUNT(DISTINCT StockCode) AS UniqueProducts
FROM online_retail
GROUP BY CustomerID;


-- Use this query to find customers who made only one purchase:
SELECT CustomerID
FROM online_retail
GROUP BY CustomerID
HAVING COUNT(DISTINCT InvoiceNo) = 1;


-- Products Commonly Purchased Together: You can find the products frequently purchased together by analyzing the invoice:
SELECT InvoiceNo, GROUP_CONCAT(DISTINCT StockCode) AS ProductsTogether
FROM online_retail
GROUP BY InvoiceNo;


 -- Avanced Queries

-- Customer Segmentation by Purchase Frequency: You can segment customers based on how many times they purchased (high, medium, low):
 SELECT CustomerID, 
       COUNT(DISTINCT InvoiceNo) AS PurchaseFrequency,
       CASE 
           WHEN COUNT(DISTINCT InvoiceNo) > 10 THEN 'High Frequency'
           WHEN COUNT(DISTINCT InvoiceNo) BETWEEN 5 AND 10 THEN 'Medium Frequency'
           ELSE 'Low Frequency'
       END AS CustomerSegment
FROM online_retail
GROUP BY CustomerID;



-- Average Order Value by Country: To find the average order value for each country:
SELECT Country, AVG(Quantity * UnitPrice) AS AvgOrderValue
FROM online_retail
GROUP BY Country;


-- Customer Churn Analysis: To identify customers who haven't purchased in the last 6 months:
SELECT CustomerID, MAX(InvoiceDate) AS LastPurchase
FROM online_retail
GROUP BY CustomerID
HAVING MAX(InvoiceDate) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- Product Affinity Analysis: To determine which products are often purchased together:
SELECT p1.StockCode AS Product1, p2.StockCode AS Product2, COUNT(*) AS TimesPurchasedTogether
FROM online_retail p1
JOIN online_retail p2 ON p1.InvoiceNo = p2.InvoiceNo AND p1.StockCode < p2.StockCode
GROUP BY Product1, Product2
ORDER BY TimesPurchasedTogether DESC;


-- Time-based Analysis: To explore monthly or quarterly sales patterns:
SELECT YEAR(InvoiceDate) AS Year, MONTH(InvoiceDate) AS Month, SUM(Quantity * UnitPrice) AS TotalSales
FROM online_retail
GROUP BY Year, Month
ORDER BY Year, Month;

 -- THE END