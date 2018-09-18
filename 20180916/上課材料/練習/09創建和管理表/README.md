# 09-創建和管理表
### 1.基於以下表格創建表DEPT
| 列名	       | ID     | NAME     |
| ----         | --     | ----     |
| 是否允许为空 | 允许   | 允许     |
| 是否允许重复 | 允许   | 允许     |
| 是否为外键列 | 否     | 否       |
| 数据类型     | NUMBER | VARCHAR2 |
| 长度	       | 7      | 25       |
 - **CREATE TABLE** dept (empid NUMBER(7), empname VARCHAR2(25));
---
### 2.用DEPARTMENTS表的數據填充DEPT表（department_id對應id，department_name對就name）。
- **INSERT INTO** dept **SELECT** d.department_id, d.department_name **FROM** departments d;
- **COMMIT**;
---
### 3.基於以下表格創建表EMP。
| 列名         | ID     | LAST_NAME | FIRST_NAME | DEPT_ID  |
| ----         | --     | --------- | ---------- | -------  |
| 是否允许为空 | 允许   | 允许      | 允许       | 允许     |
| 是否允许重复 | 允许   | 允许      | 允许       | 允许     |
| 是否为外键列 | 否     | 否        | 否         | 否       |
| 数据类型     | NUMBER | VARCHAR2  | VARCHAR2   | VARCHAR2 |
| 长度         | 7      | 25        | 25         | 7        |
- **CREATE TABLE** emp (empid NUMBER(7), last_name VARCHAR2(25), first_name VARCHAR2(25), deptid VARCHAR2(7))
---
### 4.修改EMP表，從而允許輸入更長的員工姓氏，由原來25個字符長度改為50
- **ALTER TABLE** emp **MODIFY**(last_name VARCHAR2(50));
---
### 5.確認DEPT和EMP表都在數據字典USER_TABLES中。
- **SELECT** * **FROM** user_tables **WHERE** table_name IN ('EMP','DEPT');
---
### 6.根據EMPLOYEES表中的數據填充EMP表，對應關係employee_id對應id，last_name對應last_name，first_name對應first_name，depart_id對應dept_id。
- **INSERT INTO** emp **SELECT** e.employee_id, e.last_name, e.first_name, TO_CHAR(e.department_id) **FROM** employees e;
- **COMMIT**;
---
### 7.刪除EMP表。
- **DROP TABLE** emp;
---
### 8.根據表EMPLOYEES表創建表EMPLOYEES2。僅包含EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY和DEPARTMENT_ID。將新表的名列分別命名為ID、FIRST_NAME、LAST_NAME、SALARY和DEPT_ID。
- **CREATE TABLE** employees2 (empid, first_name, last_name, salary, deptid) AS **SELECT** employee_id, first_name, last_name, salary, department_id **FROM** employees;
---
### 9.將EMPLOYEES2重命名為EMP。
- **ALTER TABLE** employees2 **RENAME TO** emp;
---
### 10.給DEPT和EMP兩表添加備註，’create from departments’和’create from employees’
- **COMMENT ON TABLE** dept IS 'create from departments';
- **COMMENT ON TABLE** emp IS 'create from employees';
---
### 11.給EMP表的ID列添加PRIMARY KEY約束，給該約束命名為my_emp_id_pk。
- **ALTER TABLE** emp **ADD CONSTRAINT** my_emp_id_pk **PRIMARY KEY**(empid);
---
### 12.為DEPT表的ID列添加PRIMARY KEY約束，命名為my_dept_id_pk。
- **ALTER TABLE** dept **ADD CONSTRAINT** my_dept_id_pk **PRIMARY KEY**(deptid);
---
### 13.將DEPT表的ID列作為EMP表的引用列，創建相關約束，確保不會將員工分配到不存在的部門。將約束命名為my_emp_dept_id_fk。
- **ALTER TABLE** emp **ADD CONSTRAINT** my_emp_dept_id_fk **FOREIGN KEY**(deptid) **REFERENCES** dept(deptid);
---
### 14.通過查詢數據字典user_constraints，確認前幾題添加的約束。
- **SELECT** * **FROM** user_constraints **WHERE** table_name IN('EMP','DEPT');
---
### 15.為EMP表，增加一個列COMMISSION，該列不允許為空值，默認值為0，該列數據類型為NUMBER，小數位2位，數位長度為2。
- **ALTER TABLE** emp **ADD**(commission NUMBER(2,2) DEFAULT 0 NOT NULL);
