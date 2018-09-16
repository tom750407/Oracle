# 2-限制和排序
### 1.創建一個查詢,顯示工資超過12000的員工的姓氏和工資.
- **SELECT** last_name, salary **FROM** employees **WHERE** salary > 12000;
---
### 2.創建一個查詢,顯示員工號176的姓氏和部門編號.
- **SELECT** last_name, department_id **FROM** employees **WHERE** employee_id = 176;
---
### 3.顯示工資不在5000至12000範圍內的所有員工的姓氏和工資.
- **SELECT** last_name, salary **FROM** employees **WHERE** salary NOT BETWEEN 5000 AND 12000;
---
### 4.顯示在2003年2月20日至2007年5月1日之間錄用的員工姓氏、職務和錄用日期,並按錄用日期進行升序排序.
- 時間的預設格式是DD-MON-YY,根據語言的不同MON輸入的格式不同,這裡使用英文的月份的前三個字母.另一個方式是用TO_DATE改變時間格式
	- **SELECT** last_name, job_id, hire_date **FROM** employees **WHERE** hire_date BETWEEN TO_DATE('2003/02/20', 'YYYY/MM/DD') AND TO_DATE('2007/05/01', 'YYYY/MM/DD') **ORDER BY** hire_date ASC;
	- **SELECT** last_name, job_id, hire_date **FROM** employees **WHERE** hire_date BETWEEN '20-FEB-2003' AND '01-MAY-2007' **ORDER BY** hire_date ASC;
---
### 5.按姓名的字母順序顯示部門20和部門90的所有員式的姓氏和部門編號.
- **SELECT** last_name, department_id **FROM** employees **WHERE** department_id = 20 OR department_id = 90 **ORDER BY** last_name;
---
### 6.列出工資在5000到12000之間,並且部門是20或者50的員工姓氏和工資,分別將列標記為“Employee”和“Monthly Salary”.
- **SELECT** last_name "Employee", salary "Monthly Salary" **FROM** employees **WHERE** (salary BETWEEN 5000 AND 12000) AND (department_id = 20 OR department_id = 50); 
---
### 7.顯示在2004年錄用的每位員工的姓氏和錄用日期.
- 顯示某一年或者多年內可以用BETWEEN將兩個日期作為條件,或者使用extract()這個函數
	- **SELECT** last_name, hire_date **FROM** employees **WHERE** extract (YEAR from hire_date) = 2004;
	- **SELECT** last_name, hire_date **FROM** employees **WHERE** hire_date BETWEEN '01-JAN-2004' AND '31-DEC-2004';
---
### 8.顯示沒有經理的所有員工的姓氏和職稱.
- **SELECT** last_name, job_id **FROM** employees **WHERE** manager_id IS NULL;
---
### 9.顯示有獎金可拿的所有員工的姓氏、工資和獎金提成比率,並按工資和獎金提成比率進行降序排序.
- **SELECT** last_name, salary, commission_pct **FROM** employees **WHERE** commission_pct IS NOT NULL **ORDER BY** salary, commission_pct DESC;
---
### 10.顯示員工姓氏中第三個字母為“a”的所有員工的姓名和姓氏.
- **SELECT** first_name, last_name **FROM** employees **WHERE** last_name LIKE '__a%';
---
### 11.顯示員工姓氏中有“a”和“e”的所有員工的姓氏和姓名.
- **SELECT** last_name, first_name **FROM** employees **WHERE** last_name LIKE '%a%' AND last_name LIKE '%e%';
---
### 12.顯示職務為sa_rep和st_clerk,且工資不等於2500,3500和7000的所有員工的姓氏,姓名、職務和工資.
- 當有多個條件的時候可以使用IN或NOT IN這樣可以少寫很多,效能也會好很多
	- **SELECT** last_name, first_name, job_id, salary **FROM** employees **WHERE** (job_id = UPPER('sa_rep') OR job_id = UPPER('st_clerk')) AND (salary != 2500 AND salary != 3500 AND salary != 7000);
	- **SELECT** last_name, first_name, job_id, salary **FROM** employees **WHERE** salary NOT IN (2500,3500,7000) AND job_id IN('SA_REP','ST_CLERK');
---
### 13.顯示獎金提成為20%的所有員工的姓氏、姓名、工資和獎金.
- **SELECT** last_name, first_name, salary, salary *  commission_pct **FROM** employees **WHERE** commission_pct = 0.2;
