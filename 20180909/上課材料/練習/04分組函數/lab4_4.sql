SELECT MAX(salary) "Maximum", MIN(salary) "Minimum", SUM(salary) "Sum", TRUNC(AVG(salary)) "Average"
FROM employees
ORDER BY 4;
