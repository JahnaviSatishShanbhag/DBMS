CREATE DATABASE ORDER_PROCESSING;

USE ORDER_PROCESSING;

CREATE TABLE CUSTOMER(
    cust_id INT PRIMARY KEY,
    cname VARCHAR(20),
    city VARCHAR(20)
);

CREATE TABLE ORDERS(
    order_no INT PRIMARY KEY,
    odate date,
    cust_no INT,
    order_amt INT,
    FOREIGN KEY(cust_no) REFERENCES CUSTOMER(cust_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE ITEM(
    item_no INT PRIMARY KEY,
    price int
);

CREATE TABLE ORDER_ITEM(
    order_no INT,
    item_no INT,
    qty INT,
    FOREIGN KEY(order_no) REFERENCES ORDERS(order_no) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(item_no) REFERENCES ITEM(item_no) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE WAREHOUSE(
    warehouse_no INT PRIMARY KEY,
    city VARCHAR(20)
);
    
CREATE TABLE SHIPMENT(
    order_no INT,
    warehouse_no INT,
    date DATE,
    FOREIGN KEY(order_no) REFERENCES ORDERS(order_no) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(warehouse_no) REFERENCES WAREHOUSE(warehouse_no) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO CUSTOMER VALUES(771,'PUSHPA K','BANGALORE');
INSERT INTO CUSTOMER VALUES(772,'SUMAN','MUMBAI');
INSERT INTO CUSTOMER VALUES(773,'SOURAV','CALICUT');
INSERT INTO CUSTOMER VALUES(774,'LAILA','HYDERABAD');
INSERT INTO CUSTOMER VALUES(775,'FAIZAL','BANGALORE');

INSERT INTO ORDERS VALUES(111,'2002-01-22',771,18000);
INSERT INTO ORDERS VALUES(112,'2002-07-30',774,6000);
INSERT INTO ORDERS VALUES(113,'2003-04-03',775,9000);
INSERT INTO ORDERS VALUES(114,'2003-11-03',775,29000);
INSERT INTO ORDERS VALUES(115,'2003-12-10',773,29000);
INSERT INTO ORDERS VALUES(116,'2004-08-19',772,56000);
INSERT INTO ORDERS VALUES(117,'2004-09-10',771,20000);
INSERT INTO ORDERS VALUES(118,'2004-11-20',775,29000);
INSERT INTO ORDERS VALUES(119,'2005-02-13',774,29000);
INSERT INTO ORDERS VALUES(120,'2005-10-13',775,29000);

INSERT INTO ITEM VALUES(5001,503);
INSERT INTO ITEM VALUES(5002,750);
INSERT INTO ITEM VALUES(5003,150);
INSERT INTO ITEM VALUES(5004,600);
INSERT INTO ITEM VALUES(5005,890);

INSERT INTO ORDER_ITEM VALUES(111,5001,50);
INSERT INTO ORDER_ITEM VALUES(112,5003,20);
INSERT INTO ORDER_ITEM VALUES(113,5002,50);
INSERT INTO ORDER_ITEM VALUES(114,5005,60);
INSERT INTO ORDER_ITEM VALUES(115,5004,90);
INSERT INTO ORDER_ITEM VALUES(116,5001,10);
INSERT INTO ORDER_ITEM VALUES(117,5003,80);
INSERT INTO ORDER_ITEM VALUES(118,5005,50);
INSERT INTO ORDER_ITEM VALUES(119,5002,10);
INSERT INTO ORDER_ITEM VALUES(120,5004,45);

INSERT INTO WAREHOUSE VALUES(1,'DELHI');
INSERT INTO WAREHOUSE VALUES(2,'BOMBAY');
INSERT INTO WAREHOUSE VALUES(3,'CHENNAI');
INSERT INTO WAREHOUSE VALUES(4,'BANGALORE');
INSERT INTO WAREHOUSE VALUES(5,'BANGALORE');
INSERT INTO WAREHOUSE VALUES(6,'DELHI');
INSERT INTO WAREHOUSE VALUES(7,'BOMBAY');
INSERT INTO WAREHOUSE VALUES(8,'CHENNAI');
INSERT INTO WAREHOUSE VALUES(9,'DELHI');
INSERT INTO WAREHOUSE VALUES(10,'BANGALORE');

INSERT INTO SHIPMENT VALUES(111,1,'2002-02-10');
INSERT INTO SHIPMENT VALUES(112,5,'2002-09-10');
INSERT INTO SHIPMENT VALUES(113,8,'2003-02-10');
INSERT INTO SHIPMENT VALUES(114,3,'2003-12-10');
INSERT INTO SHIPMENT VALUES(115,9,'2004-01-19');
INSERT INTO SHIPMENT VALUES(116,1,'2004-09-20');
INSERT INTO SHIPMENT VALUES(117,5,'2004-09-10');
INSERT INTO SHIPMENT VALUES(118,7,'2004-11-30');
INSERT INTO SHIPMENT VALUES(119,7,'2005-04-30');
INSERT INTO SHIPMENT VALUES(120,6,'2005-12-21');

SELECT c.cname,COUNT(o.order_no),AVG(o.order_amt) FROM CUSTOMER c,ORDERS o
WHERE c.cust_id=o.cust_no
GROUP BY o.cust_no;

SELECT s.order_no FROM SHIPMENT s,WAREHOUSE W
WHERE s.warehouse_no=w.warehouse_no
AND
w.city='BANGALORE';

DELETE FROM ITEM i
WHERE i.item_no=5001;

SELECT * FROM ORDER_ITEM;