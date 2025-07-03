create database homework22
use homework22


--EASY
--TASK-1
--Compute Running Total Sales per Customer
SELECT *,
  SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM sales_data;


--TASK-2
--Count the Number of Orders per Product Category
SELECT product_category,
  COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;


--TASK-3
--Find the Maximum Total Amount per Product Category
SELECT product_category,
  MAX(total_amount) AS max_amount
FROM sales_data
GROUP BY product_category;


--TASK-4
--Find the Minimum Price of Products per Product Category
SELECT product_category,
  MIN(unit_price) AS min_price
FROM sales_data
GROUP BY product_category;


--TASK-5
--Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
SELECT *,
  AVG(total_amount) OVER (
    ORDER BY order_date
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
  ) AS moving_avg
FROM sales_data;


--TASK-6
--Find the Total Sales per Region
SELECT region,
  SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;


--TASK-7
--Compute the Rank of Customers Based on Their Total Purchase Amount
SELECT customer_id, customer_name,
  SUM(total_amount) AS total_spent,
  RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_by_spending
FROM sales_data
GROUP BY customer_id, customer_name;


--TASK-8
--Calculate the Difference Between Current and Previous Sale Amount per Customer
SELECT *,
  total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS diff_from_prev
FROM sales_data;


--TASK-9
--Find the Top 3 Most Expensive Products in Each Category
SELECT *
FROM (
  SELECT *,
    RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS rnk
  FROM sales_data
) AS ranked
WHERE rnk <= 3;


--TASK-10
--Compute the Cumulative Sum of Sales Per Region by Order Date
SELECT *,
  SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS cumulative_sales
FROM sales_data;



--MEDIUM
--TASK-1
--Compute Cumulative Revenue per Product Category
SELECT *,
  SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date) AS cumulative_revenue
FROM sales_data;


--TASK-2
--Sum of Previous Values to Current Value
SELECT Value,
  SUM(Value) OVER (ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Sum of Previous]
FROM OneColumn;


--TASK-3
--Odd Starting Row Number per Partition
SELECT Id, Vals,
  ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) + 
  2 * (ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) - 1) AS RowNumber
FROM Row_Nums;


--TASK-4
--Customers who purchased from more than one product_category
SELECT customer_id, customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;


--TASK-5
--Customers with Above-Average Spending in Their Region
SELECT customer_id, customer_name, region,
  SUM(total_amount) AS customer_total
FROM sales_data
GROUP BY customer_id, customer_name, region
HAVING SUM(total_amount) >
  (SELECT AVG(region_total)
   FROM (
     SELECT region, SUM(total_amount) AS region_total
     FROM sales_data
     GROUP BY region
   ) AS sub);


--TASK-6
--Rank customers based on their total spending within region
SELECT customer_id, customer_name, region,
  SUM(total_amount) AS total_spent,
  RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS regional_rank
FROM sales_data
GROUP BY customer_id, customer_name, region;


--TASK-7
--Running Total by Customer by Order Date
SELECT *,
  SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS cumulative_sales
FROM sales_data;


--TASK-8
--Monthly Sales Growth Rate
SELECT FORMAT(order_date, 'yyyy-MM') AS sales_month,
  SUM(total_amount) AS monthly_sales,
  LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')) AS prev_month_sales,
  (SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM'))) * 100.0 /
    NULLIF(LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')), 0) AS growth_rate
FROM sales_data
GROUP BY FORMAT(order_date, 'yyyy-MM');






--TASK-9
--Customers with increased total_amount over previous order
SELECT *,
  LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_total,
  CASE
    WHEN total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date)
    THEN 'Increased'
  END AS increased_flag
FROM sales_data;



--HARD
--TASK-1
--Products with Price > Average
SELECT *
FROM sales_data
WHERE unit_price > (
  SELECT AVG(unit_price)
  FROM sales_data
);


--TASK-2
--Group Total in First Row
SELECT *,
  CASE 
    WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
    THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
  END AS Tot
FROM MyData;


--TASK-3
--Sum Puzzle (Sum Cost, Sum Unique Quantity)
SELECT Id,
  SUM(Cost) AS Cost,
  SUM(DISTINCT Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY Id;


--TASK-4
--Find Gaps in Seat Numbers
SELECT 
  SeatNumber + 1 AS [Gap Start],
  LEAD(SeatNumber) OVER (ORDER BY SeatNumber) - 1 AS [Gap End]
FROM (
  SELECT SeatNumber, 
         LEAD(SeatNumber) OVER (ORDER BY SeatNumber) AS next_seat
  FROM Seats
) AS temp
WHERE next_seat - SeatNumber > 1;


--TASK-5
--Even Starting Row Number per Partition
SELECT Id, Vals,
  ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) +
  2 * (ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) - 1) + 1 AS Changed
FROM Row_Nums;