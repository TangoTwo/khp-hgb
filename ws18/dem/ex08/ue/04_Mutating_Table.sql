-- Mutating Table Problem mit DELETE CASCADE

-- Eine mutating table ist eine Tabelle, die gerade durch ein UPDATE, DELETE, or INSERT Statement ge�ndert wird,
-- oder eine Tabelle, die aufgrund einer deklarativen DELETE CASCADE Referentiellen Integrit�t ge�ndert werden muss
-- Mutating table exceptions treten auf, wenn versucht wird, innerhalb eines Row-Triggers mit einer Abfrage auf die triggernde Tabelle zuzugreifen. 

-- Gegeben sind zwei Tabellen "A" und "B". "A" is die Master-Tabelle and "B" die Detail-Tabelle. 
-- Ein FK wird zwischen "B" and "A" definiert, mit der CASCADE DELETE Option. 

CREATE TABLE A (
  IDa    NUMBER   NOT NULL,
  valA   VARCHAR2(10),
  PRIMARY KEY (ida)); 

CREATE TABLE B (
  IDb    NUMBER,
  valB   VARCHAR2(10),
  FOREIGN KEY (IDb) REFERENCES A (IDa) ON DELETE CASCADE);

CREATE OR REPLACE TRIGGER b_br
  AFTER DELETE ON B
  FOR EACH ROW
DECLARE
    n integer;
BEGIN
  SELECT COUNT(*) INTO n FROM A;
  dbms_output.put_line('there are ' || n || ' rows in A');
  dbms_output.put_line('after statment on B');
  dbms_output.new_line;
END;
/ 

INSERT INTO A VALUES(1, 'Table A');
INSERT INTO A VALUES(2, 'Table A');

INSERT INTO B VALUES(1, 'Table B');
INSERT INTO B VALUES(1, 'Table B');
COMMIT; 

DELETE FROM A WHERE IDa = 1; --> Fehler

-- Fehlerbericht:
-- SQL-Fehler: ORA-04091: Tabelle L20621.A wird gerade ge�ndert, Trigger/Funktion sieht dies m�glicherweise nicht
-- ORA-06512: in "<USER>.B_BR", Zeile 4
-- ORA-04088: Fehler bei der Ausf�hrung von Trigger '<USER>.B_BR'
-- 04091. 00000 -  "table %s.%s is mutating, trigger/function may not see it"
-- *Cause:    A trigger (or a user defined plsql function that is referenced in
--           this statement) attempted to look at (or modify) a table that was
--           in the middle of being modified by the statement which fired it.
--*Action:   Rewrite the trigger (or function) so it does not read that table.

-- Problem: Das SQL Statement ("select count(*) into n from A") wird f�r die erste Zeile der Tabelle ausgef�hrt,
-- dann feuert der AFTER Row Trigger B_BR. 
-- Ein Statement im AFTER Row Trigger Body versucht, auf die originale Tabelle A zuzugreifen.
-- Da die Tabelle A aufgrund des CASCADE DELETE FK mutiert, ist die Abfrage in Oracle nicht erlaubt.
-- Wird es dennoch versucht, wird ein Laufzeitfehler ausgel�st, 
-- die �nderungen des Triggers und der Statements, die die Trigger verursacht haben, werden zur�ckgerollt und
-- die Kontrolle wird wieder dem Benutzer bzw. der Applikation �bergeben.

-- L�sung: Verwendung eines Statement Triggers statt eines Row Trigger 
-- Wird die Zeile "FOR EACH ROW" aus dem obigen Trigger gel�scht, wird der ROW-Trigger zum Statement-Trigger.
-- Somit mutiert die Tabelle nicht w�hrend der Trigger (zeilenweise) feuert und gibt die korrekten Daten aus.

CREATE OR REPLACE TRIGGER b_br
  AFTER DELETE ON B
DECLARE
    N INTEGER;
BEGIN
  SELECT COUNT(*) INTO n FROM a;
  dbms_output.put_line('there are ' || n || ' rows in a');
  dbms_output.put_line('after statment on b');
  dbms_output.new_line;
END;
/ 

DELETE FROM A WHERE IDa = 1; --> funktioniert

SELECT COUNT(*) FROM A;
SELECT COUNT(*) FROM B;


-- Eine �nderung von Row-Trigger zu Statement-Trigger ist nicht immer m�glich.
-- In diesem Fall sollte eine Tempor�re Tabelle oder ein Compound-Trigger verwendet werden.
DROP TABLE B;
DROP TABLE A;