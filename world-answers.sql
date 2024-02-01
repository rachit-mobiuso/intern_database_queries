-- SAKILA SQL PRACTICE-1

-- Q1 Display all columns and 10 rows from table “city”.(10 rows) 
select * from city limit 10;

-- Q2 Modify the above query to display from row # 16 to 20 with all columns. (5 rows) 
select * from city where id between 16 and 20;

-- Q3 How many rows are available in the table city. (1 row)-4079. 
select count(*) from city;

-- Q4 Using city table find out which is the most populated city.
select name,population from city order by population desc limit 1;

-- Q5 Using city table find out the least populated city. 
select name,population from city order by population asc limit 1;

-- Q6 Display name of all cities where population is between 670000 to 700000. (13 rows)
select name from city where population between 670000 and 700000;

-- Q7 Find out 10 most populated cities and display them in a decreasing order i.e. most populated city to appear first.
select * from city order by population desc limit 10;

-- Q8 Order the data by city name and get first 10 cities from city table.
select * from city order by name asc limit 10;

-- Q9 Display all the districts of USA where population is greater than 3000000, from city table. (6 rows) 
select district from city where countrycode='USA' and population > 3000000;

-- Q10 What is the value of name and population in the rows with ID =5, 23, 432 and 2021. Pl. write a single query to display the same. (4 rows).
select name,population from city where id = 5 or id = 23 or id = 432 or id = 2021;

-- SAKILA SQL PRACTICE-2

-- Q1 Write a query in SQL to display the code, name, continent and GNP for all the countries whose country name last second word is 'd’, using “country” table. (22 rows)
select code,name,continent,GNP from country where name like '%d_';
 
 -- Q2 Write a query in SQL to display the code, name, continent and GNP of the 2nd and 3rd highest GNP from “country” table. (Japan & Germany) 
select code, name, continent, gnp from country order by gnp desc limit 2 offset 1;
