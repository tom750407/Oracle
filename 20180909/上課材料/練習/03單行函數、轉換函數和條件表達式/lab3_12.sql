SELECT last_name, job_id "Job", 
       DECODE ((job_id),
                'AD_PRES', 'A',
                'ST_MAN', 'B',
                'IT_PROG', 'C',
                'SA_REP', 'D',
                'ST_CLERK', 'E',
                'O') "Grade"
FROM employees;
