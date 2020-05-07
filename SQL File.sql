CREATE TABLE student(
studentID NUMERIC(5,0) PRIMARY KEY,
studentName varchar(50)not null,
student_mobile numeric(11,0) not null,
student_university VARCHAR(30) NOT NULL,
student_address VARCHAR(30) ,
);

INSERT INTO student VALUES (10,'Sharvil',3158898675,'VJTI','Thane');
INSERT INTO student VALUES (11,'Hitesh',31588985689,'Bhopal University','Ramesh Street');
INSERT INTO student VALUES (12,'Dhiraj',31588985689,'Kolkata University','Madal Avenue');
INSERT INTO student VALUES (13,'Aseem',31588985689,'Delhi University','Red Fort');
INSERT INTO student VALUES (14,'Rohit', 31588947927,'Mumbai University','Seawoods');
INSERT INTO student VALUES (15,'Kunal', 31588978468,'Mumbai University','Chembur');

select * from student;


CREATE TABLE counsellor(
counsellorID NUMERIC(5,0) PRIMARY KEY,
counsellor_Name VARCHAR(200) NOT NULL,
counsellor_Type char(20) check(counsellor_Type in ('Professional','Alumni')),
counsellor_address VARCHAR(30) not null
);

INSERT INTO counsellor VALUES (10,'Vera','Professional','118 Concord Place');
INSERT INTO counsellor VALUES (11,'Gibbs','Professional','112 Harvard Place');
INSERT INTO counsellor VALUES (12,'Angela','Professional','8 Marshall Street');
INSERT INTO counsellor VALUES (13,'Marsha','Professional','South Campus');
INSERT INTO counsellor VALUES (14,'Hershell','Alumni','128 Armory Sqaure');

select * from counsellor;


CREATE TABLE profile(
gre_score int not null,
yrs_Exp int ,
major varchar(20) not null,
counsellorID NUMERIC(5,0) FOREIGN KEY REFERENCES counsellor(counsellorID),
studentID NUMERIC(5,0)  FOREIGN KEY REFERENCES student(studentID),
CONSTRAINT profile_pk PRIMARY KEY (studentID, counsellorID)
);

INSERT INTO profile VALUES (312,4,'Computer',10,10);
INSERT INTO profile VALUES (300,1,'Electrical',10,11);
insert into profile values(324,0,'Computer',11,12);
insert into profile values(290,0,'Environment',12,13);
insert into profile values(304,0,'Arts',10,14);
insert into profile values(303,1,'Chemistry',12,15);

select * from profile;

create table university(
university_id numeric(4,0) primary key,
university_name varchar(50) not null,
country varchar(20) not null,
Major_prescribed varchar(20) not null,

studentID NUMERIC(5,0) FOREIGN KEY references student(studentID),
counsellorID NUMERIC(5,0) FOREIGN KEY REFERENCES counsellor(counsellorID),
);

INSERT INTO university VALUES (101,'NYU','USA','ADS',10,10);
INSERT INTO university VALUES (102,'Rochester University','USA','ADS',10,10);
INSERT INTO university VALUES (103,'AAchen University','Germany','Automobile',14,10);
INSERT INTO university VALUES (104,'Syracuse','USA','IM',11,10);
INSERT INTO university VALUES (105,'Berlin University','Germany','Automobile',12,14);
INSERT INTO university VALUES (106,'Monash University','Australia','Computer Engineering',14,10);

select * from university;

create table university_evaluation(
university_type char(50) check(university_type in('Ambitious','Moderate','Safe')),
No_universities numeric(5,0), 
studentID NUMERIC(5,0) foreign key references student(studentID),
counsellorID numeric(5,0) foreign key references counsellor(counsellorID),
university_id numeric(4,0) foreign key references university(university_id),
constraint university_evaluation_pk primary key(studentID,counsellorID,university_id)
);

insert into university_evaluation values('Ambitious',null,10,10,101);
insert into university_evaluation values('Safe' ,null,14,10,106);
insert into university_evaluation values('Safe' ,null,14,10,102);
insert into university_evaluation values('Moderate' ,null,11,11,103);
insert into university_evaluation values('Moderate' ,null,11,11,104);

select * from university_evaluation ;


create table Feedback(
review_id numeric(4,0) primary key, 
counsellor_rating int not null,

studentID NUMERIC(5,0) foreign key references student(studentID),
counsellorID numeric(5,0) foreign key references counsellor(counsellorID)
)

insert into Feedback values(1000,9,10,10);
insert into Feedback values(1001,7,14,10);
insert into Feedback values(1002,4,10,11);
insert into Feedback values(1003,2,11,11);
insert into Feedback values(1004,2,12,12);
insert into Feedback values(1005,7,15,11);
insert into Feedback values(1006,10,14,13);
insert into Feedback values(1007,8,12,11);

select * from Feedback ;


create table Teacher(
teacher_id numeric(5,0) primary key,
teacher_name varchar(50) not null,
teacher_email varchar(50) not null,
subject_taught varchar(50) not null
)

