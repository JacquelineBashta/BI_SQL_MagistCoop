-- Explore the Magist tables
use magist;

-- 1. How many orders are there in the dataset?
select count(*) as total_orders
from orders
;

    -- how many order items is these orders??
select count(*) as total_orders_items
from order_items
;



-- 2. Are orders actually delivered?
select order_status, count(*)
from orders
group by order_status;

-- percentage of delivered orders
select (select count(*) from orders) as total_orders
		,count(*) as total_delivered
		,round(count(*) * 100.0/  (select count(*) from orders),2)  as delivered_percent
from orders
where order_status = "delivered"
;




-- 3. Is Magist having user growth?
select YEAR(order_purchase_timestamp) as The_year 
       ,MONTH(order_purchase_timestamp) as The_month
	   ,count(order_id) as order_monthly
from orders
group by the_year,the_month
order by the_year asc, the_month asc
;


-- 4. How many products are there in the products table?

select count(distinct product_id)
from products
;



-- 5. Which are the categories with most products?
select product_category_name
       ,product_category_name_translation.product_category_name_english
       ,count(*)
       ,(select count(*) from products) as Total_count
from products
left join product_category_name_translation
using (product_category_name)
group by product_category_name
-- having count(*) > 1000
order by count(*) Desc
;




-- 6. How many of those products were present in actual transactions?
select count(distinct product_id) as num_sold_product_ids
from order_items
where order_id is not NULL
;
-- Answer: all of them




-- 7. What’s the price for the most expensive and cheapest products?
select Max(price) , Min(price)
from order_items
where order_id is not NULL
;




-- 8. What are the highest and lowest payment values?
select Max(payment_value) , Min(payment_value)
from order_payments
where order_id is not NULL and payment_value !=0 -- vouchers!
;
