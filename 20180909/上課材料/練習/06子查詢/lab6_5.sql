SELECT a.last_name, a.salary, a.manager_id, b.last_name
FROM employees a JOIN employees b ON(a.manager_id = b.employee_id)
WHERE a.manager_id IN(SELECT employee_id
                    FROM employees
                    WHERE last_name = 'King');
