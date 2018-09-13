SELECT UPPER(last_name) || ' ' || LPAD(salary * (NVL(commission_pct, 0) + 1), 15, '$')
FROM employees;
