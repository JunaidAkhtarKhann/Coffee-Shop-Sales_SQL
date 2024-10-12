create database Coffee_shop_Sales
use Coffee_shop_Sales

select * from Coffee_Sales

-------------------------------------------------------------------------------------------------------------------
--                                    Checking/Summarising the DATA TYPES
-------------------------------------------------------------------------------------------------------------------
select * from Coffee_Sales
sp_help 'Coffee_Sales'

select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= 'Coffee_Sales'


-------------------------------------------------------------------------------------------------------------------
--                                    ALTERING the DATA TYPES
-------------------------------------------------------------------------------------------------------------------
select * from Coffee_Sales

ALTER TABLE Coffee_Sales
ALTER COLUMN transaction_date DATE

ALTER TABLE Coffee_Sales
ALTER COLUMN transaction_time TIME

-------------------------------------------------------------------------------------------------------------------
-- Calculate the Total Sales for each respective Months
-------------------------------------------------------------------------------------------------------------------
select * from Coffee_Sales


select SUM(transaction_qty * unit_price) as JANUARY_SALES from Coffee_Sales
where MONTH(transaction_date) = 1 -- JANUARY

Select SUM(transaction_qty * unit_price) as FEBRUARY_SALE from Coffee_Sales
where MONTH(transaction_date) = 2 --FEBRUARY

Select SUM(transaction_qty * unit_price) as MARCH_SALE from Coffee_Sales
where MONTH(transaction_date) = 3 -- MARCH

Select SUM(transaction_qty * unit_price) as APRIL_SALE from Coffee_Sales
where MONTH(transaction_date) = 4 --APRIL

Select SUM(transaction_qty * unit_price) as MAY_SALE from Coffee_Sales
where MONTH(transaction_date) = 5 -- MAY

Select SUM(transaction_qty * unit_price) as JUNE_SALE from Coffee_Sales
where MONTH(transaction_date) = 6 -- JUNE

Select SUM(transaction_qty * unit_price) as JULY_SALE from Coffee_Sales
where MONTH(transaction_date) = 7 -- JULY

Select SUM(transaction_qty * unit_price) as AUGUST_SALE from Coffee_Sales
where MONTH(transaction_date) = 8 -- AUGUST

Select SUM(transaction_qty * unit_price) as SEPTEMBER_SALE from Coffee_Sales
where MONTH(transaction_date) = 9 --SEPTEMBER

Select SUM(transaction_qty * unit_price) as OCTOBER_SALE from Coffee_Sales
where MONTH(transaction_date) = 10 --OCTOBER

Select SUM(transaction_qty * unit_price) as NOVEMBER_SALE from Coffee_Sales
where MONTH(transaction_date) = 11 --NOVEMBER

Select SUM(transaction_qty * unit_price) as DECEMBER_SALE from Coffee_Sales
where MONTH(transaction_date) = 12 --DECEMBER


-------------------------------------------------------------------------------------------------------------------
-- Determine Month-on-Month increase or decrease in Total Sales
-------------------------------------------------------------------------------------------------------------------

select * from Coffee_Sales

select 
	MONTH(transaction_date) as Months,
	ROUND(SUM(transaction_qty * unit_price),1) as total_Sale, 
	LAG(SUM(transaction_qty * unit_price),1)
	over (order by MONTH(transaction_date)) as Prev_month,
	LAG(SUM(transaction_qty*unit_price),1) over (order by MONTH(transaction_date)) - 
	SUM(transaction_qty*unit_price) as DIFFERENCE
from Coffee_Sales
Group by MONTH(transaction_date)

-------------------------------------------------------------------------------------------------------------------
-- Calculate the Percentage Change in sales by previous month sale (Monthly Sales trend)
-------------------------------------------------------------------------------------------------------------------

select 
	MONTH(transaction_date) as MONTH_NUM,
	ROUND(SUM(transaction_qty * unit_price),1) as total_sales,
	(SUM(transaction_qty * unit_price)-LAG(SUM(transaction_qty * unit_price),1)
	over (order by MONTH(transaction_date))) / LAG(SUM(transaction_qty * unit_price),1)
	over (order by MONTH(transaction_date)) * 100 mom_increase_percent
from coffee_Sales
	group by MONTH(transaction_date)


-------------------------------------------------------------------------------------------------------------------
-- Calculate the Total Number of Irders for each respective months
-------------------------------------------------------------------------------------------------------------------
Select * from Coffee_Sales

Select COUNT(c.transaction_id) as January_Transaction from Coffee_Sales c
Where MONTH(c.transaction_date) = 1 -- JAN

Select COUNT(c.transaction_id) as FEB_COUNT from Coffee_Sales c
Where MONTH(c.transaction_date) = 2 -- FEB

-------------------------------------------------------------------------------------------------------------------
-- Calculate the Month-on-Month increase or decrease in the sales & number of orders.
-------------------------------------------------------------------------------------------------------------------
Select * from Coffee_Sales

-- MOM_SALES

