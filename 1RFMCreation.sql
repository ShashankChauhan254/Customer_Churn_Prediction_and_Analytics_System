CREATE TABLE recency AS
SELECT CustomerID,
DATEDIFF(
(SELECT MAX(STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i')) FROM Customer_Clean_Transactions), 
MAX(STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i'))
) AS Recency
FROM Customer_Clean_Transactions
GROUP BY CustomerID;

CREATE TABLE frequency AS
SELECT CustomerID, COUNT(DISTINCT Invoice) AS Frequency
FROM Customer_Clean_Transactions
GROUP BY CustomerID;

CREATE TABLE monetary AS
SELECT CustomerID, ROUND(SUM(Quantity * Price), 2) AS Monetary
FROM Customer_Clean_Transactions
GROUP BY CustomerID;

CREATE TABLE rfm_data AS
SELECT r.CustomerID, r.Recency, f.Frequency, m.Monetary
FROM recency r 
JOIN frequency f ON r.CustomerID = f.CustomerID
JOIN monetary m ON r.CustomerID = m.CustomerID;

SELECT * FROM rfm_data;