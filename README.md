# Retail_sales_analysis
**Retail Sales Analysis**

## Project Overview

**Project Title**: Retail Sales Analysis
**Level**: Beginner

This project demonstrates fundamental SQL skills applied to retail data analysis. It covers database setup, data cleaning, exploratory analysis, and answering business-driven questions using SQL. Ideal for beginners, this hands-on project builds a solid foundation for aspiring data analysts.

## Objectives

1. **Database Setup**: Create and populate the retail database.
2. **Data Cleaning**: Identify and handle missing or null values.
3. **Exploratory Data Analysis (EDA)**: Understand trends and anomalies.
4. **Business Insights**: Solve real-world problems with SQL queries.

## Project Structure

### 1. Database Setup

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Insights

1. **Sales on '2022-11-05'**:

```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```

2. **Clothing sales with quantity > 4 in Nov-2022**:

```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;
```

3. **Total Sales per Category**:

```sql
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

4. **Average Age of Beauty Buyers**:

```sql
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

5. **High Value Transactions**:

```sql
SELECT * FROM retail_sales WHERE total_sale > 1000;
```

6. **Transactions by Gender and Category**:

```sql
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

7. **Top Selling Month per Year**:

```sql
SELECT year, month, avg_sale FROM (
  SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
  FROM retail_sales
  GROUP BY year, month
) t
WHERE rank = 1;
```

8. **Top 5 Customers by Sales**:

```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

9. **Unique Customers per Category**:

```sql
SELECT category, COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;
```

10. **Sales by Shift**:

```sql
WITH hourly_sale AS (
  SELECT *,
    CASE
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

## Findings

* **Demographics**: Broad age distribution across genders and categories.
* **Premium Transactions**: Many high-value orders (over 1000 units).
* **Monthly Trends**: Seasonality affects sales.
* **Customer Behavior**: Identified top buyers and category loyalty.

## Reports

* **Sales Summary**
* **Trend Analysis by Month and Shift**
* **Customer Purchase Behavior**

## Conclusion

This project offers a beginner-friendly walkthrough of data analysis using SQL. You’ll gain hands-on experience with data cleaning, aggregations, filtering, and deriving business insights. These skills are fundamental for any data analyst role.

## How to Use

1. **Clone this Project**: Download or clone the GitHub repo.
2. **Database Setup**: Run the `database_setup.sql` script.
3. **Query Execution**: Use `analysis_queries.sql` to analyze data.
4. **Modify and Explore**: Adapt queries for deeper exploration.

## Author - Abhay Shankar

This project is part of my professional portfolio demonstrating SQL and analytical thinking. For collaborations or questions:

* **LinkedIn**: [Connect with me](https://www.linkedin.com/in/abhay-shankar-473349179/)


