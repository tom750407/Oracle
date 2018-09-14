SELECT last_name, department_name
FROM employees JOIN departments USING (department_id)
WHERE last_name LIKE '%a%';
----------------------------
SELECT a.last_name, b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id AND a.last_name LIKE '%a%';
