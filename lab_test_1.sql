CREATE DATABASE student_enroll;

USE student_enroll;

-- Question i
CREATE TABLE student(
    regno VARCHAR(20) PRIMARY KEY,
    name VARCHAR(20),
    major VARCHAR(20),
    bdate date
);

CREATE TABLE course(
    course_no INT PRIMARY KEY,
    cname VARCHAR(20),
    dept VARCHAR(20)
);

CREATE TABLE enroll(
    regno VARCHAR(20),
    course_no INT,
    marks INT,
    sem INT,
    PRIMARY KEY(regno,course_no),
    FOREIGN KEY(regno) REFERENCES student(regno) ON DELETE CASCADE,
    FOREIGN KEY(course_no) REFERENCES course(course_no) ON DELETE CASCADE
);

CREATE TABLE text(
    book_isbn INT PRIMARY KEY,
    book_title VARCHAR(40),
    publisher VARCHAR(20),
    author VARCHAR(20)
);

CREATE TABLE book_adoption(
    course_no INT,
    sem INT,
    book_isbn INT,
    FOREIGN KEY(course_no) REFERENCES course(course_no) ON DELETE CASCADE,
    FOREIGN KEY(book_isbn) REFERENCES text(book_isbn) ON DELETE CASCADE
);

-- Question ii
INSERT INTO student VALUES('CS01','RAM','DS','1986-03-12');
INSERT INTO student VALUES('IS02','SMITH','USP','1987-12-23');
INSERT INTO student VALUES('EC03','AHMED','SNS','1985-04-17');
INSERT INTO student VALUES('CS03','SNEHA','DBMS','1987-01-01');
INSERT INTO student VALUES('TC05','AKHILA','EC','1986-10-06');

SELECT * FROM student;

INSERT INTO course VALUES(11,'DS','CS');
INSERT INTO course VALUES(22,'USP','IS');
INSERT INTO course VALUES(33,'SNS','EC');
INSERT INTO course VALUES(44,'DBMS','CS');
INSERT INTO course VALUES(55,'EC','TC');

SELECT * FROM course;

INSERT INTO enroll VALUES('CS01',11,4,85);
INSERT INTO enroll VALUES('IS02',22,6,80);
INSERT INTO enroll VALUES('EC03',33,2,80);
INSERT INTO enroll VALUES('CS03',44,6,75);
INSERT INTO enroll VALUES('TC05',55,2,8);

SELECT * FROM enroll;

INSERT INTO text VALUES(1,'DS and C','Princeton','Reddy');
INSERT INTO text VALUES(2,'Fundamentals of DS','Princeton','Shanbhag');
INSERT INTO text VALUES(3,'Fundamentals of DBMS','Princeton','Robin');
INSERT INTO text VALUES(4,'SQL','Princeton','Cotran');
INSERT INTO text VALUES(5,'Electronic circuits','TMH','Tripathi');
INSERT INTO text VALUES(6,'Adv unix prog','TMH','Baveja');

SELECT * FROM text;

INSERT INTO book_adoption VALUES(11,4,1);
INSERT INTO book_adoption VALUES(11,4,2);
INSERT INTO book_adoption VALUES(44,6,3);
INSERT INTO book_adoption VALUES(44,6,4);
INSERT INTO book_adoption VALUES(55,2,5);
INSERT INTO book_adoption VALUES(22,6,6);

SELECT * FROM book_adoption;

-- Question iii
INSERT INTO text VALUES(7,'C programming and DS','Princeton','Reddy');
INSERT INTO book_adoption VALUES(11,4,7);

-- Question iv
SELECT c.course_no,t.book_isbn,t.book_title FROM course c,text t,book_adoption b
WHERE c.course_no=b.course_no
AND
b.book_isbn=t.book_isbn
AND
c.dept='CS'
GROUP BY b.course_no
HAVING COUNT(b.course_no)>2
ORDER BY t.book_title;

-- Question v
SELECT c.dept FROM course c, book_adoption b,text t
WHERE c.course_no=b.course_no
AND
b.book_isbn=t.book_isbn
AND
t.publisher='TMH';

-- Question vi
CREATE VIEW new_view(course,total_book_isbn,publisher)
AS SELECT c.course_no,COUNT(b.book_isbn),t.publisher FROM course c, book_adoption b,text t
WHERE c.course_no=b.course_no
AND
b.book_isbn=t.book_isbn
GROUP BY b.course_no;

-- Question vii
SELECT c.cname FROM course c, book_adoption b,text t
WHERE c.course_no=b.course_no
AND
b.book_isbn=t.book_isbn
AND
t.publisher='Springer';
