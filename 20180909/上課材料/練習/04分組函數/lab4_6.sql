SELECT job_id, COUNT(job_id)
FROM employees
GROUP BY job_id;
