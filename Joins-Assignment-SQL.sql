-- SQL JOIN QUESTIONS .

USE sakila;
select c.customer_id, c.first_name, c.last_name , r.rental_id, f.title  -- "customer->rental->inventory->film"
from customer c
join rental r
ON c.customer_id= r.customer_id
join inventory i
ON i.inventory_id= r.inventory_id
join film f
ON f.film_id = i.film_id;

-- 2. List all customers and show their rental count, including those who haven't rented any films.

select c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) as total_rentals
from customer c
LEFT JOIN  rental r
ON C.customer_id=r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 3. Show all films along with their category. Include films that don't have a category assigned.
select f.title, c.name as category_name        -- film-> film_category-> category
from film f
LEFT JOIN film_category fc
on f.film_id=fc.film_id
left join category c
ON c.category_id = fc.category_id;

-- 4. Show all customers and staff emails from both customer and 
-- staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).

select c.first_name , c.last_name, c.email, s.first_name , s.last_name, s.email
from customer c
left join staff s
on c.store_id = s.store_id

UNION

select c.first_name , c.last_name, c.email, s.first_name , s.last_name, s.email
from customer c
right join staff s
on c.store_id = s.store_id;

-- 5. Find all actors who acted in the film "ACADEMY DINOSAUR". "actor-film_actor-film
select a.first_name,a.last_name ,f.title                          -- not left join.
from actor a
join film_actor fa
on a.actor_id=fa.actor_id
join film f
on f.film_id =fa.film_id
where f.title = "ACADEMY DINOSAUR";


-- 6. List all stores and the total number of staff members working in each store, even if a store has no staff.
select s.store_id, count(st.staff_id) as total_staff 
from store s
left join staff st
on s.store_id= st.store_id
group by s.store_id;


-- 7. List the customers who have rented films more than 5 times. Include their name and total rental count.

SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_rentalcount
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.rental_id) > 5;






