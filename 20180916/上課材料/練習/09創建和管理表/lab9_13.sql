ALTER TABLE emp
ADD CONSTRAINT my_emp_dept_id_fk
FOREIGN KEY(deptid) REFERENCES dept(deptid);
