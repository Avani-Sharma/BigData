-- create DATABASE
create or replace transient database orders;

-- create schema 
create or replace schema test;

-- create table from sample data
create or replace table test.orders1 as 
select * from snowflake_sample_data.tpch_sf100.orders;

-- fetch data from table
select * from orders1;

-- disable cached result for session
alter session set use_cached_result=false;

-- check session parameter
show parameters like 'use_cached_result';

-- suspend warehouse 
alter warehouse compute_wh suspend;

-- resume warehouse 
alter warehouse compute_wh resume;

-- create materialized view
create or replace materialized view orders_mv as
select year(o_orderdate) as year,
    max(o_comment) as max_comment,
    min(o_comment) as min_comment,
    max(o_clerk) as max_clerk,
    from orders.test.orders1
    group by year(o_orderdate);

-- fetch data from materialized view
select * from orders_mv;

-- show all materialized views
show materialized views;

-- update table data
update test.orders1 
set o_clerk = 'sam'
where year(o_orderdate) = 1993;




-- cluster by example
-- create schema inside database
create or replace schema orders.test;

-- create second table from sample data
create or replace table orders.test.orders2 as
select * from snowflake_sample_data.tpch_sf100.orders;

-- apply clustering key on year extracted from order date
alter table orders.test.orders2 cluster by (year(o_orderdate));

-- query with filter on clustered column
select * from orders.test.orders2
where year(o_orderdate) = 1995;