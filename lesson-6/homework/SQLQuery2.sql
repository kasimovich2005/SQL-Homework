create database homework6
use homework6

------Puzzle 1: Finding Distinct Values


CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
    INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');

select * from InputTbl

SELECT DISTINCT
    LEAST(col1, col2) AS col1,
    GREATEST(col1, col2) AS col2
FROM InputTbl;


----Puzzle 2: Removing Rows with All Zeroes

CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

-----1-usul
	
	select * from TestMultipleZero
	where A<>0 or B<>0 or C<>0 or D<>0

----2usul
	select * from TestMultipleZero
	where not(A=0 and B=0 and C=0 and D=0)

-- 3-usul
	select * from TestMultipleZero
	where A+B+C+D>0


---Puzzle 3: Find those with odd ids

create table section1(id int, name varchar(20))
go
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')

select * 
from section1
where id % 2 = 1;


---Puzzle 4: Person with the smallest id (use the table in puzzle 3)

SELECT *
FROM section1
WHERE id = (SELECT MIN(id) FROM section1);


-----Puzzle 5: Person with the highest id (use the table in puzzle 3)

SELECT *
FROM section1
WHERE id = (SELECT MAX(id) FROM section1);

-----Puzzle 6: People whose name starts with b (use the table in puzzle 3)

SELECT *
FROM section1
WHERE LOWER(name) LIKE 'b%';

----Puzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).


CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);
go
INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';





