SELECT job_id, MAX(salary) "Maximum", MIN(salary) "Minimum", SUM(salary) "Sum", TRUNC(AVG(salary)) "Average"
FROM employees
GROUP BY job_id
ORDER BY job_id;
