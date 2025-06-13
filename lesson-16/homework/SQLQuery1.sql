create database homework16
use homework16


CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')



CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )





CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);




















-- EASY TASKS

------   1. 1 dan 1000 gacha bo'lgan rekursiv so'rov yordamida raqamlar jadvalini yarating.
 
WITH Numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1 FROM Numbers WHERE num < 1000
)
SELECT * FROM Numbers
OPTION (MAXRECURSION 1000);

-- 2. Olingan jadvaldan foydalanib, bir xodimga to'g'ri keladigan jami sotishni topish uchun so'rov yozing.(Sotish, Xodimlar)
SELECT 
    E.EmployeeID,
    E.FirstName+
    E.LastName AS Full_name,
    SalesPerEmp.TotalSales
FROM Employees E
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS SalesPerEmp
ON E.EmployeeID = SalesPerEmp.EmployeeID;


-- 3.Xodimlarning o'rtacha ish haqini topish uchun CTE yarating.(Xodimlar)
WITH AvgSalary AS (
    SELECT AVG(Salary) AS AverageSalary FROM Employees
)
SELECT * FROM AvgSalary;


-- 4. Highest sales for each product using derived table
SELECT p.ProductID, MAX_Sales
FROM Products p
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS MAX_Sales
    FROM Sales
    GROUP BY ProductID
) s ON p.ProductID = s.ProductID;

-- 5. Double the number per record until < 1,000,000
WITH Doubles AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2 FROM Doubles WHERE num * 2 < 1000000
)
SELECT * FROM Doubles
OPTION (MAXRECURSION 20);

-- 6. Employees with more than 5 sales using CTE
WITH SalesCount AS (
    SELECT EmployeeID, COUNT(*) AS SalesNum
    FROM Sales
    GROUP BY EmployeeID
)
SELECT e.FirstName, e.LastName, s.SalesNum
FROM SalesCount s
JOIN Employees e ON e.EmployeeID = s.EmployeeID
WHERE s.SalesNum > 5;

-- 7. Products with sales greater than $500 using CTE
WITH ProductSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT p.ProductID, p.ProductName, ps.TotalSales
FROM Products p
JOIN ProductSales ps ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500;

-- 8. Employees with salaries above average using CTE
WITH AvgSal AS (
    SELECT AVG(Salary) AS avg_sal FROM Employees
)
SELECT * FROM Employees
WHERE Salary > (SELECT avg_sal FROM AvgSal);

-- MEDIUM TASKS

-- 1. Top 5 employees by number of orders (derived table)
SELECT TOP 5 e.FirstName, e.LastName, s.OrderCount
FROM (
    SELECT EmployeeID, COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) s
JOIN Employees e ON e.EmployeeID = s.EmployeeID
ORDER BY s.OrderCount DESC;

-- 2. Sales per product category (assuming Products table has CategoryID)


SELECT E.EmployeeID, E.FirstName, E.LastName
FROM Employees E
LEFT JOIN Sales S ON E.EmployeeID = S.EmployeeID
WHERE S.SalesID IS NULL;






-- 3. Return factorial of each value in Numbers1



SELECT 
    d.DepartmentName,
    e.FirstName
	+e.LastName AS Full_name,
    e.Salary AS MaxSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary = (
    SELECT MAX(e2.Salary)
    FROM Employees e2
    WHERE e2.DepartmentID = e.DepartmentID
);





-- 4. Split string into characters (recursion)

WITH CharCTE AS (
    SELECT Id, 1 AS pos, SUBSTRING(String, 1, 1) AS char, String
    FROM Example
    UNION ALL
    SELECT Id, pos + 1, SUBSTRING(String, pos + 1, 1), String
    FROM CharCTE
    WHERE pos + 1 <= LEN(String)
)
SELECT Id, char FROM CharCTE
ORDER BY Id, pos
OPTION (MAXRECURSION 100);

-- 5. Sales difference between current and previous month using CTE
WITH MonthlySales AS (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
),
SalesDiff AS (
    SELECT 
        SaleMonth,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY SaleMonth) AS PrevSales
    FROM MonthlySales
)
SELECT *, (TotalSales - PrevSales) AS SalesDifference FROM SalesDiff;

-- 6. Employees with sales over $45,000 in each quarter
WITH QuarterlySales AS (
    SELECT 
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS QTR,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
)
SELECT e.FirstName, e.LastName, q.TotalSales, q.QTR
FROM QuarterlySales q
JOIN Employees e ON e.EmployeeID = q.EmployeeID
WHERE q.TotalSales > 45000;

-- DIFFICULT TASKS

-- 1. Fibonacci using recursion
WITH Fibonacci (n, a, b) AS (
    SELECT 1, 0, 1
    UNION ALL
    SELECT n + 1, b, a + b FROM Fibonacci
    WHERE n < 30
)
SELECT n, a AS FibonacciValue FROM Fibonacci
OPTION (MAXRECURSION 100);

-- 2. Find string where all characters are the same and length > 1

SELECT 
    E.FirstName + ' ' + E.LastName AS EmployeeName,
    SUM(CASE WHEN MONTH(S.SaleDate) = 1 THEN S.SalesAmount ELSE 0 END) AS Jan,
    SUM(CASE WHEN MONTH(S.SaleDate) = 2 THEN S.SalesAmount ELSE 0 END) AS Feb,
    SUM(CASE WHEN MONTH(S.SaleDate) = 3 THEN S.SalesAmount ELSE 0 END) AS Mar,
    SUM(CASE WHEN MONTH(S.SaleDate) = 4 THEN S.SalesAmount ELSE 0 END) AS Apr,
    SUM(CASE WHEN MONTH(S.SaleDate) = 5 THEN S.SalesAmount ELSE 0 END) AS May
    -- Add more months as needed
FROM Sales S
JOIN Employees E ON S.EmployeeID = E.EmployeeID
GROUP BY E.FirstName, E.LastName;


-- 3. 1, 12, 123... up to n=5


SELECT C.CustomerID, C.FirstName, C.LastName
FROM Customers C
WHERE NOT EXISTS (
    SELECT ProductID
    FROM Products
    EXCEPT
    SELECT S.ProductID
    FROM Sales S
    WHERE S.CustomerID = C.CustomerID
);



-- 4. Employees with most sales in last 6 months
WITH Last6Months AS (
    SELECT * FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
),
TopSales AS (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Last6Months
    GROUP BY EmployeeID
)
SELECT e.FirstName, e.LastName, t.TotalSales
FROM TopSales t
JOIN Employees e ON e.EmployeeID = t.EmployeeID
WHERE t.TotalSales = (SELECT MAX(TotalSales) FROM TopSales);

-- 5. Remove duplicate and single digits from string

WITH EmpAvg AS (
    SELECT 
        E.EmployeeID,
        E.DepartmentID,
        AVG(S.SalesAmount) AS EmpAvgSales
    FROM Employees E
    JOIN Sales S ON E.EmployeeID = S.EmployeeID
    GROUP BY E.EmployeeID, E.DepartmentID
),
DeptAvg AS (
    SELECT 
        E.DepartmentID,
        AVG(S.SalesAmount) AS DeptAvgSales
    FROM Employees E
    JOIN Sales S ON E.EmployeeID = S.EmployeeID
    GROUP BY E.DepartmentID
)
SELECT 
    EA.EmployeeID,
    EA.EmpAvgSales,
    DA.DeptAvgSales
FROM EmpAvg EA
JOIN DeptAvg DA ON EA.DepartmentID = DA.DepartmentID
WHERE EA.EmpAvgSales > DA.DeptAvgSales;
