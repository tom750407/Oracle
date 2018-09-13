SELECT SYSDATE "Date"
FROM dual;
-------------------------------------------
SELECT TO_DATE(SYSDATE,'YYYY/MM/DD') "Date"
FROM dual;
-------------------------------------------
SELECT TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS') "Date"
FROM dual;
