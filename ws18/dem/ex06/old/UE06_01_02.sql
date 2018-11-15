DELETE FROM top_salaries;
DECLARE
  	num 	NUMBER(3) := &p_num;
  	sal       	employees.salary%TYPE;
		c_emp_cnt			INTEGER;
  	CURSOR 	emp_cursor IS
    		SELECT  salary, COUNT(salary) AS sal_count
    		FROM  employees
				GROUP BY salary
			ORDER BY  salary DESC;
		rec emp_cursor%ROWTYPE;
BEGIN
	OPEN emp_cursor;
  	FETCH emp_cursor INTO rec;
  	WHILE emp_cursor%ROWCOUNT <= num AND emp_cursor%FOUND LOOP
    		InsertTopSalaries(rec.salary, rec.sal_count);
	END LOOP;
	CLOSE emp_cursor;  
END;
/
SELECT * FROM top_salaries;
