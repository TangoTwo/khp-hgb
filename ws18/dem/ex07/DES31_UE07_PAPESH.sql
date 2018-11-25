-- 1.1
CREATE OR REPLACE PACKAGE top_customer_pkg AS
  FUNCTION GetFilmcount(cus_id customer.customer_id%TYPE)
    RETURN INTEGER;
END;

CREATE OR REPLACE PACKAGE BODY top_customer_pkg AS
  FUNCTION GetFilmcount(cus_id customer.customer_id%TYPE)
    RETURN INTEGER
  IS
    film_count INTEGER;
    BEGIN
      SELECT COUNT(*) INTO film_count
      FROM customer
             INNER JOIN rental r2 ON customer.customer_id = r2.customer_id
             INNER JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
             INNER JOIN film f ON i2.film_id = f.film_id
      WHERE customer.customer_id = cus_id
        AND length > 60;
      RETURN film_count;
    END;
  END;

BEGIN
  dbms_output.PUT_LINE('Checking film count for ID 100');
  dbms_output.PUT_LINE(top_customer_pkg.GetFilmcount(100));
END;

-- 1.2
CREATE OR REPLACE PACKAGE top_customer_pkg AS
  FUNCTION GetFilmcount(cus_id customer.customer_id%TYPE, begin_date rental.rental_date%TYPE, end_date rental.rental_date%TYPE)
    RETURN INTEGER;
  FUNCTION GetFilmcount(cus_id customer.customer_id%TYPE)
    RETURN INTEGER;
  PROCEDURE GetTopNCustomer(n_count INTEGER DEFAULT 10, begin_date rental.rental_date%TYPE DEFAULT SYSDATE-7, end_date rental.rental_date%TYPE DEFAULT SYSDATE);
END;

CREATE OR REPLACE PACKAGE BODY top_customer_pkg AS
  FUNCTION GetFilmcount(cus_id customer.customer_id%TYPE, begin_date rental.rental_date%TYPE, end_date rental.rental_date%TYPE)
    RETURN INTEGER
  IS
    film_count INTEGER;
    BEGIN
      SELECT COUNT(*) INTO film_count
      FROM customer
             INNER JOIN rental r2 ON customer.customer_id = r2.customer_id
             INNER JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
             INNER JOIN film f ON i2.film_id = f.film_id
      WHERE customer.customer_id = cus_id
        AND length > 60 AND begin_date <= rental_date AND rental_date <= end_date;
      RETURN film_count;
    END;

  FUNCTION GetFilmcount(cus_id customer.customer_id%TYPE)
    RETURN INTEGER
  IS
    BEGIN
      RETURN GetFilmcount(cus_id, TO_DATE('1900-01-01', 'yyyy-mm-dd'), SYSDATE);
    END;

  PROCEDURE GetTopNCustomer(n_count INTEGER DEFAULT 10, begin_date rental.rental_date%TYPE DEFAULT SYSDATE-7, end_date rental.rental_date%TYPE DEFAULT SYSDATE)
  IS
    film_count INTEGER;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('The top ' || n_count || ' customers from ' || begin_date || ' to ' || end_date || ' are:');
      FOR cus_record IN (
      SELECT first_name, last_name, c.customer_id
      FROM customer c
             INNER JOIN rental r2 ON c.customer_id = r2.customer_id
             INNER JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
             INNER JOIN film f ON i2.film_id = f.film_id
      WHERE length > 60
        AND begin_date <= rental_date AND rental_date <= end_date
      GROUP BY first_name, last_name, c.customer_id
        ORDER BY COUNT(f.film_id) DESC
        FETCH FIRST n_count ROWS ONLY
      )
      LOOP
        film_count := GetFilmcount(cus_record.customer_id, begin_date, end_date);
        DBMS_OUTPUT.PUT_LINE(cus_record.first_name || ' ' || cus_record.last_name || ': ' || film_count || ' films');
        INSERT INTO top_customers(cus_id, count, created_by) VALUES (cus_record.customer_id, film_count, USER);
      END LOOP;
    END;
  END;

