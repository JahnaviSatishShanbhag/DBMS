create database supplier_lab3;
use supplier_lab3;

create table supplier(
sid int,
sname varchar(20),
city varchar(20),
primary key(sid)
);

create table parts(
pid int,
pname varchar(20),
color varchar(20),
primary key(pid)
);

create table catalog(
sid int,
pid int,
cost real,
primary key(sid,pid),
foreign key(sid) references supplier(sid),
foreign key(pid) references parts(pid)
);

insert into supplier
values("10001","Acme Widget","Bangalore"),("10002","Johns","Kolkata"),("10003","Vimal","Mumbai"),("10004","Reliance","Delhi");


insert into parts
values("20001","Book","Red"),("20002","Pen","Red"),("20003","Pencil","Green"),("20004","Mobile","Green"),("20005","Charger","Black");

insert into catalog
values("10001","20001","10"),("10001","20002","10"),("10001","20003","30"),("10001","20004","10"),("10001","20005","10"),("10002","20001","10"),("10002","20002","20"),("10003","20003","30"),("10004","20003","40");

select p.pname from parts p
where p.pid in (select distinct pid from catalog);

select s.sname from supplier s,catalog c
where s.sid=c.sid
group by c.sid
having count(*)=5;

select s.sname from supplier s
where s.sid in (select distinct c.sid from catalog c,parts p
where c.pid=p.pid and p.color="Red");

select p.pname from parts p
where p.pid not in (select distinct pid from catalog where sid!=(select sid from supplier
where sname="Acme Widget"));

select c.sid from catalog c
where c.cost>(select avg(cost) from catalog
where pid=c.pid
group by pid);

select s.sname,p.pid from supplier s,parts p, catalog c
where s.sid=c.sid
and c.pid=p.pid
and c.cost in (select max(cost) from catalog where pid=c.pid
group by c.pid);
