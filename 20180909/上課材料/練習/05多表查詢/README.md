# 05-多表查詢
### 1.編寫一個查詢，以顯示所有員工的姓氏、部門編號和部門名稱，要求使用自然聯結和傳統語法兩種方式實現。
- **SELECT** last_name, department_id, department_name **FROM** employees JOIN departments USING (department_id);
- **SELECT** a.last_name, a.department_id, b.department_name **FROM** employees a, departments b **WHERE** a.department_id = b.department_id;
---
### 2.創建部門80中所有職務的唯一列表，並列出部門的地點。要求至少寫出兩種分別使用自然聯結和傳統語法的語句。
- **SELECT** DISTINCT job_id, city **FROM** employees JOIN departments USING (department_id) JOIN locations USING (location_id) **WHERE** department_id = 80;
- **SELECT** DISTINCT a.job_id, c.city **FROM** employees a, departments b, locations c **WHERE** a.department_id = b.department_id AND b.location_id = c.location_id AND a.department_id = 80;
---
### 3.編寫一個查詢，以顯示賺取獎金的所有員工的姓氏、部門名稱、城市代碼和城市名稱。
- **SELECT** last_name, department_name, location_id, city **FROM** employees JOIN departments USING (department_id) JOIN locations USING (location_id) **WHERE** commission_pct IS NOT NULL;
- **SELECT** a.last_name, b.department_name, b.location_id, c.city **FROM** employees a, departments b, locations c **WHERE** a.department_id = b.department_id AND b.location_id = c.location_id AND commission_pct IS NOT NULL;
---
### 4.顯示姓氏中含有小寫字母a的所有員工姓氏和部門名稱。
- **SELECT** last_name, department_name **FROM** employees JOIN departments USING (department_id) **WHERE** last_name LIKE '%a%';
- **SELECT** a.last_name, b.department_name **FROM** employees a, departments b **WHERE** a.department_id = b.department_id AND a.last_name LIKE '%a%';
---
### 5.編寫一個查詢，以顯示在Toronto工作的所有員工的姓氏、職務、部門編寫和部門名稱。
- **SELECT** last_name, job_id, department_id, department_name **FROM** employees JOIN departments USING (department_id) JOIN locations USING (location_id) **WHERE** city = 'Toronto';
- **SELECT** a.last_name, a.job_id, a.department_id, b.department_name **FROM** employees a, departments b, locations c **WHERE** a.department_id = b.department_id AND b.location_id = c.location_id AND c.city = 'Toronto';
---
### 6.顯示員工姓氏、員工編號以及他們經理的姓氏和經理編號。將這些列分別標記為Employee、Emp#、Manager和Mgr#。
- **SELECT** a.employee_id "Emp#", a.last_name "Employee", a.manager_id "Manager", b.last_name "Mgr#" **FROM** employees a JOIN employees b ON(a.manager_id = b.employee_id) **ORDER BY** 1;
- **SELECT** a.employee_id "Emp#", a.last_name "Employee", a.manager_id "Manager", b.last_name "Mgr#" **FROM** employees a, employees b **WHERE** a.manager_id = b.employee_id **ORDER BY** 1;
---
### 7.在上題基礎上，使其顯示中包含沒有上級經理的員工King。
- **SELECT** a.employee_id "Emp#", a.last_name "Employee", a.manager_id "Manager", b.last_name "Mgr#" **FROM** employees a LEFT OUTER JOIN employees b ON(a.manager_id = b.employee_id) **ORDER BY** 1;
---
### 8.創建一個查詢，以顯示員工的姓氏、部門編號以及與該員工在同一部門一起工作的有多少人？
- **SELECT** a.last_name, a.department_id, COUNT(b.employee_id) - 1 **FROM** employees a JOIN employees b ON(a.department_id = b.department_id) **GROUP BY** a.last_name, a.department_id **ORDER BY** 2, 1;
---
### 9.創建一個查詢，顯示所有員工姓名、職務、部門名稱、工作地點以及工資級別。
- **SELECT** a.first_name || ' ' || a.last_name, a.job_id, b.department_name, c.city, d.grade **FROM** employees a JOIN departments b ON(a.department_id = b.department_id) JOIN locations c ON(b.location_id = c.location_id) JOIN job_grades d ON(a.salary BETWEEN d.lowest_sal AND d.highest_sal) **ORDER BY** 5;
---
### 10.創建一個查詢，顯示在全名叫KimberelyGrant的員工之後入職的所有員工的姓名和入職日期。
- **SELECT** first_name || ' ' || last_name, hire_date **FROM** employees **WHERE** hire_date > (**SELECT** hire_date **FROM** employees **WHERE** first_name || ' ' || last_name ='Kimberely Grant')
- **SELECT** b.first_name || ' ' || b.last_name, b.hire_date **FROM** employees a JOIN employees b ON(b.hire_date > a.hire_date) **WHERE** a.first_name || ' ' || a.last_name = 'Kimberely Grant';
---
### 11.顯示在其經理之前入職的所有員工的全名和入職日期，以及其經理的全名和入職日期。列名分別為Employee、Emp hired、Manager和Mgr hired。
- **SELECT** a.first_name || ' ' || a.last_name "Employee", a.hire_date "Emp hired", b.first_name || ' ' || b.last_name "Manager", b.hire_date "Mgr hired" **FROM** employees a JOIN employees b ON(a.manager_id = b.employee_id) **WHERE** a.hire_date < b.hire_date;
- **SELECT** a.first_name || ' ' || a.last_name "Employee", a.hire_date "Emp hired", b.first_name || ' ' || b.last_name "Manager", b.hire_date "Mgr hired" **FROM** employees a JOIN employees b ON(a.manager_id = b.employee_id) AND a.hire_date < b.hire_date;
