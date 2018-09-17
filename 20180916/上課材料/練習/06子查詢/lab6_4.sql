SELECT last_name, department_id, job_id
FROM employees JOIN departments USING(department_id)
WHERE location_id = 1700;
-----------------------------------
SELECT last_name, department_id, job_id
FROM employees
WHERE department_id IN(SELECT department_id
                       FROM departments
                       WHERE location_id = 1700);
