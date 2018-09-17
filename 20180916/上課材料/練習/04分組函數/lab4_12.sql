SELECT job_id "Job",
       SUM(CASE department_id WHEN 20 THEN salary END) "Dept20",
       SUM(CASE department_id WHEN 50 THEN salary END) "Dept50",
       SUM(CASE department_id WHEN 80 THEN salary END) "Dept80",
       SUM(CASE department_id WHEN 90 THEN salary END) "Dept90",
       SUM(salary) "Total"
FROM employees
GROUP BY job_id
ORDER BY 1;
