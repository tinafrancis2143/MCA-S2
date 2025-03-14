create database test1;
use test1;

create table student(
student_name varchar(20),
student_number int,
class int,
major varchar(5),
primary key(student_number)
);

create table course(
course_name varchar(30),
course_number varchar(40),
credit_hours int,
department varchar(5),
primary key(course_number)
);

create table section(
section_identifier int,
course_number varchar(40),
semester varchar(10),
years int,
instructor varchar(20),
foreign key(course_number)references course(course_number),
primary key(section_identifier)
);

create table grade_report(
student_number int,
section_identifier int,
grade varchar(5),
foreign key(student_number)references student(student_number),
foreign key(section_identifier)references section(section_identifier)
);

create table prerequisite(
course_number varchar(40),
prerequisite_number varchar(20),
foreign key(course_number)references course(course_number)
);

insert into student(student_name,student_number,class,major)values('smith',17,1,'cs'),('brown',8,2,'cs');
select * from student;

insert into course(course_name,course_number,credit_hours,department)values('Intro to computer science','CS1310',4,'cs'),('Data structure','CS3320',4,'cs'),('Discrete Mathematics','MATH2410',3,'MATH'),('Database','CS3380',3,'cs');
select * from course;

insert into section(section_identifier,course_number,semester,years,instructor)values(85,'MATH2410','fall',07,'king'),(92,'CS1310','fall',07,'Anderson'),(102,'CS3320','spring',08,'kruth'),(112,'MATH2410','fall',08,'chang'),(119,'CS1310','fall',08,'Anderson'),(135,'CS3380','fall',08,'stone');
select * from section;

insert into grade_report(student_number,section_identifier,grade)values(17,112,'B'),(17,119,'C'),(8,85,'A'),(8,92,'A'),(8,102,'B'),(8,135,'A');
select * from grade_report;

insert into prerequisite(course_number,prerequisite_number)values('CS3380','CS3320'),('CS3380','MATH2410'),('CS3320','CS1310');
select * from prerequisite;

select grade_report.grade, section.course_number from grade_report inner join section  on section.section_identifier=grade_report.section_identifier
inner join student on grade_report.student_number=student.student_number where student_name="smith";

select grade_report.grade,student.student_name from section inner join course on section.course_number=course.course_number
inner join grade_report on section.section_identifier=grade_report.section_identifier
inner join student on grade_report.student_number=student.student_number
where semester="fall" and years=08 and course_name="database";

select prerequisite.prerequisite_number
from course inner join prerequisite on course.course_number=prerequisite.course_number
where course_name="database";

create view name as select student_name from student where major='cs';
select * from name;

select course.course_name, section.instructor 
from section inner join course on section.course_number=course.course_number
where instructor="king" and years=07 and 08;

select section.course_number,section.semester,section.years,count(grade_report.student_number) as student_count from section 
inner join grade_report on grade_report.section_identifier=section.section_identifier
where instructor="king"
GROUP BY section.course_number, section.semester,section.years;

insert into student values("Johnson",25,1,"Math");
select * from student;

SET SQL_SAFE_UPDATES = 0;
update student set class=2 where student_name="smith";
select * from student;

insert into course values("knowledge","CS4390",3,"CS");
select * from course;

select student.student_name,grade_report.grade,section.course_number,section.semester,section.years,course.course_name,course.credit_hours
from student inner join grade_report on student.student_number=grade_report.student_number
inner join section on grade_report.section_identifier=section.section_identifier
inner join course on section.course_number=course.course_number
where class=2 and major="CS";

update grade_report set student_number=25 where student_number=17;
delete from student where student_name="smith" and student_number=17;
select * from student;

