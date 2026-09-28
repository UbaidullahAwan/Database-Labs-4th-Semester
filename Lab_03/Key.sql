-- ====================================== MySQL Lab Guide  ======================================



-- ====================================== Part A ========================================

/*
  Statement 1: Create a database for the University Lab and select it.

  Query 1:      CREATE DATABASE IF NOT EXISTS UniversityLab;
                USE UniversityLab;


  Statement 2: Create the Departments table with Primary Key and Unique Key constraints.

  Query 2:      CREATE TABLE departments (
                    dept_id INT PRIMARY KEY,
                    dept_name VARCHAR(100) UNIQUE
                );


  Statement 3: Create the Students table with Primary Key, NOT NULL, Unique Key, and Foreign Key constraints.

  Query 3:      CREATE TABLE students (
                    student_id INT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    email VARCHAR(100) UNIQUE,
                    age INT,
                    dept_id INT,
                    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
                );


  Statement 4: Create the Courses table with a Primary Key and Foreign Key.

  Query 4:      CREATE TABLE courses (
                    course_id INT PRIMARY KEY,
                    course_name VARCHAR(100),
                    dept_id INT,
                    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
                );


  Statement 5: Create the Instructors table with Primary Key, Unique Key, and Foreign Key constraints.

  Query 5:      CREATE TABLE instructors (
                    instructor_id INT PRIMARY KEY,
                    name VARCHAR(100),
                    email VARCHAR(100) UNIQUE,
                    dept_id INT,
                    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
                );


  Statement 6: Create the Enrollments table using a Composite Primary Key and Foreign Keys.

  Query 6:      CREATE TABLE enrollments (
                    student_id INT,
                    course_id INT,
                    semester VARCHAR(20),
                    PRIMARY KEY (student_id, course_id),
                    FOREIGN KEY (student_id) REFERENCES students(student_id),
                    FOREIGN KEY (course_id) REFERENCES courses(course_id)
                );
*/


-- ====================================== Part B: Insert Data ========================================

/*
  Statement 1: Insert sample records into the Departments table.

  Query 1:      INSERT INTO departments VALUES
                (1, 'CS'),
                (2, 'EE');


  Statement 2: Insert sample records into the Students table.

  Query 2:      INSERT INTO students (name, email, age, dept_id) VALUES
                ('Ali', 'ali@gmail.com', 20, 1),
                ('Sara', 'sara@gmail.com', 21, 1),
                ('Ahmed', 'ahmed@gmail.com', 22, 2);


  Statement 3: Insert sample records into the Courses table.

  Query 3:      INSERT INTO courses VALUES
                (101, 'Database', 1),
                (102, 'AI', 1),
                (201, 'Circuits', 2);


  Statement 4: Insert sample records into the Enrollments table.

  Query 4:      INSERT INTO enrollments VALUES
                (1, 101, 'Fall 2025'),
                (1, 102, 'Fall 2025'),
                (2, 101, 'Fall 2025');


  Statement 5: Insert sample records into the Instructors table.

  Query 5:      INSERT INTO instructors (instructor_id, name, email, dept_id) VALUES
                (1, 'Dr. Khan', 'khan@gmail.com', 1),
                (2, 'Dr. Ahmed', 'dr.ahmed@gmail.com', 2);
*/


-- ====================================== Part C: Lab Tasks ========================================

