-- 3.1
SELECT last_name, first_name
FROM actors
WHERE COUNT(last_name, first_name) > 1;

-- 3.2
SELECT title
FROM 
-- 5
SELECT manager_id, store_id, SUM(earnings)
FROM managers INNER JOIN stores USING(store_id)
GROUP BY CUBE(manager_id, store_id);

SELECT manager_id, store_id, SUM(earnings), GROUPING(manager_id) GRP_M, GROUPING(store_id) GRP_S
FROM managers INNER JOIN stores USING(store_id)
GROUP BY CUBE(manager_id, store_id);

SELECT manager_staff_id, store_id, staff_id
FROM stores INNER JOIN managers USING(store_id) INNER JOIN employees USING(employee_id)
GROUP BY GROUPING SETS ((manager_staff_id, store_id, staff_id), (manager_staff_id, store_id), (store_id, staff_id));

SELECT country, EXTRACT(YEAR FROM date) AS "year", staff_id, SUM(amount), COUNT(*)
FROM 
GROUP BY GROUPING SETS((country, year), (staff_id, year), ());