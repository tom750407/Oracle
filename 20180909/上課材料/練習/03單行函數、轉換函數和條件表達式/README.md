# 3-單行函數、轉換函數和條件表達式
### 1.編寫一個查詢,使其顯示當前日期,將列名命名為Date.
- dual是系統提供的一個虛擬表
- SYSDATE是用來查詢系統目前的時間
- TO_DATE()函數能將日期改成想要的格式但不包括時間
- TO_CHAR()函數能將日期跟時間轉換成字串顯示出來
	- **SELECT** SYSDATE "Date" **FROM** dual;
	- **SELECT** TO_DATE(SYSDATE,'YYYY/MM/DD') "Date" **FROM** dual;
	- **SELECT** TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS') "Date" **FROM** dual;
---
### 2.顯示每位員工的編號,姓氏,薪金和增加15%薪金之後薪金值（並將該列命名為New Salary）不允許輸出的結果中有空值.
- NVL(column_name, substitute value),因為帶有空值的計算不管如何都會得到空值,所以必須將空值先轉換為非null的值
	- **SELECT** employee_id, last_name, salary * (NVL(commission_pct, 0) + 1) "Old Salary", salary * (NVL(commission_pct, 0) + 1 + 0.15) "New Salary" **FROM** employees;
---
### 3.顯示每位員工的編號,姓氏,薪金和增加15%薪金之後薪金值（並將該列命名為New Salary）,添加一個列,命名為Increase,該列是從增加了15%工資以後的列,減去原有的工資,即工資實際漲了多少.同樣要求,該查詢結果中,不允許有空值.
- **SELECT** employee_id, last_name, salary * (NVL(commission_pct, 0) + 1) "Old Salary", salary * (NVL(commission_pct, 0) + 1 + 0.15) "New Salary", salary * (NVL(commission_pct, 0) + 0.15) "Increase" **FROM** employees;
---
### 4.編寫一個查詢,顯示姓氏以J、A或M開始的所有員工的姓氏,要求第一個字母大寫,所有其它字母小寫,並顯示姓名的長度.
- INITCAP()函數作用在於將字串的首字符變為大寫
- LENGTH()函數是統計字符長度
- UPPER()函數是將字串全部字符變為大寫,
- SUBSTR(column_name, starting_index, length)這個函數是字串刪減,裡面包含了三個參數,第一個是要做字串刪減的資料,第二個是一個從1開始的index,刪減這個索引前的字符,第三個是刪減後保留字符的長度
	- **SELECT** INITCAP(last_name), LENGTH(last_name) **FROM** employees **WHERE** UPPER(SUBSTR(last_name, 1, 1)) IN ('J', 'A', 'M');
---
### 5.顯示每位員工的姓氏,併計算今天和員工入職日期之間的月數.將該列命名為MONTHS_WORKED.按入職的月數進行排序.輸出結果要求是進行四捨五入後的整數結果.
- ROUND()後面接一個數字,四捨五入後給出整數
- MONTHS_BETWEEN(first_date, second_date)用來算出兩個日期中間差了多少個月
	- **SELECT** last_name, ROUND((SYSDATE - hire_date) / 30.5) month_worked **FROM** employees **ORDER BY** hire_date;
	- **SELECT** last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) month_worked **FROM** employees **ORDER BY** hire_date;
---
### 6.編寫一個查詢,顯示<員工姓氏> 現在的薪水是 <工資> 每月 他期望他能拿到每月<3倍工資>.將該列命名為 Dream Salaries.例如：
### King 現在的薪水是 $24,000.00 每月 他期望他能拿到每月$72,000.00.
- **SELECT** last_name || ' earn ' || to_char(salary, '$99,999.00') || ' per month, and he/she expects to earn $' || to_char(salary * 3, '$99,999.00') || ' as his/her dream salaries' "Dream Salaries" **FROM** employees;
---
### 7.創建一個查詢,顯示所有員工的姓氏和薪金.要求,姓氏要大寫,將薪金格式規定為15個字符長,左邊填充$,將該列命名為SALARY例如：
### KING $$$$$$$$$$24000
- **SELECT** UPPER(last_name) || ' ' || LPAD(salary * (NVL(commission_pct, 0) + 1), 15, '$') **FROM** employees
---
### 8.顯示每位員工的姓氏、入職日期和薪金復核日期,薪金復核日期是入職六個月的第一個星期一進行.將該列命名為REVIEW.規定這一日期格式,使其顯示樣式類似於”Monday,the Thirty-First of July,2000”.
- **SELECT** last_name, hire_date, TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date,6),'MONDAY'), 'fmDay, "the" Ddspth "of" Month, YYYY') review **FROM** employees;
---
### 9.顯示員工的姓氏、入職日期和該員工是在星期幾開始工作的.將該列命名為DAY.按星期中各天的順序（從星期一開始）將結果排序.
- **SELECT** last_name, hire_date, TO_CHAR(hire_date, 'DAY') day **FROM** employees **ORDER BY** TO_CHAR(hire_date -1, 'D');
- **SELECT** last_name, hire_date, TO_CHAR(hire_date, 'DAY') day **FROM** employees **ORDER BY** CASE TO_CHAR(hire_date, 'fmDAY') WHEN 'MONDAY' THEN 1 WHEN 'TUESDAY' THEN 2 WHEN 'WEDNESDAY' THEN 3 WHEN 'THURSDAY' THEN 4 WHEN 'FRIDAY' THEN 5 WHEN 'SATURDAY' THEN 6 WHEN 'SUNDAY' THEN 7 END;
---
### 10.創建一個查詢,使其顯示員工的姓氏和獎金比率.如果某員工沒有資金,則顯示“No Commission”,將該列命名為COMM.
- **SELECT** last_name, NVL(TO_CHAR(commission_pct,'0.00'), 'No commission') comm **FROM** employees;
---
### 11.創建一個查詢,使其顯示員工的姓氏,並用星號指明他們的年薪.每個星號代表一千元,有幾千就有幾個星號,取整,不足一千的不參與統計.按薪金降序排序.將該列命名為EMPLOYEES_AND_THEIR_SALARIES. 類似：
### King************
- **SELECT** RPAD(last_name, LENGTH(last_name) + TRUNC(salary * (NVL(commission_pct, 0) + 1) / 1000), '*') employees_and_their_salaries **FROM** employees;
---
### 12.使用DECODE函數編寫一個查詢,使其按照以下數據根據JOB_ID列的值顯示所有員工的級別：
|職務(Job) | 級別(Grade)|
|--------- | -----------|
|AD_PRES   | A          |
|ST_MAN    | B          |
|IT_PROG   | C          |
|SA_REP    | D          |
|ST_CLERK  | E          |
|OTHER     | O          |
- **SELECT** last_name, job_id "Job", DECODE ((job_id), 'AD_PRES', 'A', 'ST_MAN', 'B', 'IT_PROG', 'C', 'SA_REP', 'D', 'ST_CLERK', 'E', 'O') "Grade" **FROM** employees;
---
### 13.用CASE語法,實現上題的要求.
- **SELECT** last_name, job_id "Job", (CASE job_id WHEN 'AD_PRES' THEN 'A' WHEN 'ST_MAN' THEN 'B' WHEN 'IT_PROG' THEN 'C' WHEN 'SA_REP' THEN 'D' WHEN 'ST_CLERK' THEN 'E' ELSE 'O' END) "Grade" **FROM** employees;