/*
  Statement 1: Create the above tables with constraints.

  Query 1:      CREATE TABLE departments (
                    dept_id INT PRIMARY KEY,
                    dept_name VARCHAR(100) UNIQUE
                );

                CREATE TABLE students (
                    student_id INT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    email VARCHAR(100) UNIQUE,
                    age INT,
                    dept_id INT,
                    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
                );

                CREATE TABLE courses (
                    course_id INT PRIMARY KEY,
                    course_name VARCHAR(100),
                    dept_id INT,
                    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
                );

                CREATE TABLE instructors (
                    instructor_id INT PRIMARY KEY,
                    name VARCHAR(100),
                    email VARCHAR(100) UNIQUE,
                    dept_id INT,
                    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
                );

                CREATE TABLE enrollments (
                    student_id INT,
                    course_id INT,
                    semester VARCHAR(20),
                    PRIMARY KEY (student_id, course_id),
                    FOREIGN KEY (student_id) REFERENCES students(student_id),
                    FOREIGN KEY (course_id) REFERENCES courses(course_id)
                );


  Statement 2: Insert data and query the tables using SELECT.

  Query 2:      INSERT INTO departments VALUES (1,'CS'),(2,'EE');

                INSERT INTO students (name,email,age,dept_id) VALUES
                ('Ali','ali@gmail.com',20,1),
                ('Sara','sara@gmail.com',21,1),
                ('Ahmed','ahmed@gmail.com',22,2);

                INSERT INTO courses VALUES
                (101,'Database',1),
                (102,'AI',1),
                (201,'Circuits',2);

                INSERT INTO enrollments VALUES
                (1,101,'Fall 2025'),
                (1,102,'Fall 2025'),
                (2,101,'Fall 2025');

                SELECT * FROM departments;
                SELECT * FROM students;
                SELECT * FROM courses;
                SELECT * FROM instructors;
                SELECT * FROM enrollments;


  Statement 3: Update a student's name.

  Query 3:      UPDATE students
                SET name = 'Ali Khan'
                WHERE student_id = 1;


  Statement 4: Delete a student record.

  Query 4:      DELETE FROM students
                WHERE student_id = 3;


  Statement 5: Try TRUNCATE and DROP.

  Query 5:      TRUNCATE TABLE instructors;

                DROP TABLE instructors;


  Statement 6: Add a new column using ALTER TABLE.

  Query 6:      ALTER TABLE students
                ADD phone VARCHAR(20);


  Statement 7: Practice joins between Students and Courses.

  Query 7:      SELECT
                    s.student_id,
                    s.name AS StudentName,
                    c.course_id,
                    c.course_name AS CourseName,
                    e.semester
                FROM students s
                JOIN enrollments e
                    ON s.student_id = e.student_id
                JOIN courses c
                    ON e.course_id = c.course_id
                ORDER BY s.student_id, c.course_id;


  Statement 8: Explore candidate keys, alternate keys, and composite keys.

  Query 8:      -- Candidate Keys in Students:
                -- student_id and email can uniquely identify a student.

                SELECT student_id, email
                FROM students;

                -- Alternate Key:
                -- email is an alternate key because student_id is selected
                -- as the Primary Key while email is still UNIQUE.

                SELECT email
                FROM students;

                -- Composite Key:
                -- student_id + course_id together form the Primary Key
                -- of the enrollments table.

                SELECT student_id, course_id
                FROM enrollments;
*/


-- ====================================== Part D: Database Keys Practice ========================================

/*
  Statement 1: Demonstrate a Primary Key.

  Query 1:      CREATE TABLE key_students (
                    student_id INT PRIMARY KEY,
                    name VARCHAR(100),
                    email VARCHAR(100)
                );


  Statement 2: Demonstrate a Foreign Key.

  Query 2:      CREATE TABLE key_departments (
                    dept_id INT PRIMARY KEY,
                    dept_name VARCHAR(100)
                );

                ALTER TABLE key_students
                ADD dept_id INT,
                ADD CONSTRAINT fk_key_department
                FOREIGN KEY (dept_id) REFERENCES key_departments(dept_id);


  Statement 3: Demonstrate a Unique Key.

  Query 3:      ALTER TABLE key_students
                ADD CONSTRAINT unique_key_email UNIQUE (email);


  Statement 4: Demonstrate a Composite Key.

  Query 4:      CREATE TABLE key_enrollments (
                    student_id INT,
                    course_id INT,
                    PRIMARY KEY (student_id, course_id)
                );


  Statement 5: Identify Candidate Keys.

  Query 5:      -- Candidate keys are columns capable of uniquely identifying a row.
                -- In the students table, student_id and email are candidate keys.


  Statement 6: Identify an Alternate Key.

  Query 6:      -- student_id is chosen as the Primary Key.
                -- Therefore, email (which is UNIQUE) acts as an Alternate Key.


  Statement 7: Identify Super Keys.

  Query 7:      -- Examples of super keys:
                -- student_id
                -- email
                -- student_id + name


  Statement 8: Demonstrate a Natural Key.

  Query 8:      CREATE TABLE citizens (
                    cnic VARCHAR(15) PRIMARY KEY,
                    name VARCHAR(100)
                );


  Statement 9: Demonstrate a Surrogate Key.

  Query 9:      CREATE TABLE surrogate_students (
                    student_id INT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(100),
                    email VARCHAR(100)
                );
*/


