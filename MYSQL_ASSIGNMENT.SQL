mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| accounts           |
| amitdb             |
| exportcsv          |
| information_schema |
| mysql              |
| performance_schema |
| program            |
| stud               |
| student            |
| sys                |
+--------------------+
10 rows in set (0.02 sec)

mysql> create database college_db;
Query OK, 1 row affected (0.12 sec)

mysql> use college_db;
Database changed
mysql> -- Departments
mysql> CREATE TABLE IF NOT EXISTS Departments (
    ->     department_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     department_name VARCHAR(50) NOT NULL
    -> );
Query OK, 0 rows affected (4.01 sec)

mysql>
mysql> -- Students
mysql> CREATE TABLE IF NOT EXISTS Students (
    ->     student_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     name VARCHAR(50) NOT NULL,
    ->     email VARCHAR(50) NOT NULL UNIQUE,
    ->     gender ENUM('Male','Female','Other') NOT NULL,
    ->     dob DATE,
    ->     department_id INT,
    ->     FOREIGN KEY (department_id) REFERENCES Departments(department_id)
    -> );
Query OK, 0 rows affected (0.63 sec)

mysql>
mysql> -- Courses
mysql> CREATE TABLE IF NOT EXISTS Courses (
    ->     course_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     course_name VARCHAR(50) NOT NULL,
    ->     department_id INT,
    ->     credits INT CHECK (credits > 0),
    ->     FOREIGN KEY (department_id) REFERENCES Departments(department_id)
    -> );
Query OK, 0 rows affected (0.47 sec)

mysql>
mysql> -- Enrollments
mysql> CREATE TABLE IF NOT EXISTS Enrollments (
    ->     enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     student_id INT,
    ->     course_id INT,
    ->     enrollment_date DATE,
    ->     FOREIGN KEY (student_id) REFERENCES Students(student_id),
    ->     FOREIGN KEY (course_id) REFERENCES Courses(course_id)
    -> );
Query OK, 0 rows affected (0.55 sec)

mysql>
mysql> -- Marks
mysql> CREATE TABLE IF NOT EXISTS Marks (
    ->     mark_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     student_id INT,
    ->     course_id INT,
    ->     marks_obtained INT CHECK (marks_obtained BETWEEN 0 AND 100),
    ->     FOREIGN KEY (student_id) REFERENCES Students(student_id),
    ->     FOREIGN KEY (course_id) REFERENCES Courses(course_id)
    -> );
Query OK, 0 rows affected (0.51 sec)

mysql> desc marks;
+----------------+------+------+-----+---------+----------------+
| Field          | Type | Null | Key | Default | Extra          |
+----------------+------+------+-----+---------+----------------+
| mark_id        | int  | NO   | PRI | NULL    | auto_increment |
| student_id     | int  | YES  | MUL | NULL    |                |
| course_id      | int  | YES  | MUL | NULL    |                |
| marks_obtained | int  | YES  |     | NULL    |                |
+----------------+------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

mysql> desc enrollments;
+-----------------+------+------+-----+---------+----------------+
| Field           | Type | Null | Key | Default | Extra          |
+-----------------+------+------+-----+---------+----------------+
| enrollment_id   | int  | NO   | PRI | NULL    | auto_increment |
| student_id      | int  | YES  | MUL | NULL    |                |
| course_id       | int  | YES  | MUL | NULL    |                |
| enrollment_date | date | YES  |     | NULL    |                |
+-----------------+------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

mysql> desc students;
+---------------+-------------------------------+------+-----+---------+----------------+
| Field         | Type                          | Null | Key | Default | Extra          |
+---------------+-------------------------------+------+-----+---------+----------------+
| student_id    | int                           | NO   | PRI | NULL    | auto_increment |
| name          | varchar(50)                   | NO   |     | NULL    |                |
| email         | varchar(50)                   | NO   | UNI | NULL    |                |
| gender        | enum('Male','Female','Other') | NO   |     | NULL    |                |
| dob           | date                          | YES  |     | NULL    |                |
| department_id | int                           | YES  | MUL | NULL    |                |
+---------------+-------------------------------+------+-----+---------+----------------+
6 rows in set (0.00 sec)

