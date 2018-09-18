INSERT INTO emp
SELECT e.employee_id, e.last_name, e.first_name, TO_CHAR(e.department_id)
FROM employees e;
COMMIT;
