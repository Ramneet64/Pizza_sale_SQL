/* Basic:
 1. Retrieve the total number of orders placed.
 
 select count(order_id) as total_orders from orders;
 */
 
 /* 2. Calculate the total revenue generated from pizza sales. 
 
 SELECT 
    SUM(order_details.quantity * pizzas.price) AS Revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id */
    
/* 3. Identify the highest-priced pizza. 

SELECT 
    pizzas.price, pizza_types.name
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;  */



/* 4. Identify the most common pizza size ordered. 

SELECT 
    pizzas.size AS Size, COUNT(order_details_id) AS Total_Order
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY Total_order DESC; */



/* 5. List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS Total_Order
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Total_Order DESC
LIMIT 5;  */



/*Intermediate:
   6. Join the necessary tables to find the total quantity of each pizza category ordered.
  
  SELECT 
    pizza_types.category as Category, sum(order_details.quantity) AS Total_Order
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY Category
ORDER BY Total_Order desc;   */
   
   
/* 7. Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS Hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time)
 */

/* 8. Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category
 */ 
 
/* 9. Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity), 0) AS Average
FROM
    (SELECT 
        orders.order_date, COUNT(order_details.quantity) AS quantity
    FROM
        order_details
    JOIN orders ON order_details.order_id = orders.order_id
    GROUP BY orders.order_date) AS order_quantity; */


/* 10. Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Revenue DESC
LIMIT 3; */




/* Advanced:
   11. Calculate the percentage contribution of each pizza type to total revenue.
   
   SELECT 
    pizza_types.category,
   round (SUM(order_details.quantity * pizzas.price) / (SELECT 
            ROUND(SUM(order_details.quantity * pizzas.price),
                        2) AS total_sales
        FROM
            order_details
                JOIN
            pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100 ,2 ) AS Revenue
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Revenue; */
   
   
/* 12. Analyze the cumulative revenue generated over time.

select order_date,
sum(revenue) over(order by order_date) as cum_revenue from
(select orders.order_date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.order_date) as sales;

*/



/* 13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.


select name, revenue from
(select category, name, revenue, 
rank() over(partition by category order by revenue desc) as rn 
from

(SELECT 
    pizza_types.category,
    pizza_types.name,
    SUM((order_details.quantity) * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category , pizza_types.name) as a) as b
where rn <= 3;
*/


