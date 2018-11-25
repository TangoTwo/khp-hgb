-- Constraints mit unterschiedlichen �berpr�fungs- und Verz�gerungsmodi
-- Verz�gerungsmodus: DEFERRABLE / NOT DEFERRABLE (Verz�gerbar / nicht verz�gerbar)
-- (Initialer) �berpr�fungsmodus: IMMEDIATE / DEFERRED (sofort / verz�gert)

--               | immediate   | deferred
--------------------------------------------               
--deferrable     |   ok        |    ok
--not deferrable |   ok        |    -

-- Erstellung von Beispieltabellen f�r die Demo
   DROP TABLE emp;
   DROP TABLE dept;

   CREATE TABLE dept (
       deptno             NUMBER(2) NOT NULL
     , dname              CHAR(14)
     , loc                CHAR(13)
     , CONSTRAINT dept_pk PRIMARY KEY (deptno)
   );

   INSERT INTO dept VALUES (10,'FINANCE','PITTSBURGH');
   INSERT INTO dept VALUES (20,'SALES','NEW YORK');
   INSERT INTO dept VALUES (30,'OPERATIONS','BOSTON');

   COMMIT;  

   CREATE TABLE emp (
       empno               NUMBER(4) NOT NULL
     , ename               CHAR(10)
     , job                 CHAR(9)
     , deptno              NUMBER(2) NOT NULL
     , CONSTRAINT emp_fk1  FOREIGN KEY (deptno)
                  REFERENCES dept (deptno)
                  DEFERRABLE 
                  INITIALLY IMMEDIATE
     , CONSTRAINT emp_pk PRIMARY KEY (empno)
   );

   INSERT INTO emp VALUES (1001, 'JEFF', 'PRESIDENT', 10);
   INSERT INTO emp VALUES (1002, 'MELODY', 'MANAGER', 30);
   INSERT INTO emp VALUES (1003, 'MARK', 'MANAGER', 10);
   INSERT INTO emp VALUES (1004, 'MARTIN', 'MANAGER', 20);

   COMMIT;
   
---------------------------------
-- �berpr�fungs-/Verz�gerungsmodus eines Constraints aus Data Dictionary abfragen
   SELECT 
       constraint_name
      , deferrable
      , deferred
   FROM user_constraints
   WHERE table_name = 'EMP';

--    CONSTRAINT_NAME   DEFERRABLE      DEFERRED
--    ----------------  --------------  ---------
--    SYS_C0067650      NOT DEFERRABLE  IMMEDIATE  --> NOT NULL - system generated
--    SYS_C0067651      NOT DEFERRABLE  IMMEDIATE  --> NOT NULL - system generated
--    EMP_PK            NOT DEFERRABLE  IMMEDIATE 
--    EMP_FK1           DEFERRABLE      IMMEDIATE 

-- Default-m��ig ist ein Constraint als Not Deferrable (nicht verz�gerbar) deklariert, 
-- d.h. Oracle wird sofort melden (notify immediately), wenn eine Constraint-Verletzung vorliegt
   
-- Wird ein verz�gerbares Constraint auf verz�gert gesetzt,
-- �berpr�ft Oracle das Constraint erst (nur) beim Commit am Ende der Transaktion


-- Test: L�schen von der Elterntabelle
   DELETE FROM dept WHERE deptno = 10;

-- -------------------------------
-- ERROR at line 1:
-- ORA-02292: Integrit�ts-Constraint (<User>.EMP_FK1) verletzt - untergeordneter Datensatz gefunden
-- dept tuple with deptno = 10 still in table dept
-- -------------------------------

-- ---------------------------------------------------------
-- Alle verz�gerbaren Transaktionen werden verz�gert gepr�ft
-- ---------------------------------------------------------
   SET CONSTRAINTS ALL DEFERRED;
-- or
-- SET CONSTRAINT EMP_FK1 DEFERRED
-- SET CONSTRAINTS erfolgreich.
   
