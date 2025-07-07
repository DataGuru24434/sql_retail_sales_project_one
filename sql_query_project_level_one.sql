-- SQL Retail Sales Analysis

create database my_retail_sales_analysis;

-- create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
             (
				transactions_id INT,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(15),
				age	INT,
				category VARCHAR(15),
				quantiy	INT,
				price_per_unit	FLOAT,
				cogs	FLOAT,
				total_sale FLOAT

);

ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;


SELECT * FROM retail_sales
LIMIT 10;



INSERT INTO retail_sales (
    transactions_id,
    sale_date,
    sale_time,
    customer_id,
    gender,
    age,
    category,
    quantiy,
    price_per_unit,
    cogs,
    total_sale
)
SELECT
    9999,               -- new unique transaction ID
    sale_date,
    sale_time,
    customer_id,
    gender,
    age,
    category,
    quantiy,
    price_per_unit,
    cogs,
    total_sale
FROM retail_sales
WHERE transactions_id = 100;

SELECT 
  COUNT(*) 
FROM retail_sales;


SELECT COUNT(*) FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR 
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR 
    category IS NULL
    OR
    quantiy IS NULL
    OR
    price_per_unit IS NULL
    OR 
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Data Exploration

-- How many sales do we have ?

SELECT COUNT(*) AS total_sale FROM retail_sales;

-- How many customers?

SELECT * FROM retail_sales;

-- How many UNIQUE  customers do we have?

SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales;

-- How many category do we have?

SELECT COUNT(DISTINCT category) AS total_sale FROM  retail_sales;

-- Data Analysis & Business problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on "2022-11-05"

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 - Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT 
    *
FROM retail_sales
WHERE  
    category = 'Clothing'
    AND 
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND quantity >=4 ;
    
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT * FROM retail_sales;

SELECT 
     category,
     SUM(total_sale) as net_sale, 
     COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;

-- Q4. Write a SQL query to find the average age of customers who purchased items form the 'Beauty' Category

SELECT 
   ROUND(AVG(age),2) as avg_age
FROM retail_sales
WHERE category='Beauty';

-- Q.5- Write a SQL query to find all transAactions where the total_sale is greater than 1000.

SELECT * FROM  retail_sales
WHERE total_sale >1000
;
-- Q.6-- Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category

SELECT
	 category,
     gender,
     COUNT(*) as total_trans
FROM retail_sales
GROUP BY 
       category,
       gender
ORDER BY 1;

-- Q.7-- write a SQL query to calculate the average sale for eaach month. Find out best selling month in each year

WITH monthly_avg AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM retail_sales
    GROUP BY 1, 2
)

SELECT 
    year,
    month,
    avg_sale,
    RANK() OVER (PARTITION BY year ORDER BY avg_sale DESC) AS sale_rank
FROM monthly_avg;

SELECT 
     customer_id,
     SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category


SELECT 
     category,
      COUNT(DISTINCT customer_id) AS count_unique_customers
FROM retail_sales
GROUP BY category;

-- Q.10. Write a SQL query to create each shift and number of orders (Example  Morning <=12, Afternoon 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT * ,
CASE 
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS shift
FROM retail_sales
)
SELECT 
  shift,
  COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift
ORDER BY total_orders DESC



