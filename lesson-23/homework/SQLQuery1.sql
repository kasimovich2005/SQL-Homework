create database homework23
use homework23


--TASK-1  
--Extract the month from Dt and prefix with 0 if single digit  
SELECT 
    Id, 
    Dt,
    RIGHT('00' + CAST(MONTH(Dt) AS VARCHAR), 2) AS MonthPrefixedWithZero
FROM Dates;


--TASK-2  
--Count unique Ids and get SUM of MAX Vals for each (Id, rID) group  
SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVal) AS TotalOfMaxVals
FROM (
    SELECT 
        Id,
        rID,
        MAX(Vals) AS MaxVal
    FROM MyTabel
    GROUP BY Id, rID
) t
GROUP BY rID;


--TASK-3  
--Get records where Vals length is between 6 and 10  
SELECT *
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;


--TASK-4  
--Find max Vals for each ID and return associated Item  
SELECT ID, Item, Vals
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY ID ORDER BY Vals DESC) AS rn
    FROM TestMaximum
) t
WHERE rn = 1;


--TASK-5  
--Find max Vals for each (Id, DetailedNumber) and sum them per Id  
SELECT 
    Id,
    SUM(MaxVal) AS SumOfMax
FROM (
    SELECT 
        Id,
        DetailedNumber,
        MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) t
GROUP BY Id;


--TASK-6  
--Return difference a - b, replace 0 with blank  
SELECT 
    Id, 
    a, 
    b, 
    CASE 
        WHEN a - b = 0 THEN '' 
        ELSE CAST(a - b AS VARCHAR)
    END AS OUTPUT
FROM TheZeroPuzzle;


--TASK-7  
--Calculate total revenue from all sales  
SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;


--TASK-8  
--Get average unit price of products  
SELECT AVG(UnitPrice) AS AverageUnitPrice
FROM Sales;


--TASK-9  
--Count total number of sales transactions  
SELECT COUNT(*) AS TotalTransactions
FROM Sales;


--TASK-10  
--Find the maximum quantity sold in a single transaction  
SELECT MAX(QuantitySold) AS MaxUnitsSold
FROM Sales;


--TASK-11  
--Get number of products sold per category  
SELECT Category, SUM(QuantitySold) AS TotalUnits
FROM Sales
GROUP BY Category;


--TASK-12  
--Get total revenue per region  
SELECT Region, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region;


--TASK-13  
--Find the product with highest total revenue  
SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;


--TASK-14  
--Calculate running total of revenue ordered by SaleDate  
SELECT 
    SaleDate,
    Product,
    QuantitySold * UnitPrice AS Revenue,
    SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS RunningTotal
FROM Sales;


--TASK-15  
--Calculate each category’s contribution to total revenue  
SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    CAST(SUM(QuantitySold * UnitPrice) * 100.0 / 
         SUM(SUM(QuantitySold * UnitPrice)) OVER () AS DECIMAL(5,2)) AS PercentOfTotal
FROM Sales
GROUP BY Category;


--TASK-16  
--Show all sales along with corresponding customer names  
SELECT 
    s.*,
    c.CustomerName
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;


--TASK-17  
--List customers who have not made any purchases  
SELECT *
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1 FROM Sales s WHERE s.CustomerID = c.CustomerID
);


--TASK-18  
--Compute total revenue generated from each customer  
SELECT 
    CustomerID,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY CustomerID;


--TASK-19  
--Find the customer who has contributed the most revenue  
SELECT TOP 1 
    c.CustomerName,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;


--TASK-20  
--Calculate total sales per customer  
SELECT 
    c.CustomerName,
    COUNT(s.SaleID) AS TotalSales
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName;


--TASK-21  
--List products that have been sold at least once  
SELECT DISTINCT Product
FROM Sales;


--TASK-22  
--Find the most expensive product in Products table  
SELECT TOP 1 *
FROM Products
ORDER BY SellingPrice DESC;



--TASK-23  
--Find products with selling price above average of their category  
SELECT *
FROM Products p
WHERE p.SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Products
    WHERE Category = p.Category
);