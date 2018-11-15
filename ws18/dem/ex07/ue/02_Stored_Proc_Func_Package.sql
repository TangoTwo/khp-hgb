-- STORED PROCEDURE

-- Gehaltserhöhung für best. Abteilung um best. Prozentsatz
-- TODO: Prozedur definieren (Abteilungsnr dnum und Prozent percent (0.5 als default) als Eingabe-Parameter)
-- Übergabemodus: IN (default), OUT und IN OUT
CREATE OR REPLACE PROCEDURE raise_salary(dnum IN employees.department_id%TYPE, percent IN FLOAT DEFAULT 0.5)
IS
  --TODO: CURSOR mit Übergabeparameter dept_no (zum Updaten von Salary in best. Department)
  CURSOR update_salary (dept_no employees.department_id%TYPE) IS
    SELECT salary
    FROM employees
    WHERE department_id = dept_no
    FOR UPDATE OF salary;
  result NUMBER;
  BEGIN
    -- Anzahl der Abteilungen bestimmen, in denen das Gehalt erhöht wird
    SELECT count(*) INTO result FROM departments WHERE department_id = dnum;

    -- Wenn eine Abteilung vorhanden ist, soll das Gehalt für alle Angestellten erhöht werden.
    IF (result > 0)
    THEN


      -- TODO Verwendung des CURSOR mittels FOR-LOOP
      -- die Schleifenvariable the_emp entspricht automatisch dem Zeilentyp des Cursors
      -- und erspart das OPEN, FETCH und CLOSE
      FOR the_emp IN update_salary(dnum)
      LOOP
        -- TODO: Achtung, WHERE bei Update nicht vergessen!
        -- Bestimmen, welche Datensätze zu aktualisieren sind
        -- CURRENT OF-Klausel ermöglicht den aktuellen Datensatz zu ändern
        -- und wird in Verbindung mit der FOR-UPDATE-Klausel verwendet
        UPDATE employees SET salary = the_emp.salary * ((100 + percent) / 100) WHERE CURRENT OF update_salary;


      END LOOP;
    END IF;
  END; --raise_salary

/

--Aufruf der Stored Procedure raise_salary: Gehalt der Mitarbeiter aus Abteilung 50 um best. Prozentsatz erhöhen
SELECT last_name, salary, department_id
FROM employees
WHERE department_id = 50;

-- TODO: Aufruf der Stored Procedure mit 10% für Abteilung 50
CALL raise_salary(50);
SELECT last_name, salary, department_id
FROM employees
WHERE department_id = 50;

SELECT last_name, salary, department_id
FROM employees
WHERE department_id = 50;
-- TODO Aufruf von raise_salary in einem PL/SQL-Block: Erhöhung des Gehalts um den Defaultwert (0.5%)


SELECT last_name, salary, department_id
FROM employees
WHERE department_id = 50;

-- TODO Abfragen der gespeicherten Prozedur aus dem DataDictionary


ROLLBACK;

-- TODO Löschen der Prozedur;
DROP PROCEDURE raise_salary;

-- STORED FUNCTIONS
-- Überprüft, ob das Gehalt des angegebenen Angestellten mehr als das durchschnittliche Gehalt beträgt
CREATE OR REPLACE FUNCTION check_sal_gt_avg(empno employees.employee_id%TYPE)
  RETURN Boolean --Angabe des Rückgabewertes
IS
  dept_id employees.department_id%TYPE;
  sal     employees.salary%TYPE;
  avg_sal employees.salary%TYPE;
  BEGIN
    --Bestimmen des entsprechenden Gehalts eines Angestellten
    SELECT salary, department_id INTO sal, dept_id FROM employees WHERE employee_id = empno;

    --Berechnen des durchschnittlichen Gehalts der Abteilung
    SELECT avg(salary) INTO avg_sal FROM employees WHERE department_id = dept_id;

    --Überprüfen, ob das Gehalt des angegebenen Angestellten mehr als das durchschnittliche Gehalt beträgt
    IF sal > avg_sal
    THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;
/

