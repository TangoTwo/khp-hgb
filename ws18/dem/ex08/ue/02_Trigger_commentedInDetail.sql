-- TRIGGER sind spezielle PL/SQL-Prozeduren die implizit (d.h. vom Datenbank-Server
-- ausgel�st werden, wenn ein bestimmtes Ereignis eintritt. Sie sind einer Tabelle, 
-- View, Schema oder der Datenbank zugeordnet.

-- DML-Trigger (Statement-Trigger und ROW-Trigger) 
-- STATEMENT-Trigger: werden einmal f�r das ausl�sende Ereignis ausgel�st.
-- ROW-Trigger: werden einmal f�r jede vom ausl�senden Ereignis betroffene Zeile ausgef�hrt.
-- Mit Hilfe von Korrelationsnamen (OLD,NEW) kann auf die alten und neuen Spaltenwerte der
-- Zeile zugegriffen werden, die durch den Trigger verarbeitet wird.


-- Beispiel Statement-Trigger:

CREATE OR REPLACE TRIGGER secure_emp
BEFORE INSERT ON employees  --Trigger wird einmal vor einer INSERT-Operation auf die Tabelle employees ausgel�st
BEGIN
  IF (TO_CHAR(SYSDATE,'DY') IN ('SAT','SUN')) OR
     (TO_CHAR(SYSDATE,'HH24:MI') NOT BETWEEN '06:00' AND '12:00') THEN
      --ein Applikationsfehler wird ausgel�st und somit die INSERT-Aktion abgebrochen
      RAISE_APPLICATION_ERROR(-20500, 'You may insert into EMPLOYEES table only during '
                  ||' business hours.');
  END IF;
END;
/

-- Test des secure_emp Triggers:
INSERT INTO employees (employee_id, last_name, first_name, email, hire_date,
             job_id, salary, department_id)
VALUES (300, 'Smith', 'Rob', 'RSMITH', SYSDATE, 'IT_PROG', 4500, 60);
SELECT * FROM employees WHERE last_name = 'Smith';
ROLLBACK;

-- Beim Debuggen eines Trigger muss dieser von einer Prozedur aufgerufen werden
-- bzw. die Aktion in der Prozedur muss zu einem Feuern des Triggers f�hren.
-- Die Prozedur muss in der Datenbank vorhanden sein und mit Compile for Debug
-- �bersetzt werden. Entsprechender Breakpoint muss im Trigger gesetzt sein.
CREATE OR REPLACE
PROCEDURE test_trigger_secure_emp
IS
BEGIN
  INSERT INTO employees (employee_id, last_name, first_name, email, hire_date, job_id, salary, department_id)
  VALUES (300, 'Smith', 'Rob', 'RSMITH', SYSDATE, 'IT_PROG', 4500, 60);
END;
/



-- Bedingungspr�dikate (INSERTING, UPDATING und DELETING) verwenden 
-- und ausl�sende Ereignisse kombinieren:
CREATE OR REPLACE TRIGGER secure_emp BEFORE
--Trigger wird einmal vor einer INSERT/UPDATE/DELETE-Operation auf die Tabelle employees ausgel�st
INSERT OR UPDATE OR DELETE ON employees 
BEGIN
  IF (TO_CHAR(SYSDATE,'DY') IN ('SAT','SUN')) OR
     (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN '10' AND '12') THEN
    IF DELETING THEN
      RAISE_APPLICATION_ERROR(-20502,
        'You may delete from EMPLOYEES table only during business hours.');
    ELSIF INSERTING THEN 
      RAISE_APPLICATION_ERROR(-20500,
        'You may insert into EMPLOYEES table only during business hours.');
    ELSIF UPDATING('SALARY') THEN -- Aktualisieren der Spalte salary 
      RAISE_APPLICATION_ERROR(-20503,
        'You may update SALARY only during business hours.');
    ELSE 
      RAISE_APPLICATION_ERROR(-20504,
        'You may update EMPLOYEES table only during business hours.');
    END IF;
  END IF;
END;
/

-- Trigger im DataDictionary anzeigen mit Hilfe der view user_triggers:
SELECT trigger_name, trigger_type, description
  FROM user_triggers;


-- Trigger l�schen
DROP TRIGGER secure_emp;


-- DML-Row Trigger erstellen: es wird verhindert, dass bestimmte Angestellte ein Gehalt
-- von �ber 15.000 verdienen
CREATE OR REPLACE TRIGGER restrict_salary
BEFORE INSERT OR UPDATE OF salary ON employees
FOR EACH ROW  --Trigger wird f�r jede Zeile einmal ausgef�hrt
BEGIN
-- :OLD und :NEW erm�glichen Zugriff auf den aktuellen und neuen Wert einer Spalte
-- der aktuellen Zeile. OLD und NEW sind nur in Row Triggern verf�gbar.
IF NOT (:NEW.job_id IN ('AD_PRES', 'AD_VP')) 
   AND :NEW.salary > 15000 THEN
     RAISE_APPLICATION_ERROR (-20202, 'Employee cannot earn more than $15,000.');
END IF;
END;
/

--Test mit Lorentz, der ein IT_PROG ist.
UPDATE employees
   SET salary = 15500
 WHERE last_name = 'Lorentz';

DROP TRIGGER restrict_salary;



-- Row-Trigger einschr�nken mit der WHEN-Klausel
CREATE OR REPLACE TRIGGER derive_commission_pct
BEFORE INSERT OR UPDATE OF salary ON employees
-- Der Trigger wird nur bei Verkaufsleuten ausgel�st
FOR EACH ROW WHEN (NEW.job_id = 'SA_REP') 
-- Die WHEN-Klausel schr�nkt den ROW-Trigger ein!
-- Der Kennzeichner NEW darf in der WHEN-Klausel nicht mit einem Doppelpunkt als Pr�fix
-- versehen werden, da sich die WHEN-Klausel au�erhalb des PL/SQL-Blockes befindet.
BEGIN
  IF INSERTING THEN
    :NEW.commission_pct := 0;
  ELSIF :OLD.commission_pct IS NULL THEN
    :NEW.commission_pct := 0;
  ELSE
    :NEW.commission_pct := :OLD.commission_pct+0.05;
  END IF;
END;
/

DROP TRIGGER derive_commission_pct;



-- Integrit�ts-Constraints mit Triggern implementieren

UPDATE employees SET department_id = 9999
 WHERE employee_id = 141;
-- Update ist nicht erfolgreich, da eine Integrit�tsverletzung vorliegt
-- (die angegebene Abteilung existiert nicht)

CREATE OR REPLACE TRIGGER employee_dept_fk_trg
AFTER UPDATE OF department_id ON employees 
--Trigger wird nach jedem UPDATE auf department_id in der Tabelle employees ausgel�st
FOR EACH ROW
BEGIN
  -- passende Abteilung wird 'on-the-fly' erzeugt
  INSERT INTO departments VALUES(:new.department_id, 'Dept ' || :new.department_id, NULL, NULL);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN  --ist die Abteilung bereits vorhanden wird die Exception unterdr�ckt
    NULL;         --und das UPDATE ist erfolgreich.
END;
/

UPDATE employees SET department_id = 9999
 WHERE employee_id = 141;
-- UPDATE ist erfolgreich, da der Trigger employee_dept_fk_trg ausgel�st wird.

-- oder mit vorhandener Abteilung 10: DUP_VAL_ON_INDEX wird unterdr�ckt
UPDATE employees SET department_id = 10
 WHERE employee_id = 141;


SELECT * FROM departments;


DROP TRIGGER employee_dept_fk_trg;
ROLLBACK;
