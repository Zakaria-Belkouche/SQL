-- drop database assesment;

CREATE database assesment;
USE assesment;

CREATE table academy(company_ID int PRIMARY KEY, 
						company_name varchar(50), 
                        location varchar(50),
                        company_size int);
                        
INSERT into academy VALUES(1, "mthree", "Canary Wharf", 6);
INSERT into academy VALUES(2, "random", "London", 8);
INSERT into academy VALUES(3, "spark", "Canada", 10);
INSERT into academy VALUES(4, "lion", "Birmingham", 7);
INSERT into academy VALUES(5, "tech", "Manchester", 14);
                        
CREATE table client(client_ID int PRIMARY KEY, 
						client_name varchar(50), 
                        company_ID int,
                        FOREIGN KEY (company_ID) REFERENCES academy(company_ID));
                        
INSERT into client VALUES(1, "ubs", "1");
INSERT into client VALUES(2, "HSBC", "1");
INSERT into client VALUES(3, "Barclays", "1");

INSERT into client VALUES(4, "openAI", "2");
INSERT into client VALUES(5, "capgemini", "2");

INSERT into client VALUES(6, "microsoft", "3");
INSERT into client VALUES(7, "apple", "3");

INSERT into client VALUES(8, "amazon", "4");

INSERT into client VALUES(9, "samsung", "5");

CREATE table courses(course_ID int PRIMARY KEY,
						course_name varchar(50), 
                        company_ID int, 
                        FOREIGN KEY (company_ID) REFERENCES academy(company_ID));
                        
INSERT into courses VALUES(10, "TechAccelerator Programme", 1);
INSERT into courses VALUES(11, "Software Engineer", 1);
INSERT into courses VALUES(12, "BA/DA pathway", 1);

INSERT into courses VALUES(13, "Finance", 2);
INSERT into courses VALUES(14, "Banking", 2);

INSERT into courses VALUES(15, "Teaching", 3);
INSERT into courses VALUES(16, "Tutoring", 3);

INSERT into courses VALUES(17, "Sales", 4);

INSERT into courses VALUES(18, "Production", 5);


CREATE table students(student_ID int PRIMARY KEY, 
						student_name varchar(50), 
                        student_email varchar(50) UNIQUE,
                        student_age int,
                        course_ID int,
                        FOREIGN KEY (course_ID) REFERENCES courses(course_ID));
                        
INSERT into students VALUES(19, "zak", "zak@email.com", 25, 10);
INSERT into students VALUES(20, "charlie", "charlie@email.com", 20, 10);
INSERT into students VALUES(21, "kieran", "kieran@email.com", 22, 10);
INSERT into students VALUES(22, "ikrama", "ikrama@email.com", 23, 10);
INSERT into students VALUES(23, "saheeb", "saheeb@email.com", 22, 10);

INSERT into students VALUES(24, "chris", "chris@email.com", 30, 11);
INSERT into students VALUES(25, "luke", "luke@email.com", 28, 11);

INSERT into students VALUES(26, "Doriel", "Doriel@email.com", 27, 12);

INSERT INTO students VALUES(27, "Bob", "bob@email.com", 22, 13);
INSERT INTO students VALUES(28, "Max", "max@email.com", 24, 13);

INSERT INTO students VALUES(29, "Tim", "tim@email.com", 20, 14);

INSERT INTO students VALUES(30, "Raafi", "raafi@email.com", 26, 15);
INSERT INTO students VALUES(31, "Hannah", "hannah@email.com", 23, 15);
INSERT INTO students VALUES(32, "Aisha", "aisha@email.com", 22, 15);

INSERT INTO students VALUES(33, "Tom", "tom@email.com", 24, 16);

INSERT INTO students VALUES(34, "Ella", "ella@email.com", 21, 17);
INSERT INTO students VALUES(35, "Jake", "jake@email.com", 25, 17);
INSERT INTO students VALUES(36, "Maya", "maya@email.com", 23, 17);

INSERT INTO students VALUES(37, "Noah", "noah@email.com", 26, 18);
INSERT INTO students VALUES(38, "Sophie", "sophie@email.com", 22, 18);


CREATE table teacher(teacher_ID int PRIMARY KEY,
						teacher_name varchar(50),
                        teacher_email varchar(50) UNIQUE);
                        
INSERT INTO teacher VALUES(59, "Kishore", "kishore@email.com");
INSERT INTO teacher VALUES(60, "Dan", "dan@email.com");
INSERT INTO teacher VALUES(61, "Krisha", "krisha@email.com");
INSERT INTO teacher VALUES(62, "Luke", "luke@email.com");



CREATE table modules(module_ID int PRIMARY KEY,
						module_name varchar(50),
                        course_ID int,
                        teacher_ID int,
                        FOREIGN KEY (course_ID) REFERENCES courses(course_ID),
                        FOREIGN KEY (teacher_ID) REFERENCES teacher(teacher_ID));
                        