--Aufruf der gespeicherten Funktion
BEGIN
  DBMS_OUTPUT.PUT_LINE('Checking salary of employee with id 205');
  -- TODO Aufruf der gespeicherten Funktion check_sal_gt_avg für employee 205
  IF
    check_sal_gt_avg(205)
  THEN
    DBMS_OUTPUT.PUT_LINE('Salary > average');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Salary < average');
  END IF;
END;
/

-- Löschen der Funktion
DROP FUNCTION check_sal_gt_avg;

-- Packages: Zusammenfassung von Prozeduren und/oder Funktionen zu einem gemeinsamen Paket(Unit).
-- Definition der Paket-Schnittstelle/Spezifikation
-- TODO: Erstellung eines Packages für die Prozedur raise_salary und die Funktion check_sal_gt_avg
CREATE OR REPLACE PACKAGE salary_pkg AS
PROCEDURE raise_salary(dnum IN employees.department_id%TYPE, percent IN FLOAT DEFAULT 0.5);
FUNCTION check_sal_gt_avg(empno employees.employee_id%TYPE)
  RETURN Boolean;--Angabe des Rückgabewertes
END;
/

-- TODO Definition des Paktet-Rumpfes/Implementierung
CREATE OR REPLACE PACKAGE BODY salary_pkg AS
  --TODO Prozedur hineinkopieren
PROCEDURE raise_salary(dnum IN employees.department_id%TYPE, percent IN FLOAT DEFAULT 0.5)
IS
  --TODO: CURSOR mit Übergabeparameter dept_no (zum Updaten von Salary in best. Department)
  CURSOR update_salary (dept_no employees.department_id%TYPE) IS
    SELECT salary
    FROM employees
    WHERE department_id = dept_no
    FOR UPDATE OF salary;
  result NUMBER;
  BEGIN
    -- Anzahl der Abteilungen bestimmen, in denen das Gehalt erhöht wird
    SELECT count(*) INTO result FROM departments WHERE department_id = dnum;

    -- Wenn eine Abteilung vorhanden ist, soll das Gehalt für alle Angestellten erhöht werden.
    IF (result > 0)
    THEN


      -- TODO Verwendung des CURSOR mittels FOR-LOOP
      -- die Schleifenvariable the_emp entspricht automatisch dem Zeilentyp des Cursors
      -- und erspart das OPEN, FETCH und CLOSE
      FOR the_emp IN update_salary(dnum)
      LOOP
        -- TODO: Achtung, WHERE bei Update nicht vergessen!
        -- Bestimmen, welche Datensätze zu aktualisieren sind
        -- CURRENT OF-Klausel ermöglicht den aktuellen Datensatz zu ändern
        -- und wird in Verbindung mit der FOR-UPDATE-Klausel verwendet
        UPDATE employees SET salary = the_emp.salary * ((100 + percent) / 100) WHERE CURRENT OF update_salary;


      END LOOP;
    END IF;
  END;

  --TODO Funktion hineinkopieren
FUNCTION check_sal_gt_avg(empno employees.employee_id%TYPE)
  RETURN Boolean --Angabe des Rückgabewertes
IS
  dept_id employees.department_id%TYPE;
  sal     employees.salary%TYPE;
  avg_sal employees.salary%TYPE;
  BEGIN
    --Bestimmen des entsprechenden Gehalts eines Angestellten
    SELECT salary, department_id INTO sal, dept_id FROM employees WHERE employee_id = empno;

    --Berechnen des durchschnittlichen Gehalts der Abteilung
    SELECT avg(salary) INTO avg_sal FROM employees WHERE department_id = dept_id;

    --Überprüfen, ob das Gehalt des angegebenen Angestellten mehr als das durchschnittliche Gehalt beträgt
    IF sal > avg_sal
    THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;

END;
/


--Aufruf
BEGIN
  DBMS_OUTPUT.PUT_LINE('Checking salary of employee with id 205');
  -- TODO: Aufruf der Funktion check_sal_gt_avg im Package
  IF
    salary_pkg.check_sal_gt_avg(205)
  THEN
    DBMS_OUTPUT.PUT_LINE('Salary > average');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Salary < average');
  END IF;
END;
/

--TODO: Löschen des Datenpaketes
