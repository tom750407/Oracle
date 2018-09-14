SELECT employee_id, last_name, department_id, job_id
FROM employees
WHERE department_id IN(SELECT department_id
                     FROM departments JOIN locations USING(location_id)
                     WHERE city = 'Seattle')
AND job_id = (SELECT job_id
              FROM employees
              WHERE employee_id = 111);
