SELECT last_name, first_name, job_id, salary
FROM employees
WHERE (job_id = UPPER('sa_rep') OR job_id = UPPER('st_clerk')) AND (salary != 2500 AND salary != 3500 AND salary != 7000);
-------------------------------------------
SELECT last_name, first_name, job_id, salary
FROM employees
WHERE salary NOT IN (2500,3500,7000) AND job_id IN('SA_REP','ST_CLERK');
