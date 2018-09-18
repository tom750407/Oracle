CREATE OR REPLACE VIEW dept50 AS
SELECT employee_id empno, last_name employee, department_id deptno, department_name deptname
FROM employees JOIN departments USING(department_id)
WHERE department_id = 50
WITH CHECK OPTION;
