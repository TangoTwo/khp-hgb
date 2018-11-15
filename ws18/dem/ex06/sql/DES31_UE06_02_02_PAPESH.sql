CREATE OR REPLACE PROCEDURE InsertTopSalaries (
pSalary IN NUMBER,
pEmp_cnt IN NUMBER)
  IS
  BEGIN
    INSERT INTO top_salaries VALUES (pSalary, pEmp_cnt, USER, SYSDATE, USER, SYSDATE);
  END;
