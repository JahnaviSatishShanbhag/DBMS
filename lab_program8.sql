create database student_faculty;

use student_faculty;

create table student(
snum int,
sname varchar(20),
major varchar(20),
lvl varchar(10),
age int,
primary key(snum));

create table faculty(
fid int,
fname varchar(20),
deptid int,
primary key(fid));

create table class(
cname varchar(20),
meets_at time,
room varchar(10),
fid int,
primary key(cname),
foreign key(fid) references faculty(fid));

create table enrolled(
snum int,
cname varchar(20),
primary key(snum,cname),
foreign key(snum) references student(snum),
foreign key(cname) references class(cname));

insert into student
values(1,"John","CS","Sr",19),(2,"Smith","CS","Jr",20),(3,"Jacob","CV","Sr",20),(4,"Tom","CS","Jr",20),(5,"Rahul","CS","Jr",20),(6,"Rita","CS","Sr",21);

insert into faculty
values(11,"Harish",1000),(12,"MV",1000),(13,"Mira",1001),(14,"Shiva",1002),(15,"Nupur",1000);

insert into class
values("class1","2015-11-12 10:15:16","R1",14),("class10","2015-11-12 10:15:16","R128",14),("class2","2015-11-12 10:15:20","R2",12),("class3","2015-11-12 10:15:25","R3",11),("class4","2015-11-12 20:15:20","R4",14),("class5","2015-11-12 20:15:20","R3",15),("class6","2015-11-12 13:20:20","R2",14),("class7","2015-11-12 10:10:10","R3",14);

insert into enrolled 
values(1,"class1"),(2,"class1"),(3,"class3"),(4,"class3"),(5,"class4"),(1,"class5"),(2,"class5"),(3,"class5"),(4,"class5"),(5,"class5");

select distinct s.sname from student s,class c,enrolled e,faculty f
where s.snum=e.snum 
and 
e.cname=c.cname 
and 
c.fid=f.fid 
and 
f.fname="Harish" 
and 
s.lvl="Jr";

select c.cname from class c
where c.room="R128" 
or 
c.cname in (select e.cname from enrolled e
group by e.cname
having count(*)=5);

select s.sname from student s
where s.snum in (select distinct e1.snum from enrolled e1,enrolled e2,class c1,class c2
where e1.snum=e2.snum and e1.cname!=e2.cname and e1.cname=c1.cname and e2.cname=c2.cname and
c1.meets_at=c2.meets_at);


select f.fname from faculty f
where f.fid in (select distinct c.fid from class c
group by c.fid
having count(c.room)=(select count(distinct room) from class));

select s.sname from student s
where s.snum not in (select distinct snum from enrolled);

select distinct f.fname from faculty f
where 5>(select count(e.snum) from class c,enrolled e
where c.cname=e.cname
and
c.fid=f.fid);

select s.age,s.lvl from student s
group by s.age,s.lvl
having s.lvl in (select s1.lvl from student s1
where s1.age=s.age
group by s1.age,s1.lvl
having count(*)>=all(select count(*) from student s2
where s2.age=s1.age
group by s2.age,s2.lvl));
