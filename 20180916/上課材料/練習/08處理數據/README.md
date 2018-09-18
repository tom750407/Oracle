# 08-處理數據
### 1.將下面數據表中的第一行添加到MY_EMPLOYEE表中，不要在INSERT子句中，出現這些列名。
| EMPID | LAST_NAME | FIRST_NAME | USERID   | SALARY |
| ----- | --------- | ---------- | -------- | ------ |
| 1     | Patel	    | Ralph      | rpatel   | 895    |
| 2     | Dancs	    | Betty      | bdancs   | 860    |
| 3     | Biri      | Ben        | bbiri    | 1100   |
| 4     | Newman    | Chad       | cnewman  | 750    |
| 5     | Ropeburn  | Audrey     | aropebur | 1550   |
- **INSERT INTO** my_emp **VALUES** (1, 'Patel', 'Ralph', 'rpatel', 895);
---
### 2.使用上述表的第二行數據添加到MY_EMPLOYEE表中，要求在INSERT子句中顯式的列出這些列名。
- **INSERT INTO** my_emp (empid, last_name, first_name, userid, salary) **VALUES** (2, 'Dancs', 'Betty', 'bdancs', 860);
---
### 3.要求，編寫一個腳本，名為loademp.sql，功能是在MY_EMPLOYEE表中插入示例表中的數據，要求使用替代變量，使該腳本可以被重複調用，並且USERID列，使用表達式構造出來，構造方法，將名字的第一個字母與姓氏的前7個字母連接起來，並且小寫。使用該腳本將示例數據中的第三、四行插入MY_EMPLOYEE表。
#### sql develop
- **INSERT INTO** my_emp **VALUES**(&empid, '&last_name', '&first_name', LOWER(SUBSTR('&first_name',1 , 1)) || LOWER(SUBSTR('&last_name', 1, 7)), &salary);
#### sql * plus
- undefine last_name;
- undefine first_name;
- **INSERT INTO** my_emp **VALUES**(&empid, '&&last_name', '&&first_name', LOWER(SUBSTR('&first_name', 1, 1)) || LOWER(SUBSTR('&last_name', 1, 7)), &salary);
#### pl
- DECLARE
- id number(38) :=&id;
- last_name char(25) :='&last_name';
- first_name char(25) :='&first_name';
- salary number(38) :=&salary;
- BEGIN
- **INSERT INTO** my_emp **VALUES**(id, last_name, first_name, LOWER(SUBSTR(first_name, 1, 1)) || LOWER(SUBSTR(last_name, 1, 7)), salary);
- END;
- /
---
### 4.確認MY_EMPLOYEE表中的結果
- **SELECT** * **FROM** my_emp;
---
### 5.將剛才添加的數據永久化。
- **COMMIT**
---
### 6.將員工3的姓氏改為Drexler
#### sql developer/sql * plus
- **UPDATE** my_emp **SET** last_name = 'Drexler' **WHERE** empid = 3;
#### pl
- DECLARE
- id number(20) :=&id;
- name varchar(20) :='&name';
- BEGIN
- **UPDATE** my_emp **SET** last_name = name **WHERE** empid = id;
- END;
- /
---
### 7.將工資低於900的員工工資改為1000
#### sql developer/sql * plus
- **UPDATE** my_emp **SET** salary = 1000 **WHERE** salary < 900;
#### pl
- DECLARE
- nsalary number(20) := &salary;
- BEGIN
- **UPDATE** my_emp **SET** salary = nsalary **WHERE** salary < 900;
- END;
- /
---
### 8.驗證對表所做的更改
- **SELECT** * **FROM** my_emp; 
---
### 9.將Betty Dancs從MY_EMPLOYEE表中刪除
- **DELETE** **FROM** my_emp **WHERE** (TRIM(first_name) || ' ' || TRIM(last_name)) = 'Betty Dancs';
---
### 10.確認對表的修改
- **SELECT** * **FROM** my_emp;
