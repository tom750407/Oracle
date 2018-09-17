SELECT first_name || ' ' || last_name, hire_date 
FROM employees 
WHERE hire_date > (SELECT hire_date
                   FROM employees
                   WHERE first_name || ' ' || last_name ='Kimberely Grant')
--------------------------------------
SELECT b.first_name || ' ' || b.last_name, b.hire_date
FROM employees a JOIN employees b ON(b.hire_date > a.hire_date)
WHERE a.first_name || ' ' || a.last_name = 'Kimberely Grant';
