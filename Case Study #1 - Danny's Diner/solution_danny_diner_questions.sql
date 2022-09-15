/* 
Case Study #1 - Danny's Diner
Tool: MySQL
Case Study Answers
Author: @mascalmeida
*/

USE dannys_diner;

-- 1. What is the total amount each customer spent at the restaurant?
SELECT sales.customer_id, SUM(menu.price) as total_amount
FROM sales
INNER JOIN menu ON sales.product_id = menu.product_id
GROUP BY customer_id
ORDER BY total_amount DESC;

-- 2. How many days has each customer visited the restaurant??
SELECT sales.customer_id , COUNT(DISTINCT(sales.order_date)) as n_days
FROM sales
GROUP BY customer_id 
ORDER BY n_days DESC;

-- 3. What was the first item from the menu purchased by each customer?
SELECT sales.customer_id, MIN(sales.order_date) AS first_purchased, menu.product_name 
FROM sales
INNER JOIN menu ON sales.product_id = menu.product_id 
GROUP BY customer_id;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT MAX(n_purchased) AS max_n_purchased, results.product_name
FROM (
	SELECT COUNT(sales.product_id) AS n_purchased, menu.product_name
	FROM sales
	INNER JOIN menu ON sales.product_id = menu.product_id 
	GROUP BY menu.product_name
	ORDER BY n_purchased DESC
	) AS results;

-- 5. Which item was the most popular for each customer?
-- Maybe create a new colum with the rank of each customer
SELECT results.customer_id, MAX(n_purchased) AS max_n_purchased, results.product_name
FROM (
	SELECT sales.customer_id, COUNT(sales.product_id) AS n_purchased, menu.product_name
	FROM sales
	INNER JOIN menu ON sales.product_id = menu.product_id 
	GROUP BY sales.customer_id, menu.product_name
	ORDER BY n_purchased DESC
	) AS results
GROUP BY customer_id;







