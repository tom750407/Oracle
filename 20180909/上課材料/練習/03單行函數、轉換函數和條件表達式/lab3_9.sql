SELECT last_name, hire_date, TO_CHAR(hire_date, 'DAY') day
FROM employees
ORDER BY TO_CHAR(hire_date -1, 'D');
------------------------------------------------
SELECT last_name, hire_date, TO_CHAR(hire_date, 'DAY') day
FROM employees
ORDER BY
CASE TO_CHAR(hire_date, 'fmDAY')
  WHEN 'MONDAY' THEN 1
  WHEN 'TUESDAY' THEN 2
  WHEN 'WEDNESDAY' THEN 3
  WHEN 'THURSDAY' THEN 4
  WHEN 'FRIDAY' THEN 5
  WHEN 'SATURDAY' THEN 6
  WHEN 'SUNDAY' THEN 7 END;
