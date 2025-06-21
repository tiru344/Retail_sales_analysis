Select * from retail_sales 
where transaction_id is NULL 
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null;

select * from retail_sales where transaction_id = 679;

select count(*) as total_sales from retail_sales;
##2. How many unique customer 
select distinct category  from retail_sales;

## Q3 Write a SQL query to calculate total sales in each category
select  category,sum(total_sale) from retail_sales
group by 1; 

## 4. Write the average age of customer who puchase items form the category beauty
select round(avg(age),2) as avg_age from retail_sales 
where category = 'Beauty';


# 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
Select transaction_id from retail_sales 
where total_sale > 1000;

# 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
Select gender,count(transaction_id),category from retail_sales 
group by gender,category 
order by 1;

# 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
select year(sale_date) as year  ,monthname(sale_date) as month ,round(avg(total_sale),2) as avg_sale  from retail_sales 
group by year,month
order by avg_sale desc
limit 2;

# OR

## 8. Write a SQL query to find the top 5 customers based on the highest total sales.
select customer_id,sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc;

## 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
select count(distinct customer_id),category from retail_sales
group by category;

## 10 .Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_cte
as
(select *, 
case
when (hour(sale_time)<12) then "Morning"
when (hour(sale_time) between 12 and 17) then "Afternoon"
else "Evening"
end AS shift
from retail_sales)
select shift,count(*) from hourly_cte
group by shift;

 