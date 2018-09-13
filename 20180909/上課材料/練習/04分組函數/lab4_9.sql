SELECT manager_id, MIN(salary) min_salary
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) > 6000
ORDER BY min_salary DESC;
