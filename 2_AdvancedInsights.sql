CREATE VIEW Top_Stock_Revenue AS 
SELECT Description AS Stock, ROUND(SUM(Quantity * Price), 2) AS Revenue
FROM customer_clean_transactions GROUP BY Description ORDER BY Revenue DESC LIMIT 10;

SELECT * FROM Top_Stock_Revenue;

CREATE VIEW Monthly_Revenue_Trend AS
SELECT CONCAT(SUBSTRING(InvoiceDate, 7, 4), '-', SUBSTRING(InvoiceDate, 4, 2)) AS Month,
ROUND(SUM(Quantity * Price), 2) AS Monthly_Revenue
FROM customer_clean_transactions GROUP BY Month ORDER BY Month;

SELECT * FROM Monthly_Revenue_Trend;

CREATE VIEW Country_Wise_Churn_Risk_Summary AS
SELECT c.Country, COUNT(DISTINCT p.CustomerID) AS Total_Customers,
ROUND(AVG(p.Churn_Probability), 2) AS Avg_Risk FROM churn_predictions p
JOIN customer_clean_transactions c ON p.CustomerID = c.CustomerID
GROUP BY c.Country ORDER BY Avg_Risk DESC;

SELECT * FROM Country_Wise_Churn_Risk_Summary;

CREATE VIEW Segment_Wise_Churn AS
SELECT Segment, COUNT(*) AS Total_Customers, 
SUM(CASE WHEN Predicted_Churn = 0 THEN 1 ELSE 0 END) AS Churned,
ROUND(AVG(Churn_Probability), 4) AS Avg_Risk FROM churn_predictions
GROUP BY Segment ORDER BY Avg_Risk DESC;

SELECT * FROM Segment_Wise_Churn;