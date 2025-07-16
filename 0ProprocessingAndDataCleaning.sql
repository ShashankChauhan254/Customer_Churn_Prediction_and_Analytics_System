CREATE DATABASE customer_segmentation;

CREATE TABLE Customer_Clean_Transactions 
SELECT * FROM online_retail_ii 
WHERE CustomerID != '' AND Quantity > 0 AND Price > 0;

SELECT * FROM Customer_Clean_Transactions;
