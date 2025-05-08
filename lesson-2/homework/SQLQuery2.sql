create database lesson2
use lesson2

create table Employees(
	EmpID INT,
	Name VARCHAR(50),
	Salary DECIMAL (10,2)
)
 
 -- Bir qatorli INSERT INTO
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Bozorqulov Sardor', 12000.00)

-- Bir necha qatorli INSERT INTO
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
    (2, 'Karimova Nargiza', 13500.50),
    (3, 'Tursunov Jahongir', 9800.75)



--Update the Salary of an employee to 7000 where EmpID = 1

UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1

--Delete a record from the Employees table where EmpID = 2.

DELETE FROM Employees
WHERE EmpID = 2

-- Give a brief definition for difference between DELETE, TRUNCATE, and DROP.

/* DELETE - Ma'lumotlarni uzchirish uchun
  TRUNCATE- Barcha ma’lumotlarni tozalash
  DROP	- Butun jadvalni o‘chirish (strukturasi bilan)

*/

--Modify the Name column in the Employees table to VARCHAR(100)

ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100)

-- Add a new column Department (VARCHAR(50)) to the Employees table.

ALTER TABLE Employees
ADD Department VARCHAR(50)

--Change the data type of the Salary column to FLOAT.

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT

--Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT

--Remove all records from the Employees table without deleting its structure.

TRUNCATE TABLE Employees

--------------------Intermediate-Level Tasks-------------------


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Insert records into Departments table
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES 
    (1, 'Finance'),
    (2, 'HR'),
    (3, 'IT'),
    (4, 'Marketing'),
    (5, 'Logistics')

	-- Update the Department of all employees where Salary > 5000 to 'Management'.

ALTER TABLE Employees
ADD Department VARCHAR(50)

INSERT INTO Employees (EmpID, Name, Salary, Department)
VALUES 
    (1, 'Bozorqulov Sardor', 12000.00, NULL),
    (2, 'Karimova Nargiza', 4500.00, NULL),
    (3, 'Tursunov Jahongir', 8000.00, NULL)

	UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

-- Write a query that removes all employees but keeps the table structure intact.

TRUNCATE TABLE Employees;

-- Drop the Department column from the Employees table.

ALTER TABLE Employees
DROP COLUMN Department;

--Rename the Employees table to StaffMembers using SQL commands.

EXEC sp_rename 'Employees', 'StaffMembers';

--Write a query to completely remove the Departments table from the database.

DROP TABLE Departments;

------------------------Advanced-Level Tasks (9)----------------
/* Create a table named Products with at least 5 columns, including: ProductID (Primary Key),
ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)*/

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
)

--Add a CHECK constraint to ensure Price is always greater than 0.

ALTER TABLE Products
ADD CONSTRAINT chk_Price_Positive CHECK (Price > 0);

--Modify the table to add a StockQuantity column with a DEFAULT value of 50.

ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50

--Rename Category to ProductCategory

EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN'

-- Insert 5 records into the Products table using standard INSERT INTO queries.

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES
    (1, 'Smartphone X', 'Electronics', 899.99, 100),
    (2, 'Running Shoes', 'Footwear', 120.00, 60),
    (3, 'Bluetooth Speaker', 'Electronics', 45.50, 80),
    (4, 'Office Chair', 'Furniture', 150.25, 40),
    (5, 'Water Bottle', 'Accessories', 12.99, 200)


SELECT * INTO Products_Backup
FROM Products

--Rename the Products table to Inventory.

EXEC sp_rename 'Products', 'Inventory'

--Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.

ALTER TABLE Inventory
DROP CONSTRAINT chk_Price_Positive

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT

--Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.


ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5)



