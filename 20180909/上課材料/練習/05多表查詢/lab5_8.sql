SELECT a.last_name, a.department_id, COUNT(b.employee_id) - 1
FROM employees a JOIN employees b
ON(a.department_id = b.department_id)
GROUP BY a.last_name, a.department_id
ORDER BY 2, 1;