Select MONTH(c.transaction_date) as MONTHS,
	ROUND(SUM(c.transaction_qty*c.unit_price),1) as Total_Sales, 
	LAG(SUM(c.transaction_qty*c.unit_price),1)
	over (order by MONTH(c.transaction_date)) as Previous_Sales,
	(SUM(c.transaction_qty*c.unit_price)- LAG(SUM(c.transaction_qty*c.unit_price),1) 
	over (order by MONTH(c.transaction_date)))/
	LAG(SUM(c.transaction_qty*c.unit_price),1)
	over (order by MONTH(c.transaction_date))* 100  Percen_Change
from Coffee_Sales c
	Group by MONTH(c.transaction_date)



--MOM_COUNTS_OF_TRANSACTIONS


select 
	MONTH(c.transaction_date) as MONTH_NUMBER,
	COUNT(c.transaction_id) as TOTAL_COUNT,
	(COUNT(c.transaction_id) - LAG(COUNT(c.transaction_id),1) over (order by MONTH(c.transaction_date)))
	/ LAG(COUNT(c.transaction_id),1) 
	over (order by MONTH(c.transaction_date))* 100 as percentc
from Coffee_Sales c
GROUP BY MONTH(c.transaction_date)


-------------------------------------------------------------------------------------------------------------------
-- Calculate the total Quantity sold in each month.
-------------------------------------------------------------------------------------------------------------------
select * from Coffee_Sales


select 
	MONTH(c.transaction_date) as Month, 
	COUNT(c.transaction_qty) as total_quantity_sold from Coffee_Sales c
	Group by MONTH(c.transaction_date) order by MONTH(c.transaction_date)


--MOM increase and decrease in QTY


select 
	MONTH(c.transaction_date) as Month, 
	COUNT(c.transaction_qty) as total_quantity_sold,
	COUNT(c.transaction_qty) - LAG(COUNT(c.transaction_qty),1) over (order by MONTH(c.transaction_date)) as Differences
	from Coffee_Sales c
	Group by MONTH(c.transaction_date) order by MONTH(c.transaction_date)


-------------------------------------------------------------------------------------------------------------------
-- Calculate the total Sales amount, total orders & total Quantity sold in each month.
-------------------------------------------------------------------------------------------------------------------
select * from Coffee_Sales

select 
	MONTH(c.transaction_date) as Month,
	CONCAT(ROUND(SUM(c.transaction_qty)/1000,2),'k') as Total_Quantity,
	CONCAT(ROUND(COUNT(c.transaction_id)/1000,2),'k') as Total_transactions,
	CONCAT(ROUND(SUM(c.transaction_qty*c.unit_price)/1000,2),'k') as Total_sale
from Coffee_Sales c
Group by MONTH(c.transaction_date)
order by MONTH(c.transaction_date)


select
	--MONTH(c.transaction_date) as Month,
	CONCAT(ROUND(Count(c.transaction_id)/1000,1), 'k') as Total_Orders,
	CONCAT(ROUND(SUM(c.transaction_qty)/1000,1),'K') as Total_Quantity,
	CONCAT(ROUND(SUM(c.transaction_qty*c.unit_price)/1000,1),'K') as Sales_Amount
	from Coffee_Sales c
	where c.transaction_date= '2023-05-18'
	Group by MONTH(c.transaction_date)

Alter table Coffee_Sales
alter Column transaction_qty int


-------------------------------------------------------------------------------------------------------------------
-- Calculate the Sales analysis by WEEKDAYS & WEEKEND.
-------------------------------------------------------------------------------------------------------------------
select * from Coffee_Sales

select * from Coffee_Sales where DATEPART(WEEKDAY,transaction_date) = 1 --SUNDAY

Select * from Coffee_Sales where DATEPART(WEEKDAY,transaction_date) = 2 --MONDAY

Select * from Coffee_Sales where DATEPART(WEEKDAY,transaction_date) = 3 --TUESDAY

Select * from Coffee_Sales where DATEPART(WEEKDAY,transaction_date) = 4 --WEDNESDAY

Select * from Coffee_Sales where DATEPART(WEEKDAY,transaction_date) = 5 --THURSDAY

Select * from Coffee_Sales where DATEPART(WEEKDAY,transaction_date) = 6 --FRIDAY

Select * from Coffee_Sales where DATEPART(WEEKDAY,transaction_date) = 7 --SATURDAY

Select
	SUM(c.transaction_qty*c.unit_price) as TOTAL_WEEKEND_SALES
	from Coffee_Sales c
	WHERE DATEPART(WEEKDAY,transaction_date) in (1,7) -- WEEKENDS

Select
	SUM(c.transaction_qty*c.unit_price) as Total_WEEKDAY_Sales
	from Coffee_Sales c
	WHERE DATEPART(WEEKDAY,transaction_date) not in (1,7) --WEESKDAY

select SUM(c.unit_price*c.transaction_qty) as TOTAL_SALES from Coffee_Sales c -- CHECKING THE TOTAL SALES


