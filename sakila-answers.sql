-- SAKILA SQL PRACTICE-1

-- Q1 Display all tables available in the database “sakila”-- 
select * from actor;
select * from address;
select * from category;
select * from city;
select * from country;
select * from customer;
select * from film;
select * from film_actor;
select * from film_category;
select * from film_text;
select * from inventory;
select * from language;
select * from payment;
select * from rental;
select * from staff;
select * from store;

-- Q2 Display structure of table “actor”. (4 row)--
desc actor; 

-- Q3 Display the schema which was used to create table “actor” and view the complete schema using the viewer. (1 row)
show create table actor;

-- Q4 Display the first and last names of all actors from the table actor. (200 rows)
select first_name,last_name from actor;

-- Q5 Which actors have the last name ‘Johansson’. (3 rows)
select * from actor where last_name='Johansson';

-- Q6 Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name. (200 rows)
select upper((concat(first_name,' ', last_name))) as actorName from actor;

-- Q7 You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information? (1 row) 
select actor_id,first_name,last_name from actor where first_name = 'Joe';

-- Q8 Which last names are not repeated? (66 rows)
select last_name from actor where last_name not in (
select last_name from actor group by last_name having count(last_name) > 1);

-- Q9 List the last names of actors, as well as how many actors have that last name
select last_name, count(last_name) as lastNameCount from actor group by last_name order by lastNameCount desc;

-- Q10 Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables “staff” and “address”. (2 rows)
select staff.first_name,staff.last_name,address.address from staff join address on staff.address_id = address.address_id;

-- SAKILA SQL PRACTICE-2

-- Q1 Which actor has appeared in the most films? (‘107', 'GINA', 'DEGENERES', '42')
select actor.actor_id,actor.first_name,actor.last_name,count(film_actor.film_id) from actor
join film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id,actor.first_name,actor.last_name order by count(film_actor.film_id) desc limit 1;


-- Q2 What is the average length of films by category? (16 rows)
select c.name,avg(length(f.title)) as avgLength from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
group by c.name order by avgLength desc;

-- Q3 Which film categories are long? (5 rows)
select * from category order by length(name) desc limit 5; 

-- Q4 How many copies of the film “Hunchback Impossible” exist in the inventory system? (6) 
select film.title,count(inventory.inventory_id)	from film 
join inventory on film.film_id = inventory.film_id
where film.title = 'Hunchback Impossible' group by film.film_id;


-- Q5 Using the tables “payment” and “customer” and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name (599 rows)
select customer.customer_id,customer.last_name,customer.first_name,sum(payment.amount) as totalPaid from customer
join payment on customer.customer_id = payment.customer_id 
group by customer.customer_id, customer.last_name, customer.first_name
order by customer.last_name, customer.first_name;


