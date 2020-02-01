USE sakila;
-- First and Last Names of all Actors from Actors Table
SELECT first_name, last_name
FROM actor;
-- First and Last Name of each Actor in single column in Upper Case letters, column name Actor Name
SELECT upper(concat(first_name," " ,last_name)) as "Actor Name"
FROM actor;
-- First name is Joe, find the actor
SELECT actor_id, first_name,last_name
FROM actor
WHERE first_name = "JOE";
-- Actors whose last name contains letters GEN
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';
-- Actors whose last name contains letters LI, order rows by last name, first name
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE '%L%' 
AND last_name LIKE '%I%'
ORDER BY last_name, first_name;
-- Using IN, country ID and columns of Afghanistan, Bangladesh, and China
SELECT country_id, country
FROM country
WHERE country in ("Afghanistan", "Bangladesh","China");
-- Create column in Actor Table named Description and use data type BLOB 
ALTER TABLE actor
ADD Description blob;
SELECT * FROM actor;
-- Delete the Description column
ALTER TABLE actor
DROP column Description;
-- Last name of Actors and Count of how many actors have that Last Name
SELECT last_name, count(last_name)
FROM actor
GROUP BY last_name;
-- Last names with count of 2 or more
SELECT last_name, count(last_name) as count
FROM actor
GROUP BY last_name
HAVING COUNT(last_name)>1;
-- Updating Groucho Williams to correct name, Harpo Williams
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';
-- Making sure name change worked
SELECT *
FROM actor
WHERE first_name = 'HARPO';
-- In single query, change Harpo back to Groucho
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO'AND last_name = 'WILLIAMS';
-- Recreate schema for address table
CREATE table address_2(
address_id int,
address varchar(100),
address2 varchar(100),
district varchar(50),
city_id smallint,
postal_code varchar(10),
phone varchar(20),
location geometry,
last_update timestamp);
SELECT S.first_name, S.last_name, A.address
FROM staff as S left join address as A
ON S.address_id = A.address_id;
SELECT *
FROM address;
-- JOIN total amount of each staff member August 2005
SELECT S.staff_id,sum(P.amount) as Total_Spent
FROM staff as S, payment as P
WHERE S.staff_id = P.staff_id AND payment_date BETWEEN '2005-08-01 00:00:00' AND '2005-08-31 00:00:00'
GROUP BY S.staff_id;
-- Inner Join for each film and number of actors
SELECT F.title, count(A.actor_id)
FROM film AS F INNER JOIN film_actor AS A
ON F.film_id = A.film_id
GROUP BY F.title;
-- Copies of Hunchback Impossible exist in inventory system
SELECT count(*)
FROM film AS F INNER JOIN inventory AS I
ON F.film_id = I.film_id
WHERE F.title = "Hunchback Impossible";
-- Total Paid by each Customer, listed alphabetically by last name
SELECT C.last_name, C.first_name,sum(P.amount) AS Total_Paid
FROM payment AS P INNER JOIN customer AS C
ON P.customer_id = C.customer_id
GROUP BY P.customer_id
ORDER BY C.last_name;
 -- Titles of English language movies that begin with K and Q
SELECT title
FROM film AS F INNER JOIN language AS L







