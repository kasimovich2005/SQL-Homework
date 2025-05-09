create database homework3
use homework3

--------------  Easy-Level Tasks  -----------------

/* 
1. Tashqi fayllardan katta hajmdagi ma'lumotlani kiritish uchun ishlatiladi
2. .CSV / .TXT / .XML / .JSON
*/

create table Products (
    ProductID int primary key,
    ProductName varchar(50),
    Price decimal(10,2)
)
go

insert into Products (ProductID, ProductName, Price)
values 
(1, 'Olma', 5000.00),
(2, 'Banan', 6000.50),
(3, 'Uzum', 8000.75)

--5. NULL - jadvalga malumot qushayotganda ma'lumot bulishi shartmas 
--   NOT NULL - hardoim ma'lumot bo'lishi shart

ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName)

create table Categories (
    CategoryID int PRIMARY KEY,
    CategoryName varchar(50) UNIQUE
)


--IDENTITY — bu ustun qiymatini avtomatik ravishda oshirib boradigan maxsus belgilovchi. (  ProductID int IDENTITY(1,1) PRIMARY KEY )

BULK INSERT Categories
FROM 'C:\Users\user\Documents\SQL Server Management Studio\lesson-3\Products.csv'
WITH (
    FIELDTERMINATOR = ',',     
    ROWTERMINATOR = '\n',      
    FIRSTROW = 2)



ALTER TABLE Categories
ADD CategoryID INT

ALTER TABLE Categories
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID)


--------------Explain the differences between PRIMARY KEY and UNIQUE KEY.----------------

/*
PRIMARY KEY - NULL qiymat bo‘lishi mumkin emas ,  Har bir jadvalda faqat 1 ta bo‘ladi
UNIQUE KEY - Bitta NULL qiymatga ruxsat beriladi, Bir nechta UNIQUE cheklov bo‘lishi mumkin

*/

-----------Add a CHECK constraint to the Products table ensuring Price > 0.


ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0)

-------14. Modify the Products table to add a column Stock (INT, NOT NULL).


ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0


----15.Use the ISNULL function to replace NULL values in Price column with a 0.


SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price, Stock
FROM Products

/* Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.


FOREIGN KEY ikki jadval o‘rtasida referensial yaxlitlikni (referential integrity) ta’minlaydi.
Products jadvalida CategoryID — bu Categories(CategoryID) ustuniga murojaat qiluvchi foreign key hisoblanadi.

Bu shuni ta’minlaydiki, har qanday mahsulot faqat mavjud bo‘lgan toifaga (kategoriya) biriktiriladi.
	Foydasi:
		Noto‘g‘ri ma’lumot kiritilishini oldini oladi (masalan, mavjud bo‘lmagan kategoriyaga mahsulot biriktirish).

		Jadval orasidagi bog‘liqliklarni ishonchli va bir xilda saqlashga yordam beradi.
*/


------17.Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT CHECK (Age >= 18)
)

------18.Create a table with an IDENTITY column starting at 100 and incrementing by 10.

CREATE TABLE InvoiceNumbers (
    InvoiceID INT IDENTITY(100, 10) PRIMARY KEY,
    Description VARCHAR(255)
)


------19. Write a query to create a composite PRIMARY KEY in a new table OrderDetails.


CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
)

/*
------20.Explain the use of COALESCE and ISNULL functions for handling NULL values.

ISNULL  (a, b)	        Agar a NULL bo‘lsa, bni qaytaradi. Faqat 2ta argument oladi.
COALESCE(a, b, c, ...)	Birinchi NULL bo'lmagan qiymatni qaytaradi. Ko‘p argument oladi.


*/

-------21.Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100) UNIQUE
)


------22.Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    CONSTRAINT FK_Orders_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)


select * from Orders

