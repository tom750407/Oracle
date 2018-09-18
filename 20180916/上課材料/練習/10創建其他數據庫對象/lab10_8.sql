CREATE OR REPLACE VIEW salary_vu AS
SELECT a.last_name "Employee", b.department_name "Department", a.salary "Salary", c.grade "Grade"
FROM employees a JOIN departments b ON(a.department_id = b.department_id)
                 JOIN job_grades c ON(a.salary BETWEEN c.lowest_sal AND c.highest_sal);
