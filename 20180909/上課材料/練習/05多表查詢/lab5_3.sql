SELECT last_name, department_name, location_id, city
FROM employees JOIN departments USING (department_id) JOIN locations USING (location_id)
WHERE commission_pct IS NOT NULL;
-------------------------------------------
SELECT a.last_name, b.department_name, b.location_id, c.city
FROM employees a, departments b, locations c
WHERE a.department_id = b.department_id AND b.location_id = c.location_id AND commission_pct IS NOT NULL;
