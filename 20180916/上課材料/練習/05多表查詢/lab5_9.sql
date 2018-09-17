SELECT a.first_name || ' ' || a.last_name, a.job_id, b.department_name, c.city, d.grade
FROM employees a JOIN departments b ON(a.department_id = b.department_id)
                 JOIN locations c ON(b.location_id = c.location_id)
                 JOIN job_grades d ON(a.salary BETWEEN d.lowest_sal AND d.highest_sal)
ORDER BY 5;
