SELECT employee_id, last_name, salary
FROM employees
WHERE department_id IN(SELECT department_id
                       FROM employees
                       WHERE last_name LIKE '%u%')
AND salary > (SELECT AVG(salary)
              FROM employees);
