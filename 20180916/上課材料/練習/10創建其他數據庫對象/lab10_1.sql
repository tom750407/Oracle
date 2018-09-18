CREATE OR REPLACE VIEW employees_vu AS
SELECT employee_id, TRIM(last_name) || ' ' || TRIM(first_name) employee, department_id
FROM employees;
