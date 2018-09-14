# 07-集合
### 1.列出不包含職務ST_CLERK的所有部門ID.
- **SELECT** department_id **FROM** employees MINUS **SELECT** department_id **FROM** employees **WHERE** job_id = 'ST_CLERK';
---
### 2.顯示沒有設立部門的國家代碼和國家名稱.
- **SELECT** country_id, country_name **FROM** countries JOIN locations USING(country_id) **WHERE** location_id IN(**SELECT** location_id **FROM** locations MINUS **SELECT** location_id **FROM** departments) MINUS **SELECT** country_id, country_name **FROM** countries JOIN locations USING(country_id) **WHERE** location_id IN (**SELECT** location_id **FROM** departments);
- **SELECT** country_id, country_name **FROM** locations JOIN countries USING(country_id) MINUS **SELECT** country_id, country_name **FROM** locations JOIN countries USING(country_id) JOIN departments USING(location_id);
---
### 3.不使用DISTINCT,輸出設立有部門的國家代碼.
- **SELECT** country_id, country_name **FROM** countries JOIN locations USING(country_id) **WHERE** location_id IN(**SELECT** location_id **FROM** departments) INTERSECT **SELECT** country_id, country_name **FROM** countries;
- **SELECT** country_id, country_name **FROM** locations JOIN countries USING(country_id) INTERSECT **SELECT** country_id, country_name **FROM** locations JOIN countries USING(country_id) JOIN departments USING(location_id);
---
### 4.創建一個查詢,顯示部門10,50,20部門所包含的職務和部門ID,要求部門顯示的順序以10,50,20顯示.
- **SELECT** job_id, department_id **FROM** employees **WHERE** department_id = 10 UNION ALL **SELECT** job_id, department_id **FROM** employees **WHERE** department_id = 50 UNION ALL **SELECT** job_id, department_id **FROM** employees **WHERE** department_id = 20;
---
### 5.列出哪些員工,從事當前職務之前,還在公司任職過其它職務,輸出該員工的ID,以及以前任職的其它職務的ID.
- **SELECT** a.employee_id, a.job_id, b.job_id **FROM** employees a JOIN job_history b ON(a.employee_id = b.employee_id) MINUS **SELECT** a.employee_id, a.job_id, b.job_id **FROM** employees a JOIN employees b ON (a.employee_id = b.employee_id);
---
### 6.整合以下兩個查詢,合併成一個輸出.
### 1）顯示所有員工的姓氏和部門ID,不管該員工是否有部門.
### 2）顯示所有部門的ID和部門名稱,不管該部門是否有員工.
- **SELECT** last_name, department_id, TO_CHAR(NULL) department_name **FROM** employees UNION **SELECT** TO_CHAR(NULL), department_id, department_name **FROM** departments;
