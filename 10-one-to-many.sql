--PREPARE DATA
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
 
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
 
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);

--INNER JOIN, intersection of both tables
SELECT * FROM customers
JOIN orders ON orders.customer_id = customers.id;
-- The order doesn't matter here:
SELECT * FROM orders
JOIN customers ON customers.id = orders.customer_id;

--INNER JOIN WITH GROUP BY
SELECT first_name, last_name, SUM(amount) AS total
FROM customers
JOIN orders ON orders.customer_id = customers.id
GROUP BY first_name, last_name
ORDER BY total;

--LEFT JOIN, take all from left table along with matching rows from right table
SELECT first_name, last_name, order_date, amount
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.id;

--LEFT JOIN WITH GROUP BY, IFNULL(Operation, subValue) so if there is null value in sum(amount), it will sub with 0
SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS money_spent
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY first_name , last_name;

--RIGHT JOIN, take all from right table along with matching rows from the left table
SELECT first_name, last_name, order_date, amount
FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;

---MORE JOIN EXERCISES
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50)
);
 
CREATE TABLE papers (
	student_id INT,
    title VARCHAR(215) NOT NULL,
    grade INT NOT NULL DEFAULT 0,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

--CASE: Select all student name, title and grade for all students that submitted the papers
SELECT first_name, title, grade FROM students
INNER JOIN papers ON students.id = papers.student_id;

--CASE: Select all student name, title and grade for all students including those not yet submitted the papers
SELECT first_name, title, grade FROM students
LEFT JOIN papers ON students.id = papers.student_id;
--CASE: Select all student name, title and grade for all students including those not yet submitted the papers
--but fill title as 'Missing' and grade as 0 if there is no value
SELECT first_name, IFNULL(title, 'Missing'), IFNULL(grade, 0) FROM students
LEFT JOIN papers ON students.id = papers.student_id;
--CASE: Include av
SELECT first_name, IFNULL(AVG(grade), 0) AS average,
CASE
    WHEN AVG(grade) >= 75 THEN 'PASSING'
    ELSE 'FAILING'
END AS passing_status 
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY first_name ORDER BY average DESC;
