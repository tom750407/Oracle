# 04-分組函數
### 1.判斷-分組函數通過處理多個行來為每個組生成一個結果。
- 是,分組函數可以對多個行來進行操作,並且為每個組給出一個結果,使用GROUP BY column1, column2,.. 按column1, column2進行分組, 即column1,column2組合相同的值為一個組
---
### 2.判斷-分組函數可以計算空值
- 否,所有的分組函數都忽略空值,可以使用NVL,NVL2或COALESCE函數替代空值
---
### 3.判斷-WHERE子句在包含到分組計算之前，可以對行進行限制
- 是,WHERE子句可以將某些行在分組前排除在外
---
### 4.顯示所有員工的最高、最低、總計和平均工資。分別將各列標記為Maximum、Minimum、Sum和Average。將結果舍入到最接近的整數並按照平均工資進行升序排序。
- **SELECT** MAX(salary) "Maximum", MIN(salary) "Minimum", SUM(salary) "Sum", TRUNC(AVG(salary)) "Average" **FROM** employees **ORDER BY** "Average";
---
### 5.顯示每個職務類型的最低、最高、總計和平均工資，將結果舍入到最接近的整數，列的命名方式與上題相同並按照職務類型進行升序排序。
- **SELECT** job_id, MAX(salary) "Maximum", MIN(salary) "Minimum", SUM(salary) "Sum", TRUNC(AVG(salary)) "Average" **FROM** employees **GROUP BY** job_id **ORDER BY** job_id;
---
### 6.顯示職務相同的員工人數。
- **SELECT** job_id, COUNT(job_id) **FROM** employees **GROUP BY** job_id;
---
### 7.確定經理的人數而不列出他們，將該列標記為Number of Managers。
- **SELECT** COUNT(DISTINCT manager_id) "Number of Managers" **FROM** employees;
