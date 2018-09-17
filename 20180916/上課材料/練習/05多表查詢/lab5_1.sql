SELECT last_name, department_id, department_name
FROM employees JOIN departments USING (department_id);
---------------------------------------------
SELECT a.last_name, a.department_id, b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id;
