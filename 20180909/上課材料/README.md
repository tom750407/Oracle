# SQL練習答案

1-編寫基本的SQL
---
1.判斷下面的 SELECT 語句是是否能執行成功
SELECT last_name, job, salary as Sal FROM employees;

- 不能成功
	- 因為employees表內沒有job這一列

2.判斷下面的 SELECT 語句是否能執行成功
SELECT * FROM job_grades;

- 不能成功
	- 因為沒有job_grades這張表

3.下面語句中，有幾處錯誤
SELECT employee_id, last_name,
sal x 12 ANNUAL SALARY
FROM employees;

- 2處錯誤
	- 首先是employees表內沒有sal這一列,所以sal x 12會報錯
	- 再來就是alias如果是多個單字要加雙引號

4.顯示DEPARTMENTS的表結構，並從該表中選擇所有的數據

- 在command window中輸入DESC departments
- 在sql window中輸入SELECT * FROM departments;

5.顯示EMPLOYEES的表結構，並創建一個查詢，顯示每位員工的姓氏、職務代碼、聘用日期和員工編號，並且首先顯示員工編號，為HIRE_DATE提供一個列別名STARTDATE。

- 在command window中輸入DESC employees
- 在sql window中輸入SELECT employee_id, first_name, job_id, hire_date startdate From employees;

6.執行第5題中的腳本

<img src="https://github.com/tom750407/Oracle/blob/master/20180909/%E4%B8%8A%E8%AA%B2%E6%9D%90%E6%96%99/src/lab1_5.sql%E5%9F%B7%E8%A1%8C%E7%B5%90%E6%9E%9C.png" width="500px">

7.創建一個查詢，以顯示EMPLOYEES表中唯一的職務代碼。

- SELECT DISTINCT job_id FROM employees;

8.第五題中的SQL語句，為需要查詢的列標題設置別名為”Emp #”、”Employess”、”Job”和”Hire Date”，並再次運行你的查詢

- SELECT employee_id "Emp #", first_name "Employees", job_id "Job", hire_date "Hire Date" FROM employees;

9.顯示姓氏並連接該僱員的職務，它們之間用逗號和空格做分隔，然後為該輸出的列設置別名”Employee and Title”

- SELECT first_name || ', ' || job_id "Employee and Title" FROM employees;

10.創建一個查詢，顯示EMPLOYEES表中所有的數據，用逗號分隔輸出的所有列，並設置別名“THE_OUTPUT”

- SELECT employee_id || ',' || first_name || ',' || last_name || ',' || email || ',' || phone_number || ',' || hire_date || ',' || job_id || ',' || salary || ',' || commission_pct || ',' || manager_id || ',' || department_id the_output FROM employees;

---
2-限制和排序
---
1.創建一個查詢，顯示工資超過12000的員工的姓氏和工資。

- SELECT last_name, salary FROM employees WHERE salary > 12000;

2.創建一個查詢，顯示員工號176的姓氏和部門編號

- SELECT last_name, department_id FROM employees WHERE employee_id = 176;


3.修改lab2_1.sql，使其顯示工資不在5000至12000範圍內的所有員工的姓氏和工資，並將該修改後的腳本另存為lab2_3.sql，使用腳本進行查詢。



4.顯示在2003年2月20日至2007年5月1日之間錄用的員工姓氏、職務和錄用日期，並按錄用日期進行升序排序。



5.按姓名的字母順序顯示部門20和部門90的所有員式的姓氏和部門編號。



6.修改lab2_3.sql，使其列出工資在5000到12000之間，並且部門是20或者50的員工姓氏和工資，分別將列標記為“Employee”和“Monthly Salary”。並將該修改過的腳本另存為lab2_6.sql。使用該腳本執行你的查詢。
