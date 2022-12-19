CREATE DATABASE ASSIGNMENT;
----------------------------------------------------------------------------------------------------------------------------
//1. Load the given dataset into snowflake with a primary key to Order Date column.
CREATE TABLE sales_data(
order_id VARCHAR(50),
order_date	DATE PRIMARY KEY,
ship_date	DATE ,
ship_mode	VARCHAR(50),
Customer_name VARCHAR(100),	
segment	VARCHAR(15),
state    VARCHAR(100),
country  VARCHAR(100),
market  VARCHAR(10),	
region   VARCHAR(20),
product_id	VARCHAR(20),
category	VARCHAR(20),
sub_category VARCHAR(20),
product_name  TEXT,	
sales	STRING,
quantity STRING,
discount STRING,
profit	STRING,
shipping_cost STRING,
order_priority	VARCHAR(10),
year STRING

);

DROP TABLE sales_data;
DESCRIBE TABLE sales_data;
SELECT * FROM sales_data;

--COPY TABLE TO ANOTHER TABLE
CREATE OR REPLACE TABLE sales_data_copy AS 
SELECT * FROM sales_data;

SELECT * FROM sales_data_copy;
--------------------------------------------------------------------------------------
//2.Change the Primary key to Order Id Column.
ALTER TABLE sales_data
DROP PRIMARY KEY;

ALTER TABLE sales_data ADD PRIMARY KEY (ORDER_ID);
-------------------------------------------------------------------------------------------------------------
//3. Check the data type for Order date and Ship date and mention in what data type it should be?

DESCRIBE TABLE sales_data;

--Order date and Ship date is in date format that is : 'YYYY-MM-DD'

-----------------------------------------------------------------------------------------------------------
//4. Create a new column called order_extract and extract the number after the last ‘–‘from Order ID column.

SELECT * ,SUBSTRING(ORDER_ID,9) AS ORDER_EXTRACT FROM sales_data;

----------------------------------------------------------------------------------------------------------------
//5. Create a new column called Discount Flag and categorize it based on discount. Use ‘Yes’ if the discount is greater than zero else ‘No’.

SELECT DISCOUNT,
CASE 
WHEN (DISCOUNT> 0) THEN 'YES'
ELSE 'NO'
END AS DISCOUNT_FLAG
FROM sales_data;

------------------------------------------------------------------------------------------------------------------------------------
//6. Create a new column called process days and calculate how many days it takes for each order id to process from the order to its shipment.

SELECT *, DATEDIFF('DAY',ORDER_DATE,SHIP_DATE) AS PROCESS_DAY FROM sales_data;

----------------------------------------------------------------------------------------------------------------------------------------
/*7. Create a new column called Rating and then based on the Process dates give
rating like given below.
a. If process days less than or equal to 3days then rating should be 5
b. If process days are greater than 3 and less than or equal to 6 then rating
should be 4
c. If process days are greater than 6 and less than or equal to 10 then rating
should be 3
d. If process days are greater than 10 then the rating should be 2.
*/

CREATE OR REPLACE VIEW RATING_VIEW AS 
SELECT ORDER_ID,ORDER_DATE,SHIP_DATE,DATEDIFF('DAY',ORDER_DATE,SHIP_DATE) AS PROCESS_DAY FROM sales_data;

select * from RATING_VIEW;

SELECT ORDER_ID,ORDER_DATE,SHIP_DATE, PROCESS_DAY,
CASE 
WHEN (PROCESS_DAY <= 3) THEN '5'
WHEN (PROCESS_DAY > 3 AND PROCESS_DAY <= 6) THEN '4'
WHEN (PROCESS_DAY > 6 AND PROCESS_DAY <= 10) THEN '3'
WHEN (PROCESS_DAY > 10) THEN '2'
ELSE 'NA'
END AS RATINGS
FROM RATING_VIEW;






