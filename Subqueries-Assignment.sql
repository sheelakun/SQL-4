-- 1. display all customer details who have made more than 5 payments.
-- 2. Find the names of actors who have acted in more than 10 films.
-- 3. Find the names of customers who never made a payment.
-- 4. List all films whose rental rate is higher than the average rental rate of all films.
-- 5. List the titles of films that were never rented.
-- 6. Display the customers who rented films in the same month as customer with ID 5.
-- 7. Find all staff members who handled a payment greater than the average payment amount.
-- 8. Show the title and rental duration of films whose rental duration is greater than the average.
-- 9. Find all customers who have the same address as customer with ID 1.
-- 10. List all payments that are greater than the average of all payments.

-- 1. display all customer details who have made more than 5 payments.
use sakila;

select * from customer
where customer_id IN (
select customer_id
from payment
group by customer_id
having COUNT(*) > 5
);

-- 2. Find the names of actors who have acted in more than 10 films.
select first_name, last_name
from actor
where actor_id in (
select actor_id 
from film_actor
group by actor_id
HAVING COUNT(film_id) > 10);


-- -- 3. Find the names of customers who never made a payment.

select first_name , last_name 
from customer
where customer_id not in (
select customer_id 
from payment);

-- 4. List all films whose rental rate is higher than the average rental rate of all films.
select film_id, title
from film
where rental_rate > (
select avg(rental_rate)
from film);


-- 5. List the titles of films that were never rented.
SELECT title
FROM film
WHERE film_id NOT IN (
SELECT i.film_id
FROM inventory i
JOIN rental r ON i.inventory_id = r.inventory_id
);


-- 6 Display the customers who rented films in the same month as customer with ID 5. _________CTE_______________________

WITH rental_dates AS (
SELECT MONTH(rental_date) AS rent_month,
YEAR(rental_date) AS rent_year
FROM rental
WHERE customer_id = 5
)
SELECT DISTINCT r.customer_id
FROM rental r
JOIN rental_dates rd
ON MONTH(r.rental_date) = rd.rent_month
AND YEAR(r.rental_date) = rd.rent_year;

-- 7. Find all staff members who handled a payment greater than the average payment amount.__________________CTE_______________

WITH avg_payment AS (
SELECT AVG(amount) AS avg_amt
FROM payment
)
SELECT DISTINCT s.staff_id, s.first_name, s.last_name, p.amount
FROM payment p
JOIN avg_payment a ON p.amount > a.avg_amt
JOIN staff s ON p.staff_id = s.staff_id;


-- 8. Show the title and rental duration of films whose rental duration is greater than the average._________CTE___________
-- CTE to calculate average rental duration
WITH avg_duration AS (
SELECT AVG(rental_duration) AS avg_due
FROM film
)
SELECT title, rental_duration
FROM film
WHERE rental_duration > (
SELECT avg_due FROM avg_duration
);

-- 9. Find all customers who have the same address as customer with ID 1.
drop table cust_totals;
CREATE TEMPORARY TABLE cust_totals AS
SELECT customer_id, first_name, last_name, address_id
from customer 
where customer_id =1;

SELECT * FROM customer
WHERE address_id = (
SELECT address_id FROM cust_totals
);

-- 10. List all payments that are greater than the average of all payments._________________VIEW__________________

CREATE VIEW total_payments AS
SELECT AVG(amount) AS avg_amt
FROM payment;

SELECT * FROM payment
WHERE amount > (
SELECT avg_amt FROM total_payments
);












