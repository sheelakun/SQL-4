use sakila;
-- Get first_name, last_name, and email of customers with their store_id
select first_name, last_name,email, store_id
from customer;

-- Get film title and its language name
select f.title , l.name as language
from film f
join language l
on f.language_id =l.language_id;

-- -- Get customer first_name, last_name and payment amount
select c.first_name, c.last_name , p.amount as payment_amt
from customer c
join payment p
on c.customer_id = p.customer_id;

-- Get rental_id, rental_date and customer first_name, last_name
select r.rental_id, r.rental_date, c.first_name, c.last_name 
from rental r
join customer c
ON r.customer_id = c.customer_id;

-- Get customer first_name, last_name and film titles they rented

SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id;

-- List all customers and their rentals. Include customers who never rented anything.

select c.customer_id, c.first_name, c.last_name, r.rental_id
from customer c
left  join rental r
on c.customer_id= r.customer_id;

-- List all films and the inventory IDs they have.

select f.title, i.inventory_id
from film f
join inventory i
on f.film_id= i.film_id;

-- List all actors and the films they acted in.
select a.actor_id, a.first_name,a.last_name,f.title
from actor a
left join film_actor fa
ON a.actor_id=fa.actor_id
left join film f
On fa.film_id=f.film_id;

-- List all customers and the titles of films they rented.

select c.customer_id, c.first_name , c.last_name, f.title
from customer c
left join rental r
On c.customer_id= r.customer_id
left join inventory i
on r.inventory_id = i.inventory_id
left join film f
on i.film_id=f.film_id;

-- List all films and how many times each film was rented.
select f.title, count(r.rental_id) as rented_film_count
from film f
Left join inventory i
on f.film_id = i.film_id
left join rental r
on i.inventory_id=r.inventory_id
GROUP BY f.film_id, f.title;

-- List all customers who have never rented any film.
select c.customer_id, c.first_name , c.last_name , r.rental_id
from customer c
left join rental r
ON c.customer_id= r.customer_id
where r.rental_id is null ;


-- List the top 5 customers who rented the most films.

select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as rental_count
from customer c
join rental r
on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by rental_count desc
limit 5;

