SELECT a.employee_id "Emp#", a.last_name "Employee", a.manager_id "Manager", b.last_name "Mgr#"
FROM employees a JOIN employees b
ON(a.manager_id = b.employee_id)
ORDER BY 1;
-----------------------------------------
SELECT a.employee_id "Emp#", a.last_name "Employee", a.manager_id "Manager", b.last_name "Mgr#"
FROM employees a, employees b
WHERE a.manager_id = b.employee_id
ORDER BY 1;
