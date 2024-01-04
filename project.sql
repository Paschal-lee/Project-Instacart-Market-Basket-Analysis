-- TASK 1
-- choosing database
use project;

-- viewing and describing all tables
DESCRIBE project.aisles;
SELECT * FROM project.aisles;
DESCRIBE project.departments;
SELECT * FROM project.departments;
DESCRIBE project.order_products__prior;
SELECT * FROM project.order_products__prior;
DESCRIBE project.order_products__train;
SELECT * FROM project.order_products__train;
DESCRIBE project.orders;
SELECT* FROM project.orders;
DESCRIBE project.products;
SELECT * FROM project.products;

-- Performing data cleaning and transformation
-- checking for empty dataset 
SELECT * FROM project.aisles WHERE aisle_id = ('');
SELECT * FROM project.aisles WHERE aisle = ('');
SELECT * FROM project.departments WHERE department_id = ('');
SELECT * FROM project.departments WHERE departments = ('');
SELECT * FROM project.order_products__prior WHERE order_id =  ('');
SELECT * FROM project.order_products__prior WHERE product_id = ('');
SELECT * FROM project.order_products__prior WHERE add_to_cart_order = ('');
SELECT * FROM project.order_products__prior WHERE reordered = ('');

SELECT * FROM project.order_products__train WHERE order_id =  ('');
SELECT * FROM project.order_products__train WHERE product_id = ('');
SELECT * FROM project.order_products__train WHERE add_to_cart_order = ('');
SELECT * FROM project.order_products__train WHERE reordered = ('');

SELECT * FROM project.orders WHERE order_id =  ('');
SELECT * FROM project.orders WHERE user_id = ('');
SELECT * FROM project.orders WHERE eval_set = ('');
SELECT * FROM project.orders WHERE order_number = ('');
SELECT * FROM project.orders WHERE order_hour_of_day = ('');
SELECT * FROM project.orders WHERE order_dow = ('');
SELECT * FROM project.orders WHERE days_since_prior_order = ('');

SELECT * FROM project.products WHERE product_id = ('');
SELECT * FROM project.products WHERE product_name = ('');
SELECT * FROM project.products WHERE aisle_id = ('');
SELECT * FROM project.products WHERE department_id = ('');

-- From the above results,project.orders column days_since_prior_order has empty datasets
-- Updating empty datasets tto null

UPDATE project.orders
SET days_since_prior_order = 'null'
WHERE days_since_prior_order = ('');
SELECT * FROM project.orders;

-- Renaming table project.orders column order_dow to order_day
ALTER TABLE project.orders 
CHANGE order_dow order_day VARCHAR(255);

ALTER TABLE project.orders
RENAME COLUMN order_dow TO order_day;

-- updating to table project.orders: converting column order_day to days of the week

UPDATE project.orders 
SET order_day = CASE
WHEN order_day = 0 THEN 'Sunday'
WHEN order_day = 1 THEN 'Monday'
WHEN order_day = 2 THEN 'Tuesday'
WHEN order_day = 3 THEN 'Wednesday'
WHEN order_day = 4 THEN 'Thursday'
WHEN order_day = 5 THEN 'Friday'
WHEN order_day = 6 THEN 'Saturday'
ELSE 'invalid day'
END;

-- updating to table project.orders: converting column order_hour_of_day to time format

UPDATE project.orders 
SET order_hour_of_day = CASE
WHEN order_hour_of_day = 00 THEN '12am'
WHEN order_hour_of_day = 01 THEN '1am'
WHEN order_hour_of_day = 02 THEN '2am'
WHEN order_hour_of_day = 03 THEN '3am'
WHEN order_hour_of_day = 04 THEN '4am'
WHEN order_hour_of_day = 05 THEN '5am'
WHEN order_hour_of_day = 06 THEN '6am'
WHEN order_hour_of_day = 07 THEN '7am'
WHEN order_hour_of_day = 08 THEN '8am'
WHEN order_hour_of_day = 09 THEN '9am'
WHEN order_hour_of_day = 10 THEN '10am'
WHEN order_hour_of_day = 11 THEN '11am'
WHEN order_hour_of_day = 12 THEN '12pm'
WHEN order_hour_of_day = 13 THEN '1pm'
WHEN order_hour_of_day = 14 THEN '2pm'
WHEN order_hour_of_day = 15 THEN '3pm'
WHEN order_hour_of_day = 16 THEN '4pm'
WHEN order_hour_of_day = 17 THEN '5pm'
WHEN order_hour_of_day = 18 THEN '6pm'
WHEN order_hour_of_day = 19 THEN '7pm'
WHEN order_hour_of_day = 20 THEN '8pm'
WHEN order_hour_of_day = 21 THEN '9pm'
WHEN order_hour_of_day = 22 THEN '10pm'
WHEN order_hour_of_day = 23 THEN '11pm'
ELSE 'Invalid day'
END;

