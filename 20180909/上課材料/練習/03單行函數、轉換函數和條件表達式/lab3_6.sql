SELECT last_name || ' earn ' || to_char(salary, '$99,999.00') 
       || ' per month, and he/she expects to earn $'
       || to_char(salary * 3, '$99,999.00') 
       || ' as his/her dream salaries' "Dream Salaries"
FROM employees;
