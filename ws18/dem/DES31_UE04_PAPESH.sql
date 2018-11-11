-- 1.1a
SELECT employee_id, last_name, hire_date, salary
FROM employees
WHERE manager_id = 102;

-- 1.1b
SELECT employee_id, last_name, hire_date, salary
FROM employees
START WITH manager_id = 102
CONNECT BY PRIOR employee_id = manager_id;

-- 1.2
SELECT employee_id, manager_id, last_name, LEVEL
FROM employees
WHERE LEVEL = 2
START WITH manager_id = 102
CONNECT BY PRIOR employee_id = manager_id;

-- 1.3
SELECT employee_id, manager_id, LEVEL, LPAD(last_name, LENGTH(last_name) + (LEVEL * 2) - 2, '_') AS last_name
FROM employees
CONNECT BY PRIOR employee_id = manager_id;

-- 1.4
SELECT manager_first_name, manager_last_name, COUNT(employee_id) AS subordinates
FROM (SELECT employee_id,
             CONNECT_BY_ROOT first_name AS manager_first_name,
             CONNECT_BY_ROOT last_name  AS manager_last_name
      FROM employees
      WHERE level > 1
      CONNECT BY PRIOR employee_id = manager_id)
GROUP BY manager_first_name, manager_last_name
ORDER BY COUNT(employee_id) DESC;

-- 2.1
CREATE OR REPLACE VIEW partners AS (
SELECT person.actor_id AS actor_id, partner.actor_id AS partner_id, person.film_id
FROM film_actor person
       INNER JOIN film_actor partner ON person.film_id = partner.film_id AND person.actor_id != partner.actor_id
WHERE person.film_id <= 13
                                   );

SELECT *
FROM partners;

SELECT first_name, last_name, actor_id
FROM actor
    WHERE first_name = 'NICK' AND last_name = 'WAHLBERG';

SELECT DISTINCT partner_id
FROM partners
WHERE partner_id NOT IN (SELECT partner_id
                          FROM partners
                        WHERE actor_id = 2)
START WITH actor_id = 2
CONNECT BY NOCYCLE PRIOR partner_id = actor_id AND level = 2 AND partner_id != 2;

-- 3.1
SELECT *
FROM (SELECT rental_id, name, staff_id
      FROM category
             INNER JOIN film_category c2 ON category.category_id = c2.category_id
             INNER JOIN film f ON c2.film_id = f.film_id
             INNER JOIN inventory i ON f.film_id = i.film_id
             INNER JOIN rental r ON i.inventory_id = r.inventory_id)
    PIVOT
    (
      COUNT(rental_id)
    FOR staff_id
    IN (1 AS Verk1_Anzahl,
      2 AS Verk2_Anzahl)
    )
ORDER BY name;

-- 3.2
SELECT language, ROUND(family) AS Family, ROUND(children) AS Children, ROUND(animation) AS Animation
FROM (SELECT c1.name, length, l.name AS language
      FROM category c1
             INNER JOIN film_category c2 ON c1.category_id = c2.category_id
             INNER JOIN film f ON c2.film_id = f.film_id
             INNER JOIN language l ON f.language_id = l.language_id)
    PIVOT
    (
      AVG(length)
    FOR name
    IN ('Family' AS Family,
      'Children' AS Children,
      'Animation' AS Animation)
    );

-- 3.3
SELECT *
FROM (SELECT title, ol.name AS ol, l.name AS l
      FROM film f
             INNER JOIN language l ON f.language_id = l.language_id
             INNER JOIN language ol ON f.original_language_id = ol.language_id
      WHERE release_year = 1983)
    UNPIVOT
    (
        sprache
    FOR Art
    IN (L, OL)
    )
ORDER BY title;

-- 4.1
SELECT title, rental_date, RANK() OVER (PARTITION BY rental_date ORDER BY title) AS rank
      FROM film f
             INNER JOIN inventory i ON f.film_id = i.film_id
             INNER JOIN rental r ON i.inventory_id = r.inventory_id
      ORDER BY rental_date DESC
      FETCH FIRST 10 ROWS WITH TIES;

-- 4.2
SELECT name, title, release_year
FROM (
    SELECT name, title, release_year, ROW_NUMBER() OVER(PARTITION BY name ORDER BY release_year DESC) AS rn
    FROM film f
           INNER JOIN film_category fc ON f.film_id = fc.film_id
           INNER JOIN category c ON fc.category_id = c.category_id
    )
WHERE rn <= 3;

-- 4.3
SELECT first_name, last_name, ROUND(AVG(rental_date - date_before)) AS days_between
FROM (
SELECT first_name, last_name, rental_date,
LAG(rental_date, 1, NULL) OVER(PARTITION BY first_name, last_name ORDER BY rental_date ASC) AS date_before
FROM rental r INNER JOIN customer c USING(customer_id))
GROUP BY first_name, last_name
ORDER BY last_name ASC;