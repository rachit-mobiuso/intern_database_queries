-- Q1 Write a query to display Employee id and First Name of an employee whose dept_id = 100. (Use:Sub-query)(6 rows)
select employee_id, first_name from employees where department_id in (select department_id from departments where department_id = 100);

-- Q2. Write a query to display the dept_id, maximum salary, of all the departments whose maximum salary is greater than the average salary. (USE: SUB-QUERY) (11 rows) 
select department_id, max(salary) as max_salary from employees group by department_id having max(salary) > (select avg(salary) from employees);

-- Q3 Write a query to display department name and, department id of the employees whose salary is less than 35000. .(USE:SUB-QUERY)(11 rows) 
select department_name, department_id from departments where department_id in (
select department_id from employees where salary < 35000);
