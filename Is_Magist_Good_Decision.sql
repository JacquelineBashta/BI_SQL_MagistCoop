#############################################  Conclusion  ########################################################
#############################################  Question (A) #######################################################
########### Is Magist a good fit for high-end tech products?
## Answer : NO! 
# Magist has 74 product Categories , only 11 of them are technolgy related 
	# Not enough experience with Electronics and technolgy products
# From these 11 Categories , only 1 Categories has Items of average price Higher than 300
	# Not enough Knowledge regarding handling high end products/ related customers

# out of total Items sold (~ 113K) there were only 202 Items that are of High_Tech Type --> ie 0.23%
	# Market places have no enough demand for High_Tech products
    
# Only 1.78% of the company Revenue are from High_Tech product Items!!
	# Company future startegy/plan might not consider High_Tech product as a priority.

######################################    Question (B)     ########################################################
########## Are orders delivered on time?
## Answer : Not Really!
# 7.8K delayed orders out of 96.5K all delivered orders --> 8.11% 
# from these 7.8K delays, there are :
# 		1.3K (16.5%) of all delayed items are delayed by 1 day  (Acceptable)
# 		3.2K (40.7%) of all delayed items are delayed by 1 Week (Very BAD)!!!!
# 		3K   (38.2%) of all delayed items are delayed by 1 Month (Very BAD)!!!!
# 		0.4K (4.6%)  of all delayed items are delyed by >1 Month (BAD)!!!!
			# These numbers are reflecting un-reliability of Magist Company and surely affect customer satisfaction badly


## Worth to mention:
# The customer review data indicate consistant customer satisfaction with average score of 4.0/5.0 , which is not really 
# consistant with the delivery speed data!
# further more 98.8% of all orders are reviewed!
-- ---------------------------------------------------------------------------------------------------------------------
######################################  Detailed Analysis  #############################################################
-- ---------------------------------------------------------------------------------------------------------------------

-- Explore the Magist tables
use magist;
#################################    Question (A)     ###############################################
-- 1. Percentage of High Tech products : how many from the existing products are High_Tech
-- 			High_Tech product are product with cat " electronic,computers,phones,.." and with avg(price) > 500

-- i. Number of all available category
select count(distinct product_category_name_english) as all_cat
from product_category_name_translation;
	-- **Result**: total of 74 category of products

-- ii. Number of category with High_Tech
select product_category_name_english
	, round(avg(price))
from product_category_name_translation
join products		using (product_category_name)
join order_items	using (product_id)
where ( product_category_name_english like "%phon%" 
        or product_category_name_english like "%computer%" 
		or product_category_name_english like "%tablet%" 
		or product_category_name_english like "%game%" 
        or product_category_name_english like "%audio%"
        or product_category_name_english like "%dvd%"
        or product_category_name_english like "%electronic%")
        -- and (product_length_cm < 25 and product_height_cm < 15 and product_height_cm < 25)
        -- and product_weight_g < 500
group by product_category_name_english
having avg(price) > 300
order by avg(price) desc
;


select product_length_cm,product_height_cm,product_width_cm,product_weight_g/1000,price
from product_category_name_translation
join products		using (product_category_name)
join order_items	using (product_id)
where ( product_category_name_english = "computers")
order by (price) desc
;

select product_length_cm,product_height_cm,product_width_cm,product_weight_g/1000,price
from product_category_name_translation
join products		using (product_category_name)
join order_items	using (product_id)
where ( product_category_name_english = "telephony")
order by (price) desc
;
-- **Result**: out of 74 category of products, there are only 11 category related to electronics,phones..
					-- Reproduce: Exclude having avg(price) > 500
-- **Result**: out of these 11 Category there are only 1 category that have products with averge prices >500
--                    High_Tech are of product_category_name_english = 'computers'

-- check the max/Min prices in computer range
-- ------------------------------------------------------------------------ 
-- 2. Percentage of High Tech products : how much % of total products sold are from High_Tech categories
with tech_items_Sold_q as(
select count(order_item_id) as High_Tech_Items_Sold 
		## TODO : add the order_status condition as != cancelled
		,(select count(order_item_id) from order_items) as All_Items_Sold
from product_category_name_translation
join products 		using (product_category_name)
join order_items 	using (product_id)
where ( product_category_name_english like "%phon%" 
        or product_category_name_english like "%computer%" 
		or product_category_name_english like "%tablet%" 
		or product_category_name_english like "%game%" 
        or product_category_name_english like "%audio%"
        or product_category_name_english like "%dvd%"
        or product_category_name_english like "%electronic%")
	-- and (product_length_cm < 15 and product_height_cm < 15 and product_height_cm < 15)
	-- and product_weight_g < 300
	-- and price > 300

order by price desc
)
select * , ((High_Tech_Items_Sold/All_Items_Sold)*100) as percent_High_Tech_Items_Sold
from tech_items_Sold_q;

