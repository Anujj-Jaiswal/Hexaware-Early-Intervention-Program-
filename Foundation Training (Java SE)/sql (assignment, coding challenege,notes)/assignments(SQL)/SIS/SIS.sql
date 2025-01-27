-- Student Information System(SIS) Assignment

-- Task 1 Database Design 
CREATE DATABASE SISDB;
USE SISDB;

CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15)
);

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number) VALUES
('Aarav', 'Sharma', '2000-05-15', 'aarav.sharma@example.com', '9123456789'),
('Vivaan', 'Mehta', '1999-08-22', 'vivaan.mehta@example.com', '9876543210'),
('Vihaan', 'Patel', '2001-12-03', 'vihaan.patel@example.com', '9234567890'),
('Aditya', 'Kumar', '1998-03-17', 'aditya.kumar@example.com', '9345678901'),
('Dhruv', 'Singh', '2000-07-29', 'dhruv.singh@example.com', '9456789012'),
('Krishna', 'Desai', '1999-11-11', 'krishna.desai@example.com', '9567890123'),
('Ishaan', 'Joshi', '2001-02-25', 'ishaan.joshi@example.com', '9678901234'),
('Ananya', 'Gupta', '2000-09-09', 'ananya.gupta@example.com', '9789012345'),
('Saanvi', 'Reddy', '1998-04-30', 'saanvi.reddy@example.com', '9890123456'),
('Riya', 'Bhattacharya', '1999-06-18', 'riya.bhattacharya@example.com', '9901234567');

