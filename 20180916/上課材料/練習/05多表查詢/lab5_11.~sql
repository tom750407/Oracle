SELECT a.first_name || ' ' || a.last_name "Employee", a.hire_date "Emp hired", 
       b.first_name || ' ' || b.last_name "Manager", b.hire_date "Mgr hired"
FROM employees a JOIN employees b ON(a.manager_id = b.employee_id)
WHERE a.hire_date < b.hire_date;
--------------------------------------
SELECT a.first_name || ' ' || a.last_name "Employee", a.hire_date "Emp hired", 
       b.first_name || ' ' || b.last_name "Manager", b.hire_date "Mgr hired"
FROM employees a JOIN employees b ON(a.manager_id = b.employee_id)
AND a.hire_date < b.hire_date;
