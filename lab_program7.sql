CREATE DATABASE AIRLINE;

USE AIRLINE;

CREATE TABLE flights(
    flno INT PRIMARY KEY,
    from_place VARCHAR(40),
    to_place VARCHAR(40),
    distance INT,
    departs TIME,
    arrives TIME,
    price INT
);

CREATE TABLE aircraft(
    aid INT PRIMARY KEY,
    aname VARCHAR(40),
    cruisingrange INT
);

CREATE TABLE employee(
    eid INT PRIMARY KEY,
    ename VARCHAR(40),
    salary INT
);

CREATE TABLE certified(
    eid INT,
    aid INT,
    FOREIGN KEY(eid) REFERENCES employee(eid) ON DELETE CASCADE,
    FOREIGN KEY(aid) REFERENCES aircraft(aid) ON DELETE CASCADE,
    PRIMARY KEY(eid,aid)
);

INSERT INTO flights VALUES(1,"Bengaluru","Mumbai",500,"16:00:00","19:00:00",5000);
INSERT INTO flights VALUES(2,"Madison","Washington",300,"04:50:00","10:30:00",3000);
INSERT INTO flights VALUES(3,"Bengaluru","New Delhi",800,"10:00:00","13:00:00",8000);
INSERT INTO flights VALUES(4,"Washington","New York",900,"16:00:00","17:00:00",9000);
INSERT INTO flights VALUES(5,"Bengaluru","Ahemdabad",950,"15:20:00","17:15:00",5000);
INSERT INTO flights VALUES(6,"Bengaluru","Frankfurt",750,"18:20:00","21:15:00",8000);
INSERT INTO flights VALUES(7,"Bengaluru","Frankfurt",750,"14:20:00","17:15:00",5000);

INSERT INTO aircraft VALUES(1,"King fisher",100);
INSERT INTO aircraft VALUES(2,"Jet airways",8000);
INSERT INTO aircraft VALUES(3,"Indian airlines",5000);
INSERT INTO aircraft VALUES(4,"King jet",900);
INSERT INTO aircraft VALUES(5,"Foreign travels",2000);

INSERT INTO employee VALUES(1,"Kalpana",85000);
INSERT INTO employee VALUES(2,"Mahima",80000);
INSERT INTO employee VALUES(3,"Harshad",4000);
INSERT INTO employee VALUES(4,"Atharv",85000);
INSERT INTO employee VALUES(5,"Vidyuth",95000);
INSERT INTO employee VALUES(6,"Sakhi",90000);
INSERT INTO employee VALUES(7,"Rajesh",81000);
INSERT INTO employee VALUES(8,"Vandana",78000);
INSERT INTO employee VALUES(9,"Dakshesh",4000);

INSERT INTO certified VALUES(1,1);
INSERT INTO certified VALUES(2,3);
INSERT INTO certified VALUES(3,5);
INSERT INTO certified VALUES(7,2);
INSERT INTO certified VALUES(8,4);
INSERT INTO certified VALUES(1,4);
INSERT INTO certified VALUES(1,5);
INSERT INTO certified VALUES(2,4);

SELECT * FROM flights;
SELECT * FROM aircraft;
SELECT * FROM certified;
SELECT * FROM employee;

SELECT a.aname FROM aircraft a
INNER JOIN certified c
ON a.aid=c.aid
INNER JOIN employee e
ON c.eid=e.eid
WHERE e.salary>80000;

SELECT c.eid,MAX(a.cruisingrange) FROM certified c
INNER JOIN aircraft a
ON c.aid=a.aid
GROUP BY c.eid
HAVING COUNT(c.eid)>=3;

SELECT e.ename FROM employee e
INNER JOIN certified c
ON e.eid=c.eid
WHERE e.salary<(SELECT MIN(f.price) FROM flights f
WHERE f.from_place="Bengaluru" AND f.to_place="Frankfurt");

SELECT e.ename FROM employee e
INNER JOIN certified c
ON c.eid=e.eid
INNER JOIN aircraft a
ON a.aid=c.aid
AND a.aname="King fisher";

SELECT e.ename,e.salary FROM employee e
WHERE e.eid NOT IN (SELECT DISTINCT eid FROM certified)
AND
e.salary>(SELECT AVG(e.salary) FROM employee e
WHERE e.eid IN (SELECT DISTINCT eid FROM certified));

SELECT a.aname,AVG(e.salary) FROM aircraft a,certified c,employee e
WHERE a.aid=c.aid
AND
c.eid=e.eid
AND
a.cruisingrange>=1000
GROUP BY c.aid;
