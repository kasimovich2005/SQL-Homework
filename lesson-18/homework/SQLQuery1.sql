create database homework18
use homework18

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Samsung Galaxy S23', 'Electronics', 899.99),
(2, 'Apple iPhone 14', 'Electronics', 999.99),
(3, 'Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
(4, 'Dell XPS 13 Laptop', 'Electronics', 1249.99),
(5, 'Organic Eggs (12 pack)', 'Groceries', 3.49),
(6, 'Whole Milk (1 gallon)', 'Groceries', 2.99),
(7, 'Alpen Cereal (500g)', 'Groceries', 4.75),
(8, 'Extra Virgin Olive Oil (1L)', 'Groceries', 8.99),
(9, 'Mens Cotton T-Shirt', 'Clothing', 12.99),
(10, 'Womens Jeans - Blue', 'Clothing', 39.99),
(11, 'Unisex Hoodie - Grey', 'Clothing', 29.99),
(12, 'Running Shoes - Black', 'Clothing', 59.95),
(13, 'Ceramic Dinner Plate Set (6 pcs)', 'Home & Kitchen', 24.99),
(14, 'Electric Kettle - 1.7L', 'Home & Kitchen', 34.90),
(15, 'Non-stick Frying Pan - 28cm', 'Home & Kitchen', 18.50),
(16, 'Atomic Habits - James Clear', 'Books', 15.20),
(17, 'Deep Work - Cal Newport', 'Books', 14.35),
(18, 'Rich Dad Poor Dad - Robert Kiyosaki', 'Books', 11.99),
(19, 'LEGO City Police Set', 'Toys', 49.99),
(20, 'Rubiks Cube 3x3', 'Toys', 7.99);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate)
VALUES
(1, 1, 2, '2025-04-01'),
(2, 1, 1, '2025-04-05'),
(3, 2, 1, '2025-04-10'),
(4, 2, 2, '2025-04-15'),
(5, 3, 3, '2025-04-18'),
(6, 3, 1, '2025-04-20'),
(7, 4, 2, '2025-04-21'),
(8, 5, 10, '2025-04-22'),
(9, 6, 5, '2025-04-01'),
(10, 6, 3, '2025-04-11'),
(11, 10, 2, '2025-04-08'),
(12, 12, 1, '2025-04-12'),
(13, 12, 3, '2025-04-14'),
(14, 19, 2, '2025-04-05'),
(15, 20, 4, '2025-04-19'),
(16, 1, 1, '2025-03-15'),
(17, 2, 1, '2025-03-10'),
(18, 5, 5, '2025-02-20'),
(19, 6, 6, '2025-01-18'),
(20, 10, 1, '2024-12-25'),
(21, 1, 1, '2024-04-20');



CREATE TABLE Employee (
    id INT PRIMARY KEY,
    salary INT
);

INSERT INTO Employee (id, salary) VALUES
(1, 100),
(2, 200),
(3, 300),
(4, 300),
(5, 100);



CREATE TABLE RequestAccepted (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date) VALUES
(1, 2, '2016-06-03'),
(1, 3, '2016-06-08'),
(2, 3, '2016-06-08'),
(3, 4, '2016-06-09');


----- 1. Joriy oyda har bir mahsulot uchun sotilgan umumiy miqdor va jami daromadni saqlash uchun MonthlySales nomli vaqtinchalik jadval yarating.


-- Create the temporary table
CREATE TABLE #MonthlySales (
    ProductID INT,
    TotalQuantity INT,
    TotalRevenue DECIMAL(18,2)
);

-- Insert data for current month (assumed as June 2025)
INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE MONTH(s.SaleDate) = MONTH(GETDATE())
  AND YEAR(s.SaleDate) = YEAR(GETDATE())
GROUP BY s.ProductID;

-- View contents
SELECT * FROM #MonthlySales;



----- 2. Mahsulot ma'lumotlarini va barcha vaqt davomida umumiy savdo miqdorini qaytaradigan vw_ProductSalesSummary nomli ko'rinish yarating.

CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(s.Quantity) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;

-----3. 3. fn_GetTotalRevenueForProduct(@ProductID INT) nomli funksiya yarating.


CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18,2);
    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;


------ 4. 4. fn_GetSalesByCategory(@Category VARCHAR(50)) funksiyasini yarating


CREATE FUNCTION fn_GetSalesByCategory (@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN (
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);


---- 5. Siz foydalanuvchidan kirish sifatida bitta argument oladigan funksiya yaratishingiz kerak va agar kiritilgan raqam tub son boʻlsa, funksiya “Ha” va aks holda “Yoʻq” ni qaytarishi kerak. Siz buni quyidagicha boshlashingiz mumkin:



CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    IF @Number <= 1 RETURN 'No';
    IF @Number IN (2,3) RETURN 'Yes';

    DECLARE @i INT = 2;
    WHILE @i * @i <= @Number
    BEGIN
        IF @Number % @i = 0 RETURN 'No';
        SET @i = @i + 1;
    END
    RETURN 'Yes';
END;


--- 6. Kirish sifatida ikkita butun sonni qabul qiluvchi fn_GetNumbersBetween nomli jadval qiymatli funksiya yarating:

CREATE FUNCTION fn_GetNumbersBetween (@Start INT, @End INT)
RETURNS @Result TABLE (Number INT)
AS
BEGIN
    DECLARE @i INT = @Start;
    WHILE @i <= @End
    BEGIN
        INSERT INTO @Result VALUES (@i);
        SET @i = @i + 1;
    END
    RETURN;
END;






---- 7. Xodimlar jadvalidan N-chi eng yuqori aniq maoshni qaytarish uchun SQL so'rovini yozing. Agar N dan kam ish haqi bo'lsa, NULLni qaytaring.

CREATE FUNCTION getNthHighestSalary (@N INT)
RETURNS TABLE
AS
RETURN (
    SELECT DISTINCT TOP 1 salary AS HighestNSalary
    FROM (
        SELECT DISTINCT salary
        FROM Employee
    ) AS DistinctSalaries
    ORDER BY salary DESC
    OFFSET (@N - 1) ROWS
);




---- 8. Eng ko'p do'stlari bo'lgan odamni topish uchun SQL so'rovini yozing.


SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY COUNT(*) DESC;












CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);



---- 9. Mijoz buyurtmasi xulosasi uchun ko'rinish yarating.


CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;









---- 10. Yetishtirilgan bo‘shliqlarni to‘ldirish uchun SQL bayonini yozing. Siz faqat tanlangan bayonot yozishingiz kerak, jadvalni o'zgartirishga hojat yo'q.


DROP TABLE IF EXISTS Gaps;

CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,'Charlie'),(8,NULL),(9,NULL);


WITH FillGaps AS (
    SELECT 
        RowNumber,
        TestCase,
        MAX(TestCase) OVER (
            ORDER BY RowNumber 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS Workflow
    FROM Gaps
)
SELECT RowNumber, Workflow
FROM FillGaps
ORDER BY RowNumber;




