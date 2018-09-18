CREATE TABLE dept2 AS
SELECT *
FROM departments;

INSERT INTO dept2 (department_id, department_name)
VALUES(dept_id_seq.nextval, '&name');
COMMIT;

SELECT * FROM dept2;