mysql> desc courses;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| course_id     | int         | NO   | PRI | NULL    | auto_increment |
| course_name   | varchar(50) | NO   |     | NULL    |                |
| department_id | int         | YES  | MUL | NULL    |                |
| credits       | int         | YES  |     | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
4 rows in set (0.01 sec)

mysql> desc departments;
+-----------------+-------------+------+-----+---------+----------------+
| Field           | Type        | Null | Key | Default | Extra          |
+-----------------+-------------+------+-----+---------+----------------+
| department_id   | int         | NO   | PRI | NULL    | auto_increment |
| department_name | varchar(50) | NO   |     | NULL    |                |
+-----------------+-------------+------+-----+---------+----------------+
2 rows in set (0.04 sec)

mysql> INSERT IGNORE INTO Departments (department_id, department_name) VALUES
    -> (1, 'Computer Science'),
    -> (2, 'Electronics'),
    -> (3, 'Mechanical'),
    -> (4, 'Civil'),
    -> (5, 'Mathematics');
Query OK, 5 rows affected (0.20 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from departments;
+---------------+------------------+
| department_id | department_name  |
+---------------+------------------+
|             1 | Computer Science |
|             2 | Electronics      |
|             3 | Mechanical       |
|             4 | Civil            |
|             5 | Mathematics      |
+---------------+------------------+
5 rows in set (0.00 sec)

mysql> INSERT IGNORE INTO Students (name, email, gender, dob, department_id) VALUES
    -> ('Supriya', 'supriya@gmail.com', 'Female', '2002-05-10', 1),
    -> ('Parth', 'parth@gmail.com', 'Male', '2001-07-15', 2),
    -> ('Akshata', 'akshata@gmail.com', 'Female', '2002-03-12', 1),
    -> ('Parinita', 'parinita@gmail.com', 'Female', '2001-11-20', 3),
    -> ('Suraj', 'suraj@gmail.com', 'Male', '2000-09-05', 4),
    -> ('Shruti', 'shruti@gmail.com', 'Female', '2002-06-25', 5),
    -> ('Pragati', 'pragati@gmail.com', 'Female', '2002-12-22', 1),
    -> ('Sonu', 'sonu@gmail.com', 'Male', '2001-08-18', 2),
    -> ('Prabhakar', 'prabhakar@gmail.com', 'Male', '2002-01-30', 3),
    -> ('Siya', 'siya@gmail.com', 'Female', '2001-10-10', 4);
Query OK, 10 rows affected (0.16 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> select * from students;
+------------+-----------+---------------------+--------+------------+---------------+
| student_id | name      | email               | gender | dob        | department_id |
+------------+-----------+---------------------+--------+------------+---------------+
|          1 | Supriya   | supriya@gmail.com   | Female | 2002-05-10 |             1 |
|          2 | Parth     | parth@gmail.com     | Male   | 2001-07-15 |             2 |
|          3 | Akshata   | akshata@gmail.com   | Female | 2002-03-12 |             1 |
|          4 | Parinita  | parinita@gmail.com  | Female | 2001-11-20 |             3 |
|          5 | Suraj     | suraj@gmail.com     | Male   | 2000-09-05 |             4 |
|          6 | Shruti    | shruti@gmail.com    | Female | 2002-06-25 |             5 |
|          7 | Pragati   | pragati@gmail.com   | Female | 2002-12-22 |             1 |
|          8 | Sonu      | sonu@gmail.com      | Male   | 2001-08-18 |             2 |
|          9 | Prabhakar | prabhakar@gmail.com | Male   | 2002-01-30 |             3 |
|         10 | Siya      | siya@gmail.com      | Female | 2001-10-10 |             4 |
+------------+-----------+---------------------+--------+------------+---------------+
10 rows in set (0.07 sec)

mysql> INSERT IGNORE INTO Courses (course_id, course_name, department_id, credits) VALUES
    -> (1, 'Data Structures', 1, 4),
    -> (2, 'Algorithms', 1, 3),
    -> (3, 'Digital Electronics', 2, 3),
    -> (4, 'Microprocessors', 2, 4),
    -> (5, 'Thermodynamics', 3, 3),
    -> (6, 'Fluid Mechanics', 3, 4),
    -> (7, 'Structural Analysis', 4, 3),
    -> (8, 'Linear Algebra', 5, 3);
Query OK, 8 rows affected (0.12 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> select * from courses;
+-----------+---------------------+---------------+---------+
| course_id | course_name         | department_id | credits |
+-----------+---------------------+---------------+---------+
|         1 | Data Structures     |             1 |       4 |
|         2 | Algorithms          |             1 |       3 |
|         3 | Digital Electronics |             2 |       3 |
|         4 | Microprocessors     |             2 |       4 |
|         5 | Thermodynamics      |             3 |       3 |
|         6 | Fluid Mechanics     |             3 |       4 |
|         7 | Structural Analysis |             4 |       3 |
|         8 | Linear Algebra      |             5 |       3 |
+-----------+---------------------+---------------+---------+
8 rows in set (0.00 sec)

mysql> INSERT IGNORE INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
    -> (1, 1, 1, '2025-01-05'),
    -> (2, 1, 2, '2025-01-06'),
    -> (3, 2, 3, '2025-01-07'),
    -> (4, 2, 4, '2025-01-08'),
    -> (5, 3, 1, '2025-01-09'),
    -> (6, 3, 2, '2025-01-10'),
    -> (7, 4, 5, '2025-01-11'),
    -> (8, 4, 6, '2025-01-12'),
    -> (9, 5, 7, '2025-01-13'),
    -> (10, 6, 8, '2025-01-14'),
    -> (11, 7, 1, '2025-01-15'),
    -> (12, 8, 3, '2025-01-16'),
    -> (13, 9, 5, '2025-01-17'),
    -> (14, 9, 6, '2025-01-18'),
    -> (15, 10, 7, '2025-01-19');
Query OK, 15 rows affected (0.11 sec)
Records: 15  Duplicates: 0  Warnings: 0

mysql> select * from enrollments;
+---------------+------------+-----------+-----------------+
| enrollment_id | student_id | course_id | enrollment_date |
+---------------+------------+-----------+-----------------+
|             1 |          1 |         1 | 2025-01-05      |
|             2 |          1 |         2 | 2025-01-06      |
|             3 |          2 |         3 | 2025-01-07      |
|             4 |          2 |         4 | 2025-01-08      |
|             5 |          3 |         1 | 2025-01-09      |
|             6 |          3 |         2 | 2025-01-10      |
|             7 |          4 |         5 | 2025-01-11      |
|             8 |          4 |         6 | 2025-01-12      |
|             9 |          5 |         7 | 2025-01-13      |
|            10 |          6 |         8 | 2025-01-14      |
|            11 |          7 |         1 | 2025-01-15      |
|            12 |          8 |         3 | 2025-01-16      |
|            13 |          9 |         5 | 2025-01-17      |
|            14 |          9 |         6 | 2025-01-18      |
|            15 |         10 |         7 | 2025-01-19      |
+---------------+------------+-----------+-----------------+
15 rows in set (0.00 sec)

mysql> INSERT IGNORE INTO Marks (student_id, course_id, marks_obtained) VALUES
    -> (1, 1, 85),
    -> (1, 2, 90),
    -> (2, 3, 78),
    -> (2, 4, 82),
    -> (3, 1, 88),
    -> (3, 2, 92),
    -> (4, 5, 75),
    -> (4, 6, 80),
    -> (5, 7, 70),
    -> (6, 8, 95),
    -> (7, 1, 84),
    -> (8, 3, 76),
    -> (9, 5, 89),
    -> (9, 6, 91),
    -> (10, 7, 73);
Query OK, 15 rows affected (0.11 sec)
Records: 15  Duplicates: 0  Warnings: 0

mysql> select * from marks;
+---------+------------+-----------+----------------+
| mark_id | student_id | course_id | marks_obtained |
+---------+------------+-----------+----------------+
|       1 |          1 |         1 |             85 |
|       2 |          1 |         2 |             90 |
|       3 |          2 |         3 |             78 |
|       4 |          2 |         4 |             82 |
|       5 |          3 |         1 |             88 |
|       6 |          3 |         2 |             92 |
|       7 |          4 |         5 |             75 |
|       8 |          4 |         6 |             80 |
|       9 |          5 |         7 |             70 |
|      10 |          6 |         8 |             95 |
|      11 |          7 |         1 |             84 |
|      12 |          8 |         3 |             76 |
|      13 |          9 |         5 |             89 |
|      14 |          9 |         6 |             91 |
|      15 |         10 |         7 |             73 |
+---------+------------+-----------+----------------+
15 rows in set (0.00 sec)

mysql> SELECT * FROM Students;
+------------+-----------+---------------------+--------+------------+---------------+
| student_id | name      | email               | gender | dob        | department_id |
+------------+-----------+---------------------+--------+------------+---------------+
|          1 | Supriya   | supriya@gmail.com   | Female | 2002-05-10 |             1 |
|          2 | Parth     | parth@gmail.com     | Male   | 2001-07-15 |             2 |
|          3 | Akshata   | akshata@gmail.com   | Female | 2002-03-12 |             1 |
|          4 | Parinita  | parinita@gmail.com  | Female | 2001-11-20 |             3 |
|          5 | Suraj     | suraj@gmail.com     | Male   | 2000-09-05 |             4 |
|          6 | Shruti    | shruti@gmail.com    | Female | 2002-06-25 |             5 |
|          7 | Pragati   | pragati@gmail.com   | Female | 2002-12-22 |             1 |
|          8 | Sonu      | sonu@gmail.com      | Male   | 2001-08-18 |             2 |
|          9 | Prabhakar | prabhakar@gmail.com | Male   | 2002-01-30 |             3 |
|         10 | Siya      | siya@gmail.com      | Female | 2001-10-10 |             4 |
+------------+-----------+---------------------+--------+------------+---------------+
10 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM Students
    -> WHERE department_id = 1;
+------------+---------+-------------------+--------+------------+---------------+
| student_id | name    | email             | gender | dob        | department_id |
+------------+---------+-------------------+--------+------------+---------------+
|          1 | Supriya | supriya@gmail.com | Female | 2002-05-10 |             1 |
|          3 | Akshata | akshata@gmail.com | Female | 2002-03-12 |             1 |
|          7 | Pragati | pragati@gmail.com | Female | 2002-12-22 |             1 |
+------------+---------+-------------------+--------+------------+---------------+
3 rows in set (0.05 sec)

mysql> SELECT c.course_name, d.department_name
    -> FROM Courses c
    -> JOIN Departments d ON c.department_id = d.department_id;
+---------------------+------------------+
| course_name         | department_name  |
+---------------------+------------------+
| Data Structures     | Computer Science |
| Algorithms          | Computer Science |
| Digital Electronics | Electronics      |
| Microprocessors     | Electronics      |
| Thermodynamics      | Mechanical       |
| Fluid Mechanics     | Mechanical       |
| Structural Analysis | Civil            |
| Linear Algebra      | Mathematics      |
+---------------------+------------------+
8 rows in set (0.00 sec)

mysql> SELECT s.name, COUNT(e.course_id) AS total_courses
    -> FROM Students s
    -> JOIN Enrollments e ON s.student_id = e.student_id
    -> GROUP BY s.student_id
    -> HAVING COUNT(e.course_id) > 1;
+-----------+---------------+
| name      | total_courses |
+-----------+---------------+
| Supriya   |             2 |
| Parth     |             2 |
| Akshata   |             2 |
| Parinita  |             2 |
| Prabhakar |             2 |
+-----------+---------------+
5 rows in set (0.06 sec)

mysql> SELECT s.name, m.marks_obtained
    -> FROM Students s
    -> JOIN Marks m ON s.student_id = m.student_id
    -> WHERE m.marks_obtained > 75;
+-----------+----------------+
| name      | marks_obtained |
+-----------+----------------+
| Supriya   |             85 |
| Supriya   |             90 |
| Parth     |             78 |
| Parth     |             82 |
| Akshata   |             88 |
| Akshata   |             92 |
| Parinita  |             80 |
| Shruti    |             95 |
| Pragati   |             84 |
| Sonu      |             76 |
| Prabhakar |             89 |
| Prabhakar |             91 |
+-----------+----------------+
12 rows in set (0.00 sec)

mysql> SELECT s.name AS Student, c.course_name AS Course, m.marks_obtained AS Marks
    -> FROM Marks m
    -> JOIN Students s ON m.student_id = s.student_id
    -> JOIN Courses c ON m.course_id = c.course_id;
+-----------+---------------------+-------+
| Student   | Course              | Marks |
+-----------+---------------------+-------+
| Supriya   | Data Structures     |    85 |
| Akshata   | Data Structures     |    88 |
| Pragati   | Data Structures     |    84 |
| Supriya   | Algorithms          |    90 |
| Akshata   | Algorithms          |    92 |
| Parth     | Digital Electronics |    78 |
| Sonu      | Digital Electronics |    76 |
| Parth     | Microprocessors     |    82 |
| Parinita  | Thermodynamics      |    75 |
| Prabhakar | Thermodynamics      |    89 |
| Parinita  | Fluid Mechanics     |    80 |
| Prabhakar | Fluid Mechanics     |    91 |
| Suraj     | Structural Analysis |    70 |
| Siya      | Structural Analysis |    73 |
| Shruti    | Linear Algebra      |    95 |
+-----------+---------------------+-------+
15 rows in set (0.00 sec)

mysql> SELECT s.name
    -> FROM Students s
    -> LEFT JOIN Marks m ON s.student_id = m.student_id
    -> WHERE m.marks_obtained IS NULL;
Empty set (0.01 sec)

mysql> SELECT d.department_name, COUNT(s.student_id) AS total_students
    -> FROM Departments d
    -> LEFT JOIN Students s ON d.department_id = s.department_id
    -> GROUP BY d.department_id;
+------------------+----------------+
| department_name  | total_students |
+------------------+----------------+
| Computer Science |              3 |
| Electronics      |              2 |
| Mechanical       |              2 |
| Civil            |              2 |
| Mathematics      |              1 |
+------------------+----------------+
5 rows in set (0.00 sec)

mysql> SELECT c.course_name, AVG(m.marks_obtained) AS avg_marks
    -> FROM Courses c
    -> LEFT JOIN Marks m ON c.course_id = m.course_id
    -> GROUP BY c.course_id;
+---------------------+-----------+
| course_name         | avg_marks |
+---------------------+-----------+
| Data Structures     |   85.6667 |
| Algorithms          |   91.0000 |
| Digital Electronics |   77.0000 |
| Microprocessors     |   82.0000 |
| Thermodynamics      |   82.0000 |
| Fluid Mechanics     |   85.5000 |
| Structural Analysis |   71.5000 |
| Linear Algebra      |   95.0000 |
+---------------------+-----------+
8 rows in set (0.04 sec)

