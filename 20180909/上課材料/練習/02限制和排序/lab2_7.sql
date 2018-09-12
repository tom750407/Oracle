SELECT last_name, hire_date
FROM employees
WHERE extract (YEAR from hire_date) = 2004;
-----------------------------------------------
SELECT last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '01-JAN-2004' AND '31-DEC-2004';
