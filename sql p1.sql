-- Sql retail sell analysis_Project 1
CREATE DATABASE project_1;

-- CREATE TABLE
DROP TABLE IF EXISTS retail_sales ;
CREATE TABLE retail_sales
   (
   transactions_id	INT PRIMARY KEY,
   sale_date	DATE,
   sale_time	TIME,
   customer_id	INT,
   gender	VARCHAR(15),
   age	INT,
   category	VARCHAR(15),
   quantiy	INT,
   price_per_unit FLOAT,
   cogs FLOAT,
   total_sale FLOAT

);

SELECT * FROM retail_sales 
LIMIT 10

-- NULL VALUE (Cleanning data)

SELECT * FROM retail_sales 
WHERE transactions_id IS NULL

SELECT * FROM retail_sales 
WHERE sale_date IS NULL

SELECT * FROM retail_sales 
WHERE sale_time IS NULL

SELECT * FROM retail_sales 
WHERE customer_id IS NULL

SELECT * FROM retail_sales 
WHERE gender IS NULL

SELECT * FROM retail_sales 
WHERE age IS NULL

SELECT * FROM retail_sales 
WHERE category IS NULL

SELECT * FROM retail_sales 
WHERE quantity IS NULL

SELECT * FROM retail_sales 
WHERE price_per_unit IS NULL

SELECT * FROM retail_sales 
WHERE cogs IS NULL

SELECT * FROM retail_sales 
WHERE total_sale IS NULL

SELECT * FROM retail_sales 
WHERE 
     transactions_id IS NULL
	 or
	 sale_date IS NULL
	 or
	  sale_time IS NULL
	 or
	customer_id IS NULL
	 or
	  gender IS NULL
	 or
	  age IS NULL
	 or
	  category IS NULL
	 or
	  quantiy IS NULL
	 or
	  price_per_unit IS NULL
	 or
	  cogs IS NULL
	 or
	  total_sale IS NULL

--DELETING DATA

DELETE FROM retail_sales
WHERE 
     transactions_id IS NULL
	 or
	 sale_date IS NULL
	 or
	  sale_time IS NULL
	 or
	customer_id IS NULL
	 or
	  gender IS NULL
	 or
	  age IS NULL
	 or
	  category IS NULL
	 or
	  quantiy IS NULL
	 or
	  price_per_unit IS NULL
	 or
	  cogs IS NULL
	 or
	  total_sale IS NULL

	  SELECT
	     COUNT(*) 
	  FROM retail_sales

	  -- How Many Sales We Have

 SELECT COUNT (*) total_sale FROM retail_sales

 -- How Many Unique Customer We have

  SELECT 
     COUNT (DISTINCT customer_id) as total_sales 
	 FROM retail_sales

  -- DATA Analytics & Business Problem
  --Q1 Write a SQL Query To retrive all columns for sales made on "2022-11-5"

  SELECT * 
  From retail_sales
  WHERE sale_date = '2022-11-05';

  --Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equals to 4 in the month of Nov-2022:

	  SELECT *
	  from retail_sales
	  Where 
	       category = 'Clothing'
		   And
		   TO_CHAR(sale_date,'YYYY-MM')= '2022-11'
		   And 
		   quantiy >= 4

--Q3-Write a SQL query to calculate the total sales (total_sale) for each category

  SELECT 
  category,
  Sum(total_sale) as net_sale
  FROM retail_sales
  GROUP BY 1

  --Q4-Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

   SELECT 
    Round(AVG(age),2) as avarage_age
   FROM retail_sales
   WHERE category = 'Beauty'

  --Q5-Write a SQL query to find all transactions where the total_sale is greater than 1000

  SELECT *
   FROM retail_sales
   WHERE total_sale >=1001

 --Q6-Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

   SELECT 
   category,
   gender,
   count(transactions_id) as total_transactions
   FROM retail_sales
   GROUP BY 1 , 2
   order by 1 ;

--Q7-Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

Select * from
 (
   SELECT 
    EXTRACT (Month from sale_date) as month,
	Extract (Year From sale_date) as year,
	Round(AVG(total_sale):: numeric,2) as avg_sale,
	RANK() Over(
	         partition by Extract (Year From sale_date) 
	         Order By Round(AVG(total_sale):: numeric,2) desc 
			 ) as rank_sale
    FROM retail_sales 
	GROUP BY 1 , 2) as t1
	where rank_sale = 1

	--order by 2, 3 desc

--Q8 Write a SQL query to find the top 5 customers based on the highest total sales 

  SELECT 
  customer_id,
  sum(total_sale) as total_sale
  from retail_sales
  group by 1
  order by 2 desc
  limit 5;

--Q9 Write a SQL query to find the number of unique customers who purchased items from each category.
	 SELECT 
	   category,
	   count(distinct customer_id) as customer_id
	   from retail_sales
	   group by 1

--Q10 Write a SQL query to create each shift and number of 
--orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17
WITH hourly_sale
as(
   SELECT *,
   case
   When Extract(Hour from sale_time) < 12 Then 'Morning'
   when Extract(Hour from sale_time) Between 12 And 17 then 'Afternoon'
   else 'Evening'
   end as shift  
   from retail_sales
   )
   Select 
   shift,
   count(*) as total_sale
   from hourly_sale
   group by shift
   