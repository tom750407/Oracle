# SQL練習答案

1-編寫基本的SQL
---
1.判斷下面的 SELECT 語句是是否能執行成功
SELECT last_name,job,salary as Sal FROM employees;

- 不能成功,因為employees表內沒有job這一列

2.判斷下面的 SELECT 語句是否能執行成功
SELECT * FROM job_grades;

+ 不能成功,因為沒有job_grades這張表

3.下面語句中，有幾處錯誤
SELECT employee_id,last_name,
sal x 12 ANNUAL SALARY
FROM employees;



4.顯示DEPARTMENTS的表結構，並從該表中選擇所有的數據



5.顯示EMPLOYEES的表結構，並創建一個查詢，顯示每位員工的姓氏、職務代碼、聘用日期和員工編號，並且首先顯示員工編號，為HIRE_DATE提供一個列別名STARTDATE，將你的SQL語句保存到lab1_5.sql中。
