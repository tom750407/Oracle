# 06-子查詢
### 1.編寫一個查詢,顯示和Zlotkey在同一個部門的所有員工的姓氏和入職日期,但不包括Zlotkey.
- **SELECT** last_name, hire_date **FROM** employees **WHERE** department_id = (**SELECT** department_id **FROM** employees **WHERE** last_name = 'Zlotkey') AND last_name != 'Zlotkey';
---
### 2.創建一個查詢,顯示年薪（工資x12加獎金）超過平均年薪的所有員工的員工編號、姓氏、部門名稱和部門所在地.
- **SELECT** employee_id, last_name, department_name, city **FROM** employees a JOIN departments b ON(a.department_id = b.department_id) JOIN locations c ON(b.location_id = c.location_id) **WHERE** (salary * (NVL(commission_pct, 0) + 1)) * 12 > (**SELECT** AVG((salary * (NVL(commission_pct, 0) + 1)) * 12) **FROM** employees);
---
### 3.編寫一個查詢,顯示所有員工的員工編號,姓氏,部門ID,條件是他們所工作的部門裡有員工姓氏包含且只包含一個u,輸出結果裡,排除這些姓氏裡包含且只包含一個u的結果.
- **SELECT** employee_id, last_name, department_id **FROM** employees **WHERE** department_id IN (**SELECT** department_id **FROM** employees **WHERE** INSTR(last_name, 'u', 1, 1) > 0 AND INSTR(last_name, 'u', 1, 2) = 0) AND (last_name NOT LIKE '%u%' OR INSTR(last_name, 'u', 1, 2) > 0);
---
### 4.顯示部門的location ID為1700的所有員工姓氏、部門編號和職務.
- **SELECT** last_name, department_id, job_id **FROM** employees JOIN departments USING(department_id) **WHERE** location_id = 1700;
- **SELECT** last_name, department_id, job_id **FROM** employees **WHERE** department_id IN(**SELECT** department_id **FROM** departments **WHERE** location_id = 1700);
---
### 5.顯示King的每個下屬員工的姓氏、工資、經理ID和經理姓氏.
- **SELECT** a.last_name, a.salary, a.manager_id, b.last_name **FROM** employees a JOIN employees b ON(a.manager_id = b.employee_id) **WHERE** a.manager_id IN(**SELECT** employee_id **FROM** employees **WHERE** last_name = 'King');
---
### 6.查詢部門工作地點在Seattle,且職務與111號員工相同的所有員工的員工編號、姓氏、部門編號和職務.
- **SELECT** employee_id, last_name, department_id, job_id **FROM** employees **WHERE** department_id IN(**SELECT** department_id **FROM** departments JOIN locations USING(location_id) **WHERE** city = 'Seattle') AND job_id = (**SELECT** job_id **FROM** employees **WHERE** employee_id = 111);
---
### 7.查詢工資超過平均工資,且部門裡有員工姓氏中包含字母u的所有員工的員工編號,姓氏和工資.
- **SELECT** employee_id, last_name, salary **FROM** employees **WHERE** department_id IN(**SELECT** department_id **FROM** employees **WHERE** last_name LIKE '%u%') AND salary > (**SELECT** AVG(salary) **FROM** employees);
