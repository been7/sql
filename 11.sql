-- view. �����ڵ�. �信�� �����Ͱ� ����. you ����
-- hr user
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

-- ����] 50�� �μ������� ���, �̸�, �μ���ȣ�� ���� DEPT50 view �� ������.
--      view ������ EMPNO, EMPLOYEE, DEPTNO �̴�.
--      view �� ���ؼ� 50�� �μ� ������� �ٸ� �μ��� ��ġ���� �ʵ��� �Ѵ�.
create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option constraint dept50_ck;

-- ����] DEPT50 view �� ������ ��ȸ�϶�.
desc dept50
-- ����] DEPT50 view �� data �� ��ȸ�϶�.
select * from dept50;
-------------

drop table teams;
drop view team50;

create table teams as
    select department_id team_id, department_name team_name
    from hr.departments;
    
create view team50 as
    select *
    from teams
    where team_id = 50;

select * from team50;

select count(*) from teams; --27��
insert into team50 --�信 �μ�Ʈ�Ѱɷ� ������,.�ƴϴ�
values(300, 'Marketing');
select count(*) from teams; -- 28��. �����δ� ���̽����̺��� �μ�Ʈ?

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



drop sequence team_teamid_seq;

create sequence team_teamid_seq;

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id = 3;

create sequence x_xid_seq
    start with 10
    increment by 5
    maxvalue 20
    nocache --�̸� �̾Ƽ� �����Ϳ� ���������ʰڴ�.
    nocycle; --20�����ϸ� �����߸鼭 ����.

select x_xid_seq.nextval from dual; --nocycle ȿ���� �����Ѵ�.

-- ����] DEPT ���̺��� DEPARTMENT_ID Į���� field value �� ����� sequence�� ������.
--      sequence �� 400 �̻�, 1000 ���Ϸ� �����Ѵ�. 10�� �����Ѵ�.
create sequence dept_deptid_seq
        start with 400
        increment by 10
        maxvalue 1000;
       
-- ����] �� sequence �� DEPT ���̺��� Education �μ��� insert �϶�.
insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

commit; --���������� Ŀ���ϱ�.
---------------------------

drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid
from employees;

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABK';

select index_name, index_type, table_owner, table_name
from user_indexes;

-- ����] DEPT ���̺��� DEPARTMENT_NAME �� ���� index �� ������.
create index dept_deptname_idx
on dept(department_name);
-----------------------

drop synonym team;

create synonym team
for departments;

select * from team; --de���̺����°Ͱ� ������ ȿ��

-- ����] EMPLOYEE ���̺��� EMPS synonym �� ������.
create synonym emps
for employees;
