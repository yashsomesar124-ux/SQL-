USE pw_assignment;

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customername VARCHAR(50),
city VARCHAR(50)
);
 
 INSERT INTO customers
 VALUES
 (1,"john smith","new york"),
 (2,"mary johnson","chicago"),
 (3,"peter adams","los angeles"),
 (4,"nancy miller","houston"),
 (5,"robert white","maimi");
 
 CREATE TABLE orders(
 orderid INT PRIMARY KEY ,
 customerid int,
 orderdate DATE,
 amount INT
 );
 
 INSERT INTO orders
 VALUES 
 (101,1,"2024-10-01",250),
 (102,2,"2024-10-05",300),
 (103,1,"2024-10-07",150),
 (104,3,"2024-10-10",450),
 (105,6,"2024-10-12",400);
 
 CREATE TABLE paments(
 pamentid VARCHAR(10),
 customerid INT,
 pamentdate DATE,
 amount INT 
 );
 
 INSERT INTO paments
 VALUES
 ("P01",1,"2024-10-02",250),
 ("P002",2,"2024-10-06",300),
 ("P003",3,"2024-10-11",450),
 ("P004",4,"2024-10-15",200);
 
 CREATE TABLE employees2(
 employeeid INT PRIMARY KEY,
 employeename VARCHAR(50),
 managerid INT NULL 
 );
 
 INSERT INTO employees2 (EmployeeID, EmployeeName, ManagerID)
 VALUES
 (1,"alex green",null),
 (2,"brain lee",1),
 (3,"carol roy",1),
 (4,"devid kim",2),
 (5,"evea smith",2);
 
 SELECT * FROM customers;
 SELECT * FROM orders;
 SELECT * FROM paments;
 SELECT * FROM employees2;
 
 # Question 1. Retrieve all customers who have placed at least one order.
 
SELECT DISTINCT c.*
FROM Customers c
JOIN Orders o ON c.customer_id = o.customerid;

# Question 1. Retrieve all customers who have placed at least one order.

SELECT * 
FROM customers c
LEFT JOIN orders o 
on c.customer_id = o.customerid;

# Question 3. Retrieve all orders and their corresponding customers,  
# including orders placed by unknown customers.

SELECT * 
FROM orders o
LEFT JOIN customers c
ON o.customerid = c.customer_id;

# Question 4. Display all customers and orders, whether matched or not.

 SELECT * 
FROM customers c
LEFT JOIN orders o 
on c.customer_id = o.customerid
UNION
 SELECT * 
FROM customers c
RIGHT JOIN orders o 
on c.customer_id = o.customerid;

# Question 5. Find customers who have not placed any orders.

 SELECT c. * 
FROM customers c
LEFT JOIN orders o 
on c.customer_id = o.customerid
WHERE o.orderid IS NULL;

# Question 6. Retrieve customers who made payments but did not place any orders

SELECT DISTINCT c.*
FROM customers c
JOIN paments p ON c.customer_id = p.customerid
LEFT JOIN Orders o ON c.customerid = o.customerid
WHERE o.orderid IS NULL;

# Question 7. Generate a list of all possible combinations between Customers and Orders
 
 SELECT * 
 FROM customers
 CROSS JOIN orders;

# Question 8. Show all customers along with order and payment amounts in one table.
SELECT 
    c.customer_id ,
    c.customername,
    o.orderid,
    o.Amount AS OrderAmount,
    p.pamentid,
    p.Amount AS PaymentAmount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customerid
LEFT JOIN Paments p ON c.customer_id = p.customerid;

# Question 9. Retrieve all customers who have both placed orders and made payments.

SELECT DISTINCT c.*
FROM Customers c
JOIN orders o ON c.customer_id = o.customerid 
JOIN paments p ON c.customer_id = p.customerid;
 


ALTER TABLE  orders 
RENAME COLUMN  coustomerid to customerid;



