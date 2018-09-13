SELECT COUNT(*) "TOTAL", 
       SUM(CASE TO_CHAR(hire_date, 'YYYY') WHEN '2003' THEN 1 END) "2003",
       SUM(CASE TO_CHAR(hire_date, 'YYYY') WHEN '2005' THEN 1 END) "2005",
       SUM(CASE TO_CHAR(hire_date, 'YYYY') WHEN '2007' THEN 1 END) "2007"
FROM employees;
-----------------------------------------------------------
SELECT (SELECT COUNT(*) FROM employees) "TOTAL",
       (SELECT COUNT(*) FROM employees WHERE TO_CHAR(hire_date, 'YYYY')=2003) "2003",
       (SELECT COUNT(*) FROM employees WHERE TO_CHAR(hire_date, 'YYYY')=2005) "2005",
       (SELECT COUNT(*) FROM employees WHERE TO_CHAR(hire_date, 'YYYY')=2007) "2007"
FROM dual;