CREATE TABLE Teacher (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO Teacher (first_name, last_name, email) VALUES
('Rajesh', 'Verma', 'rajesh.verma@example.com'),
('Priya', 'Nair', 'priya.nair@example.com'),
('Suresh', 'Iyer', 'suresh.iyer@example.com'),
('Anita', 'Shah', 'anita.shah@example.com'),
('Deepak', 'Kulkarni', 'deepak.kulkarni@example.com');

CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

INSERT INTO Courses (course_name, credits, teacher_id) VALUES
('Mathematics', 4, 1),
('Physics', 3, 2),
('Chemistry', 3, 3),
('Computer Science', 5, 4),
('English Literature', 2, 5),
('Biology', 3, 1),
('History', 2, 2),
('Economics', 4, 3),
('Philosophy', 2, 4),
('Art', 3, 5);


CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2023-09-01'),
(1, 4, '2023-09-01'),
(2, 2, '2023-09-02'),
(3, 3, '2023-09-03'),
(4, 4, '2023-09-04'),
(5, 5, '2023-09-05'),
(6, 6, '2023-09-06'),
(7, 7, '2023-09-07'),
(8, 8, '2023-09-08'),
(9, 9, '2023-09-09'),
(10, 10, '2023-09-10'),
(2, 5, '2023-09-02'),
(3, 1, '2023-09-03'),
(4, 2, '2023-09-04'),
(5, 3, '2023-09-05');

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Payments (student_id, amount, payment_date) VALUES
(1, 5000.00, '2023-09-15'),
(2, 4500.50, '2023-09-16'),
(3, 4800.75, '2023-09-17'),
(4, 5200.00, '2023-09-18'),
(5, 5000.00, '2023-09-19'),
(6, 4700.25, '2023-09-20'),
(7, 5300.00, '2023-09-21'),
(8, 4900.50, '2023-09-22'),
(9, 5100.75, '2023-09-23'),
(10, 5050.00, '2023-09-24');

-- Tasks 2: 

-- 1. Insert a new student into the "Students" table with the specified details.
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES ('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

-- 2. Enroll a student in a course. 
INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES (1, 2, '2023-09-25');  

-- 3. Update the email address of a specific teacher. 
UPDATE Teacher
SET email = 'new.email@example.com'
WHERE teacher_id = 3; 

-- 4. Delete a specific enrollment record from the "Enrollments" table based on the student and course.
DELETE FROM Enrollments
WHERE student_id = 1 AND course_id = 2;  

-- 5. Update the "Courses" table to assign a specific teacher to a course. 
UPDATE Courses
SET teacher_id = 4  
WHERE course_id = 1; 

-- 6. Delete a specific student from the "Students" table and remove their enrollment records from the "Enrollments" table.
DELETE FROM Students
WHERE student_id = 5;

-- 7. Update the payment amount for a specific payment record in the "Payments" table.
UPDATE Payments
SET amount = 5500.00
WHERE payment_id = 3; 

-- Tasks 3: 

-- 1. Calculate the total payments made by a specific student using JOIN between Payments and Students tables.
SELECT S.first_name, S.last_name, SUM(P.amount) AS total_payments
FROM Students S
JOIN Payments P ON S.student_id = P.student_id
WHERE S.student_id = 1;  

-- 2. Retrieve a list of courses along with the count of students enrolled in each course.
SELECT C.course_name, COUNT(E.student_id) AS student_count
FROM Courses C
JOIN Enrollments E ON C.course_id = E.course_id
GROUP BY C.course_name;

-- 3. Find the names of students who have not enrolled in any course using LEFT JOIN.
SELECT S.first_name, S.last_name
FROM Students S
LEFT JOIN Enrollments E ON S.student_id = E.student_id
WHERE E.enrollment_id IS NULL;

-- 4. Retrieve the first name, last name of students, and the names of the courses they are enrolled in.
SELECT S.first_name, S.last_name, C.course_name
FROM Students S
JOIN Enrollments E ON S.student_id = E.student_id
JOIN Courses C ON E.course_id = C.course_id;

-- 5. List the names of teachers and the courses they are assigned to using a JOIN between Teacher and Courses tables.
SELECT T.first_name, T.last_name, C.course_name
FROM Teacher T
JOIN Courses C ON T.teacher_id = C.teacher_id;

-- 6. Retrieve a list of students and their enrollment dates for a specific course using JOIN.
SELECT S.first_name, S.last_name, E.enrollment_date
FROM Students S
JOIN Enrollments E ON S.student_id = E.student_id
JOIN Courses C ON E.course_id = C.course_id
WHERE C.course_id = 1;  

-- 7. Find the names of students who have not made any payments using LEFT JOIN.
SELECT S.first_name, S.last_name
FROM Students S
LEFT JOIN Payments P ON S.student_id = P.student_id
WHERE P.payment_id IS NULL;

-- 8. Identify courses that have no enrollments using LEFT JOIN.
SELECT C.course_name
FROM Courses C
LEFT JOIN Enrollments E ON C.course_id = E.course_id
WHERE E.enrollment_id IS NULL;

-- 9. Identify students who are enrolled in more than one course using a self-join on the Enrollments table.
SELECT S.first_name, S.last_name, COUNT(E.enrollment_id) AS course_count
FROM Students S
JOIN Enrollments E ON S.student_id = E.student_id
GROUP BY S.student_id
HAVING COUNT(E.enrollment_id) > 1;

-- 10. Find teachers who are not assigned to any courses using LEFT JOIN.
SELECT T.first_name, T.last_name
FROM Teacher T
LEFT JOIN Courses C ON T.teacher_id = C.teacher_id
WHERE C.course_id IS NULL;

-- Tasks 4:

-- 1. Calculate the average number of students enrolled in each course.
SELECT AVG(student_count) AS avg_students_per_course
FROM (
    SELECT course_id, COUNT(student_id) AS student_count
    FROM Enrollments
    GROUP BY course_id
) AS CourseEnrollments;

-- 2. Identify the student(s) who made the highest payment.
SELECT S.first_name, S.last_name, P.amount
FROM Students S
JOIN Payments P ON S.student_id = P.student_id
WHERE P.amount = (SELECT MAX(amount) FROM Payments);

-- 3. Retrieve a list of courses with the highest number of enrollments.
SELECT course_name
FROM Courses
WHERE course_id = (
    SELECT course_id
    FROM Enrollments
    GROUP BY course_id
    ORDER BY COUNT(student_id) DESC
    LIMIT 1
);

-- 4. Calculate the total payments made to courses taught by each teacher.
SELECT T.first_name, T.last_name, (
    SELECT SUM(P.amount)
    FROM Enrollments E
    JOIN Payments P ON E.student_id = P.student_id
    WHERE E.course_id IN (
        SELECT course_id FROM Courses WHERE teacher_id = T.teacher_id
    )
) AS total_payments
FROM Teacher T;

-- 5. Identify students who are enrolled in all available courses.
SELECT first_name, last_name
FROM Students
WHERE student_id IN (
    SELECT student_id
    FROM Enrollments
    GROUP BY student_id
    HAVING COUNT(course_id) = (SELECT COUNT(course_id) FROM Courses)
);

-- 6. Retrieve the names of teachers who have not been assigned to any courses.
SELECT first_name, last_name
FROM Teacher
WHERE teacher_id NOT IN (SELECT teacher_id FROM Courses);

-- 7. Calculate the average age of all students.
SELECT AVG(DATEDIFF(CURDATE(), date_of_birth) / 365) AS avg_age
FROM Students;

-- 8. Identify courses with no enrollments.
SELECT course_name
FROM Courses
WHERE course_id NOT IN (SELECT course_id FROM Enrollments);

-- 9. Calculate the total payments made by each student for each course they are enrolled in.
SELECT E.student_id, E.course_id, SUM(P.amount) AS total_payments
FROM Enrollments E
JOIN Payments P ON E.student_id = P.student_id
GROUP BY E.student_id, E.course_id;

-- 10. Identify students who have made more than one payment.
SELECT student_id
FROM Payments
GROUP BY student_id
HAVING COUNT(payment_id) > 1;

-- 11. Calculate the total payments made by each student.
SELECT S.first_name, S.last_name, SUM(P.amount) AS total_payments
FROM Students S
JOIN Payments P ON S.student_id = P.student_id
GROUP BY S.student_id;

-- 12. Retrieve a list of course names along with the count of students enrolled in each course.
SELECT C.course_name, COUNT(E.student_id) AS student_count
FROM Courses C
JOIN Enrollments E ON C.course_id = E.course_id
GROUP BY C.course_name;

-- 13. Calculate the average payment amount made by students.
SELECT AVG(P.amount) AS avg_payment
FROM Payments P;










