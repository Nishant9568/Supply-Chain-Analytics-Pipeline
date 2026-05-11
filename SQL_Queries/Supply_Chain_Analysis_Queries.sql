-- ALTER USER postgres WITH PASSWORD '12345';

-- select count(category_name) from  supply_chain_data;
-- select * from  supply_chain_data;


-- ###   Late Delivery Rate by Customer Segment


-- SELECT customer_segment, 
--        COUNT(*) as total_orders,
--        SUM(CASE WHEN delivery_status = 'Late' THEN 1 ELSE 0 END) as late_orders,
--        ROUND(CAST(SUM(CASE WHEN delivery_status = 'Late' THEN 1 ELSE 0 END) AS NUMERIC) / COUNT(*) * 100, 2) as late_rate_percentage
-- FROM supply_chain_data
-- GROUP BY customer_segment
-- ORDER BY late_rate_percentage DESC;

-- ###  Top 5 Products most prone to Delays

-- select category_name,
-- 	   count(*) as Total_orders,
-- 	   avg(delay_in_days) as avg_Delay_Days
-- from supply_chain_data
-- where delivery_status = 'Late'
-- group by category_name
-- order by avg_delay_days desc
-- limit 5

-- ###Inventory & Category Performance (The "Money" Insight)

-- select category_name,
-- 	Round(sum(order_item_total) :: Numeric, 2) as Total_Revenue,
-- 	Round(avg(order_item_total) :: Numeric, 2) as Avg_order_values,
-- 	Round(Avg(delay_in_days), 2) as Avg_delay
-- from supply_chain_data
-- group by category_name
-- order by Total_Revenue desc
-- limit 10

-- ### Temporal Analysis (The "Seasonality" Insight)

-- select extract(month from order_date_dateorders) as Order_month,
-- 	   count(*) as Total_orders,
-- 	   round(avg(delay_in_days), 2) as Avg_delay
-- from supply_chain_data
-- group by Order_month
-- order by order_month

-- ###  Customer Loyalty & Risk Analysis

-- select customer_segment,
-- 	   shipping_mode,
-- 	   count(*) as total_orders,
-- 	   round(avg(delay_in_days), 2) as avg_delay
-- from supply_chain_data
-- group by customer_segment, shipping_mode
-- order by customer_segment, avg_delay desc


-- ###  Market Efficiency (The "Global Supply Chain" Insight)

select order_country,
	   avg(days_for_shipment_scheduled) as Schduled,
	   avg(days_for_shipping_real) as real_time,
	   avg(days_for_shipping_real - days_for_shipment_scheduled) as efficiency_gap
from supply_chain_data
group by order_country
having count(*) > 100
order by efficiency_gap desc
limit 10