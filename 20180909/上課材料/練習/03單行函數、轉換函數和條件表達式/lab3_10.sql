SELECT last_name, NVL(TO_CHAR(commission_pct,'0.00'), 'No commission') comm
FROM employees;
