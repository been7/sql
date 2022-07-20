-- view
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;

desc empvu80 --select절의 칼럼이 뷰의 구조가 됨.

select * from empvu80;

select * from ( --뷰 없었으면 이렇게 써야됨.
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);
    
create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;

desc empvu80
-------------

drop table teams;
drop view team50;

create table teams as
    select department_id team_id, department_name team_name
    from departments;
    
create view team50 as
    select *
    from teams
    where team_id = 50;

select * from team50;

select count(*) from teams; --27개
insert into team50 --뷰에 인서트한걸로 썼지만,.아니다
values(300, 'Marketing');
select count(*) from teams; -- 28개. 실제로는 베이스테이블에 인서트?

create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option; --제약조건.뷰에 붙일 수 있다.

insert into team50 values(50, 'IT Support'); --베이스테이블 teams에 인서트
select count(*) from teams; --29개.
insert into team50 values(301, 'IT Support'); --error, view WITH CHECK OPTION where-clause violation.팀id가 50이 아니라서.

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; --뷰도 읽기전용으로 만들 ㅅ 있다.

insert into empvu10 values(501, 'abel', 'Sales'); --error. cannot perform a DML
----------- view 는 쿼리의 별명.

drop sequence 

