-- view
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;

desc empvu80 --select���� Į���� ���� ������ ��.

select * from empvu80;

select * from ( --�� �������� �̷��� ��ߵ�.
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

select count(*) from teams; --27��
insert into team50 --�信 �μ�Ʈ�Ѱɷ� ������,.�ƴϴ�
values(300, 'Marketing');
select count(*) from teams; -- 28��. �����δ� ���̽����̺� �μ�Ʈ?

create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option; --��������.�信 ���� �� �ִ�.

insert into team50 values(50, 'IT Support'); --���̽����̺� teams�� �μ�Ʈ
select count(*) from teams; --29��.
insert into team50 values(301, 'IT Support'); --error, view WITH CHECK OPTION where-clause violation.��id�� 50�� �ƴ϶�.

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; --�䵵 �б��������� ���� �� �ִ�.

insert into empvu10 values(501, 'abel', 'Sales'); --error. cannot perform a DML
----------- view �� ������ ����.

drop sequence 

