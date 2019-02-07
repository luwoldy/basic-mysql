-- 1a
SELECT first_name, last_name from actor;
-- 1b
SELECT concat(first_name, " ",last_name) as Actor_Name FROM actor;
-- 2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = "Joe";
-- 2b
SELECT * FROM actor WHERE last_name LIKE "%GEN%";
-- 2c
SELECT * FROM actor WHERE last_name LIKE "%LI%" ORDER BY last_name ASC, first_name ASC;
-- 2d
SELECT country_id, country FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China");
-- 3a
ALTER TABLE actor
ADD COLUMN description BLOB;
-- 3b
ALTER TABLE actor
DROP COLUMN description;
-- 4a
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;
-- 4b
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name HAVING COUNT(last_name) > 1;
-- 4c
UPDATE actor SET first_name = "Harpo" WHERE first_name = "Groucho" and last_name = "Williams";
-- 4d
UPDATE actor SET first_name = "Groucho" WHERE first_name = "Harpo";
-- 5a
SHOW CREATE TABLE address;
-- 6a
SELECT s.first_name, s.last_name, a.address FROM address a JOIN staff s ON s.address_id=a.address_id;
-- 6b
SELECT s.first_name, SUM(p.amount) FROM payment p JOIN staff s ON s.staff_id=p.staff_id GROUP BY s.staff_id;
-- 6c
SELECT f.title, fa.film_id, COUNT(fa.actor_id) FROM film_actor fa INNER JOIN film f ON f.film_id=fa.film_id GROUP BY fa.film_id;
-- 6d
SELECT COUNT(title) FROM film WHERE title = "Hunchback Impossible"; 
-- 6e
SELECT c.first_name, c.last_name, SUM(p.amount) FROM payment p JOIN customer c ON c.customer_id=p.customer_id GROUP BY c.customer_id ORDER BY c.last_name ASC;
-- 7a
SELECT * FROM film
WHERE title LIKE "Q%" OR title LIKE "K%" and language_id IN 
(SELECT 
            language_id 
        FROM
            language
        WHERE
            language_id = 1);
SELECT * from film WHERE title ="Alone Trip";
SELECT * FROM film_actor WHERE film_id = 17;
-- 7b
SELECT first_name FROM actor WHERE actor_id IN
(SELECT actor_id FROM film_actor WHERE film_id = (
SELECT film_id FROM film WHERE title = "Alone Trip"));
-- 7c
SELECT c.first_name, c.last_name, c.email, co.country FROM customer c
INNER JOIN address ad on c.address_id=ad.address_id
INNER JOIN city ci on ad.city_id=ci.city_id
INNER JOIN country co on ci.country_id=co.country_id
WHERE country ="Canada";
-- 7d
SELECT f.title, c.name from film f
JOIN film_category fc USING(film_id)
JOIN category c USING(category_id)
WHERE name="Family";
-- 7e
SELECT f.title, COUNT(r.inventory_id) FROM film f
JOIN inventory inv USING(film_id)
JOIN rental r USING(inventory_id)
GROUP BY f.title ORDER BY SUM(r.inventory_id) DESC;
-- 7f
SELECT s.store_id, SUM(p.amount) FROM store s
JOIN inventory inv USING(store_id)
JOIN rental r USING(inventory_id)
JOIN payment p USING(rental_id)
GROUP BY store_id;
-- 7g
SELECT s.store_id, c.city, co.country FROM store s
JOIN address ad USING(address_id)
JOIN city c USING(city_id)
JOIN country co USING(country_id);
-- 8a
SELECT ca.name, SUM(p.amount) FROM category ca
JOIN film_category fc USING(category_id)
JOIN inventory  USING(film_id)
JOIN rental  USING(inventory_id)
JOIN payment p USING(rental_id)
GROUP BY ca.name ORDER BY SUM(p.amount) DESC LIMIT 5;
-- 8b
CREATE VIEW top_view AS
SELECT ca.name, SUM(p.amount) FROM category ca
JOIN film_category fc USING(category_id)
JOIN inventory  USING(film_id)
JOIN rental  USING(inventory_id)
JOIN payment p USING(rental_id)
GROUP BY ca.name ORDER BY SUM(p.amount) DESC LIMIT 5;
SELECT * FROM top_view;
-- 8c
DROP VIEW top_view;