-- ====================================== Part E: Table Commands Practice ========================================

/*
  Statement 1: Add a phone column to Students.

  Query 1:      ALTER TABLE students
                ADD phone VARCHAR(20);


  Statement 2: Modify the age column so that it cannot contain NULL.

  Query 2:      ALTER TABLE students
                MODIFY age INT NOT NULL;


  Statement 3: Add a department-name column and then rename it to department.

  Query 3:      ALTER TABLE students
                ADD dept_name VARCHAR(50);

                ALTER TABLE students
                CHANGE dept_name department VARCHAR(50);


  Statement 4: Drop the phone column.

  Query 4:      ALTER TABLE students
                DROP COLUMN phone;


  Statement 5: Add a Unique constraint to email if creating a practice table without one.

  Query 5:      ALTER TABLE surrogate_students
                ADD CONSTRAINT unique_surrogate_email UNIQUE (email);
*/


-- ====================================== Part F: CRUD Operations ========================================

/*
  Statement 1: INSERT a new student.

  Query 1:      INSERT INTO students (name, email, age, dept_id)
                VALUES ('Usman', 'usman@gmail.com', 23, 1);


  Statement 2: SELECT all students.

  Query 2:      SELECT * FROM students;


  Statement 3: UPDATE a student's name.

  Query 3:      UPDATE students
                SET name = 'Usman Khan'
                WHERE email = 'usman@gmail.com';


  Statement 4: DELETE the newly inserted student.

  Query 4:      DELETE FROM students
                WHERE email = 'usman@gmail.com';
*/


-- ====================================== Part G: Additional JOIN Practice ========================================

/*
  Statement 1: Show every enrolled student with course and department information.

  Query 1:      SELECT
                    s.student_id,
                    s.name AS StudentName,
                    c.course_name AS CourseName,
                    d.dept_name AS Department,
                    e.semester
                FROM students s
                JOIN enrollments e
                    ON s.student_id = e.student_id
                JOIN courses c
                    ON e.course_id = c.course_id
                JOIN departments d
                    ON c.dept_id = d.dept_id
                ORDER BY s.student_id;


  Statement 2: Show all students, including students who are not enrolled in any course.

  Query 2:      SELECT
                    s.student_id,
                    s.name AS StudentName,
                    c.course_name AS CourseName,
                    e.semester
                FROM students s
                LEFT JOIN enrollments e
                    ON s.student_id = e.student_id
                LEFT JOIN courses c
                    ON e.course_id = c.course_id
                ORDER BY s.student_id;


  Statement 3: Show each course with the number of enrolled students.

  Query 3:      SELECT
                    c.course_id,
                    c.course_name,
                    COUNT(e.student_id) AS TotalStudents
                FROM courses c
                LEFT JOIN enrollments e
                    ON c.course_id = e.course_id
                GROUP BY c.course_id, c.course_name
                ORDER BY c.course_id;
*/


-- ====================================== End of Solved Lab ========================================
