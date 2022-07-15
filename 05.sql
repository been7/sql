--group function
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date)
from employees;

-- 과제] 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;

select count(*) --많이 쓴다. 그룹 안의 레코드 개수 리턴.
from employees;

-- 과제] 70번 부서원이 몇명인 지 조회하라.
select count(*)
from employees
where department_id = 70;

select count(employee_id) --em_id는 프라이머리키. 널없다.
from employees;

select count(manager_id) --파라미터 value가 null이면 무시.
from employees;

select avg(commission_pct) --영업직들만 평균. 널인애들 무시.
from employees;

-- 과제] 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct, 0))
from employees;
------------------

select avg(salary)
from employees;

select avg(distinct salary)
from employees;

select avg(all salary)
from employees;

-- 과제] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

-- 과제] 매니저 수를 조회하라.
select count(distinct manager_id)
from employees;
-----------------------

select department_id, count(employee_id) --count에 파라미터 프라
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id --groub by 절에 있는 것만 select에 쓸 수 있다.
order by department_id; -- error

-- 과제] 직업별 사원수를 조회하라.
select job_id, count(employee_id) --job_id가 레이블
from employees
group by job_id
order by job_id;
---------------------

select department_id, max(salary) --그룹 만들고 나서 그룹 골라냄. 
from employees
group by department_id
having department_id > 50; --having 으로 그룹 골라내기 가능

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- error. having에서는 별명 못쓴다.

select department_id, max(salary) --레코드 먼저 골라내고 골라진 레코드로 그룹 만들기
from employees
where department_id > 50 --where가 group by보다먼저 나와야함.
group by department_id;

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; -- error 조건문에 그룹펑션있으면 having 쓴다. having은 그룹을 골라낸다.