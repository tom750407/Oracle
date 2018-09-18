DECLARE
id number(38) :=&id;
last_name char(25) :='&last_name';
first_name char(25) :='&first_name';
salary number(38) :=&salary;
BEGIN
INSERT INTO my_emp VALUES(id, last_name, first_name, LOWER(SUBSTR(first_name, 1, 1)) || LOWER(SUBSTR(last_name, 1, 7)), salary);
END;
/
COMMIT;
EXIT;
