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
SELECT F.title
FROM film AS F INNER JOIN language AS L
ON F.language_id = L.language_id
WHERE F.title like "K%" or F.title like "Q%";
-- Display all actors who appear in the film Alone Trip
SELECT a.actor_id, a.first_name, a.last_name 
FROM film_actor as fa
INNER JOIN actor AS a ON a.actor_id = fa.actor_id
INNER JOIN film AS f ON f.film_id =fa.film_id 
WHERE f.title = 'Alone Trip';
-- Names and email addresses of all Canadian customers
SELECT c.customer_id,c.first_name,c.last_name,c.email
-- Identify all movies categorized as family movies
SELECT *
FROM category;
SELECT f.title
FROM film_category as fc
INNER JOIN category as c ON fc.category_id = c.category_id
INNER JOIN film as f ON fc.film_id = f.film_id
WHERE c.category_id = 8;
-- Display the most frequently rented movies in descending order
SELECT f.title, count(f.title) as "Rental Count"
FROM inventory as i
INNER JOIN rental AS r ON r.inventory_id = i.inventory_id
INNER JOIN film as f on f.film_id = i.film_id
GROUP BY f.title
ORDER BY count(f.title) DESC;
-- how much dollars of business did each store bring in
SELECT st.store_id AS "Store ID", sum(p.amount) AS "Total Sales"
FROM staff as s
INNER JOIN payment AS p ON p.staff_id = s.staff_id
INNER JOIN store AS st ON s.store_id = st.store_id
GROUP BY st.store_id;
-- Each store, store ID, city, and country
-- List the top 5 genres in gross revenue in descending order
SELECT*
FROM category as c
inner join (select f.film_id, f.category_id, i.inventory_id, i.store_id
			from film_category as f inner join inventory as i
			on f.film_id = i.film_id) as x
on x.category_id = c.category_id;

  select z.name, sum(y.amount)
from (select r.rental_id, r.inventory_id, p.amount, p.payment_id
          from rental as r inner join payment as p 
          on p.rental_id = r.rental_id) as y
inner join 
        (select c.category_id, c.name, x.film_id, x.inventory_id, x.store_id
        from category as c
        inner join (select f.film_id, f.category_id, i.inventory_id, i.store_id 
                        from film_category as f inner join inventory as i 
                        on f.film_id = i.film_id) as x
    on x.category_id = c.category_id) as z
on y.inventory_id = z.inventory_id
group by z.name
order by sum(y.amount) desc; 









