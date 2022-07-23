
USE giraffe_db;

CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT, -- superviser
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL; -- add the branch_id as foreign key in employee table

ALTER TABLE employee
ADD FOREIGN KEY(super_id) 
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL 
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

/* ON DELETE SET NULL : esto significa que si elimino uno de los empleados que es manager,  el manager id que esta asociado a ese empleado se volvera nulo ( en la tabla branch y employee)
ejemplo:
DELETE FROM employee WHERE emp_id = 102;
SELECT * FROM branch;
SELECT * FROM employee;

DELETE CASCADE : Si eliminamos un valor almancenado en branch_id en la tabla branch_supplier (que es una foreing key) eliminaremos todas las filas que tienen ese valor (por ejemplo branch_id = 2)
ejemplo:
DELETE FROM branch WHERE branch_id = 2;
SELECT * FROM branch_supplier;
*/

-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL); -- null porque aun no fueron creados esos id

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100; -- ahora si se lo agregamos ya que creamos un dato en la fk

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- More basic queries

-- Find all from..  table
SELECT * FROM branch;
SELECT * FROM branch_supplier;
SELECT * FROM client;
SELECT * FROM employee;
SELECT * FROM works_with;

-- Find all employees ordered by salary
SELECT * from employee
ORDER BY salary DESC; -- try ASC (is on by defect)

-- Find all employees ordered by sex then name
SELECT * from employee
ORDER BY sex, first_name, last_name;

-- Find the first 5 employees in the table
SELECT * from employee
LIMIT 5;

-- Find the first and last names of all employees
SELECT first_name, last_name
FROM employee;

-- Find the forename and surnames names of all employees
SELECT first_name AS forename, last_name AS surname
FROM employee;

-- Find out all the different genders
SELECT DISTINCT sex
FROM employee;

-- Find all male employees
SELECT * FROM employee
WHERE sex = 'M';

-- Find all employees at branch 2
SELECT * FROM employee
WHERE branch_id = 2;

-- Find all employee's id's and names who were born after 1969
SELECT emp_id, first_name, last_name
FROM employee
WHERE birth_day >= 1970-01-01;

-- Find all female employees at branch 2
SELECT * FROM employee
WHERE branch_id = 2 AND sex = 'F';

-- Find all employees who are female & born after 1969 or who make over 80000
SELECT * FROM employee
WHERE (birth_day >= '1970-01-01' AND sex = 'F') OR salary > 80000;

-- Find all employees born between 1970 and 1975
SELECT * FROM employee
WHERE birth_day BETWEEN '1970-01-01' AND '1975-01-01';

-- Find all employees named Jim, Michael, Johnny or David
SELECT * FROM employee
WHERE first_name IN ('Jim', 'Michael', 'Johnny', 'David');

-- Functions

-- Find the number of employees
SELECT COUNT(emp_id)
FROM employee;

-- Find the average of all employee's salaries
SELECT AVG(salary)
FROM employee;

-- Find the sum of all employee's salaries
SELECT SUM(salary)
FROM employee;

-- Find out how many males and females there are
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

-- Find the total sales of each salesman
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

-- Find the total amount of money spent by each client
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;

SELECT * FROM works_with;

-- Wildcards -- definir diferentes patrones en los datos

-- % = any # characters, _ = one character

-- Find any client's who are an LLC
SELECT * FROM client
WHERE client_name LIKE '%LLC'; 

-- Find any branch suppliers who are in the label business
SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '% Label%';

-- Find any employee born on october (month 10)
SELECT *
FROM employee
WHERE birth_day LIKE '____-10%'; -- tengo 4 _ que indican el espacio del anio (4 caracteres)

-- Find any clients who are schools
SELECT *
FROM client
WHERE client_name LIKE '%school%';

-- Union
-- Find a list of employee and branch names
SELECT employee.first_name AS Employee_Branch_Names
FROM employee
UNION
SELECT branch.branch_name
FROM branch;

-- Find a list of all clients & branch suppliers' names
SELECT client.client_name AS Non_Employee_Entities, client.branch_id AS Branch_ID
FROM client
UNION
SELECT branch_supplier.supplier_name, branch_supplier.branch_id
FROM branch_supplier;

