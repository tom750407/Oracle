DECLARE
id number(20) :=&id;
name varchar(20) :='&name';
BEGIN
UPDATE my_emp SET last_name = name WHERE empid = id;
END;
/
COMMIT;
EXIT;
