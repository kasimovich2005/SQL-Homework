create database homework17
use homework17


----  1. Siz barcha distribyutorlar va ularning mintaqalar bo'yicha sotilishi haqida hisobot taqdim etishingiz kerak. 
----Agar distribyutorda mintaqa uchun hech qanday savdo bo'lmasa, o'sha kun uchun nol dollar qiymatini belgilang. 
----Har bir mintaqa uchun kamida bitta sotuv bor deb hisoblang

DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);



WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
AllCombos AS (
    SELECT r.Region, d.Distributor
    FROM Regions r
    CROSS JOIN Distributors d
)
SELECT 
    ac.Region,
    ac.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM AllCombos ac
LEFT JOIN #RegionSales rs
    ON rs.Region = ac.Region AND rs.Distributor = ac.Distributor
ORDER BY ac.Distributor, ac.Region;



---- 2. Kamida beshta bevosita hisobotga ega bo'lgan menejerlarni toping

CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

SELECT e.name
FROM Employee e
JOIN (
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m ON e.id = m.managerId;



-----3. 2020-yil fevral oyida kamida 100 dona buyurtma qilingan mahsulotlarning nomlarini va ularning miqdorini olish uchun yechim yozing.


CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);



SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;



---- 4. Har bir mijoz eng koʻp buyurtma bergan sotuvchini qaytaradigan SQL bayonotini yozing.


DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');



SELECT CustomerID, Vendor
FROM (
    SELECT CustomerID, Vendor, COUNT(*) AS Orders,
           RANK() OVER (PARTITION BY CustomerID ORDER BY COUNT(*) DESC) AS rk
    FROM Orders
    GROUP BY CustomerID, Vendor
) t
WHERE rk = 1;




---5. Sizga @Check_Prime nomli oʻzgaruvchi sifatida raqam beriladi, bu raqam tub yoki yoʻqligini tekshirib koʻring, keyin “Bu raqam tub” ni qaytaring, aks holda “Bu raqam tub emas” ni qaytaring.
--Misol kiritish:

DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @isPrime BIT = 1;

WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;
        BREAK;
    END
    SET @i = @i + 1;
END

IF @Check_Prime <= 1
    SET @isPrime = 0;

IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';



---- 6. Berilgan jadvaldagi har bir qurilma uchun signallarning umumiy sonini va signallarning umumiy sonini qaytarish uchun SQL so'rovini yozing.


CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');



WITH LocationStats AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS signal_count
    FROM Device
    GROUP BY Device_id, Locations
),
MaxLoc AS (
    SELECT *,
        RANK() OVER (PARTITION BY Device_id ORDER BY signal_count DESC) AS rk
    FROM LocationStats
),
DeviceSummary AS (
    SELECT 
        Device_id,
        COUNT(DISTINCT Locations) AS no_of_location,
        SUM(signal_count) AS no_of_signals
    FROM LocationStats
    GROUP BY Device_id
)
SELECT 
    ds.Device_id,
    ds.no_of_location,
    ml.Locations AS max_signal_location,
    ds.no_of_signals
FROM DeviceSummary ds
JOIN MaxLoc ml ON ds.Device_id = ml.Device_id AND ml.rk = 1;




---- 7. Tegishli bo'limda o'rtacha maoshdan ortiq maosh oladigan barcha Xodimlarni topish uchun SQL yozing. Chiqishingizda EmpID, EmpName, Maoshni qaytaring


CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);


SELECT EmpID, EmpName, Salary
FROM Employee e
JOIN (
    SELECT DeptID, AVG(Salary) AS avg_salary
    FROM Employee
    GROUP BY DeptID
) d ON e.DeptID = d.DeptID
WHERE e.Salary > d.avg_salary;



---- 8. Siz ofis lotereya pulining bir qismisiz, unda siz yutuqli lotereya raqamlari jadvalini hamda har bir chiptaning tanlangan raqamlari jadvalini saqlaysiz. 
----Agar chiptada barcha yutuq raqamlari bo'lmasa-da, ba'zilari bo'lsa, siz 10 dollar yutib olasiz. 
----Agar chiptada barcha yutuq raqamlari bo'lsa, siz 100 dollar yutib olasiz. Bugungi o'yin uchun umumiy yutuqni hisoblang.

-- Create tables
CREATE TABLE WinningNumbers (Number INT);
CREATE TABLE Tickets (TicketID VARCHAR(20), Number INT);

-- Sample input
TRUNCATE TABLE WinningNumbers;
INSERT INTO WinningNumbers VALUES (25), (45), (78);

TRUNCATE TABLE Tickets;
INSERT INTO Tickets VALUES 
('A23423', 25), ('A23423', 45), ('A23423', 78),
('B35643', 25), ('B35643', 45), ('B35643', 98),
('C98787', 67), ('C98787', 86), ('C98787', 91);

-- Calculate winnings
SELECT 
    SUM(
        CASE 
            WHEN matches = total THEN 100
            WHEN matches > 0 THEN 10
            ELSE 0
        END
    ) AS TotalWinnings
FROM (
    SELECT 
        t.TicketID,
        COUNT(DISTINCT t.Number) AS total,
        COUNT(DISTINCT w.Number) AS matches
    FROM Tickets t
    LEFT JOIN WinningNumbers w ON t.Number = w.Number
    GROUP BY t.TicketID
) AS results;




---9. Sarflar jadvali ish stoli va mobil qurilmalari bo'lgan onlayn xarid veb-saytidan xaridlarni amalga oshirgan foydalanuvchilarning xarajatlari jurnalini saqlaydi.
---Foydalanuvchilarning umumiy sonini va har bir sana uchun faqat mobil, faqat ish stoli va ikkala mobil va ish stoli yordamida sarflangan umumiy miqdorni topish uchun SQL so‘rovini yozing.


CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);



WITH SpendingType AS (
    SELECT 
        User_id,
        Spend_date,
        MAX(CASE WHEN Platform = 'mobile' THEN 1 ELSE 0 END) AS has_mobile,
        MAX(CASE WHEN Platform = 'desktop' THEN 1 ELSE 0 END) AS has_desktop
    FROM Spending
    GROUP BY User_id, Spend_date
),
UserType AS (
    SELECT 
        s.Spend_date,
        CASE 
            WHEN has_mobile = 1 AND has_desktop = 0 THEN 'Mobile Only'
            WHEN has_mobile = 0 AND has_desktop = 1 THEN 'Desktop Only'
            WHEN has_mobile = 1 AND has_desktop = 1 THEN 'Both'
        END AS PlatformType,
        s.User_id
    FROM SpendingType s
),
SpendSum AS (
    SELECT 
        u.Spend_date,
        u.PlatformType,
        COUNT(DISTINCT u.User_id) AS total_users,
        SUM(s.Amount) AS total_amount
    FROM UserType u
    JOIN Spending s ON u.User_id = s.User_id AND u.Spend_date = s.Spend_date
    GROUP BY u.Spend_date, u.PlatformType
)
SELECT * FROM SpendSum
ORDER BY Spend_date;




------ 10. Quyidagi ma'lumotlarni guruhdan ajratish uchun SQL bayonotini yozing.

-- Input jadvali
CREATE TABLE #Grouped (
  Product VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);

INSERT INTO #Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

-- Yechim: Quantity soni bo’yicha satrlarni ko’paytirish
SELECT
  g.Product,
  1 AS Quantity
FROM #Grouped g
CROSS APPLY (
    SELECT TOP (g.Quantity) n = ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM sys.all_objects
) AS t
ORDER BY g.Product;