-- Find a list of all money spent or earned by the company -- salary and sales

SELECT salary FROM employee
UNION
SELECT total_sales FROM works_with;

-- Joins
-- Add the extra branch
INSERT INTO branch VALUES(4, "Buffalo", NULL, NULL);
SELECT * FROM branch;

-- Find all branches and the name of their managers
SELECT e.emp_id, e.first_name, b.branch_name
FROM employee as e
JOIN branch as b   -- LEFT JOIN, RIGHT JOIN
	ON e.emp_id = b.mgr_id;
    
SELECT e.emp_id, e.first_name, b.branch_name
FROM employee as e
RIGHT JOIN branch as b   -- LEFT JOIN (employee table), RIGHT JOIN (branch table)
	ON e.emp_id = b.mgr_id;

-- Nested Queries

-- Find names of all employees who have sold over 50,000

SELECT e.first_name, e.last_name
FROM employee as e
WHERE e.emp_id 
	IN ( SELECT w.emp_id
		FROM works_with as w
		WHERE w.total_sales> 50.000);

-- Find all clients who are handles by the branch that Michael Scott manages
-- Assume you know Michael's ID
SELECT c.client_id, c.client_name FROM client AS c
WHERE c.branch_id = (SELECT b.branch_id
                          FROM branch as b
                          WHERE b.mgr_id = 102);


 -- Find all clients who are handles by the branch that Michael Scott manages
 -- Assume you DONT'T know Michael's ID
SELECT c.client_id, c.client_name FROM client AS c
WHERE c.branch_id = (SELECT b.branch_id FROM branch as b
						WHERE b.mgr_id = (SELECT e.emp_id FROM employee as e 
                        WHERE (e.first_name = 'Michael' and e.last_name = 'Scott') LIMIT 1));
 
 -- Find the names of employees who work with clients handled by the scranton branch
 SELECT e. emp_id, e.first_name, e.last_name FROM employee as e 
 WHERE e.branch_id IN (SELECT b.branch_id FROM branch as b WHERE b.branch_name = 'scranton');
 
 -- Find the names of all clients who have spent more than 100,000 dollars
 SELECT c.client_id, c.client_name FROM client AS c
 WHERE c.client_id IN (SELECT client_id FROM (SELECT SUM(w.total_sales) AS totals, w.client_id
                                FROM works_with as w
                                GROUP BY w.client_id) AS total_client_sales
								WHERE totals > 100000);
                                
-- Triggers
-- CREATE
--     TRIGGER `event_name` BEFORE/AFTER INSERT/UPDATE/DELETE
--     ON `database`.`table`
--     FOR EACH ROW BEGIN
-- 		-- trigger body
-- 		-- this code is applied to every
-- 		-- inserted/updated/deleted row
--     END;

CREATE TABLE trigger_test (
     message VARCHAR(100)
); -- solo a modo de ejemplo, no es necesario crear la tabla para trabajar con triggers


-- DELIMITER $$ -- cambiamos el delimeter para crear el trigger luego lo volvemos a ;
DROP TRIGGER IF EXISTS my_trigger;
CREATE TRIGGER my_trigger 
BEFORE INSERT
ON employee
FOR EACH ROW

INSERT INTO trigger_test VALUES('added new employee');

INSERT INTO employee
VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

-- DELIMITER $$
DROP TRIGGER IF EXISTS my_trigger;
CREATE TRIGGER my_trigger
BEFORE INSERT
ON employee
FOR EACH ROW 
INSERT INTO trigger_test VALUES(NEW.first_name);

INSERT INTO employee
VALUES(110, 'Kevin', 'Malone', '1978-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_test;

DROP TRIGGER IF EXISTS my_trigger;
DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
         IF NEW.sex = 'M' THEN
               INSERT INTO trigger_test VALUES('added male employee');
         ELSEIF NEW.sex = 'F' THEN
               INSERT INTO trigger_test VALUES('added female');
         ELSE
               INSERT INTO trigger_test VALUES('added other employee');
         END IF;
    END$$
DELIMITER ;
INSERT INTO employee
VALUES(111, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3);


DROP TRIGGER my_trigger;

