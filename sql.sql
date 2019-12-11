-- (northwind database)
-- On which day of the month are the most *orders* being placed (use only the 2 most recent years of data)?
-- which day has the lowest number of orders? Are you suprised? Why would this day have the least?

WITH last_date AS(
    SELECT 
        MAX(order_date) AS last_date
    FROM orders
), two_recent_years AS(
    SELECT
        order_id,
        order_date
    FROM orders 
    WHERE EXTRACT(YEAR FROM order_date)
        >= EXTRACT(YEAR FROM (SELECT * FROM last_date))-1
)
SELECT 
    EXTRACT(DAY FROM order_date) AS day_of_month,
    COUNT(order_id) AS tot_orders
FROM two_recent_years
GROUP BY day_of_month
ORDER BY tot_orders DESC;

-- day 6 has high number of orders
-- day 31 has the lowest number of orders...indeed only 7 months have 31 days


-- On which day of the WEEK are the most *orders* being placed (use only the most recent year of data)?
-- What can you say about any trends in orders being placed? 

WITH last_date AS(
    SELECT 
        MAX(order_date) AS last_date
    FROM orders
), two_recent_years AS(
    SELECT
        order_id,
        order_date
    FROM orders 
    WHERE EXTRACT(YEAR FROM order_date)
        = EXTRACT(YEAR FROM (SELECT * FROM last_date))
)
SELECT 
    to_char(order_date, 'Day') AS day_of_week,
    COUNT(order_id) AS tot_orders
FROM two_recent_years
GROUP BY day_of_week;

-- No orders placed during the weekend


--How out of date is this database (ie the last order compared to today's date)

SELECT
    CURRENT_DATE - MAX(order_date) AS days_from_last_order
FROM orders;
