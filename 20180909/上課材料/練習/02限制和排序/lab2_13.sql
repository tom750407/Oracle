SELECT last_name, first_name, salary, salary * (commission_pct + 1)
FROM employees
WHERE commission_pct = 0.2;
