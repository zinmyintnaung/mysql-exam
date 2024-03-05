--WINDOW FUNCTIONS perform aggregate operations on groups of rows, but they produce a result FOR EACH ROWS
--DATE PREPARATION
CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);
 
INSERT INTO employees (department, salary) VALUES
('engineering', 80000),('engineering', 69000),('engineering', 70000),('engineering', 103000),('engineering', 67000),('engineering', 89000),
('engineering', 91000),('sales', 59000),('sales', 70000),('sales', 159000),('sales', 72000),('sales', 60000),('sales', 61000),
('sales', 61000),('customer service', 38000),('customer service', 45000),('customer service', 61000),('customer service', 40000),
('customer service', 31000),('customer service', 56000),('customer service', 55000);

--OVER() create a window alongside all the rows
SELECT emp_no, department, salary, AVG(salary) OVER() FROM employees;

SELECT emp_no, department, salary, MIN(salary) OVER(), MAX(salary) OVER()
FROM employees;

--OVER(PARTITION BY COL_NAME) will limit the window into specified column
--For example, AVG(salary) with OVER(PARTITION BY department) 
SELECT emp_no, department, salary, AVG(salary) OVER(PARTITION BY department) AS department_average
FROM employees;
--CASE: Compare average department salary with company average
SELECT emp_no, department, salary, 
AVG(salary) OVER(PARTITION BY department) AS department_average,
AVG(salary) OVER() AS company_average
FROM employees;
--CASE: Get total salary of each department compare with total company payroll
SELECT emp_no, department, salary,
SUM(salary) OVER(PARTITION BY department) AS department_total_salary,
SUM(salary) OVER() AS company_payroll
FROM employees;

--ORDER BY inside OVER() will produce rolling basis result for each partition (window)
SELECT emp_no, department, salary, 
    SUM(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS rolling_dept_salary,
    SUM(salary) OVER(PARTITION BY department) AS total_dept_salary
FROM employees;

--RANK() - Only work with OVER(), put ranking information to each window
SELECT emp_no, department, salary, 
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rank_salary
FROM employees;
--CASE: Get ranking of employees salary within their department with overall company salary ranking
SELECT emp_no, department, salary, 
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_rank_salary,
    RANK() OVER(ORDER BY salary DESC) AS overall_ranking
FROM employees ORDER BY department;

--DENSE_RANK() - same as RANK() but it will not skip the rank number if there are same ranking, e.g. 1, 1, 2, 3 (RANK() produce 1,1,3,4)
SELECT emp_no, department, salary, 
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_rank_salary,
    RANK() OVER(ORDER BY salary DESC) AS overall_ranking,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_overall_ranking
FROM employees;
--ROW_NUMBER() - set sequential number for each window's rows
SELECT emp_no, department, salary, 
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_row_number,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_rank_salary,
    RANK() OVER(ORDER BY salary DESC) AS overall_ranking,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_overall_ranking
FROM employees ORDER BY department, dept_row_number;
--CASE: Add ROW_NUMBER() for both department serial and overall ranking serial
SELECT emp_no, department, salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_row_number,
    RANK() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_salary_rank,
    RANK() OVER(ORDER BY salary DESC) as overall_rank,
    DENSE_RANK() OVER(ORDER BY salary DESC) as overall_dense_rank,
    ROW_NUMBER() OVER(ORDER BY salary DESC) as overall_num
FROM employees ORDER BY overall_rank;

--NTILES(N) - divide partition into N groups buckets
SELECT emp_no, department, salary,
    NTILE(4) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_quartile,
	NTILE(4) OVER(ORDER BY salary DESC) AS salary_quartile
FROM employees;

--FIRST_VALUE(COLUMN_NAME) - return the first value (of the given column) from the partition
SELECT emp_no, department, salary,
    FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) AS higest_paid_in_dept,
	SUM(salary) OVER(PARTITION BY department) AS overall_salary
FROM employees;
--CASE: highest paid emp_no in each dept vs highest paid in the company payroll
SELECT emp_no, department, salary,
    FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) AS higest_paid_in_dept,
	FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) AS higest_paid_overall
FROM employees;

--LEAD(), LAG() - useful to evaluate current role with previous (lag) and next (lead) rows data
SELECT emp_no, department, salary,
    salary - LAG(salary) OVER(ORDER BY salary DESC) as salary_diff
FROM employees;
 
SELECT emp_no, department, salary,
    salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) as dept_salary_diff
FROM employees;
