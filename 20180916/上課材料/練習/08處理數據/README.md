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

---
### 4.確認MY_EMPLOYEE表中的結果

---
### 5.將剛才添加的數據永久化。

---
### 6.將員工3的姓氏改為Drexler

---
### 7.將工資低於900的員工工資改為1000

---
### 8.驗證對表所做的更改

---
### 9.將Betty Dancs從MY_EMPLOYEE表中刪除

---
### 10.確認對表的修改
