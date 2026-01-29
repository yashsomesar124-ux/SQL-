

USE pw_assignment;

-- Employee Table
CREATE TABLE employees1 (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id VARCHAR(5),
    salary INT
);

-- Department Table
CREATE TABLE departments (
    department_id VARCHAR(5) PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

-- Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount INT,
    sale_date DATE,
    FOREIGN KEY (emp_id) REFERENCES employees1(emp_id)
);

-- ==============================
-- INSERT DATA
-- ==============================

INSERT INTO employees1 VALUES
(101,'Abhishek','D01',62000),
(102,'Shubham','D01',58000),
(103,'Priya','D02',67000),
(104,'Rohit','D02',64000),
(105,'Neha','D03',72000),
(106,'Aman','D03',55000),
(107,'Ravi','D04',60000),
(108,'Sneha','D04',75000),
(109,'Kiran','D05',70000),
(110,'Tanuja','D05',65000);

INSERT INTO departments VALUES
('D01','Sales','Mumbai'),
('D02','Marketing','Delhi'),
('D03','Finance','Pune'),
('D04','HR','Bengaluru'),
('D05','IT','Hyderabad');

INSERT INTO sales VALUES
(201,101,4500,'2025-01-05'),
(202,102,7800,'2025-01-10'),
(203,103,6700,'2025-01-14'),
(204,104,12000,'2025-01-20'),
(205,105,9800,'2025-02-02'),
(206,106,10500,'2025-02-05'),
(207,107,3200,'2025-02-09'),
(208,108,5100,'2025-02-15'),
(209,109,3900,'2025-02-20'),
(210,110,7200,'2025-03-01');

SELECT * FROM employees1;
SELECT * FROM departments;
SELECT * FROM sales;

-- 1. Employees earning more than average salary

SELECT name FROM employees1
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. Employees in department with highest average salary
SELECT name FROM employees1
WHERE department_id = (
    SELECT department_id FROM employees1
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

-- 3. Employees who made at least one sale
SELECT name FROM employees1
WHERE emp_id IN (SELECT emp_id FROM sales);

-- 4. Employee with highest sale amount
SELECT name FROM employees1
WHERE emp_id = (
    SELECT emp_id FROM sales
    ORDER BY sale_amount DESC
    LIMIT 1
);

-- 5. Employees earning more than Shubham
SELECT name FROM employees1
WHERE salary > (
    SELECT salary FROM employees1 WHERE name='Shubham'
);

-- 6. Employees in same department as Abhishek
SELECT name FROM employees1
WHERE department_id = (
    SELECT department_id FROM employees1 WHERE name='Abhishek'
);

-- 7. Departments with employee earning more than 60000
SELECT department_name FROM departments
WHERE department_id IN (
    SELECT department_id FROM employees1 WHERE salary > 60000
);

-- 8. Department name of employee with highest sale
SELECT department_name FROM departments
WHERE department_id = (
    SELECT department_id FROM employees1
    WHERE emp_id = (
        SELECT emp_id FROM sales
        ORDER BY sale_amount DESC
        LIMIT 1
    )
);

-- 9. Employees with sales greater than average sale
SELECT name FROM employees1
WHERE emp_id IN (
    SELECT emp_id FROM sales
    WHERE sale_amount > (SELECT AVG(sale_amount) FROM sales)
);

-- 10. Total sales by employees earning more than average salary
SELECT SUM(sale_amount) AS total_sales FROM sales
WHERE emp_id IN (
    SELECT emp_id FROM employees1
    WHERE salary > (SELECT AVG(salary) FROM employees1)
);

-- 11. Employees with no sales
SELECT name FROM employees1
WHERE emp_id NOT IN (SELECT emp_id FROM sales);

-- 12. Departments where average salary > 55000
SELECT department_name FROM departments
WHERE department_id IN (
    SELECT department_id FROM employees1
    GROUP BY department_id
    HAVING AVG(salary) > 55000
);

-- 13. Departments where total sales > 10000
SELECT department_name FROM departments
WHERE department_id IN (
    SELECT e.department_id FROM employees1 e
    JOIN sales s ON e.emp_id = s.emp_id
    GROUP BY e.department_id
    HAVING SUM(s.sale_amount) > 10000
);

-- 14. Employee with second highest sale
SELECT name FROM employees1
WHERE emp_id = (
    SELECT emp_id FROM sales
    ORDER BY sale_amount DESC
    LIMIT 1 OFFSET 1
);

-- 15. Employees whose salary > highest sale amount
SELECT name FROM employees1
WHERE salary > (SELECT MAX(sale_amount) FROM sales);
