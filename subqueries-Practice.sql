Use sakila;
-- SUBQUERIES----------------------------------------------------

-- Get all customers who have made payments
Select first_name, last_name
from customer 
where customer_id in (select customer_id
from payment);

-- Get title, rental_rate of films whose rental_rate is greater than average rental_rate
SELECT title, rental_rate
FROM film
WHERE rental_rate > (
  SELECT AVG(rental_rate)
  FROM film
);

-- Find customers whose rental count is more than 30
select customer_id, total_rental                -- using having doesn't need subqueries .
FROM (SELECT customer_id, COUNT(*) AS total_rental
      FROM rental
      GROUP BY customer_id) AS rental_summary
WHERE total_rental > 30;


-- List all customers who have made at least one rental.
select customer_id,first_name , last_name
from customer
where customer_id in ( select customer_id
from rental );


-- List all films that appear in the inventory.
select title , film_id 
from film
where film_id in (
select film_id
from inventory);


-- List all customers who have rented more than 5 films.
select customer_id , first_name , last_name
from customer 
where customer_id in (
select customer_id
from rental
group by customer_id
having count(rental_id) > 5);

-- CTE PRACTICE ---------------------------------------------------------------------------

-- Find films with rental rate higher than average

-- Find average rental rate

SELECT AVG(rental_rate)
FROM film;

-- Use subquery

SELECT title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate) 
    FROM film
);

-- to create the ctes for average , 
WITH avg_rate AS (
    SELECT AVG(rental_rate) AS avg_value
    FROM film
)
SELECT title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT avg_value FROM avg_rate
);

-- Find films whose rental_rate is higher than average
WITH avge_rent as (select AVG(rental_rate) as avg_rental
from film)

select title, rental_rate
from film
where rental_rate > (select avg_rental from  avge_rent);

-- Find customers who spent more than 200.
WITH total_amt AS (
    SELECT customer_id, SUM(amount) AS spent_amt
    FROM payment
    GROUP BY customer_id
)
SELECT customer_id
FROM total_amt
WHERE spent_amt > 200;


-- Find customers who rented more than 5 times.
with total_rentals as ( select customer_id , COUNT(rental_id) AS rented_count
from rental
group by customer_id)

select customer_id ,rented_count
from total_rentals 
where rented_count > 5;

-- Top 5 customers by spending

WITH spent_amt as (select customer_id, SUM(amount)as spending_amt
from payment
group by customer_id)

select customer_id ,spending_amt
from spent_amt
order by spending_amt desc
limit 5;


-- Find films that have more than 3 copies in inventory

WITH film_num AS (
SELECT f.film_id, f.title, COUNT(i.inventory_id) AS film_count
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
)
SELECT film_id, title,film_count
FROM film_num
WHERE film_count > 3;

-- Find customers whose total spending is above average spending

WITH customer_total AS (
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
),
avg_spending AS (
SELECT AVG(total_spent) AS avg_amt
FROM customer_total
)
SELECT customer_id, total_spent
FROM customer_total
WHERE total_spent > (
SELECT avg_amt FROM avg_spending
);










 























































