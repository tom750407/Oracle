# 3-單行函數、轉換函數和條件表達式
### 1.編寫一個查詢，使其顯示當前日期，將列名命名為Date。
- dual是系統提供的一個虛擬表
- SYSDATE是用來查詢系統目前的時間
- TO_DATE()函數能將日期改成想要的格式但不包括時間
- TO_CHAR()函數能將日期跟時間轉換成字串顯示出來
	- **SELECT** SYSDATE "Date" **FROM** dual;
	- **SELECT** TO_DATE(SYSDATE,'YYYY/MM/DD') "Date" **FROM** dual;
	- **SELECT** TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS') "Date" **FROM** dual;
---
### 2.顯示每位員工的編號，姓氏，薪金和增加15%薪金之後薪金值（並將該列命名為New Salary）不允許輸出的結果中有空值。
- NVL(column_name, substitute value),因為帶有空值的計算不管如何都會得到空值,所以必須將空值先轉換為非null的值
	- **SELECT** employee_id, last_name, salary * (NVL(commission_pct, 0) + 1) "Old Salary", salary * (NVL(commission_pct, 0) + 1 + 0.15) "New Salary" **FROM** employees;
---
### 3.顯示每位員工的編號，姓氏，薪金和增加15%薪金之後薪金值（並將該列命名為New Salary），添加一個列，命名為Increase，該列是從增加了15%工資以後的列，減去原有的工資，即工資實際漲了多少。同樣要求，該查詢結果中，不允許有空值。
- **SELECT** employee_id, last_name, salary * (NVL(commission_pct, 0) + 1) "Old Salary", salary * (NVL(commission_pct, 0) + 1 + 0.15) "New Salary", salary * (NVL(commission_pct, 0) + 0.15) "Increase" **FROM** employees;
---
### 4.編寫一個查詢，顯示姓氏以J、A或M開始的所有員工的姓氏，要求第一個字母大寫，所有其它字母小寫，並顯示姓名的長度。
- INITCAP()函數作用在於將字串的首字符變為大寫
- LENGTH()函數是統計字符長度
- UPPER()函數是將字串全部字符變為大寫,
- SUBSTR(column_name, starting_index, length)這個函數是字串刪減,裡面包含了三個參數,第一個是要做字串刪減的資料,第二個是一個從1開始的index,刪減這個索引前的字符,第三個是刪減後保留字符的長度
	- **SELECT** INITCAP(last_name), LENGTH(last_name) **FROM** employees **WHERE** UPPER(SUBSTR(last_name, 1, 1)) IN ('J', 'A', 'M');
---
### 5.顯示每位員工的姓氏，併計算今天和員工入職日期之間的月數。將該列命名為MONTHS_WORKED。按入職的月數進行排序。輸出結果要求是進行四捨五入後的整數結果。
- ROUND()後面接一個數字,四捨五入後給出整數
- months_between(first_date, second_date)用來算出兩個日期中間差了多少個月
	- **SELECT** last_name, ROUND((SYSDATE - hire_date) / 31) month_worked **FROM** employees **ORDER BY** hire_date;
	- **SELECT** last_name, ROUND(months_between(SYSDATE, hire_date)) month_worked **FROM** employees **ORDER BY** hire_date;
---
### 6.編寫一個查詢，為每個員工產生如下內容
### <員工姓氏> 現在的薪水是 <工資> 每月 他期望他能拿到每月<3倍工資>。將該列命名為 Dream Salaries。例如：
### King 現在的薪水是 $24,000.00 每月 他期望他能拿到每月$72,000.00。
- **SELECT** last_name || ' earn ' || to_char(salary, '$99,999.00') || ' per month, and he/she expects to earn $' || to_char(salary * 3, '$99,999.00') || ' as his/her dream salaries' "Dream Salaries" **FROM** employees;
