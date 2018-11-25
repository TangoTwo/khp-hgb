-- Constraints mit unterschiedlichen Überprüfungs- und Verzögerungsmodi
-- Verzögerungsmodus: DEFERRABLE / NOT DEFERRABLE (Verzögerbar / nicht verzögerbar)
-- (Initialer) Überprüfungsmodus: IMMEDIATE / DEFERRED (sofort / verzögert)

--               | immediate   | deferred
--------------------------------------------               
--deferrable     |   ok        |    ok
--not deferrable |   ok        |    -

-- Erstellung von Beispieltabellen für die Demo
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
-- Überprüfungs-/Verzögerungsmodus eines Constraints aus Data Dictionary abfragen
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

-- Default-mäßig ist ein Constraint als Not Deferrable (nicht verzögerbar) deklariert, 
-- d.h. Oracle wird sofort melden (notify immediately), wenn eine Constraint-Verletzung vorliegt
   
-- Wird ein verzögerbares Constraint auf verzögert gesetzt,
-- überprüft Oracle das Constraint erst (nur) beim Commit am Ende der Transaktion


-- Test: Löschen von der Elterntabelle
   DELETE FROM dept WHERE deptno = 10;

-- -------------------------------
-- ERROR at line 1:
-- ORA-02292: Integritäts-Constraint (<User>.EMP_FK1) verletzt - untergeordneter Datensatz gefunden
-- dept tuple with deptno = 10 still in table dept
-- -------------------------------

-- ---------------------------------------------------------
-- Alle verzögerbaren Transaktionen werden verzögert geprüft
-- ---------------------------------------------------------
   SET CONSTRAINTS ALL DEFERRED;
-- or
-- SET CONSTRAINT EMP_FK1 DEFERRED
-- SET CONSTRAINTS erfolgreich.
   
-- Versuch: Constraint EMP_PK als deferred deklarieren 
   SET CONSTRAINT EMP_PK DEFERRED;
-- Fehler: ORA-02447: Nicht verzögerbares Constraint kann nicht verzögert werden

   DELETE FROM dept WHERE deptno = 10;

-- 1 row deleted.
   
-- dept tuple with deptno = 10 deleted from table dept
   
   COMMIT;

-- -------------------------------
-- ERROR at line 1:
-- ORA-02091: Transaktion wurde zurückgesetzt
-- ORA-02292: Integritäts-Constraint (<USER>.EMP_FK1) verletzt - untergeordneter Datensatz gefunden
-- 02091. 00000 -  "transaction rolled back"
   
   
-- -------------------------------
-- Zusammenfassung: Deferrable: überprüft Constraint Integrity nur vor dem Commit.
-- Somit hat der Entwickler mehr Flexibilität beim Programmieren und muss sich 
-- erst gegen Ende der Transaktion hinsichtlich Verstößen gegen Constraints Gedanken machen.
-- Nachteil: ev. ungültige Änderungen wurden bereits durchgeführt und werden zurückgerollt.



   
-- Beispiel-Tabellen für Demo2   
-- Teilweise ist es notwendig, den Check bestimmter Constraints zu verschieben;
-- bekannt unter "Henne-Ei"-Problem:
-- Achtung: Fehlermeldung
   CREATE TABLE chicken (cID INT PRIMARY KEY,
                      eID INT REFERENCES egg(eID));
   CREATE TABLE egg(eID INT PRIMARY KEY,
                 cID INT REFERENCES chicken(cID));
                 
-- Fehlermeldung: CREATE TABLE statement für chicken zeigt auf Tabelle egg (noch nicht erstellt)
-- Erstellung von Tabelle egg zeigt auf Tabelle chicken und liefert Fehler, 
-- da die Tabelle chicken noch nicht existiert.
-- -> Workaround: SQL Schema Modification Elements.

-- Zuerst werden Chicken und Egg Tabellen ohne FK Deklaration erstellt.

   CREATE TABLE chicken(cID INT PRIMARY KEY,
                        eID INT);
   CREATE TABLE egg(eID INT PRIMARY KEY,
                    cID INT);

-- Danach werden FK Constraints dazugefügt:
   ALTER TABLE chicken ADD CONSTRAINT chickenREFegg
        FOREIGN KEY (eID) REFERENCES egg(eID)
        INITIALLY DEFERRED DEFERRABLE;
   ALTER TABLE egg ADD CONSTRAINT eggREFchicken
        FOREIGN KEY (cID) REFERENCES chicken(cID)
        INITIALLY DEFERRED DEFERRABLE;
   
-- INITIALLY DEFERRED DEFERRABLE: Oracle führt Constraint-Checking verzögert durch 
-- Beispiel: Einfügen von (1, 2) in chicken einzufügen und (2, 1) in egg:

   INSERT INTO chicken VALUES(1, 2);
   INSERT INTO egg VALUES(2, 1);
   COMMIT;
   
-- Da die FK Constraints als "deferred" deklariert sind, werden sie beim Commit geprüft
-- ohne deferred Constraint Checking kann man nichts in chicken/egg einfügen, 
-- da das erste Insert jeweils einen Constraint-Verstoß darstellt.
   
-- Um die Tabellen zu löschen, müssen zuerst die Constraints gelöscht werden,
-- da Oracle kein Löschen einer Tabelle erlaubt, die von einer anderen Tabelle
-- referenziert wird.

   ALTER TABLE egg DROP CONSTRAINT eggREFchicken;
   ALTER TABLE chicken DROP CONSTRAINT chickenREFegg;
   DROP TABLE egg;
   DROP TABLE chicken;
