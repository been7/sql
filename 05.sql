--group function
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date)
from employees;

-- ����] �ְ���ް� �ּҿ����� ������ ��ȸ�϶�.
select max(salary) - min(salary)
from employees;

select count(*) --���� ����. �׷� ���� ���ڵ� ���� ����.
from employees;

-- ����] 70�� �μ����� ����� �� ��ȸ�϶�.
select count(*)
from employees
where department_id = 70;

select count(employee_id) --em_id�� �����̸Ӹ�Ű. �ξ���.
from employees;

select count(manager_id) --�Ķ���� value�� null�̸� ����.
from employees;

select avg(commission_pct) --�������鸸 ���. ���ξֵ� ����.
from employees;

-- ����] ������ ��� Ŀ�̼����� ��ȸ�϶�.
select avg(nvl(commission_pct, 0))
from employees;
------------------

select avg(salary)
from employees;

select avg(distinct salary)
from employees;

select avg(all salary)
from employees;

-- ����] ������ ��ġ�� �μ� ������ ��ȸ�϶�.
select count(distinct department_id)
from employees;

-- ����] �Ŵ��� ���� ��ȸ�϶�.
select count(distinct manager_id)
from employees;
-----------------------

select department_id, count(employee_id) --count�� �Ķ���� ����
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id --groub by ���� �ִ� �͸� select�� �� �� �ִ�.
order by department_id; -- error

-- ����] ������ ������� ��ȸ�϶�.
select job_id, count(employee_id) --job_id�� ���̺�
from employees
group by job_id
order by job_id;
---------------------

select department_id, max(salary) --�׷� ����� ���� �׷� ���. 
from employees
group by department_id
having department_id > 50; --having ���� �׷� ��󳻱� ����

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- error. having������ ���� ������.

select department_id, max(salary) --���ڵ� ���� ��󳻰� ����� ���ڵ�� �׷� �����
from employees
where department_id > 50 --where�� group by���ٸ��� ���;���.
group by department_id;

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; -- error ���ǹ��� �׷���������� having ����. having�� �׷��� ��󳽴�.