-- updating table project.order_products__prior and resetting the column reordered to when order is 0 to first order and when order is 1 to multiorder

ALTER TABLE project.order_products__prior 
MODIFY COLUMN reordered VARCHAR(255);

UPDATE project.order_products__prior 
SET reordered = CASE 
WHEN reordered = 0 THEN 'First order'
WHEN reordered = 1 THEN 'Multi order'
ELSE 'invalid order'
END;

SELECT * FROM project.order_products__prior;

-- updating table project.order_products__train and resetting the column reordered to when order is 0 to first order and when order is 1 to multiorder 

ALTER TABLE project.order_products__train
MODIFY COLUMN reordered VARCHAR(255);
UPDATE project.order_products__train
SET reordered = CASE
WHEN reordered = 0 THEN 'First order'
WHEN reordered = 1 THEN 'Multi order'
ELSE 'invalid order'
END;

SELECT * FROM project.order_products__train;
UPDATE project.orders SET days_since_prior__order = 'NULL' 
WHERE days_since_prior__order = ('');

/* TASK 3: Data Analysis and Insights
1. Market Basket Analysis:
Analysis: Identify frequently co-occurring products in orders to improve store layout and marketing strategies.
*/

-- What are the top 10 product pairs that are most frequently purchased together?
SELECT a.product_id AS product1,
b.product_id AS product2,
COUNT(*) AS frequency
FROM project.order_products__train a
JOIN project.order_products__train b 
ON a.order_id = b.order_id 
AND a.product_id < b.product_id
GROUP BY product1, product2
ORDER BY frequency DESC
LIMIT 10;

-- What are the top 5 products that are most commonly added to the cart first?
SELECT
a.product_id AS product1,
b.product_id AS product2,
COUNT(*) AS frequency
FROM project.order_products__train a
JOIN project.order_products__train b 
ON a.add_to_cart_order = b.add_to_cart_order
AND a.order_id < b.order_id
GROUP BY a.product_id, b.product_id
ORDER BY frequency DESC
LIMIT 5;

-- How many unique products are typically included in a single order?
SELECT eval_set, count(DISTINCT order_id) AS unique_products
FROM project.orders
GROUP BY eval_set
ORDER BY unique_products;

/*
2. Customer Segmentation:
Analysis: Group customers based on their purchasing behavior for targeted marketing efforts.
*/

-- Can we categorize customers based on the total amount they've spent on orders?
SELECT
a.user_id AS product1,
b.order_id AS product2,
COUNT(*) AS frequency
FROM project.orders a
JOIN project.orders b 
ON a.eval_set = b.eval_set
AND a.user_id = b.order_id
GROUP BY product1,product2
ORDER BY frequency;

-- What are the different customer segments based on purchase frequency?
SELECT 
a.user_id,
COUNT(b.order_id) AS purchase_frequency
FROM project.orders a
JOIN project.orders b
ON a.user_id = b.user_id 
GROUP BY a.user_id
ORDER BY purchase_frequency DESC;

-- How many orders have been placed by each customer?
SELECT a.user_id,
COUNT(b.order_id) AS customer_orders
FROM project.orders a
JOIN project.orders b
ON a.user_id = b.user_id 
GROUP BY a.user_id
ORDER BY customer_orders DESC;

/*
3. Product Association Rules:
Analysis: Identify rules or patterns in customer behavior indicating which products are frequently bought together.
*/ 

-- What are the top 5 product combinations that are most frequently purchased together?
SELECT a.product_id AS product1,
b.product_id AS product2,
COUNT(*) AS frequency
FROM project.order_products__train a
JOIN project.order_products__train b 
ON a.order_id = b.order_id 
AND a.product_id < b.product_id
GROUP BY product1, product2
ORDER BY frequency DESC
LIMIT 5;



















