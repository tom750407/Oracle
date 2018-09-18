# 10-創建其他數據庫對象
### 1.基於EMPLOYEES表中的員工編號、員工姓名和部門編號，創建一個名為EMPLOYEES_VU的視圖，要求視圖中員工姓名的列命名為EMPLOYEE。
- **CREATE OR REPLACE VIEW** employees_vu AS **SELECT** employee_id, TRIM(last_name) || ' ' || TRIM(first_name) employee, department_id **FROM** employees;
---
### 2.顯示EMPLOYEES_VU視圖的內容及視圖的結構。
- 在command window中輸入**DESC** employees_vu
- 在sql window中輸入**SELECT** * **FROM** employees_vu;
---
### 3.從USER_VIEWS數據字典中查看我們剛才創建的視圖。
- **SELECT** * **FROM** user_views **WHERE** view_name = 'EMPLOYEES_VU';
---
### 4.使用EMPLOYEES_VU視圖，創建一個查詢，使其顯示所有員工的員工姓名和部門編號。
- **SELECT** employee, department_id **FROM** employees_vu;
---
### 5.創建一個名為DEPT50的視圖，其中包含部門50中所有員工的員工編號、員工姓氏和部門編號以及部門名稱，將視圖的各列命名為EMPNO、EMPLOYEE、DEPTNO和DEPTNAME。不允許通過該視圖將員工重新分配給其它部門。
- **CREATE OR REPLACE VIEW** dept50 AS **SELECT** employee_id empno, last_name employee, department_id deptno, department_name deptname **FROM** employees JOIN departments USING(department_id) **WHERE** department_id = 50 **WITH CHECK OPTION**;
---
### 6.顯示DEPT50視圖的結構和內容。
- 在command window中輸入**DESC** dept50
- 在sql window中輸入**SELECT** * **FROM** dept50;
---
### 7.嘗試將Matos重新分配給部門80.
- **UPDATE** dept50 **SET** deptno = 80 **WHERE** employee = 'Matos';
---
### 8.基於所有員工的員工姓氏、部門名稱、薪金和薪金等級，創建一個名為SALARY_VU的視圖，各列命名為Employee、Department、Salary和Grade。
- **CREATE OR REPLACE VIEW** salary_vu AS **SELECT** a.last_name "Employee", b.department_name "Department", a.salary "Salary", c.grade "Grade" **FROM** employees a JOIN departments b ON(a.department_id = b.department_id) JOIN job_grades c ON(a.salary BETWEEN c.lowest_sal AND c.highest_sal);
---
### 9.創建一個用於DEPT表的主鍵列的序列。該序列從200開始，最大值為1000，序號增量為10.將該序列命名為DEPT_ID_SEQ.
- **CREATE SEQUENCE** dept_id_seq **START WITH** 200 **INCREMENT BY** 10 **MAXVALUE** 1000 **NOCYCLE**;
---
### 10.編寫一個查詢，使其顯示有關序列的以下信息：序列名、最大值、增量值和最後編號。
- **SELECT** sequence_name, max_value, increment_by, last_number **FROM** User_Sequences **WHERE** sequence_name = 'DEPT_ID_SEQ';
---
### 11.準備DEPT2表，準備的語句Create table dept2 as select * from departments;使其在表DEPT中插入兩行，要求插入時使用我們為ID列創建的序列。添加兩個名為Education和Administration的部門。確認添加的內容。
- **CREATE TABLE** dept2 AS **SELECT** * **FROM** departments;
- **INSERT INTO** dept2 (department_id, department_name) **VALUES**(dept_id_seq.nextval, '&name');
- **COMMIT**;
- **SELECT** * **FROM** dept2;
