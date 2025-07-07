# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**:MySQL Workbench or any compatible SQL interface


I carried out this project to demonstrate my SQL skills and apply core techniques used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions using SQL queries. It reflects my hands-on experience in working with data and is ideal for anyone beginning their journey in data analysis who wants to build a strong foundation in SQL.

## Objectives

1. **Set up a retail sales database**: I created and populated a retail sales database using structured sales data to simulate a real-world business environment.
2. **Data Cleaning**: I identified and handled records with missing or null values to ensure the dataset was clean, consistent, and ready for analysis.
3. **Exploratory Data Analysis (EDA)**: I explored the data to uncover basic patterns, trends, and summary statistics that provide an overview of the sales performance.
4. **Business Analysis**: I wrote SQL queries to solve real-world business problems, extract insights, and support data-driven decision-making.

## Project Structure

### 1. Database Setup

- **Database Creation**: I began the project by creating a database named my_retail_sales_analysis to store and manage the retail sales data.
- **Table Creation**:I then created a table called retail_sales with columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database my_retail_sales_analysis;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: I determined the total number of records in the dataset to understand the overall size and scale of the data.
- **Customer Count**: I identified the number of unique customers to assess the customer base represented in the dataset.
- **Category Count**: I explored the dataset to find all unique product categories, giving insight into the variety of items sold.
- **Null Value Check**: I checked for any null or missing values across all columns and removed incomplete records to ensure data quality and reliability.



```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Sales on a Specific Date**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Clothing Sales (Quantity > 4) in November 2022**:
```sql
SELECT 
    *
FROM retail_sales
WHERE  
    category = 'Clothing'
    AND 
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND quantity >=4 ;
```

3. **Total Sales per Category**:
```sql

SELECT * FROM retail_sales;

SELECT 
     category,
     SUM(total_sale) as net_sale, 
     COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;
```

4. **Average Age of Customers (Beauty Category).**:
```sql
SELECT 
   ROUND(AVG(age),2) as avg_age
FROM retail_sales
WHERE category='Beauty';
```

5. **High-Value Transactions**:
```sql
SELECT * FROM  retail_sales
WHERE total_sale >1000
;
```

6. **Transaction Count by Gender and Category**:
```sql
SELECT
      category,
       gender, 
       COUNT(*) AS total_trans
FROM retail_sales
GROUP BY 
     category,  
     gender
ORDER BY category;

```

7. **Monthly Average Sales + Best-Selling Month**:
```sql
WITH monthly_avg AS
 (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM retail_sales
    GROUP BY year, month
),
ranked_months AS(
SELECT 
    year,
     month,
     avg_sale,
       RANK() OVER (PARTITION BY year ORDER BY avg_sale DESC) AS sale_rank
FROM monthly_avg)
SELECT 
     year,
     month,
     avg_sale
     FROM ranked_months
     WHERE sale_rank=1;

```




8. **Top 5 Customers by Total Sales**:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```

9. **Unique Customers per Category**:
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as count_unique_customers
FROM retail_sales
GROUP BY category
```

10. **10. Sales Shift Analysis (Morning, Afternoon, Evening)**:
```sql
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




```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Akinyemi Hassan

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/hassan-akinyemi-8b3464137/)


Thank you for your support, and I look forward to connecting with you!
