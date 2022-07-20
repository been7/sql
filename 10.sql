-- DDL(Date Definition Language), 자동커밋됨.
drop table hire_dates;

create table hire_dates( --칼럼네임.데이터타입
id number(8),
hire_date date default sysdate);

select tname
from tab; -- data dictionary

-- 과제] drop table 후, 위 문장 실행 결과에서, 쓰레기는 제하고, 조회하라.
select tname
from tab
where tname not like 'BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3);

commit;

select *
from hire_dates;
-----------------

-- DCL(Date Contrl Language)
-- system user 로 변경한다. system유저가 실행하는것들.
create user you identified by you;
grant connect, resource to you;

-- you user 로 변경(you connection)
select tname
from tab; --프로젝트할 때 이렇게 새로 만들어서 진행해라..

create table depts(
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20));

desc user_constraints;

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps( 
employee_id number(3) primary key,
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),
salary number(6) constraint emps_sal_ck check(salary > 1000),
department_id number(3),
constraint emps_email_uk unique(email),
constraint emps_deptid_fk foreign key(department_id)
    references depts(department_id));

select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);
commit;

delete depts; --error, (YOU.EMPS_DEPTID_FK) violated
--pk-fk로 묶인 사이. pk지우면 fk무결성해쳐서 삭제못함.

insert into depts values(100, 'Marketing'); --error, (YOU.DEPTS_DEPTID_PK) violated
insert into depts values(null, 'Marketing'); --error, cannot insert NULL
insert into emps values(501, null, 'good@gmail.com', 6000, 100); --error, cannot insert NULL
insert into emps values(501, 'label', 'musk@gmail.com', 6000, 100); --error, (YOU.EMPS_EMAIL_UK) violated
insert into emps values(501, 'abel', 'good@gmail.com', 6000, 200); --error, parent key not found

drop table emps cascade constraints;
select constraint_name, constraint_type, table_name
from user_constraints;

-- system user
grant all on hr.departments to you; --hr에서 d를 머 할수있는 권한을 you 한테 부여.

-- you user
drop table employees cascade constraints; --복습땐 이거먼저
create table employees(
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_pk unique,
phone_number varchar2(20),
hire_date date constraint emp_hireddate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct_ number(2, 2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));
--------------- 테이블생성. create

--on delete?
drop table gu cascade constraints;
drop table dong cascade constraints;
drop table dong2 cascade constraints;

create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong (
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade); -- 부모에서 지워지면 나도 지워지겠다. cascade

create table dong2 (
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null);

insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null); --포린키값 널 가능
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong;
select * from dong2;

commit; --insert부터 진행중이던 transaction 종료시키기.
----------------

--disable fk
drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1); --부모테이블a의 1 복사해서 넣음
insert into b values(32, 9); --error, parent key not found

alter table b disable constraint b_aid_fk;
insert into b values(32, 9);


alter table b enable constraint b_aid_fk; --error, parent keys not found
alter table b enable novalidate constraint b_aid_fk;

insert into b values(33, 8); --error, parent keys not found
-------------------

drop table sub_departments;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;

desc sub_departments

select * from sub_departments;
--------------------

drop table users cascade constraints;

create table users(
user_id number(3));

desc users --테이블 구조 확인

alter table users add(user_name varchar2(10));
desc users

alter table users modify(user_name number(7));
desc users

alter table users drop column user_name;
desc users
-----------------

--테이블 읽기전용으로 바꾸기
insert into users values(1); --쓰기되는지 확인

alter table users read only; --읽기 전용으로 바꿈
insert into users values(2); --error, 쓰기안된다.

alter table users read write; --쓰기가능하게바꿈.
insert into users values(2);

commit; --습관적으로 ,,. 하기

--이런 명령어가 있었다..정도로 기억하고 필요하면 복사해서 쓰기.