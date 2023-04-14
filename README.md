# Pizza-Runner_SQL_challange-2
Hi , This is second SQL project which i have developed to solve SQL use case given by Danny's following His 8 week SQL challenge series.

----------------------------------------------------------------------------------------------------------------------------------------

**Links** 

here is the link of SQL challange Case Study #2 - Pizza Runner https://8weeksqlchallenge.com/case-study-2/

## Table Of Contents
  - [Introduction](#introduction)
  - [Dataset](#dataset)
  - [Entity Relationship Diagram](#entity-relationship-diagram)
  - [Data Clean](#data-clean)
  - [Case Study Solutions](#case-study-solutions)

**Introduction**

Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”

Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.

## Dataset
Key datasets for this case study
- **runners** : The table shows the registration_date for each new runner
- **customer_orders** : Customer pizza orders are captured in the customer_orders table with 1 row for each individual pizza that is part of the order. The pizza_id relates to the type of pizza which was ordered whilst the exclusions are the ingredient_id values which should be removed from the pizza and the extras are the ingredient_id values which need to be added to the pizza.
- **runner_orders** : After each orders are received through the system - they are assigned to a runner - however not all orders are fully completed and can be cancelled by the restaurant or the customer. The pickup_time is the timestamp at which the runner arrives at the Pizza Runner headquarters to pick up the freshly cooked pizzas. The distance and duration fields are related to how far and long the runner had to travel to deliver the order to the respective customer.
- **pizza_names** : Pizza Runner only has 2 pizzas available the Meat Lovers or Vegetarian!
- **pizza_recipes** : Each pizza_id has a standard set of toppings which are used as part of the pizza recipe.
- **pizza_toppings** : The table contains all of the topping_name values with their corresponding topping_id value

## Entity Relationship Diagram
![alt text](https://github.com/manaswikamila05/8-Week-SQL-Challenge/blob/main/Case%20Study%20%23%202%20-%20Pizza%20Runner/ERD.jpg)

## Data Clean
There are some known data issues with few tables. Data cleaning was performed and saved in temporary tables before attempting the case study.

**customer_orders table**
- The exclusions and extras columns in customer_orders table will need to be cleaned up before using them in the queries
- In the exclusions and extras columns, there are blank spaces and null values.

**runner_orders table**
- The pickup_time, distance, duration and cancellation columns in runner_orders table will need to be cleaned up before using them in the queries
- In the pickup_time column, there are null values.
- In the distance column, there are null values. It contains unit - km. The 'km' must also be stripped
- In the duration column, there are null values. The 'minutes', 'mins' 'minute' must be stripped
- In the cancellation column, there are blank spaces and null values.


In this Task I try to solve and answer all query related to this task and find insights from data for answer a few simple questions about 
The challenges in this case study include:

What are the busiest days of the week and the busiest times of the day?

What is the average delivery time?

What are the most popular pizza toppings?

What is the average order value?

How many pizzas are delivered by each delivery driver?

What is the average customer rating?

Which delivery driver has the best average rating?

Which delivery driver has the most deliveries?

**Description**

![image](https://user-images.githubusercontent.com/56063563/232028715-5b6d67e0-87c6-4dc1-8382-2b2f02a8d91c.png)

**Steps followed**

**Summarry**

**Attachments**