insert into Teacher values(1,'Madhuri','madhuri@gmail.com','Digital Signals');
insert into Teacher values(2,'Nidhi','nidhi01@gmail.com','ERP');
insert into Teacher values(3,'Ingle','ingle@gmail.com','Computer vision');
insert into Teacher values(4,'Rahul','rpatil@gmail.com','Intro to C++');
insert into Teacher values(5,'Prerna','pren@gmail.com','SPCC');



select * from teacher;


create table LOR(
length int,
teacher_id numeric(5,0) foreign key references Teacher(teacher_id),
counsellorID numeric(5,0) foreign key references counsellor(counsellorID)
constraint  LOR_pk  primary key(teacher_id,counsellorID) 
)


insert into LOR values(1000,1,10);
insert into LOR values(1001,2,11);
insert into LOR values(1002,3,10);
insert into LOR values(1003,4,11);
insert into LOR values(1004,1,12);
insert into LOR values(1005,2,13);

select * from LOR;

create table Schedule(
slot_id numeric(5,0) primary key,
counselling_day date default getdate() not null ,
counselling_time datetime  not null,
counselling_end datetime ,
slot_duration int not null,
room_number int 
)
insert into Schedule values(900,'12/12/2017','12/12/2017 10:00:00',null,2,201);
insert into Schedule values(901,'12/13/2017','12/13/2017 13:00:00',null,4,201);
insert into Schedule values(902,'11/6/2017','11/6/2017 13:00:00',null,2,201);
insert into Schedule values(903,'12/1/2018','12/1/2018 13:00:00',null,1,201);
insert into Schedule values(904,'11/6/2019','11/6/2019 15:00:00',null,5,201);
insert into Schedule values(905,'2/15/2018','2/15/2018 3:00:00',null,6,301);
insert into Schedule values (906,'6/11/2017','6/11/2017 7:00:00',null,13,301)
insert into Schedule values (907,'1/11/2018','1/11/2018 17:00:00',null,13,301)

select * from Schedule;

select * from Payroll;

create table Payroll(
slot_id numeric(5,0) foreign key references Schedule(slot_id),
counsellorID numeric(5,0) foreign key references counsellor(counsellorID)
constraint Payroll_pk primary key(slot_id,counsellorID),

Rate numeric(5,2) not null,
Amount numeric(5,0) not null,
)


select * from Schedule;
select * from Payroll;
select * from counsellor;

update Schedule
set slot_duration=4
where slot_id=902;

insert into Payroll values(900,10,11,100);
insert into Payroll values(901,10,11,20);
insert into Payroll values(902,12,11,200);
insert into Payroll values(903,12,11,190);
insert into Payroll values(904,13,11,120);
insert into Payroll values(905,14,11,110);
insert into Payroll values(906,13,11,10);

select * from Payroll;

SELECT Sum(Payroll.Amount) AS SumOfAmount, counsellor.counsellor_Name, counsellor.counsellorID
FROM Payroll INNER JOIN counsellor ON Payroll.counsellorID = counsellor.counsellorID
GROUP BY counsellor.counsellor_Name, counsellor.counsellorID;


SELECT round(Avg(cast(Feedback.counsellor_rating as float)),2) AS AvgOfcounsellor_rating, counsellor.counsellor_Name, 
counsellor.counsellor_Type, counsellor.counsellor_address
FROM counsellor INNER JOIN Feedback ON counsellor.counsellorID = Feedback.counsellorID
GROUP BY counsellor.counsellor_Name, counsellor.counsellor_Type, counsellor.counsellor_address;

SELECT counsellor_schedule.counselling_type, Sum(Schedule.slot_duration) AS SumOfslot_duration
FROM Schedule INNER JOIN counsellor_schedule ON Schedule.slot_id = counsellor_schedule.slot_id
GROUP BY counsellor_schedule.counselling_type;


SELECT Count(university.country) AS CountOfcountry, university.country, university.Major_prescribed
FROM university
GROUP BY university.country, university.Major_prescribed
ORDER BY Count(university.country) DESC;

SELECT student.studentID, student.studentName, profile.gre_score, profile.major, 
Count(university_evaluation.No_universities) AS CountOfNo_universities
FROM university_evaluation INNER JOIN (profile INNER JOIN student 
ON profile.studentID = student.studentID) ON university_evaluation.studentID = profile.studentID
GROUP BY student.studentID, student.studentName, profile.gre_score, profile.major
having student.studentID=10
;


select * from Schedule;

create table counsellor_schedule
(
counsellor_day varchar(50) not null,
counsellor_time datetime not null,
counselling_type varchar(10) check(counselling_type in ('VISA','SOP','OFC','LOR','Academic','Misc')),

slot_id numeric(5,0) foreign key references Schedule(slot_id),
counsellorID numeric(5,0) foreign key references counsellor(counsellorID),
constraint counsellor_schedule_pk primary key(slot_id,counsellorID)
)

