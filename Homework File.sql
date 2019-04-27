use sakila;

# 1a
select first_name, last_name from actor;

# 1b
SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name' FROM actor;

# 2a
select actor_id, first_name, last_name from actor
where first_name = 'Joe';

# 2b
select * from actor
where last_name like '%gen%';

# 2c
select * from actor
where last_name like '%li%'
ORDER BY last_name ASC, first_name ASC;

# 2d
select country_id, country from country
where country IN ('Afghanistan', 'Bangladesh', 'China');

# 3a
alter table actor
add column description blob;
select * from actor;

# 3b
alter table actor
drop column description;
select * from actor;

# 4a
select count(*), last_name from actor
where last_name = last_name GROUP BY last_name;

# 4b
select count(*), last_name from actor
where last_name = last_name GROUP BY last_name having count(*) >1;

# 4c
select * from actor where first_name = 'Groucho';
update actor set first_name = 'Harpo' where actor_id = 172;
select * from actor where first_name = 'Harpo';

# 4d
update actor set first_name = 'GROUCHO' where first_name = 'Harpo';

# 5a
show create table address;

# 6a
select staff.first_name, staff.last_name, address.address
from staff
inner join address on
staff.address_id=address.address_id;

# 6b
select staff.first_name, staff.last_name, sum(payment.amount) as total_paid
from staff
inner join payment on
staff.staff_id=payment.staff_id
group by staff.staff_id;

# 6c
select film.title, count(film_actor.actor_id) as number_of_actors
from film
inner join film_actor on
film.film_id=film_actor.film_id
group by film.title;

# 6d
select film.title, count(inventory.film_id) as inventory_count
from film
inner join inventory on
film.film_id=inventory.film_id
where film.title = 'Hunchback Impossible'
group by film.title; #This line is returning the same result with or without the group by

# 6e
select customer.first_name, customer.last_name, sum(payment.amount) as amount_paid
from customer
inner join payment on
customer.customer_id=payment.customer_id
group by customer.customer_id
order by last_name ASC;

# 7a 
select title
from film
where title like 'K%' or title like 'Q%' 
and language_id IN
(select language_id
 from language
 where name = 'English');
 
# 7b
select first_name, last_name
from actor
where actor_id in 
(
 select actor_id
 from film_actor
 where film_id in
 (
  select film_id
  from film
  where title = 'Alone Trip'
  )
);

# 7c
select country.country, customer.first_name, customer.last_name, customer.email
from country
inner join city on
country.country_id=city.country_id
inner join address on
city.city_id=address.city_id
inner join customer on
address.address_id=customer.address_id
where country.country = 'Canada';

# 7d
select film.title, category.name
from film
inner join film_category on
film.film_id=film_category.film_id
inner join category on
film_category.category_id=category.category_id
where category.name = "Family";

# 7e
select film.title, count(rental.rental_id) as Total_Rentals
from film
inner join inventory on 
film.film_id=inventory.film_id
inner join rental on
inventory.inventory_id=rental.inventory_id
GROUP BY film.title
ORDER BY Total_Rentals DESC;

# 7f
select store.store_id, sum(payment.amount) as revenue
from store
inner join staff on 
store.store_id=staff.store_id
inner join payment on
staff.staff_id=payment.staff_id
group by store.store_id
ORDER BY revenue desc;

# 7g
select store.store_id, city.city, country.country
from store
inner join address on 
store.address_id=address.address_id
inner join city on
address.city_id=city.city_id
inner join country on 
city.country_id=country.country_id;

# 7h
select category.name, sum(payment.amount) as revenue
from category
inner join film_category on 
category.category_id=film_category.category_id
inner join film on
film_category.film_id=film.film_id
inner join inventory on
film.film_id=inventory.film_id
inner join rental on
inventory.inventory_id=rental.inventory_id
inner join payment on
rental.rental_id=payment.rental_id
group by category.name
ORDER BY revenue desc;

# 8a 
create view top5_film_genres as 
select category.name, sum(payment.amount) as revenue
from category
inner join film_category on 
category.category_id=film_category.category_id
inner join film on
film_category.film_id=film.film_id
inner join inventory on
film.film_id=inventory.film_id
inner join rental on
inventory.inventory_id=rental.inventory_id
inner join payment on
rental.rental_id=payment.rental_id
group by category.name
ORDER BY revenue desc
limit 5;

# 8b
select * from top5_film_genres;

# 8c
drop view top5_film_genres;


