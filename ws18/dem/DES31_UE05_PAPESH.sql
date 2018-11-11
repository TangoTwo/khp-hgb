-- 1.1
SELECT DISTINCT release_year, title, LISTAGG(SUBSTR(first_name, 1, 1) || '. ' || last_name, ', ')
    WITHIN GROUP (ORDER BY last_name, first_name, a3.actor_id)
    OVER (PARTITION BY title) AS "actors"
FROM film
       INNER JOIN film_actor a2 ON film.film_id = a2.film_id
       INNER JOIN actor a3 ON a2.actor_id = a3.actor_id
ORDER BY release_year, title;

-- 1.2
SELECT DISTINCT first_name || ' ' || last_name               AS customer,
                LISTAGG(title || '(' || release_year || ')', ', ')
                    WITHIN GROUP (ORDER BY release_year DESC)
                    OVER (PARTITION BY customer.customer_id) AS films
FROM customer
       INNER JOIN rental r ON customer.customer_id = r.customer_id
       INNER JOIN inventory i ON r.inventory_id = i.inventory_id
       INNER JOIN film f ON i.film_id = f.film_id
WHERE rental_date > ADD_MONTHS(CURRENT_DATE, -(12 * 4));

-- 1.3
WITH three_or_more AS (SELECT c.customer_id, name, COUNT(f.film_id)
                       FROM customer c
                              INNER JOIN rental r ON c.customer_id = r.customer_id
                              INNER JOIN inventory i ON r.inventory_id = i.inventory_id
                              INNER JOIN film f ON i.film_id = f.film_id
                              INNER JOIN film_category ON f.film_id = film_category.film_id
                              INNER JOIN category ON film_category.category_id = category.category_id
                       GROUP BY c.customer_id, name
                       HAVING count(f.film_id) >= 3)
SELECT DISTINCT first_name || ' ' || last_name AS customer, LISTAGG(name, ', ')
    WITHIN GROUP (ORDER BY name)
    OVER (PARTITION BY customer.customer_id)   AS interests
FROM customer
       INNER JOIN three_or_more ON three_or_more.customer_id = customer.customer_id
       INNER JOIN address a2 ON customer.address_id = a2.address_id
       INNER JOIN city c2 ON a2.city_id = c2.city_id
WHERE city = 'Linz';

;

-- 2.1
CREATE VIEW "UE05_02a" AS
  SELECT category, store1, store2, ROUND(1 + (store2 - store1) / store1, 3) AS "STORE1:STORE2"
  FROM (SELECT *
        FROM (SELECT store_id, name AS category, SUM(amount) AS revenue
              FROM inventory i
                     INNER JOIN film f ON i.film_id = f.film_id
                     INNER JOIN film_category c2 ON f.film_id = c2.film_id
                     INNER JOIN category c3 ON c2.category_id = c3.category_id
                     INNER JOIN rental r ON i.inventory_id = r.inventory_id
                     INNER JOIN payment p ON r.rental_id = p.rental_id
              GROUP BY store_id, name
              HAVING store_id = 1
                  OR store_id = 2)
            PIVOT
            (
              SUM(revenue)
            FOR (store_id)
            IN (1 AS store1,
              2 AS store2)
            )
        ORDER BY category);

-- Show view
SELECT *
FROM "UE05_02a";

-- 2.2
CREATE MATERIALIZED VIEW "UE05_02b"
REFRESH COMPLETE ON DEMAND
  AS
    SELECT *
    FROM "UE05_02a";

-- 2.3
ALTER MATERIALIZED VIEW "UE05_02b"
REFRESH START WITH trunc(SYSDATE) + 23.5 / 24
NEXT trunc(sysdate) + 1 / 24 * 23.5;

DROP VIEW "UE05_02a";
DROP MATERIALIZED VIEW "UE05_02b";

-- 3.1
SELECT column_name, data_type, data_length, nullable, data_precision AS decimal_points, data_scale AS digits_right
FROM all_tab_columns
WHERE table_name = '&tablename';

-- 3.2
COMMENT ON TABLE store
IS 'Test';

SELECT *
FROM user_tab_comments;

-- 3.3
SELECT DISTINCT column_name, constr.constraint_name, constr.constraint_type, constr.search_condition_vc, constr.status
FROM user_constraints constr
       JOIN user_cons_columns ucc USING (table_name)
WHERE '"' || ucc.column_name || '"' = REGEXP_SUBSTR(search_condition_vc, '\"(.*?)\"');

-- 4.1
CREATE SEQUENCE id_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE OR REPLACE FUNCTION seq(a INT)
  RETURN VARCHAR2 IS
  BEGIN
    RETURN a || '_' || id_seq.nextval;
  END;

CREATE TABLE probe
(
  probe_id  VARCHAR2(30) PRIMARY KEY,
  zeit      TIMESTAMP    NOT NULL,
  art       VARCHAR2(30) NOT NULL,
  kommentar VARCHAR2(30)
);

INSERT INTO probe (probe_id, zeit, art)
VALUES (seq(1), SYSDATE, 'Milch');

INSERT INTO probe (probe_id, zeit, art, kommentar)
VALUES (seq(2), SYSDATE, 'Eier', 'Sehr duenne Schale');

INSERT INTO probe (probe_id, zeit, art)
VALUES (seq(3), SYSDATE, 'Schafskaese');

INSERT INTO probe (probe_id, zeit, art)
VALUES (seq(3), SYSDATE, 'Butter');

SELECT *
FROM probe;

COMMIT;

DROP TABLE probe;
DROP FUNCTION seq;
DROP SEQUENCE id_seq;

-- 4.2
-- Beim Autokennzeichen an sich handelt es sich um einen künstlichen Schlüssel.
-- Da es nicht auf existierende Eigenschaften zurückgreift.
-- Als alleiniger Primärschlüssel eignet es sich jedoch nicht, da beim Verkauf der frühere Besitzer manchmal die Nummerntafel behalten kann.
-- dh es sich dann um ein anderes Auto handelt. Außerdem wird bei Umzug in ein anderes Verwaltungsgebiet der Anfangsfolge des Kennzeichens abgeändert.
-- Daher wäre es sinnvoll, die Fahrgestellnummer als Primärschlüssel zu verwenden, da diese eindeutig an das Fahrzeug gebunden ist.
-- AUSNAHME: In England ist die Nummerntafel fest an das Auto gebunden. Hier wäre es zulässig, diese als Primärschlüssel zu verwenden.

-- 4.3
-- Ja, die ISBN ist eine Kombination aus verschiedenen serialisierten Daten wie Publisher und Titel.
-- Jedoch kann eine Bibliothek ein Buch öfter führen, wodurch es zu Problemen kommen könnte.
-- Daher ist eine zweite ID für die Bibliothek sehr ratsam.