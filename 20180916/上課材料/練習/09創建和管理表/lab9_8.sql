CREATE TABLE employees2 (empid, first_name, last_name, salary, deptid) AS
SELECT employee_id, first_name, last_name, salary, department_id
FROM employees;
