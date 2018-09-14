SELECT b.last_name || ' ' || b.first_name, b.hire_date
FROM employees a JOIN employees b ON(b.hire_date > a.hire_date)
WHERE a.last_name || ' ' || a.first_name = 'Grant Kimberely';
--------------------------------------
SELECT last_name || ' ' || first_name, hire_date 
FROM employees 
WHERE hire_date > (SELECT hire_date
                   FROM employees
                   WHERE last_name || ' ' || first_name ='Grant Kimberely')
