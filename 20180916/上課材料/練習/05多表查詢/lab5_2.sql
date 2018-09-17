SELECT DISTINCT job_id, city
FROM employees JOIN departments USING (department_id) JOIN locations USING (location_id)
WHERE department_id = 80;
-------------------------------------
SELECT DISTINCT a.job_id, c.city
FROM employees a, departments b, locations c
WHERE a.department_id = b.department_id AND b.location_id = c.location_id AND a.department_id = 80;
