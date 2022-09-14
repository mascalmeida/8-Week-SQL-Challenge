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
INNER JOIN menu ON sales.product_id=menu.product_id
GROUP BY customer_id
ORDER BY total_amount DESC;
