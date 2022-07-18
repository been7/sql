--join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join ���������� ����ؼ� �����ߴ�,.
select department_id, department_name, location_id, city
from departments natural join locations; --�߾Ⱦ�.

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- ����] ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
where department_id is null;

select employee_id, last_name, department_id, location_id
from employees natural join departments; --�μ���ȣ�� �Ŵ������̵� ���ƾ� ����

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d --���̺��� ������
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400; -- error. usingĮ���� ���λ�d ���ΰ� ����

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400; --error . usingĮ�� ���λ�X

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where manager_id = 100; --error

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where d.manager_id = 100; --using �ƴ� ����Į���� ���λ� ���̴ϱ� ��.

select e.last_name, d.department_name
from employees e join departments d
using (department_id) --using equi join
where e.manager_id = 100; --���λ� d �������� ��� ����.
-----------------------

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id); -- = equi join

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- ����] �� ������, using ���� refactoring �϶�.
select employee_id, city, department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id --���� 1
where e.manager_id = 149; --���� 2

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149; --���� ��� ����.

-- ����] Toronto �� ��ġ�� �μ����� ���ϴ� �������
--      �̸�, ����, �μ���ȣ, �μ����� ��ȸ�϶�.
select e.last_name, e.job_id, e.department_id,
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id --non equi join ����
and l.city = 'Toronto'; 

-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG'; -- �ٽú���
-----------------

-- self join. ���λ� �ʼ�. 2�� ���̺��� ô �ؾ��ؼ�.
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager -- �� ô
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; -- error

select last_name emp, last_name mgr
from employees worker join employees manager 
on worker.manager_id = manager.employee_id; -- error

-- ����] ���� �μ����� ���ϴ� ������� �̸�, �μ���ȣ, ������ �̸��� ��ȸ�϶�.
select worker.last_name, department.department_id, coworker.last_name
from employees worker join employees coworker
on worker.last_name = coworker.last_name;