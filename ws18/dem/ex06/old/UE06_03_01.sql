CREATE TABLE my_payment AS
SELECT *
FROM payment
WHERE rental_id IS NOT NULL;
ALTER TABLE my_payment ADD PRIMARY KEY (payment_id);
ALTER TABLE my_payment ADD penalty NUMBER;
  


-- UPDATE in loop
DECLARE
  starttime NUMBER; 
  total NUMBER;
  maxRent NUMBER := 0;
  actualRent NUMBER := 0;
BEGIN
  starttime := DBMS_UTILITY.GET_TIME();
  FOR mp IN (SELECT amount, rental_id, payment_id, payment_date FROM my_payment) LOOP
    SELECT MAX(rental_duration) INTO maxRent 
    FROM film 
      INNER JOIN inventory USING (film_id) 
      INNER JOIN rental USING (inventory_id) WHERE rental_id = mp.rental_id;

    SELECT MAX(CEIL(return_date - rental_date)) INTO actualRent 
    FROM rental 
    WHERE rental_id = mp.rental_id;
    
    IF actualRent > maxRent THEN
      UPDATE my_payment
         SET penalty = amount * 1.15
      WHERE mp.payment_id = payment_id;
    END IF;
    
  END LOOP;
  total := DBMS_UTILITY.GET_TIME() - starttime;
  DBMS_OUTPUT.PUT_LINE('PL/SQL LOOP: ' || total / 100 || ' seconds'); 
END;
/

SELECT *
FROM my_payment;

DROP TABLE my_payment;
