SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date
BETWEEN TO_DATE('2003/02/20', 'YYYY/MM/DD')
AND TO_DATE('2007/05/01', 'YYYY/MM/DD');
----------------------------------------------------------------
SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date
BETWEEN '20-FEB-2003'
AND '01-MAY-2007';
