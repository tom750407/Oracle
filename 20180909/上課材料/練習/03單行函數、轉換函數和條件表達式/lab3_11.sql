SELECT RPAD(last_name, LENGTH(last_name) + 
       TRUNC(salary * (NVL(commission_pct, 0) + 1) / 1000), '*') employees_and_their_salaries
FROM employees;
