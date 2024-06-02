-- select total number of order placed.

SELECT 
    COUNT(order_id) AS total_number_of_orders
FROM
    orders;


-- calculate the total revenue generated from pizza sales

SELECT 
    SUM(od.quantity * p.price) AS revenue
FROM
    orders_details AS od
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id;
    
    
    -- Identify the 3 highest_priced pizza
    
   SELECT 
    pt.name, p.price
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC limit 3;

-- Identyfy most comman pizza siza

SELECT 
    p.size, COUNT(od.order_details_id) AS no_of_orders
FROM
    pizzas AS p
        JOIN
    orders_details AS od ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY no_of_orders DESC;


-- List the top 5 most ordered pizza types along with their quantities

SELECT 
    pt.name, SUM(od.quantity) AS quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    orders_details AS od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY quantity DESC
LIMIT 5;


-- find the total quantity of each pizza category ordered

SELECT 
    pt.category, SUM(od.quantity) AS quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    orders_details AS od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY quantity DESC;

-- Determine the distribution of orders by hour of the day

SELECT 
    HOUR(order_time), COUNT(order_id)
FROM
    orders
GROUP BY HOUR(order_time);


-- find the category-wise distribution of pizzas

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- calculate the average number of pizzas ordered per day
SELECT 
    AVG(quantity) as avg_pizza_order
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS quantity
    FROM
        orders AS o
    JOIN orders_details AS od ON o.order_id = od.order_id
    GROUP BY o.order_date) AS order_q;
    
   -- Determine the top 3 most ordered pizza types based on revenue
  SELECT 
    pt.name, SUM(od.quantity * p.price) AS revenue
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    orders_details AS od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;