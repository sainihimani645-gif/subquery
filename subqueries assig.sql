Create database pwskills_subqueries ;
Use pwskills_subqueries ;

##Employee Table
Create Table employee (
emp_id int Primary key ,
name varchar(50) ,
department_id varchar(5) ,
salary int) ;

## Insert Data

INSERT INTO employee VALUES
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Priya', 'D02', 67000),
(104, 'Rohit', 'D02', 64000),
(105, 'Neha', 'D03', 72000),
(106, 'Aman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);

##Department table
Create table Department (
department_id varchar(5) Primary Key ,
department_name varchar(50) ,
location varchar(50) ) ;

##Insert table
INSERT INTO department VALUES
( 'D01' , 'Sales', 'Mumbai' ),
( 'D02' , 'Marketing', 'Delhi' ),
( 'D03' , 'Finance', 'Pune' ),
( 'D04' , 'HR', 'Bengaluru' ),
( 'D05' , 'IT', 'Hyderabad' );

drop Table department;

##Sales Table
Create Table Sales (
sales_id int primary key,
emp_id int,
sales_amount int,
sales_date date,
foreign key (emp_id) REFERENCES employee (emp_id) ) ;

##Insert Table
INSERT INTO sales VALUES
(201, 101, 4500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800, '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107, 3200, '2025-02-09'),
(208, 108, 5100, '2025-02-15'),
(209, 109, 3900, '2025-02-20'),
(210, 110, 7200, '2025-03-01');

##verify tables
Select * from employee;
select * from department;
select * from sales;

##QUE 1##
SELECT name
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);

##Que 2##
SELECT name
FROM employee
WHERE department_id = (
    SELECT department_id
    FROM employee
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1 );
    
    ##Que 3##
    SELECT name
FROM employee
WHERE emp_id IN (SELECT DISTINCT emp_id FROM sales);

##Que 4##
SELECT e.name, s.sale_amount
FROM Employee e
JOIN Sales s ON e.emp_id = s.emp_id
ORDER BY s.sale_amount DESC
LIMIT 1;

##QUE 5##
SELECT name
FROM employee
WHERE salary > (SELECT salary FROM employee WHERE name = 'Shubham');

##Intermediate level##

##Que 1##
SELECT name
FROM employee
WHERE department_id = (
    SELECT department_id
    FROM employee
    WHERE name = 'Abhishek'
)
AND name != 'Abhishek';

##Que 2##
SELECT DISTINCT department.department_name
FROM department
JOIN employee ON department.department_id = employee.department_id
WHERE employee.salary > 60000;

##Que 3##
SELECT department_name
FROM department
WHERE department_id = (
    SELECT department_id
    FROM employee
    WHERE emp_id = (
        SELECT emp_id
        FROM sales
        ORDER BY sale_amount DESC
        LIMIT 1
    )
);

##Que 4##
SELECT DISTINCT employee.name
FROM employee 
JOIN sales ON employee.emp_id = sales.emp_id
WHERE sales.sale_amount > (SELECT AVG(sale_amount) FROM sales);

##Que 5##
SELECT SUM(sale_amount) AS total_sales
FROM sales
WHERE emp_id IN (
    SELECT emp_id FROM employee
    WHERE salary > (SELECT AVG(salary) FROM employee)
);

##Advanced Level##
##Que 1##
SELECT name
FROM employee
WHERE emp_id NOT IN (SELECT DISTINCT emp_id FROM sales);

##Que 2##
SELECT department.department_name
FROM department
JOIN employee ON department.department_id = employee.department_id
GROUP BY department.department_name
HAVING AVG(employee.salary) > 55000;

##Que 3##
SELECT department.department_name
FROM department
JOIN employee ON department.department_id = employee.department_id
JOIN sales ON employee.emp_id = sales.emp_id
GROUP BY department.department_name
HAVING SUM(sales.sale_amount) > 10000;

##Que 4##
SELECT employee.name
FROM employee
JOIN sales ON employee.emp_id = sales.emp_id
ORDER BY sales.sale_amount DESC
LIMIT 1 OFFSET 1;

##Que 5##
SELECT name
FROM employee
WHERE salary > (SELECT MAX(sale_amount) FROM sales);











    
    
    








