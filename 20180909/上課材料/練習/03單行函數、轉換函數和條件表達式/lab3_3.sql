SELECT employee_id, last_name, 
       salary * (NVL(commission_pct, 0) + 1) "Old Salary", 
       salary * (NVL(commission_pct, 0) + 1 +0.15) "New Salary", 
       salary * (NVL(commission_pct,0) + 0.15) "Increase"
FROM employees;
