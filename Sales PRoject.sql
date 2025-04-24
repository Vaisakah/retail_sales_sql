create database sql_project_1;
use sql_project_1;
-- Create table, copy the table names from excel
drop table if exists retail_sales;
create table retail_sales (transactions_id int primary key, 
							sale_date date,	
                            sale_time time,
                            customer_id	int,
                            gender	varchar (15),
                            age	int,
                            category varchar(15),	
                            quantiy	int,
                            price_per_unit	float,
                            cogs	float,
                            total_sale float);
select * from retail_sales 
where transactions_id is null;
select count(*) from retail_sales;

-- delete null values
delete from retail_sales 
where transactions_id is null;
-- Data Exploration
-- How many record of sales
select count(*) as total_sales from retail_sales;
-- How many customers you have
select count(distinct customer_id) as total_customers from retail_sales;
-- how many categories we have
select count(distinct category) as total_category from retail_sales;
-- names of all distinct category
select distinct category as category_names from retail_sales;
-- Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales
where sale_date = '2022-11-05';
-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from retail_sales
where category = 'Clothing' and quantiy >= 4 and sale_date between '2022-11-1' and '2022-11-30';-- there is no to char function here
-- Write a SQL query to calculate the total sales (total_sale) for each category
select category, sum(total_sale), count(*) from retail_sales
group by category; 
-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
select round(avg(age),2) as average_age, category from retail_sales where category = 'beauty';
-- Write a SQL query to find all transactions where the total_sale is greater than 1000
select * from retail_sales
where total_sale >= 1000;
-- *Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender, count(transactions_id) from retail_sales
group by category, gender order by 1;
-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- most important. usage of rank (), over partition by 
select
year (sale_date) as year, month (sale_date) as month, avg(total_sale), 
rank() over(partition by  year(sale_date) order by avg(total_sale) desc) from retail_sales group by 1, 2;-- order by 1, 3;-- we can extract year and month from the date like this
	
-- keep it in a sub query to display the rank with 1 -- simple CTE 

select * from 
(
select
year (sale_date) as year, month (sale_date) as month, avg(total_sale), 
rank() over(partition by  year(sale_date) order by avg(total_sale) desc) as rank_new from retail_sales group by 1, 2
) as t1 where rank_new = 1;
