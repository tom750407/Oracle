DECLARE
name varchar(50) :='&name';
BEGIN
DELETE FROM my_emp WHERE (TRIM(first_name) || ' ' || TRIM(last_name)) = name;
END;
/
COMMIT;
EXIT;
