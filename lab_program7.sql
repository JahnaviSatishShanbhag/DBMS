CREATE DATABASE AIRLINE;

USE AIRLINE;

create table flight(
flno int,
ffrom varchar(20),
tto varchar(20),
distance int,
departs timestamp,
arrives timestamp,
price int,
primary key(flno));

create table aircraft(
aid int,
aname varchar(20),
crusingrange int,
primary key(aid));

create table employees(
eid int,
ename varchar(20),
salary int,
primary key(eid));

create table certified(
eid int,
aid int,
primary key(eid,aid),
foreign key(eid) references employees(eid),
foreign key(aid) references aircraft(aid));

insert into aircraft
values(101,"747",3000),(102,"Boeing",900),(103,"647",800),(104,"Dreamliner",10000),(105,"Boeing",3500),(106,"707",1500),(107,"Dream",120000);

insert into employees
values(701,"A",50000),(702,"B",100000),(703,"C",150000),(704,"D",90000),(705,"E",40000),(706,"F",60000),(707,"G",90000);

insert into certified
values(701,101),(701,102),(701,106),(701,105),(702,104),(703,104),(704,104),(702,107),(703,107),(704,107),(702,101),(703,105),(704,105),(705,103);

insert into flight
values(101,"Bangalore","Delhi",2500,"2005-05-13 07:15:31","2005-05-13 17:15:31",5000),(102,"Bangalore","Lucknow",3000,"2005-05-13 07:15:31","2005-05-13 11:15:31",6000),(103,"Lucknow","Delhi",500,"2005-05-13 12:15:31","2005-05-13 17:15:31",3000),(107,"Bangalore","Frankfurt",8000,"2005-05-13 07:15:31","2005-05-13 22:15:31",60000),(104,"Bangalore","Frankfurt",8500,"2005-05-13 07:15:31","2005-05-13 23:15:31",75000),(105,"Kolkata","Delhi",3400,"2005-05-13 07:15:31","2005-05-13 09:15:31",7000);

select distinct a.aname from aircraft a,certified c,employees e
where a.aid=c.aid
and
c.eid=e.eid
and
e.salary>80000;

select c.eid,max(a.crusingrange) from aircraft a,certified c
where a.aid=c.aid
and
c.eid in (select distinct eid from certified
group by eid
having count(*)>3);

select e.ename from employees e
where e.salary<(select min(f.price) from flight f
where f.ffrom="Bangalore"
and
f.tto="Frankfurt");

select a.aname,avg(e.salary) from aircraft a,certified c,employees e
where a.aid=c.aid
and
c.eid=e.eid
and
a.crusingrange>1000
group by c.aid;

select distinct e.ename from employees e,aircraft a,certified c
where a.aid=c.aid
and
c.eid=e.eid
and
a.aname="Boeing";

select a.aid from aircraft a
where a.crusingrange>(select min(f.distance) from flight f
where f.ffrom="Bangalore"
and
f.tto="Frankfurt");

select e.ename,e.salary from employees e
where e.eid not in (select distinct eid from certified)
and
e.salary>(select avg(salary) from employees
where eid in (select distinct eid from certified));
