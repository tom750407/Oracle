# 2-限制和排序
### 1.創建一個查詢，顯示工資超過12000的員工的姓氏和工資。
- **SELECT** last_name, salary **FROM** employees **WHERE** salary > 12000;
---
### 2.創建一個查詢，顯示員工號176的姓氏和部門編號
- **SELECT** last_name, department_id **FROM** employees **WHERE** employee_id = 176;
---
### 3.顯示工資不在5000至12000範圍內的所有員工的姓氏和工資。
- **SELECT** last_name, salary **FROM** employees **WHERE** salary NOT **BETWEEN** 5000 **AND** 12000;
---
### 4.顯示在2003年2月20日至2007年5月1日之間錄用的員工姓氏、職務和錄用日期，並按錄用日期進行升序排序。
- 時間的預設格式是DD-MON-YY,根據語言的不同MON輸入的格式不同,這裡使用英文的月份的前三個字母.另一個方式是用TO_DATE改變時間格式
	- **SELECT** last_name, job_id, hire_date **FROM** employees **WHERE** hire_date **BETWEEN** TO_DATE('2003/02/20', 'YYYY/MM/DD') **AND** TO_DATE('2007/05/01', 'YYYY/MM/DD') **ORDER BY** hire_date ASC;
	- **SELECT** last_name, job_id, hire_date **FROM** employees **WHERE** hire_date **BETWEEN** '20-FEB-2003' **AND** '01-MAY-2007' **ORDER BY** hire_date ASC;
---
### 5.按姓名的字母順序顯示部門20和部門90的所有員式的姓氏和部門編號。

---
### 6.列出工資在5000到12000之間，並且部門是20或者50的員工姓氏和工資，分別將列標記為“Employee”和“Monthly Salary”。

---
