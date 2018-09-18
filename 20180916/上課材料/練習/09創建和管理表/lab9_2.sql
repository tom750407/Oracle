INSERT INTO dept
SELECT d.department_id, d.department_name
FROM departments d;
COMMIT;
