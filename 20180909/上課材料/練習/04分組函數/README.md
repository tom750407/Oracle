# 04-分組函數
### 1.判斷-分組函數通過處理多個行來為每個組生成一個結果.
- 是,分組函數可以對多個行來進行操作,並且為每個組給出一個結果,使用GROUP BY column1, column2,.. 按column1, column2進行分組, 即column1,column2組合相同的值為一個組
---
### 2.判斷-分組函數可以計算空值
- 否,所有的分組函數都忽略空值,可以使用NVL,NVL2或COALESCE函數替代空值
---
### 3.判斷-WHERE子句在包含到分組計算之前,可以對行進行限制
- 是,WHERE子句可以將某些行在分組前排除在外
---
### 4.顯示所有員工的最高、最低、總計和平均工資.分別將各列標記為Maximum、Minimum、Sum和Average.將結果舍入到最接近的整數並按照平均工資進行升序排序.
- **SELECT** MAX(salary) "Maximum", MIN(salary) "Minimum", SUM(salary) "Sum", TRUNC(AVG(salary)) "Average" **FROM** employees **ORDER BY** "Average";
---
### 5.顯示每個職務類型的最低、最高、總計和平均工資,將結果舍入到最接近的整數,列的命名方式與上題相同並按照職務類型進行升序排序.
- **SELECT** job_id, MAX(salary) "Maximum", MIN(salary) "Minimum", SUM(salary) "Sum", TRUNC(AVG(salary)) "Average" **FROM** employees **GROUP BY** job_id **ORDER BY** job_id;
---
### 6.顯示職務相同的員工人數.
- **SELECT** job_id, COUNT(job_id) **FROM** employees **GROUP BY** job_id;
---
### 7.確定經理的人數而不列出他們,將該列標記為Number of Managers.
- **SELECT** COUNT(DISTINCT manager_id) "Number of Managers" **FROM** employees;
---
### 8.編寫一個查詢,顯示最高工資和最低工資之間的差額,將該列標記為DIFFERENCE.
- **SELECT** MAX(salary) maximum, Min(salary) minimum, MAX(salary) - MIN(salary) difference **FROM** employees;
---
### 9.顯示經理編號以及該經理所管員工的最低工資,不包括其經理未知的任何員工.排除最低工資不超過6000的所有組.按工資降序進行排序.
- **SELECT** manager_id, MIN(salary) min_salary **FROM** employees **WHERE** manager_id IS NOT NULL **GROUP BY** manager_id **HAVING** MIN(salary) > 6000 **ORDER BY** min_salary DESC;
---
### 10.編寫一個查詢,顯示每個部門編號,部門員工人數,和該部門的平均工資.將各列命令為Deptno、Number of People、Avg of Salary.平均工資舍入到小數後兩位,排除掉未知部門,結果按部門編號進行排序.
- **SELECT** department_id "Deptno", COUNT(*) "Number of People", TRUNC(AVG(salary), 2) "Avg of Salary" **FROM** employees **WHERE** department_id IS NOT NULL **GROUP BY** department_id **ORDER BY** 1;
---
### 11.創建一個查詢,顯示員工總數,以及其中在2003、2005、2006年入職的員工數.為每列創建標題為Total、2003、2005、2006.例如輸出如下：
| TOTAL | 2003 | 2005 | 2007 |
| ----- | ---- | ---- | ---- |
| 107   | 6    | 29   | 19   |
- **SELECT** COUNT(*) "TOTAL", SUM(CASE TO_CHAR(hire_date, 'YYYY') WHEN '2003' THEN 1 END) "2003", SUM(CASE TO_CHAR(hire_date, 'YYYY') WHEN '2005' THEN 1 END) "2005", SUM(CASE TO_CHAR(hire_date, 'YYYY') WHEN '2007' THEN 1 END) "2007" **FROM** employees;
- **SELECT** (**SELECT** COUNT(*) **FROM** employees) "TOTAL", (**SELECT** COUNT(*) **FROM** employees **WHERE** TO_CHAR(hire_date, 'YYYY')=2003) "2003", (**SELECT** COUNT(*) **FROM** employees **WHERE** TO_CHAR(hire_date, 'YYYY')=2005) "2005", (**SELECT** COUNT(*) **FROM** employees **WHERE** TO_CHAR(hire_date, 'YYYY')=2007) "2007" **FROM** dual;
---
### 12.創建一個矩陣查詢,使其顯示所有的職務類型、部門20、50、80和90部門基於部門編號的職務工資總和,以及所有職務的工資總和.使其輸出為:
|Job        | Dept20 | Dept50 | Dept80 | Dept90 | Total |
|-----------|--------|--------|--------|--------|-------|
|AC_ACCOUNT |        |        |        |        |   8300|
|AC_MGR     |        |        |        |        |  12008|
|AD_ASST    |        |        |        |        |   4400|
|AD_PRES    |        |        |        |   24000|  24000|
|AD_VP      |        |        |        |   34000|  34000|
|FI_ACCOUNT |        |        |        |        |  39600|
|FI_MGR     |        |        |        |        |  12008|
|HR_REP     |        |        |        |        |   6500|
|IT_PROG    |        |        |        |        |  29000|
|MK_MAN     |   13000|        |        |        |  13000|
|MK_REP     |    6000|        |        |        |   6000|
|PR_REP     |        |        |        |        |  10000|
|PU_CLERK   |        |        |        |        |  13900|
|PU_MAN     |        |        |        |        |  11000|
|SA_MAN     |        |        |   61000|        |  61000|
|SA_REP     |        |        |  243500|        | 250500|
|SH_CLERK   |        |   64300|        |        |  64300|
|ST_CLERK   |        |   55700|        |        |  55700|
|ST_MAN     |        |   36400|        |        |  36400|
- **SELECT** job_id "Job", SUM(CASE department_id WHEN 20 THEN salary END) "Dept20", SUM(CASE department_id WHEN 50 THEN salary END) "Dept50", SUM(CASE department_id WHEN 80 THEN salary END) "Dept80", SUM(CASE department_id WHEN 90 THEN salary END) "Dept90", SUM(salary) "Total" **FROM** employees **GROUP BY** job_id **ORDER BY** 1;
