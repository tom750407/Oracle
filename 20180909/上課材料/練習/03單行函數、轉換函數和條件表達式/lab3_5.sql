SELECT last_name, ROUND((SYSDATE - hire_date) / 30.5) month_worked
FROM employees
ORDER BY hire_date;
-----------------------------------------
SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) month_worked
FROM employees
ORDER BY hire_date;
