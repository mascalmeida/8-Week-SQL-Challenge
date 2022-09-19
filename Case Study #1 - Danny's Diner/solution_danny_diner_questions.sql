/* 
Case Study #1 - Danny's Diner
Tool: MySQL
Case Study Answers
Author: @mascalmeida
*/

USE dannys_diner;

-- 1. What is the total amount each customer spent at the restaurant?
-- Key learning point: INNER JOIN function & GROUP BY function & SUM aggregation function
SELECT sales.customer_id, SUM(menu.price) AS total_amount
FROM sales
INNER JOIN menu ON sales.product_id = menu.product_id
GROUP BY customer_id
ORDER BY total_amount DESC;

-- 2. How many days has each customer visited the restaurant?
-- Key learning point: Using COUNT aggregation function with DISTINCT
SELECT sales.customer_id , COUNT(DISTINCT(sales.order_date)) AS n_days
FROM sales
GROUP BY customer_id 
ORDER BY n_days DESC;

-- 3. What was the first item from the menu purchased by each customer?
-- Key learning point: Using MIN aggregation function
SELECT sales.customer_id, MIN(sales.order_date) AS first_purchased, menu.product_name 
FROM sales
INNER JOIN menu ON sales.product_id = menu.product_id 
GROUP BY customer_id;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
-- Key learning point: Using multiple SELECT statements
SELECT MAX(n_purchased) AS max_n_purchased, results.product_name
FROM (
	SELECT COUNT(sales.product_id) AS n_purchased, menu.product_name
	FROM sales
	INNER JOIN menu ON sales.product_id = menu.product_id 
	GROUP BY menu.product_name
	ORDER BY n_purchased DESC
	) AS results;

-- 5. Which item was the most popular for each customer?
-- Key learning point: Combine RANK and PARTITION BY functions
WITH purchased_rank AS(
	SELECT 
		results.customer_id, results.n_purchased, results.product_name,
		RANK() OVER (
			PARTITION BY customer_id
	        ORDER BY n_purchased DESC
	    ) n_purchased_rank
	FROM (
		SELECT sales.customer_id, COUNT(sales.product_id) AS n_purchased, menu.product_name
		FROM sales
		INNER JOIN menu ON sales.product_id = menu.product_id 
		GROUP BY sales.customer_id, menu.product_name
		ORDER BY n_purchased DESC
		) AS results
	GROUP BY customer_id, product_name
)
SELECT customer_id, product_name, n_purchased FROM purchased_rank
WHERE n_purchased_rank <= 1;

-- 6. Which item was purchased first by the customer after they became a member?
-- Key learning point:





