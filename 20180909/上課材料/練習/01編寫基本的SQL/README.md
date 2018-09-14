# 1-編寫基本的SQL
### 1.判斷下面的SELECT語句是是否能執行成功
### SELECT last_name, job, salary as Sal FROM employees;
- 不能成功
        - 因為employees表內沒有job這一列
---
### 2.判斷下面的SELECT語句是否能執行成功
### SELECT * FROM job_grades;
- 不能成功
        - 因為沒有job_grades這張表
---
### 3.下面語句中,有幾處錯誤
### SELECT employee_id, last_name, sal x 12 ANNUAL SALARY FROM employees;
- 2處錯誤
	- 首先是employees表內沒有sal這一列,所以sal x 12會報錯
	- 再來就是alias如果是多個單字要加雙引號
---
### 4.顯示DEPARTMENTS的表結構,並從該表中選擇所有的數據.
- 在command window中輸入**DESC** departments
- 在sql window中輸入**SELECT** * **FROM** departments;
---
### 5.顯示EMPLOYEES的表結構,並創建一個查詢,顯示每位員工的姓氏、職務代碼、聘用日期和員工編號,並且首先顯示員工編號,為HIRE_DATE提供一個列別名STARTDATE.
- 在command window中輸入**DESC** employees
- 在sql window中輸入**SELECT** employee_id, first_name, job_id, hire_date startdate From employees;
---
### 6.創建一個查詢,以顯示EMPLOYEES表中唯一的職務代碼.
- **SELECT** DISTINCT job_id **FROM** employees;
---
### 7.顯示每位員工的姓氏、職務代碼、聘用日期和員工編號,並設置別名為”Emp #”、”Employess”、”Job”和”Hire Date”.
- **SELECT** employee_id "Emp #", first_name "Employees", job_id "Job", hire_date "Hire Date" **FROM** employees;
---
### 8.顯示姓氏並連接該僱員的職務,它們之間用逗號和空格做分隔,然後為該輸出的列設置別名”Employee and Title”.
- **SELECT** first_name || ', ' || job_id "Employee and Title" **FROM** employees;
---
### 9.創建一個查詢,顯示EMPLOYEES表中所有的數據,用逗號分隔輸出的所有列,並設置別名“THE_OUTPUT”.
- **SELECT** employee_id || ',' || first_name || ',' || last_name || ',' || email || ',' || phone_number || ',' || hire_date || ',' || job_id || ',' || salary || ',' || commission_pct || ',' || manager_id || ',' || department_id the_output **FROM** employees;
