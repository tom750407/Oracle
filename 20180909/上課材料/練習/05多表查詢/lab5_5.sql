SELECT last_name, job_id, department_id, department_name
FROM employees JOIN departments USING (department_id) JOIN locations USING (location_id)
WHERE city = 'Toronto';
----------------------------------------
SELECT a.last_name, a.job_id, a.department_id, b.department_name
FROM employees a, departments b, locations c
WHERE a.department_id = b.department_id AND b.location_id = c.location_id AND c.city = 'Toronto';
