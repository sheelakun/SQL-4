-- Day 1 SQL
USE Sakila;
select * from actor;
-- Day 1 SQL
USE Sakila;
select * from actor;
----------------------------------------------------------------------------
-- created seprate database
CREATE DATABASE IF NOT EXISTS sakila_practice;

-- Step 2: copy customer table from sakila to practice 
CREATE TABLE sakila_practice.customer
AS SELECT * FROM sakila.customer;
-- used the new database---------------------------
USE sakila_practice;

SHOW TABLES;
-- CREATED TABLES--------------------------------------
SELECT * FROM customer;
CREATE TABLE Films(
film_id           SMALLINT UNSIGNED,
title             VARCHAR(255),
release_year      YEAR,
rental_rate         DECIMAL(4,2)
);

SHOW TABLES;
-- will add contraints-----------------------------
CREATE TABLE staff_reviews (
  review_id   INT          PRIMARY KEY,
  staff_id    SMALLINT UNSIGNED NOT NULL,
  review_date DATE         NOT NULL,
  notes       TEXT
);
SHOW TABLES;
-- ALTER ----------------------------------
ALTER TABLE customer
ADD COLUMN age TINYINT ;
SELECT * FROM customer;

USE sakila_practice;
DESCRIBE customer;  
USE sakila_practice;
RENAME TABLE films TO films_archive;
SHOW TABLES;


USE sakila_practice;
SELECT DATABASE(); -- must show: sakila_practice

-- copied from sakila
CREATE TABLE IF NOT EXISTS practice_customer
AS SELECT * FROM sakila.customer;

SELECT COUNT(*) FROM practice_customer; 
DESCRIBE practice_customer;

-- new database------------------------------------------------

CREATE DATABASE practice_db;
USE practice_db;
SHOW TABLES;
CREATE TABLE students (
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  age INT,
  email VARCHAR(100)
);
INSERT INTO students (name, age, email)
VALUES ('Sam', 25, 'sam@gmail.com');
select* from students;

INSERT INTO students (name, age, email)
VALUES
('John', 30, 'john@gmail.com'),
('Sara', 22, 'sara@gmail.com'),
('Maya', 27, 'maya@gmail.com');

select* from students;

-- update ----------------------------

UPDATE students
SET age = 26
WHERE student_id = 1;

select* from students;

-- DELETE FROM students
-- WHERE age > 28;

-- DQL ----------------------------------------------------------------------


SELECT first_name, last_name
FROM customer;

SELECT * 
FROM customer
WHERE store_id= 1;

SELECT *
FROM customer
WHERE store_id = 1 AND active = 1;

SELECT *
FROM customer
WHERE first_name LIKE 'A%';

SELECT first_name, last_name
from customer
order by first_name desc;

select country_id, country
from country
limit 5;

SELECT DISTINCT store_id
FROM customer;

SELECT customer_id, COUNT(*) AS rentals
FROM rental
GROUP BY customer_id;

-- string operations -----------------------------------------------------

SELECT UPPER(title) AS upper_title
FROM film;

select lower(first_name) AS lower_name
from customer;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM actor;

SELECT title, LENGTH(title) AS title_length
FROM film;


SELECT title
FROM film
WHERE title LIKE 'A%';

-- Actors ending with "SON"
select first_name
from actor
where first_name like "%son";

SELECT first_name, LEFT(first_name, 3)
FROM actor;


SELECT first_name, RIGHT(first_name, 4) AS name_
FROM actor;

SELECT last_name, SUBSTRING(last_name, 3) AS last_ -- after 2 character
FROM actor;

SELECT title, REPLACE(title, 'A', '-') as newcolumn
FROM film;

SELECT title, REPLACE(title, ' ', '*') as newolumn
FROM film;

SELECT title, LOCATE('A', title) as newc
FROM film;

select title, LOCATE("o", title) as c
from  film;

-- Find actors whose first name length > 5
SELECT first_name, LENGTH(first_name) AS name_length
FROM actor
WHERE LENGTH(first_name) > 5;

SELECT first_name,
       TRIM(first_name) AS cleaned_name
FROM  customer;

-- Numeric Functions ---------------------
SELECT COUNT(*) AS total_payments
FROM payment;

SELECT amount, ROUND(amount, 1)
FROM payment;

SELECT amount,
       CEIL(amount), --  roundup
       FLOOR(amount) -- roundowm
FROM payment;

SELECT customer_id,
       SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id;


SELECT customer_id,
       AVG(amount) AS avg_spent
FROM payment
GROUP BY customer_id;


SELECT customer_id,
       SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
LIMIT 5;

SELECT payment_id,
       amount,
       ABS(amount - 5) AS diff
FROM payment;

SELECT MAX(amount) - MIN(amount) AS difference
FROM payment;

SELECT rental_id,
       MOD(rental_id, 2) AS even_or_odd
FROM rental;

-- Date & Time functions

SELECT NOW();   -- current date & time
SELECT CURDATE();  -- only date

-- 🔹 2. Extract Date Parts (from rental table)

SELECT rental_id,rental_date,
       YEAR(rental_date) AS year,
       MONTH(rental_date) AS month,
       DAY(rental_date) AS day
FROM rental;
-- date difference -----------------
SELECT rental_id,rental_date, return_date,
       DATEDIFF(return_date, rental_date) AS rental_days
FROM rental;

-- add dates
select rental_id, rental_date,
DATE_ADD( rental_date,INTERVAL 7 DAY) AS DUE_DATE
FROM rental;

SELECT rental_id,
       DATE_FORMAT(rental_date, '%Y-%m-%d') AS formatted_date
FROM rental;

select rental_id,
          DATE_Format( rental_date, '%Y-%M-%D') As DATES
          FROM rental;
          
SELECT rental_id,
       EXTRACT(YEAR FROM rental_date) AS year
FROM rental;

SELECT rental_id, -- rental durration with hr
       TIMESTAMPDIFF(hour, rental_date, return_date) AS hour_rented
FROM rental;


