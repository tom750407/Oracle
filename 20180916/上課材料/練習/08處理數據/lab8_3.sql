INSERT INTO my_emp
VALUES(&empid, '&last_name', '&first_name', LOWER(SUBSTR('&first_name',1 , 1)) || LOWER(SUBSTR('&last_name', 1, 7)), &salary);
COMMIT;
