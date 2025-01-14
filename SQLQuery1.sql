use pizza_sales

-- KPIs

-- 1) Total Revenue

select 
round(sum (price*quantity),2) as Total_Revnue
from order_details as o
join pizzas as p
on p.pizza_id = o.pizza_id

-- 2) Avg order value

select 
round(sum(price*quantity)/count(distinct(order_id)),2) as Avg_Order_Value
from order_details as p
join pizzas as o
on o.pizza_id = p.pizza_id

-- 3) Total pizza solds

select 
sum(quantity) as [Total pizza solds]
from order_details

-- 4) Total Orders

select
count (order_id) as [Total Orders] 
from orders

-- 5) Avg Pizzas Per Order

select 
sum(quantity)/count(distinct(order_id)) as [Avg Pizzas Per Order]
from order_details

select 
 sum(quantity)
from order_details as o
join pizzas as p
on p.pizza_id = o.pizza_id
join pizza_types as P_T
on P_T.pizza_type_id=p.pizza_type_id
group by name


-- Question to answer ??

-- 1) Daily Trends For Total Orders

select 
format (date,'dddd') as [DayOfWeek] , count(distinct order_id) as Total_Orders
from orders
group by format (date,'dddd')   
order by Total_Orders desc

-- 2) Hourly Trends For Total Orders

select 
FORMAT (time,'hh') as [Hour] , count(distinct order_id) as Total_Orders
from orders
group by FORMAT (time,'hh')
order by [Hour] 

-- 3) Percentage of sales by pizza category

select 
category 
, sum(quantity*price) as Total_Revenue
,round (sum(quantity*price)*100/ (
select sum(quantity*price) 
from pizzas as p
join order_details as o
on p.pizza_id = o.pizza_id ), 2 ) as [%_of_sale] 
from order_details as o
join pizzas as p
on p.pizza_id = o.pizza_id
join pizza_types as pt
on pt.pizza_type_id=p.pizza_type_id
group by category
order by [%_of_sale] desc

-- 4) Percentage of sales by pizza size

select 
size 
, sum(quantity*price) as Total_Revenue
,round (sum(quantity*price)*100/ (
select sum(quantity*price) 
from pizzas as p
join order_details as o
on p.pizza_id = o.pizza_id ), 2 ) as [%_of_sale] 
from order_details as o
join pizzas as p
on p.pizza_id = o.pizza_id
group by size
order by [%_of_sale] desc

-- 5) Total Pizzas Sold by Pizza Category

select
category
, sum (quantity) as Total_pizzas_sold
from order_details as o
join pizzas as p
on p.pizza_id=o.pizza_id
join pizza_types as pt
on pt.pizza_type_id=p.pizza_type_id
group by category 
order by sum(quantity) desc

-- 6) Top 5 Best Sellers by Total Pizzas Sold

select top 5
name
, sum (quantity) as Total_pizzas_sold
from order_details as o
join pizzas as p
on p.pizza_id=o.pizza_id
join pizza_types as pt
on pt.pizza_type_id=p.pizza_type_id
group by name 
order by sum(quantity) desc

-- 7) Top 5 worst Sellers by Total Pizzas Sold

select top 5
name
, sum (quantity) as Total_pizzas_sold
from order_details as o
join pizzas as p
on p.pizza_id=o.pizza_id
join pizza_types as pt
on pt.pizza_type_id=p.pizza_type_id
group by name 
order by sum(quantity) asc 