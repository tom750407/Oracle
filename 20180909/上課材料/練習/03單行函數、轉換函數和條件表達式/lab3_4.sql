SELECT INITCAP(last_name), LENGTH(last_name)
FROM employees
WHERE UPPER(SUBSTR(last_name,1,1)) IN ('J','A','M');
