SELECT department_id "Deptno", COUNT(*) "Number of People", TRUNC(AVG(salary), 2) "Avg of Salary"
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY 1;
