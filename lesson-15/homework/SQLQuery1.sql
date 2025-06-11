create database homework15
use homework15

----  1. Eng kam ish haqi bo'lgan xodimlarni toping\

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);



select * from employees as e
where salary = (select MIN(salary) from employees)



----  2. O'rtacha narxdan yuqori mahsulotlarni toping


CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);


select * from products
where price > (select AVG(price) from products)

/*

3. Savdo bo'limida xodimlarni toping Vazifa: "Sotish" bo'limida ishlaydigan xodimlarni oling. 
Jadvallar: xodimlar (ustunlar: id, ism, bo'lim_id), bo'limlar (ustunlar: id, bo'lim_nomi)

*/

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);


select * from employees
where department_id = ( SELECT id FROM departments WHERE department_name = 'Sales')


---4-Vazifa: Hech qanday buyurtma bermagan mijozlarni oling. 
--Jadvallar: mijozlar (ustunlar: customer_id, ism), buyurtmalar (ustunlar: order_id, customer_id)




CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);


select * from customers
where customer_id NOT IN (SELECT customer_id FROM orders)





---------  5. Har bir turkumda maksimal narxga ega mahsulotlarni toping

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);


select * from products p
where price = (
    select MAX(price)
    from products
    where category_id = p.category_id)







------ 6. Bo'limda eng yuqori o'rtacha maoshga ega bo'lgan xodimlarni toping
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);




SELECT * FROM employees 
WHERE department_id = ( SELECT TOP 1 department_id FROM employees 
	GROUP BY department_id
		ORDER BY AVG(salary) DESC)



-----  7. Bo'lim o'rtachasidan yuqori daromad oladigan xodimlarni toping


CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);


select  * from employees e
where salary > (  select AVG(salary) from employees  where department_id = e.department_id)


---- 9. Har bir toifadagi topshiriq bo'yicha uchinchi eng yuqori narxni toping : 
--Har bir toifadagi uchinchi eng yuqori narxga ega mahsulotlarni oling. 
--Jadvallar: mahsulotlar (ustunlar: id, mahsulot_nomi, narx, kategoriya_id)

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);



select * from products p1
where 2 = ( SELECT COUNT(DISTINCT p2.price)
    FROM products p2
    WHERE p2.category_id = p1.category_id AND p2.price > p1.price
);







----- 10. Ish haqi kompaniyaning o'rtacha va bo'limning maksimal ish haqi orasida bo'lgan xodimlarni toping

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);


select * from employees e
where salary > (select AVG(salary) from employees)
  AND salary < (
      select MAX(salary)
      from employees
      where department_id = e.department_id
)


