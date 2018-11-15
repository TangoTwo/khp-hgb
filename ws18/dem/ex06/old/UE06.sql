-- 1.4
ALTER TABLE  top_salaries ADD (emp_cnt NUMBER(5), PRIMARY KEY (salary), CONSTRAINT age_gt_0 CHECK (emp_cnt >= 0));

-- 1.5
