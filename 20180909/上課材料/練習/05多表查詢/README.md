# 05-多表查詢
### 1.編寫一個查詢，以顯示所有員工的姓氏、部門編號和部門名稱，要求使用自然聯結和傳統語法兩種方式實現。
- **SELECT** last_name, department_id, department_name **FROM** employees JOIN departments USING (department_id);
- **SELECT** a.last_name, a.department_id, b.department_name **FROM** employees a, departments b **WHERE** a.department_id = b.department_id;
---
### 2.創建部門80中所有職務的唯一列表，並列出部門的地點。要求至少寫出兩種分別使用自然聯結和傳統語法的語句。
- **SELECT** DISTINCT job_id, city **FROM** employees JOIN departments USING (department_id) JOIN locations USING (location_id) **WHERE** department_id = 80;
- **SELECT** DISTINCT a.job_id, c.city **FROM** employees a, departments b, locations c **WHERE** a.department_id = b.department_id AND b.location_id = c.location_id AND a.department_id = 80;
---
### 3.編寫一個查詢，以顯示賺取獎金的所有員工的姓氏、部門名稱、城市代碼和城市名稱。要求同上
- **SELECT** last_name, department_name, location_id, city **FROM** employees JOIN departments USING (department_id) JOIN locations USING (location_id) **WHERE** commission_pct IS NOT NULL;
- **SELECT** a.last_name, b.department_name, b.location_id, c.city **FROM** employees a, departments b, locations c **WHERE** a.department_id = b.department_id AND b.location_id = c.location_id AND commission_pct IS NOT NULL;
---
### 4.顯示姓氏中含有小寫字母a的所有員工姓氏和部門名稱。要求同上
- **SELECT** last_name, department_name **FROM** employees JOIN departments USING (department_id) **WHERE** last_name LIKE '%a%';
- **SELECT** a.last_name, b.department_name **FROM** employees a, departments b **WHERE** a.department_id = b.department_id AND a.last_name LIKE '%a%';
---
### 5.編寫一個查詢，以顯示在Toronto工作的所有員工的姓氏、職務、部門編寫和部門名稱。要求同上
- **SELECT** last_name, job_id, department_id, department_name **FROM** employees JOIN departments USING (department_id) JOIN locations USING (location_id) **WHERE** city = 'Toronto';
- **SELECT** a.last_name, a.job_id, a.department_id, b.department_name **FROM** employees a, departments b, locations c **WHERE** a.department_id = b.department_id AND b.location_id = c.location_id AND c.city = 'Toronto';
---
### 6.顯示員工姓氏、員工編號以及他們經理的姓氏和經理編號。將這些列分別標記為Employee、Emp#、Manager和Mgr#。要求同上
- **SELECT** employee.last_name "Employee", employee.employee_id "Emp#", manager.last_name "Mgr#", employee.manager_id "Manager" **FROM** employees employee JOIN employees manager ON (employee.manager_id = manager.employee_id);
- **SELECT** employee.last_name "Employee", employee.employee_id "Emp#", manager.last_name "Mgr#", employee.manager_id "Manager" **FROM** employees employee, employees manager **WHERE** employee.manager_id = manager.employee_id;
