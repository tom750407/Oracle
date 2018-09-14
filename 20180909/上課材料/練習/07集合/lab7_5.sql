SELECT a.employee_id, a.job_id, b.job_id
FROM employees a JOIN job_history b ON(a.employee_id = b.employee_id)
MINUS
SELECT a.employee_id, a.job_id, b.job_id
FROM employees a JOIN employees b ON (a.employee_id = b.employee_id);