BEGIN
  dbms_output.PUT_LINE(top_customer_pkg.GetFilmcount(100));
  top_customer_pkg.GetTopNCustomer(20, TO_DATE('2007-01-01','yyyy-mm-dd'), TO_DATE('2016-01-31','yyyy-mm-dd'));
  top_customer_pkg.GetTopNCustomer();
END;

-- 2.1
DROP TABLE top_customers;
CREATE TABLE top_customers(cus_id NUMBER NOT NULL, count INTEGER NOT NULL, created_by VARCHAR(30) NOT NULL, date_added TIMESTAMP DEFAULT SYSDATE NOT NULL, date_removed TIMESTAMP DEFAULT NULL);

BEGIN
  dbms_output.PUT_LINE(top_customer_pkg.GetFilmcount(100));
  top_customer_pkg.GetTopNCustomer(20, TO_DATE('2000-01-01','yyyy-mm-dd'));
  top_customer_pkg.GetTopNCustomer();
END;

SELECT * FROM top_customers;

-- 2.2
CREATE OR REPLACE PACKAGE top_customer_pkg AS
  FUNCTION GetFilmcount(cus_id customer.customer_id%TYPE, begin_date rental.rental_date%TYPE, end_date rental.rental_date%TYPE)
    RETURN INTEGER;
  FUNCTION GetFilmcount(cus_id customer.customer_id%TYPE)
    RETURN INTEGER;
  PROCEDURE GetTopNCustomer(n_count INTEGER DEFAULT 10, begin_date rental.rental_date%TYPE DEFAULT SYSDATE-7, end_date rental.rental_date%TYPE DEFAULT SYSDATE);
  PROCEDURE DeactivateTopCustomers(n_count INTEGER);
END;

CREATE OR REPLACE PACKAGE BODY top_customer_pkg AS
  FUNCTION GetFilmcount(cus_id customer.customer_id%TYPE, begin_date rental.rental_date%TYPE, end_date rental.rental_date%TYPE)
    RETURN INTEGER
  IS
    film_count INTEGER;
    BEGIN
      SELECT COUNT(*) INTO film_count
      FROM customer
             INNER JOIN rental r2 ON customer.customer_id = r2.customer_id
             INNER JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
             INNER JOIN film f ON i2.film_id = f.film_id
      WHERE customer.customer_id = cus_id
        AND length > 60 AND begin_date <= rental_date AND rental_date <= end_date;
      RETURN film_count;
    END;

  FUNCTION GetFilmcount(cus_id customer.customer_id%TYPE)
    RETURN INTEGER
  IS
    BEGIN
      RETURN GetFilmcount(cus_id, TO_DATE('1900-01-01', 'yyyy-mm-dd'), SYSDATE);
    END;

  PROCEDURE GetTopNCustomer(n_count INTEGER DEFAULT 10, begin_date rental.rental_date%TYPE DEFAULT SYSDATE-7, end_date rental.rental_date%TYPE DEFAULT SYSDATE)
  IS
    film_count INTEGER;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('The top ' || n_count || ' customers from ' || begin_date || ' to ' || end_date || ' are:');
      FOR cus_record IN (
      SELECT first_name, last_name, c.customer_id
      FROM customer c
             INNER JOIN rental r2 ON c.customer_id = r2.customer_id
             INNER JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
             INNER JOIN film f ON i2.film_id = f.film_id
      WHERE length > 60
        AND begin_date <= rental_date AND rental_date <= end_date
      GROUP BY first_name, last_name, c.customer_id
        ORDER BY COUNT(f.film_id) DESC
        FETCH FIRST n_count ROWS ONLY
      )
      LOOP
        film_count := GetFilmcount(cus_record.customer_id, begin_date, end_date);
        DBMS_OUTPUT.PUT_LINE(cus_record.first_name || ' ' || cus_record.last_name || ': ' || film_count || ' films');
        INSERT INTO top_customers(cus_id, count, created_by) VALUES (cus_record.customer_id, film_count, USER);
      END LOOP;
    END;

  PROCEDURE DeactivateTopCustomers(n_count INTEGER)
  IS
    CURSOR cus_cur (n_cound INTEGER) IS
      SELECT date_removed FROM top_customers WHERE count < n_count
      FOR UPDATE NOWAIT;
    result NUMBER;
    BEGIN
      SELECT count(*) INTO result
      FROM top_customers WHERE count < n_count;
      IF(result > 0) THEN
        FOR the_cus IN cus_cur(n_count)
          LOOP
          UPDATE top_customers SET date_removed = SYSDATE
          WHERE CURRENT OF cus_cur;
        END LOOP;
      END IF;
    END;
