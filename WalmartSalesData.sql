-- --------------------------------------------------------------------
-- --------Feature Engineering-----------------------------------------

-- time_of_day
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		ELSE "Evening"
	END
	) AS time_of_day
FROM salesDataWalmart.sales;

ALTER TABLE salesDataWalmart.sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE salesDataWalmart.sales 
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		ELSE "Evening"
	END
);

-- day_of_week 
SELECT
	date,
    DAYNAME(date)
FROM salesDataWalmart.sales;

ALTER TABLE salesDataWalmart.sales ADD COLUMN day_of_week VARCHAR(15);

UPDATE salesDataWalmart.sales 
SET day_of_week = DAYNAME(date);

-- month_name

ALTER TABLE salesDataWalmart.sales ADD COLUMN month_name VARCHAR(9);

UPDATE salesDataWalmart.sales
SET month_name = MONTHNAME(date);

-- --------------------------------------------------------------------

-- --------------------------------------------------------------------
-- ------------------------GENERIC QUESTIONS---------------------------

-- How many unique cities in the data?
SELECT
	DISTINCT city
FROM salesDataWalmart.sales;

-- In which city is each branch?
SELECT
	DISTINCT branch
FROM salesDataWalmart.sales;


SELECT
	DISTINCT city,
		branch
FROM salesDataWalmart.sales;  
      
-- --------------------------------------------------------------------

-- --------------------------------------------------------------------
-- ------------------------PRODUCT QUESTIONS---------------------------

-- How many unique product lines does the data have?
SELECT 
	COUNT(DISTINCT product_line)
FROM salesDataWalmart.sales;

-- What is the most common payment method?
SELECT 
	payment,
	COUNT(payment) as cnt
FROM salesDataWalmart.sales
GROUP BY payment
ORDER BY cnt DESC;

-- What is the highest selling product_line?
SELECT 
	product_line,
    COUNT(product_line) as cnt
FROM salesDataWalmart.sales
GROUP BY product_line
ORDER BY cnt DESC;

-- What is the total revenue by month?
SELECT 
	month_name AS month,
    SUM(total) AS total_revenue
FROM salesDataWalmart.sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month had the largest COGS?
SELECT
	month_name AS month,
    SUM(cogs) AS total_cogs
FROM salesDataWalmart.sales
GROUP BY month_name
ORDER BY total_cogs DESC;

-- What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) AS total_revenue
FROM salesDataWalmart.sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
	branch, city,
    SUM(total) AS total_revenue
FROM salesDataWalmart.sales
GROUP BY city, branch
ORDER BY total_revenue DESC;

-- What product line had the largest VAT?
SELECT 
	product_line,
    AVG(tax_pct) AS avg_tax
FROM salesDataWalmart.sales
GROUP BY product_line
ORDER BY avg_tax DESC;


-- Which branch sold more products on average than total average product sold? 
SELECT 
	branch, 
    AVG(quantity) AS avg_quantity
FROM salesDataWalmart.sales
GROUP BY branch
HAVING AVG(quantity) > (SELECT AVG(quantity) FROM salesDataWalmart.sales);

-- What is the most common product line by gender?
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_count
FROM salesDataWalmart.sales
GROUP BY gender, product_line
ORDER BY total_count DESC;

-- What is the average rating of each product line?
SELECT
	ROUND(AVG(rating), 2) AS average_rating,
    product_line
FROM salesDataWalmart.sales
GROUP BY product_line
ORDER BY average_rating DESC;






