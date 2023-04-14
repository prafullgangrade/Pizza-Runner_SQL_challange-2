-- 1. How many pizzas were ordered?
SELECT COUNT(pizza_id) AS pizza_count
FROM customer_orders;
-- 2. How many unique customer orders were made?
SELECT COUNT(distinct order_id) AS unique_pizza_count
FROM customer_orders;
-- 3. How many successful orders were delivered by each runner?
SELECT 
    runner_id, 
    COUNT(order_id) AS order_count
FROM runner_orders_post
WHERE duration_mins IS NOT NULL
GROUP BY runner_id;
-- 4. How many of each type of pizza was delivered?
WITH pizza_counter AS (  
SELECT
    c.order_id,
    COUNT(c.pizza_id) AS pizza_count 
FROM cust_orders c
LEFT JOIN runner_orders_post r 
    ON c.order_id = r.order_id
WHERE duration_mins IS NOT NULL
GROUP BY c.order_id
)  
SELECT 
    SUM(pizza_count) AS total_pizza_count
FROM pizza_counter;
-- 5.How many Vegetarian and Meatlovers were ordered by each customer?
WITH pizza_counter_1 AS (
SELECT 
    customer_id,
    COUNT(pizza_id) AS pizza_count
FROM customer_orders
WHERE pizza_id = 1
GROUP BY customer_id
),

pizza_counter_2 AS (
SELECT
    customer_id,
    COUNT(pizza_id) AS pizza_count
FROM customer_orders
WHERE pizza_id = 2
GROUP BY customer_id
)

SELECT DISTINCT 
    pc1.customer_id,
    pc1.pizza_count AS total_meatlovers,
    pc2.pizza_count AS total_vegetarian
FROM pizza_counter_1 pc1, pizza_counter_2 pc2
ORDER BY 1;
-- 6. What was the maximum number of pizzas delivered in a single order? 
SELECT
    order_id,
    COUNT(pizza_id) AS total_pizzas
FROM customer_orders
GROUP BY order_id
ORDER BY total_pizzas DESC;
-- 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
WITH pizza_changes_counter AS (
SELECT 
    co.customer_id,
    CASE 
        WHEN co.exclusions_cleaned LIKE '%' OR co.extras_cleaned LIKE '%' THEN 1
        ELSE 0
    END AS pizza_change_count,
    CASE
        WHEN co.exclusions_cleaned IS NULL AND co.extras_cleaned IS NULL THEN 1
        WHEN co.exclusions_cleaned IS NULL AND co.extras_cleaned = 'NaN' THEN 1
        ELSE 0
    END AS pizza_no_change_count
FROM cust_orders co
LEFT JOIN runner_orders_post ro 
    ON co.order_id = ro.order_id
WHERE ro.duration_mins IS NOT NULL
)
  
SELECT
    customer_id,
    SUM(pizza_change_count) AS total_pizzas_with_changes,
    SUM(pizza_no_change_count) AS total_pizzas_without_changes
FROM pizza_changes_counter
GROUP BY customer_id;
-- 9. What was the total volume of pizzas ordered for each hour of the day?
SELECT
	COUNT(order_id) AS order_count,
	HOUR(order_time) AS hour
FROM cust_orders
GROUP BY hour;
-- 10. What was the volume of orders for each day of the week?
WITH orders_by_day AS (
SELECT
	COUNT(order_id) AS order_count,
	WEEKDAY(order_time) AS day
FROM cust_orders
GROUP BY day
ORDER BY day
)

SELECT	
	order_count,
    CASE 
	WHEN day = 0 THEN 'Monday'
		WHEN day = 1 THEN 'Tuesday'
	WHEN day = 2 THEN 'Wednesday'
	WHEN day = 3 THEN 'Thursday'
	WHEN day = 4 THEN 'Friday'
	WHEN day = 5 THEN 'Saturday'
	WHEN day = 6 THEN 'Sunday'
   END AS day
FROM orders_by_day;

-- Runner and Customer Experience
-- 1. How many runner signed up for each 1 week period? (ie.week starts 2021-01-01)
SELECT
	COUNT(runner_id) AS runner_count,
    WEEK(registration_date) AS week
FROM runners
GROUP BY week;
-- What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
SELECT
    r.runner_id,
    AVG(MINUTE(TIMEDIFF(r.pick_up_time, c.order_time))) AS time_mins
FROM cust_orders c
LEFT JOIN runner_orders_post r
	ON c.order_id = r.order_id
GROUP BY r.runner_id;
-- 4. What was the average distance travelled for each customer?
SELECT
	c.customer_id,
    AVG(r.distance_km) AS avg_dist_km
FROM cust_orders c 
LEFT JOIN runner_orders_post r
	ON c.order_id = r.order_id
GROUP BY c.customer_id;
-- 5. What was the difference between the longest and shortest delivery times for all orders?
SELECT
    MAX(duration_mins) - MIN(duration_mins) AS delivery_time_diff
FROM runner_orders_post;
-- 6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT 
	runner_id,
    AVG(distance_km),
    AVG(duration_mins)
FROM runner_orders_post
GROUP BY runner_id;
-- 7. What is the successful delivery percentage for each runner?
WITH cancellation_counter AS (
SELECT
	runner_id,
    CASE
    	WHEN cancellation IS NULL OR cancellation = 'NaN' THEN 1
	ELSE 0
    END AS no_cancellation_count,
    CASE
    	WHEN cancellation IS NOT NULL OR cancellation != 'NaN' THEN 1
	ELSE 0
    END AS cancellation_count
FROM runner_orders_post
)
    
SELECT 
	runner_id,
    SUM(no_cancellation_count) / (SUM(no_cancellation_count) + SUM(cancellation_count))*100 AS delivery_success_percentage
FROM cancellation_counter
GROUP BY runner_id;




