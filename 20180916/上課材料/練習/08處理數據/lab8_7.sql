-- 7. Insert employee 5 --
INSERT INTO my_emp(empid, last_name, first_name, Userid, salary)
VALUES (5, 'Ropeburn', 'Audrey',  LOWER(SUBSTR('Audrey', 1, 1)) || LOWER(SUBSTR('Ropeburn', 1, 7)),1550);
SELECT * FROM my_emp;
-- 8. Update salary to 3000 where salary is 1550 --
UPDATE my_emp
SET salary = 3000
WHERE salary = 1550;
SELECT * FROM my_emp;
-- 9. Update last name to Biri for employee 3 --
UPDATE my_emp
SET last_name = 'Biri'
WHERE empid = 3;
SELECT * FROM my_emp;
-- 10. Delete Ben Biri this row --
DELETE FROM my_emp
WHERE TRIM(first_name) || ' ' || TRIM(last_name) = 'Ben Biri';
SELECT * FROM my_emp;
-- Set savepoint a
SAVEPOINT a;
-- 11. ADD Betty Dancs --
INSERT INTO my_emp(empid, last_name, first_name, Userid, salary)
VALUES (2, 'Dancs', 'Betty',  LOWER(SUBSTR('Betty', 1, 1)) || LOWER(SUBSTR('Dancs', 1, 7)),860);
SELECT * FROM my_emp;
-- 12. Rollback before step 11 --
ROLLBACK TO SAVEPOINT a;
SELECT * FROM my_emp;
-- 13. Commit all the change --
COMMIT;
SELECT * FROM my_emp;
