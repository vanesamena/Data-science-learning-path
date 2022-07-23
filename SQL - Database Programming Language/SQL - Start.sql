
/* INT                           -- Whole Numbers
DECIMAL(M,N)                  -- Decimal Numbers - Exact Value
VARCHAR(l)                    -- String of text of length l
BLOB                          -- Binary Large Object, Stores large data
DATE                          -- 'YYYY-MM-DD'
TIMESTAMP                     -- 'YYYY-MM-DD HH:MM:SS' - used for recording events */

-- Create a database
CREATE DATABASE giraffe_db;

USE giraffe_db; 
-- Creating tables
CREATE TABLE student (
  student_id INT,
  name VARCHAR(40),
  major VARCHAR(40),
  PRIMARY KEY(student_id)
);

DESCRIBE student;
-- eliminar una tabla
-- DROP TABLE student; -- volver a crearla luego
-- crear y eliminar una columna
ALTER TABLE student ADD gpa DECIMAL;
ALTER TABLE student DROP COLUMN gpa;

-- Inserting Data
INSERT INTO student VALUES(1, 'Jack', 'Biology');
INSERT INTO student VALUES(2, 'Kate', 'Sociology');
INSERT INTO student(student_id, name) VALUES(3, 'Claire'); -- no tenemos major
INSERT INTO student VALUES(4, 'Jack', 'Biology');
INSERT INTO student VALUES(5, 'Mike', 'Computer Science');

-- Constraints
DROP TABLE student;
CREATE TABLE student (
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(40) NOT NULL,
  -- name VARCHAR(40) UNIQUE,
  major VARCHAR(40) DEFAULT 'undecided'
  -- PRIMARY KEY(student_id)
);

-- Inserting Data
INSERT INTO student (name, major) VALUES('Jack', 'Biology');
INSERT INTO student (name, major) VALUES('Kate', 'Sociology');
INSERT INTO student (name) VALUES('Claire');
INSERT INTO student (name, major) VALUES('Jack', 'Biology');
INSERT INTO student (name, major) VALUES('Mike', 'Computer Science');

SELECT * FROM student;

-- Update & Delete

UPDATE student
SET major= 'Bio'
WHERE major = 'Biology';

UPDATE student
SET major= 'Chemistry'
WHERE student_id = 3;

UPDATE student
SET major= 'Biochemistry'
WHERE major = 'Bio' OR major = 'Chemistry';

UPDATE student
SET name = 'Tom', major = 'undecided'
WHERE student_id = 1;

DELETE FROM student
WHERE student_id = 5;

DELETE FROM student
WHERE name = 'Tom' AND major = 'undecided';

-- Basic Queries
SELECT * FROM student;

SELECT student.name, student.major
FROM student
ORDER BY name DESC;

SELECT student.name, student.major
FROM student
ORDER BY name DESC;
-- LIMIT 2;

SELECT * FROM student
WHERE name = 'Jack';

SELECT *
FROM student
WHERE major = 'Biology' AND student_id > 1;

SELECT * FROM student
WHERE major <> 'Chemistry'; -- Not equal