END;

BEGIN
  top_customer_pkg.DeactivateTopCustomers(35);
END;
SELECT * FROM top_customers;
-- 2.3
-- Wird der Befehl auf einer Konsole ausgeführt, wird die Tabelle in der anderen Session zurückgesetzt.
-- Wird in der ersten ein COMMIT ausgeführt, übernimmt die zweite Session die Änderungen der ersten.

-- 2.4
-- Folgende Fehlermeldung tritt auf: ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
-- Die Tabelle ist nun so lange gesperrt, bis in der verändernden Konsole ein COMMIT Befehl ausgeführt wird.


-- 3.1
DROP TABLE messages;
CREATE TABLE messages(results VARCHAR2(100));

CREATE OR REPLACE PROCEDURE name_part(name customer.last_name%TYPE)
IS
  first customer.first_name%TYPE;
  last customer.last_name%TYPE;
  cus_id customer.customer_id%TYPE;
  BEGIN
    SELECT first_name, last_name, customer_id INTO first, last, cus_id FROM customer WHERE last_name LIKE name;
    IF SQL%ROWCOUNT = 1 THEN
      INSERT INTO messages(results) VALUES (first || ' ' || last || ' ' || cus_id);
    END IF;
    DBMS_OUTPUT.PUT_LINE('ROWCOUNT ' || SQL%ROWCOUNT);
  END;

CALL name_part('FFFF'); -- No name found
CALL name_part('FULTZ'); -- Einer
CALL NAME_PART('ALL%'); -- Mehrere
SELECT * FROM messages;

-- Keiner: Fehlermeldung 'no data found'
-- Einer: CALL wird ausgeführt, Nachricht wird eingetragen
-- Mehrere: Fehlermeldung 'exact fetch returns more than requested number of rows'

-- 3.2
CREATE OR REPLACE PROCEDURE name_part(name customer.last_name%TYPE)
IS
  first customer.first_name%TYPE;
  last customer.last_name%TYPE;
  cus_id customer.customer_id%TYPE;
  BEGIN
    SELECT first_name, last_name, customer_id INTO first, last, cus_id FROM customer WHERE last_name LIKE name;
      INSERT INTO messages(results) VALUES (first || ' ' || last || ' ' || cus_id);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO messages(results) VALUES ('No customer found where last name begins with ' || name);
  END;

-- 3.3
CREATE OR REPLACE PROCEDURE name_part(name customer.last_name%TYPE)
IS
  first customer.first_name%TYPE;
  last customer.last_name%TYPE;
  cus_id customer.customer_id%TYPE;
  BEGIN
    SELECT first_name, last_name, customer_id INTO first, last, cus_id FROM customer WHERE last_name LIKE name;
      INSERT INTO messages(results) VALUES (first || ' ' || last || ' ' || cus_id);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO messages(results) VALUES ('No customer found where last name begins with ' || name);
    WHEN TOO_MANY_ROWS THEN
      INSERT INTO messages(results) VALUES ('Too many customers found for name ' || name);
    WHEN OTHERS THEN
      INSERT INTO messages(results) VALUES ('An undefined error occured');
      DBMS_OUTPUT.PUT_LINE(SQLCODE || SQLERRM);
  END;