-- **Result**: out of around 113k Items sold, only 202 was of High_Tech Items! (0.18%) !!
-- ------------------------------------------------------------------------ 
-- Average price of all sold products
select round(avg(price))
from order_items
where order_item_id is not null; -- 121 

-- ------------------------------------------------------------------------ 

-- 3. Percentage of High Tech products Revenue: how much % of total sold products price are from High_Tech categories
with tech_items_Sold_q as(
select round(sum(price + freight_value)) as High_Tech_Items_Total_price
		, (select round(sum(price + freight_value)) from order_items) as All_Items_Total_price
from product_category_name_translation
join products using (product_category_name)
join order_items using (product_id)
where ( product_category_name_english like "%phon%" 
        or product_category_name_english like "%computer%" 
		or product_category_name_english like "%tablet%" 
		or product_category_name_english like "%game%" 
        or product_category_name_english like "%audio%"
        or product_category_name_english like "%dvd%"
        or product_category_name_english like "%electronic%")
	-- and price > 300
)
select * , round(((High_Tech_Items_Total_price/All_Items_Total_price)*100),2) as percent_High_Tech_Revenue
from tech_items_Sold_q;

-- **Result**: 1.47% of the comapny Revenue are from High_Tech product Items!!

#################################    Question (B)     ###############################################
-- TODO : 1. How fast Magist process is ? (Considering time between purchasing an order until delivering it)



-- 2. Get percentage of delayed delivery vs overall deliveries (Considering estimated delivery date vs actual)
-- i. Total number of delivered items = 96470
select count(*)
from orders 
where order_status = "Delivered" and order_delivered_customer_date is not null;

-- Total number of delayed deliveries = 7826
-- ie. orders.order_delivered_customer_date > orders.order_estimated_delivery_date
with delivery_time_q as
(
select order_status
		,order_delivered_customer_date
        ,order_estimated_delivery_date
		,case
			when order_delivered_customer_date <= order_estimated_delivery_date then "OnTime"
			else "Delayed"
			end as delivered_on_Time
from orders 
where order_status = "Delivered" and order_delivered_customer_date is not null
)
select count(*) as delayed_deliveries
from delivery_time_q
where delivered_on_Time = "Delayed";

-- ** Final result ** : percentage of 7826/96470 *100 = 8.11% of all deliveries are delayed!!!

-- ii. find out how long it is delayed??
with delayed_days_q as
(
select order_status
		,order_delivered_customer_date
        ,order_estimated_delivery_date,
	case
	when order_delivered_customer_date <= order_estimated_delivery_date  -- get exact delay time!
		then round(TIMESTAMPDIFF(Minute,order_delivered_customer_date,
                                       order_estimated_delivery_date)/(60*24),3)
	else 
		round(TIMESTAMPDIFF(Minute,order_delivered_customer_date,
								order_estimated_delivery_date)/(60*24),3)
	end as Est_vs_Act_delivery_days
from orders 
where order_status = "Delivered" and order_delivered_customer_date is not null
order by Est_vs_Act_delivery_days
),
delay_Period_q as
(
select * 
		,case
        	when Est_vs_Act_delivery_days < -30 then  "1+ Months"
            when Est_vs_Act_delivery_days < -7 then  "within a Month"
            when Est_vs_Act_delivery_days < -1 then  "within a Week"
            when Est_vs_Act_delivery_days < 0 then  "within a Day"
	end as Delay_Period
from delayed_days_q
)
select count(*) as order_delayed
from delay_Period_q
-- where Delay_Period = "1+ Months"  -- 360/7826 
-- where Delay_Period = "within a Month"  -- 2988/7826 
where Delay_Period = "within a Week"  -- 3186/7826 
-- where Delay_Period = "within a Day"  -- 1292/7826 
;

-- TODO relation between delay and (product size , also number of items/order)
-- ------------------------------------------------------------------------ 
-- 2. Get percentage of satisfied customer reviews
-- i. Get average score over months/years
 -- Get average score over months/years
select   year(review_creation_date)
		,month(review_creation_date)
        ,avg(review_score)
 FROM magist.order_reviews
 group by year(review_creation_date), month(review_creation_date)
 order by Year(review_creation_date), month(review_creation_date)
 ;
 -- **Result**: Overall average score is 4.0/5.0 --> and its stable -consistance over years and months
 -- Actually reviews indicate "surprsingly" an overall customer satisfaction
 -- TODO : check delays related product with small size + high price??
 
 -- ii. Get the percentage of Review contributers ( number of orders which has reviews / number of overall orders)
 select count(*) as reviewed_orders
 , (select count(*) from orders) as all_orders
 from order_reviews
 -- where review_score is not null
 ; -- 98279/99441 = 98.8% of all orders are reviewed!
 
 select count(distinct order_id) from order_reviews;
 #################################    Extra     ###############################################
select sum(order_item_id)
from order_items
group by order_id
order by 1 desc
;