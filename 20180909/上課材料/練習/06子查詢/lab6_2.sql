SELECT employee_id, last_name, department_name, city
FROM employees a JOIN departments b ON(a.department_id = b.department_id)
                 JOIN locations c ON(b.location_id = c.location_id)
WHERE (salary * (NVL(commission_pct, 0) + 1)) * 12 > 
      (SELECT AVG((salary * (NVL(commission_pct, 0) + 1)) * 12)
       FROM employees);