Select 
	CASE WHEN DATEPART(WEEKDAY,transaction_date) in (1,7) THEN 'WEEKEND' 
	ELSE 'WEEKDAY'
	END as DAY_WEEK,
	ROUND(SUM(c.transaction_qty*c.unit_price),2) as TOTAL_SALES
	from Coffee_Sales c
	GROUP BY CASE WHEN DATEPART(WEEKDAY,transaction_date) in (1,7) THEN 'WEEKEND'
	ELSE 'WEEKDAY'
	END


-------------------------------------------------------------------------------------------------------------------
-- Calculate the Sales analysis by Store Locations for each Month.
-------------------------------------------------------------------------------------------------------------------
Select * from Coffee_Sales

Select
	c.store_location,
	CONCAT(ROUND(SUM(c.transaction_qty*c.unit_price)/1000,2),'k') as TOTAL_SALES
	from Coffee_Sales c
	WHERE MONTH(c.transaction_date) = 1 -- JANUARY
	GROUP BY c.store_location
	ORDER BY TOTAL_SALES DESC

-------------------------------------------------------------------------------------------------------------------
-- Calculate the Total Sales for each day of EVERY Month.
-------------------------------------------------------------------------------------------------------------------
Select * from Coffee_Sales

select 
	DAY(c.transaction_date) as Dates,
	SUM(c.transaction_qty*c.unit_price) as Total_Sales
from Coffee_Sales c
Where MONTH(c.transaction_date) = 1 -- JANUARY
GROUP BY DAY(c.transaction_date)
ORDER BY DAY(c.transaction_date)

-------------------------------------------------------------------------------------------------------------------
-- Calculate the Average Sales of EVERY Month.
-------------------------------------------------------------------------------------------------------------------
Select * from Coffee_Sales

Select
	ROUND(AVG(TOTAL_SALES),2) as JAN_AVG_SALES From 
(Select 
	ROUND(SUM(c.transaction_qty*c.unit_price),2) as TOTAL_SALES -- To get accurate average we first calculate the total sales for January 
from 	                                                        -- then pull the avg from total sales 
	Coffee_Sales c
Where
	MONTH(c.transaction_date) = 1 -- JANUARY
GROUP BY
	c.transaction_date) as inner_Query


-------------------------------------------------------------------------------------------------------------------
-- Calculate the total sales by Product_Category for EVERY Month.
-------------------------------------------------------------------------------------------------------------------
select * from Coffee_Sales

Select 
	c.product_category,
	SUM(c.transaction_qty*c.unit_price) as JAN_Total_Sales
from Coffee_Sales c
Where MONTH(c.transaction_date) = 1 -- JANUARY
Group by c.product_category

-------------------------------------------------------------------------------------------------------------------
-- Calculate the Total Sales by Product_type of EVERY Month.
-------------------------------------------------------------------------------------------------------------------
select * from Coffee_Sales

select 
	c.product_type,
	SUM(c.transaction_qty*c.unit_price) as JAN_Total_sales
from Coffee_Sales c
Where MONTH(c.transaction_date) = 1 -- JANUARY
Group by c.product_type

-------------------------------------------------------------------------------------------------------------------
-- Calculate the Total Sales by HOUR & DAY.
-------------------------------------------------------------------------------------------------------------------
Select * from Coffee_Sales

Select 
	DATEPART(HOUR,c.transaction_time) as hour,
	SUM(c.transaction_qty*c.unit_price) as Total_Sales
from Coffee_Sales c
Group by DATEPART(HOUR,c.transaction_time)
Order by DATEPART(HOUR,c.transaction_time)





Select 
CASE
	WHEN DATEPART(WEEKDAY,c.transaction_date) =2 THEN 'MONDAY'
	WHEN DATEPART(WEEKDAY,c.transaction_date) =3 THEN 'TUESDAY'
	WHEN DATEPART(WEEKDAY,c.transaction_date) =4 THEN 'WEDNESDAY'
	WHEN DATEPART(WEEKDAY,c.transaction_date) =5 THEN 'THURSDAY'
	WHEN DATEPART(WEEKDAY,c.transaction_date) =6 THEN 'FRIDAY'
	WHEN DATEPART(WEEKDAY,c.transaction_date) =7 THEN 'SATURDAY'
	ELSE 'SUNDAY'
END AS WEEKS,
	ROUND(SUM(c.transaction_qty*c.unit_price),1) as Total_Sales
from Coffee_Sales c
WHERE MONTH(c.transaction_date) = 5 -- MAY
Group by CASE
	WHEN DATEPART(WEEKDAY,c.transaction_date) =2 THEN 'MONDAY'
	WHEN DATEPART(WEEKDAY,c.transaction_date) =3 THEN 'TUESDAY'
	WHEN DATEPART(WEEKDAY,c.transaction_date) =4 THEN 'WEDNESDAY'
	WHEN DATEPART(WEEKDAY,c.transaction_date) =5 THEN 'THURSDAY'
	WHEN DATEPART(WEEKDAY,c.transaction_date) =6 THEN 'FRIDAY'
	WHEN DATEPART(WEEKDAY,c.transaction_date) =7 THEN 'SATURDAY'
	ELSE 'SUNDAY'
END

