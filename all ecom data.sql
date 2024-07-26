create table ecom_data(
	order_line int,
	order_id varchar,
	order_date date,
	ship_date date,
	ship_mode varchar,
	customer_id	varchar,
	product_id varchar,
	sales double precision,
	quantity double precision,
	discount double precision,
	profit double precision,
	customer_name varchar,
	segment varchar,	
	age int,
	country varchar,
	city varchar,
	state varchar,
	postal_code int,
	region varchar,
	category varchar,
	sub_category varchar,
	product_name varchar

)

copy ecom_data from 'R:/data/ecom all.csv' delimiter ',' csv header

select * from ecom_data

----create table sales t1
select distinct order_line, order_id, order_date, ship_date, ship_mode, customer_id, product_id,sales,quantity, discount, profit from ecom_all

create table sales as 
	
    select distinct order_line, order_id, order_date, ship_date, ship_mode, customer_id,
    product_id,sales,quantity, discount, profit from ecom_data
 select * from sales


------create table customer t2
select distinct customer_id, customer_name,segment,age,country,city,state,postal_code, region from ecom_data

create table customer as
select distinct customer_id, customer_name,segment,age,country,city,state,postal_code, region from ecom_data


select * from customer


-----create table t3

select distinct postal_code, city,state,region, country from customer

create table product as
select distinct product_id,category,sub_category,product_name from ecom_data

select * from product

	
	------create table t4
	
select distinct category,sub_category,product_name from ecom_data
	
create table sub_dim_product_category as
    select distinct category,sub_category from product
    alter table "sub_dim_product_category" add column "category_id" serial primary key;
	
select * from sub_dim_product_category


-----create table t5

create table dim_product as
     select p.product_id,p.product_name,sc.category_id from product as p
     inner join sub_dim_product_category as sc
     on p.sub_category=sc.sub_category
	
select * from dim_product


-----create table t6

	
create table dim_customer_region as 
select distinct postal_code, city, state, region from customer

select*from dim_customer_region

------t7


create table dim_customer as
select customer_id, customer_name, age, postal_code from customer

select * from dim_customer
	
----t8
create table sub_dim_customer_age_category as 
  select distinct age,
  case
  when age<= 25 then 'teenage'
  when age<= 50 then 'adult'
  when age<= 60 then 'senior'
  else 'elder'
end as age_category 
from customer;

select * from sub_dim_customer_age_category

