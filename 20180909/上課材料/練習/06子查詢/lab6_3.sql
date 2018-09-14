SELECT employee_id, last_name, department_id
FROM employees
WHERE department_id IN (SELECT department_id
                       FROM employees
                       WHERE INSTR(last_name, 'u', 1, 1) > 0
                       AND INSTR(last_name, 'u', 1, 2) = 0)
AND (last_name NOT LIKE '%u%'
OR INSTR(last_name, 'u', 1, 2) > 0);
