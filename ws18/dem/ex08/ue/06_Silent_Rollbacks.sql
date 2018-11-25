-- Silent Rollbacks k�nnen im Mehrbenutzerbetrieb auftreten und werden
-- von der Datenbank f�r Serialisierung von mehreren Sessions verwendet
-- https://asktom.oracle.com/Misc/something-different-part-i-of-iii.html
-- https://asktom.oracle.com/Misc/part-ii-seeing-restart.html
-- https://asktom.oracle.com/Misc/part-iii-why-is-restart-important-to.html
-- https://asktom.oracle.com/Misc/that-old-restart-problem-again.html
DROP TABLE t;

CREATE TABLE t ( 
  x INT, 
  y INT 
);

INSERT INTO t VALUES ( 1, 1 );

CREATE OR REPLACE TRIGGER t_buffer
BEFORE UPDATE ON t
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE ('OLD.x = ' || :OLD.x || ', OLD.y = ' || :OLD.y);
  DBMS_OUTPUT.PUT_LINE ('NEW.x = ' || :NEW.y || ', NEW.y = ' || :NEW.y);
END;
/

-- Session 1
UPDATE t
SET x = x + 1;

-- Session 2 (Strg+Shift+n)
UPDATE t
SET x = x + 1
WHERE x > 0;
-- Statement blockiert in Session 2

-- Session 1
COMMIT;

-- Session 2: doppelte Ausgabe, zuerst f�r 1. �nderung (die im Hintergrund zur�ckgerollt wurde), dann f�r die
-- 2. �nderung basierend auf den Werten von Session 1
-- hier sieht man, dass der Trigger tats�chlich 2x gefeuert hat
-- Achtung bei DBMS+UTL-Paketen, solche Funktionen (Schreiben in Datei, Versand von Mail) werden vom
-- Trigger ausgef�hrt, k�nnen allerdings im Falle eines Rollbacks nicht r�ckg�ngig gemacht werden.

-- Auf Design achten - ist ein Trigger die richtige Wahl f�r diese Aufgabe? Ist der Trigger transaktionssicher?
-- M�glichkeit f�r Implementierung w�re �ber Materialisierte Sichten (UPDATE on COMMIT) bzw. Datenbank-Job.
