DELETE FROM my_emp
WHERE (TRIM(first_name) || ' ' || TRIM(last_name)) = 'Betty Dancs';
COMMIT;
