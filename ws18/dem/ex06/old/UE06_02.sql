-- 2.1
ALTER TABLE top_salaries ADD (createdBy VARCHAR(30), dateCreated TIMESTAMP, modifiedBy VARCHAR(30), dateModified TIMESTAMP);

-- 2.2
CREATE OR REPLACE PROCEDURE InsertTopSalaries (
pSalary IN NUMBER,
pEmp_cnt IN NUMBER)
  IS
  BEGIN
    INSERT INTO top_salaries VALUES (pSalary, pEmp_cnt, USER, SYSDATE, USER, SYSDATE);
  END;