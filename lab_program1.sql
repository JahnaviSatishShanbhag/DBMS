CREATE DATABASE INSURANCE;
USE INSURANCE;

CREATE TABLE PERSON(
    driver_id VARCHAR(10),
    name VARCHAR(20),
    address VARCHAR(15),
    PRIMARY KEY(driver_id)
);

CREATE TABLE CAR(
    reg_no VARCHAR(10),
    model VARCHAR(20),
    year DATE,
    PRIMARY KEY(reg_no)
);

CREATE TABLE ACCIDENT(
    report_no INT,
    adate DATE,
    location VARCHAR(15),
    PRIMARY KEY(report_no)
);

CREATE TABLE OWNS(
    driver_id VARCHAR(10),
    reg_no VARCHAR(10),
    PRIMARY KEY(driver_id,reg_no),
    FOREIGN KEY(driver_id) REFERENCES PERSON(driver_id) ON DELETE CASCADE,
    FOREIGN KEY(reg_no) REFERENCES CAR(reg_no) ON DELETE CASCADE
);

CREATE TABLE PARTICIPATED(
    driver_id VARCHAR(10),
    reg_no VARCHAR(10),
    report_no INT,
    damage_amt FLOAT,
    FOREIGN KEY(driver_id,reg_no) REFERENCES OWNS(driver_id,reg_no) ON DELETE CASCADE,
    FOREIGN KEY(report_no) REFERENCES ACCIDENT(report_no) ON DELETE CASCADE
);

INSERT INTO PERSON VALUES('1111','RAMU','K.S.LAYOUT');
INSERT INTO PERSON VALUES('2222','JOHN','INDIRANAGAR');
INSERT INTO PERSON VALUES('3333','PRIYA','JAYANAGAR');
INSERT INTO PERSON VALUES('4444','GOPAL','WHITEFIELD');
INSERT INTO PERSON VALUES('5555','LATHA','VIJAYANAGAR');

INSERT INTO CAR VALUES('KA04Q2301','MARUTHI-DX','2000-12-01');
INSERT INTO CAR VALUES('KA05P1000','FORDICON','2000-11-02');
INSERT INTO CAR VALUES('KA03L1234','ZEN-VXI','1999-08-23');
INSERT INTO CAR VALUES('KA03L9999','MARUTHI-DX','2002-09-30');
INSERT INTO CAR VALUES('KA01P4020','INDICA-VX','2002-04-17');

INSERT INTO ACCIDENT VALUES(12,'2002-06-01','M G ROAD');
INSERT INTO ACCIDENT VALUES(200,'2002-12-10','DOUBLEROAD');
INSERT INTO ACCIDENT VALUES(300,'1999-07-23','M G ROAD');
INSERT INTO ACCIDENT VALUES(25000,'2000-06-11','RESIDENCY ROAD');
INSERT INTO ACCIDENT VALUES(26500,'2001-10-16','RICHMOND ROAD');

INSERT INTO OWNS VALUES('1111','KA04Q2301');
INSERT INTO OWNS VALUES('1111','KA05P1000');
INSERT INTO OWNS VALUES('2222','KA03L1234');
INSERT INTO OWNS VALUES('3333','KA03L9999');
INSERT INTO OWNS VALUES('4444','KA01P4020');

INSERT INTO PARTICIPATED VALUES('1111','KA04Q2301',12,20000);
INSERT INTO PARTICIPATED VALUES('2222','KA03L1234',200,500);
INSERT INTO PARTICIPATED VALUES('3333','KA03L9999',300,10000);
INSERT INTO PARTICIPATED VALUES('4444','KA01P4020',25000,2375);
INSERT INTO PARTICIPATED VALUES('1111','KA05P1000',26500,70000);

UPDATE PARTICIPATED
SET damage_amt=25000
WHERE report_no=12 AND reg_no='KA04Q2301';

SELECT COUNT(*) FROM ACCIDENT
WHERE adate LIKE '2002-__-__';

SELECT COUNT(A.report_no)
FROM ACCIDENT A,PARTICIPATED P,CAR C
WHERE A.report_no=P.report_no
AND
P.reg_no=C.reg_no
AND
C.model='MARUTHI-DX';

COMMIT;
