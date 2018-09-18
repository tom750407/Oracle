DECLARE
nsalary number(20) := &salary;
BEGIN
UPDATE my_emp SET salary = nsalary WHERE salary < 900;
END;
/
COMMIT;
EXIT;