INSERT INTO modules VALUES(39, "Python", 10, 59);
INSERT INTO modules VALUES(40, "SQL", 10, 59);
INSERT INTO modules VALUES(41, "Linux", 10, 59);
INSERT INTO modules VALUES(42, "Azure", 10, 59);
INSERT INTO modules VALUES(43, "IT fundementals", 10, 59);

INSERT INTO modules VALUES(44, "C", 11, 60);
INSERT INTO modules VALUES(45, "C#", 11, 60);
INSERT INTO modules VALUES(46, "JavaScript", 11, 60);
INSERT INTO modules VALUES(47, "HTML", 11, 60);

INSERT INTO modules VALUES(48, "Finance", 12, 60);
INSERT INTO modules VALUES(49, "Data Handling", 12, 61);
INSERT INTO modules VALUES(50, "Social Skills", 12, 61);

INSERT INTO modules VALUES(51, "Interest", 13, 61);
INSERT INTO modules VALUES(52, "Inflation", 13, 62);

INSERT INTO modules VALUES(53, "Types of Banks", 14, 62);

INSERT INTO modules VALUES(54, "Maths", 15, 60);
INSERT INTO modules VALUES(55, "Physics", 15, 59);

INSERT INTO modules VALUES(56, "Chemistry", 16, 60);

INSERT INTO modules VALUES(57, "Closing", 17, 59);

INSERT INTO modules VALUES(58, "Manufacture", 18, 62);
					

-- Time for some Questions / Tasks!

-- Question 1) Show all academy names and their locations.

SELECT company_name, location FROM academy;

-- Question 2) Show the names and emails of all students who are 
-- 					enrolled in the course with the ID 10.

SELECT student_name, student_age FROM students WHERE course_ID = 10;

-- Question 3) Show each student’s name along with the course name they’re enrolled in.

SELECT s.student_name, c.course_name
FROM students AS s
INNER JOIN
courses AS c
ON c.course_ID = s.course_ID;
                        
-- Question 4) Show the names of all courses along with the
-- 				teacher names who teach their modules.

SELECT c.course_name, m.module_name, t.teacher_name 
FROM courses as c
INNER JOIN
modules as m ON c.course_ID = m.course_ID
INNER JOIN
teacher as t ON m.teacher_ID = t.teacher_ID;

-- Question 5)
-- For each course, show the course name and the number of students enrolled, 
-- including courses with zero students, ordered by the count (highest first).

SELECT c.course_name, COUNT(s.student_ID) AS student_count
FROM courses as c
LEFT JOIN
students as s
ON c.course_ID = s.course_ID
GROUP BY c.course_name
ORDER BY student_count DESC;

-- Question 6)
-- Show the names of all teachers and the total number of modules 
-- each one teaches, ordered from most to least.

SELECT teacher_name, count(m.module_ID) AS module_count
FROM teacher AS t
LEFT JOIN
modules as m
ON t.teacher_ID = m.teacher_ID
GROUP BY teacher_name
ORDER BY module_count DESC;

-- Question 7)
-- Show each client’s name along with the academy (company) name they’re associated with.

SELECT c.client_name, a.company_name
FROM client as c
INNER JOIN
academy as a
ON c.company_ID = a.company_ID;

-- Question 8)
-- Show the course name, module name, and teacher name 
-- but only for courses taught by the teacher “Kishore.”

SELECT c.course_name, m.module_name, t.teacher_name
FROM courses as c
INNER JOIN 
modules AS m ON c.course_ID = m.course_ID
INNER JOIN
teacher AS t ON t.teacher_ID = m.teacher_ID
WHERE t.teacher_name = "kishore";

-- Question 9)
-- Show each academy’s name and the total number of clients they have
-- including academies with no clients.

SELECT a.company_name, count(c.client_ID) AS client_count
FROM academy as a
LEFT JOIN
client as c ON a.company_ID = c.company_ID
GROUP BY a.company_ID;

-- Question 10)
-- Show each course name along with the average age of students enrolled in that course.

SELECT c.course_name, AVG(s.student_age) as average_age
FROM courses as c
INNER JOIN
students as s ON s.course_ID = c.course_ID
GROUP BY c.course_name;

-- Question 11) 
-- Create an index on the student_email column in the students table
-- to speed up queries that search for a student by their email address.

CREATE INDEX idxStudentEmail ON students(student_email);
SELECT * FROM students WHERE student_email = "zak@email.com";

-- Question 12)
-- Create a trigger that automatically stores a record in a log table
-- whenever a new student is added to the students table.

CREATE table student_log(log_ID int AUTO_INCREMENT PRIMARY KEY, 
								student_name varchar(50), 
                                action varchar(20),
                                created_at DATETIME);
                                
DELIMITER $$
CREATE TRIGGER T1 
AFTER INSERT ON students
FOR EACH ROW
BEGIN
INSERT INTO student_log (student_name, action, created_at) 
VALUES (NEW.student_name, "INSERT", NOW());
END$$
Delimiter ;

INSERT into students VALUES(1234, "amira", "amira@email.com", 21, 10);

SELECT * FROM student_log;                                