-- Versuch: Constraint EMP_PK als deferred deklarieren 
   SET CONSTRAINT EMP_PK DEFERRED;
-- Fehler: ORA-02447: Nicht verz�gerbares Constraint kann nicht verz�gert werden

   DELETE FROM dept WHERE deptno = 10;

-- 1 row deleted.
   
-- dept tuple with deptno = 10 deleted from table dept
   
   COMMIT;

-- -------------------------------
-- ERROR at line 1:
-- ORA-02091: Transaktion wurde zur�ckgesetzt
-- ORA-02292: Integrit�ts-Constraint (<USER>.EMP_FK1) verletzt - untergeordneter Datensatz gefunden
-- 02091. 00000 -  "transaction rolled back"
   
   
-- -------------------------------
-- Zusammenfassung: Deferrable: �berpr�ft Constraint Integrity nur vor dem Commit.
-- Somit hat der Entwickler mehr Flexibilit�t beim Programmieren und muss sich 
-- erst gegen Ende der Transaktion hinsichtlich Verst��en gegen Constraints Gedanken machen.
-- Nachteil: ev. ung�ltige �nderungen wurden bereits durchgef�hrt und werden zur�ckgerollt.



   
-- Beispiel-Tabellen f�r Demo2   
-- Teilweise ist es notwendig, den Check bestimmter Constraints zu verschieben;
-- bekannt unter "Henne-Ei"-Problem:
-- Achtung: Fehlermeldung
   CREATE TABLE chicken (cID INT PRIMARY KEY,
                      eID INT REFERENCES egg(eID));
   CREATE TABLE egg(eID INT PRIMARY KEY,
                 cID INT REFERENCES chicken(cID));
                 
-- Fehlermeldung: CREATE TABLE statement f�r chicken zeigt auf Tabelle egg (noch nicht erstellt)
-- Erstellung von Tabelle egg zeigt auf Tabelle chicken und liefert Fehler, 
-- da die Tabelle chicken noch nicht existiert.
-- -> Workaround: SQL Schema Modification Elements.

-- Zuerst werden Chicken und Egg Tabellen ohne FK Deklaration erstellt.

   CREATE TABLE chicken(cID INT PRIMARY KEY,
                        eID INT);
   CREATE TABLE egg(eID INT PRIMARY KEY,
                    cID INT);

-- Danach werden FK Constraints dazugef�gt:
   ALTER TABLE chicken ADD CONSTRAINT chickenREFegg
        FOREIGN KEY (eID) REFERENCES egg(eID)
        INITIALLY DEFERRED DEFERRABLE;
   ALTER TABLE egg ADD CONSTRAINT eggREFchicken
        FOREIGN KEY (cID) REFERENCES chicken(cID)
        INITIALLY DEFERRED DEFERRABLE;
   
-- INITIALLY DEFERRED DEFERRABLE: Oracle f�hrt Constraint-Checking verz�gert durch 
-- Beispiel: Einf�gen von (1, 2) in chicken einzuf�gen und (2, 1) in egg:

   INSERT INTO chicken VALUES(1, 2);
   INSERT INTO egg VALUES(2, 1);
   COMMIT;
   
-- Da die FK Constraints als "deferred" deklariert sind, werden sie beim Commit gepr�ft
-- ohne deferred Constraint Checking kann man nichts in chicken/egg einf�gen, 
-- da das erste Insert jeweils einen Constraint-Versto� darstellt.
   
-- Um die Tabellen zu l�schen, m�ssen zuerst die Constraints gel�scht werden,
-- da Oracle kein L�schen einer Tabelle erlaubt, die von einer anderen Tabelle
-- referenziert wird.

   ALTER TABLE egg DROP CONSTRAINT eggREFchicken;
   ALTER TABLE chicken DROP CONSTRAINT chickenREFegg;
   DROP TABLE egg;
   DROP TABLE chicken;
