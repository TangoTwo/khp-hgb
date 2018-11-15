DECLARE
  starttime    NUMBER;
  total        NUMBER;
  amount       my_payment.amount%TYPE;
  rental_id    my_payment.rental_id%TYPE;
  payment_id   my_payment.payment_id%TYPE;
  payment_date my_payment.payment_date%TYPE;
  maxrent      NUMBER := 0;
  actualrent   NUMBER := 0;
  CURSOR mp IS
    SELECT amount, rental_id, payment_id, payment_date, CEIL(return_date - rental_date), rental_duration
    FROM my_payment
           INNER JOIN rental USING (rental_id)
           INNER JOIN inventory USING (inventory_id)
           INNER JOIN film USING (film_id);
BEGIN
  starttime := dbms_utility.GET_TIME();
  UPDATE (SELECT my_payment.penalty, amount, CEIL(return_date - rental_date) AS actualrent, rental_duration AS maxrent
          FROM my_payment
                 INNER JOIN rental USING (rental_id)
                 INNER JOIN inventory USING (inventory_id)
                 INNER JOIN film USING (film_id))
      mp
  SET mp.penalty = amount * 1.15 WHERE actualrent > maxrent;
  total := dbms_utility.GET_TIME() - starttime;
  dbms_output.PUT_LINE('UPDATE: ' || total / 100 || ' seconds');
END;
/