insert into counsellor_schedule values('Monday','12/12/2017 10:00:00','VISA',900,10);
insert into counsellor_schedule values('Tuesday','2/21/2018 10:00:00','Academic',901,11);
insert into counsellor_schedule values('Monday','12/12/2017 10:00:00','Academic',902,12);
insert into counsellor_schedule values('Friday','2/14/2019 10:00:00','SOP',903,10);
insert into counsellor_schedule values('Friday','12/3/2017 10:00:00','VISA',904,11);
insert into counsellor_schedule values('Tuesday','12/27/2018 10:00:00','SOP',905,12);
insert into counsellor_schedule values('Thursday','5/2/2017 10:00:00','Misc',906,13);
insert into counsellor_schedule values('Thursday','6/21/2017 10:00:00','Academic',907,14);

select * from counsellor_schedule;


create table appointment
(
appointment_id numeric(5,0) primary key ,
appointment_type varchar(50),

studentID NUMERIC(5,0) foreign key references student(studentID),
counsellorID numeric(5,0) foreign key references counsellor(counsellorID),
slot_id numeric(5,0) foreign key references Schedule(slot_id)
)

insert into appointment values(1000,'NULL',10,10,900);
insert into appointment values(1001,'NULL',11,11,901);
insert into appointment values(1002,'NULL',12,10,902);
insert into appointment values(1003,'NULL',10,12,903);
insert into appointment values(1004,'NULL',13,13,904);


select * from appointment;


select * from student;
select * from counsellor;
select * from profile;
select * from university;
select * from university_evaluation;
select * from Teacher;
select * from Feedback;
select * from LOR;
select * from Schedule;
select * from Payroll;
select * from counsellor_schedule;
select * from appointment;

drop table appointment;
drop table counsellor_schedule;
drop table Payroll;
drop table profile;
drop table Feedback;
drop table LOR;
drop table university_evaluation;
drop table university;
drop table counsellor;
drop table student;

select * from university_evaluation;
insert into university_evaluation values();

select * from profile;

update profile 
set gre_score=309 where studentID=14
;

drop procedure no_univ;
--Stored Procedure
create procedure no_univ
as 
begin
update university_evaluation
set No_universities=a.number
from
(select studentID,university_type,count(1)as number from university_evaluation 
group by studentID,university_type)a
where a.studentID=university_evaluation.studentID
and a.university_type=university_evaluation.university_type
end;

--Running the stored procedure
exec no_univ;
select * from university_evaluation;
select * from profile;
select * from university;

insert into Profile values(900,312,0,'Electrical',11,12);
drop table profile;

delete from university_evaluation where university_id='101';

insert into university_evaluation values('Safe',null,14,10,101);
insert into university_evaluation values('Safe',null,14,12,103);
insert into university_evaluation values('Moderate',null,11,12,102);
insert into university_evaluation values('Safe',null,12,12,104);
insert into university_evaluation values('Ambitious',null,10,12,101);
insert into university_evaluation values('Ambitious',null,10,13,105);
select * from Profile;

--Trigger for university type
drop trigger university_type;

create trigger university_type
on profile 
for insert,update 
as
if @@ROWCOUNT>=1
begin 
update university_evaluation
set university_type=tmp.uni 
from
(select a.gre_score,a.yrs_Exp,a.studentID,
case when a.gre_score between 270 and 300  then 'Safe'
when a.gre_score between 300 and 315  then 'Moderate'
when a.gre_score between 315 and 340  then 'Ambitious'
else 'Invalid'
end as uni,
b.university_type from 
profile a inner join university_evaluation b
on a.studentID=b.studentID)as tmp
where university_evaluation.studentID=tmp.studentID
end;

select * from profile;

update profile 
set gre_score=324 where studentID=12 ;
exec no_univ;
select * from university_evaluation;

insert into university_evaluation values('Safe',null,12,12,104);


update profile set gre_score=299 where studentID=14;


set gre_score=299 where studentID=14;

select * from Payroll;
select * from Schedule;

create trigger Schedule_Payroll_Update
on Schedule 
for update 
as
if @@ROWCOUNT>=1
begin 
update Payroll
set Amount=amt.Amount *Payroll.Rate
from
(select a.counsellorID,a.slot_id ,(sum(b.slot_duration))as Amount
from Payroll a inner join Schedule b
on a.slot_id=b.slot_id
group by a.counsellorID,a.slot_id)as amt
where amt.slot_id=Payroll.slot_id

update Schedule
set counselling_end=ending.end1
from
(select DATEADD(HOUR,slot_duration,counselling_time)as end1,slot_duration
from Schedule group by slot_duration,counselling_time)ending
where ending.slot_duration=Schedule.slot_duration;
end;


update Schedule
set slot_duration=13 where slot_id=902;

select * from Payroll;
select * from Schedule;



update Schedule
set slot_duration=7 where slot_id=906;


select * from counsellor;
select * from Payroll;
select * from Schedule;

select * from profile;
