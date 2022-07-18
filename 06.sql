--join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join 이퀄연산자 사용해서 조인했다,.
select department_id, department_name, location_id, city
from departments natural join locations; --잘안씀.

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- 과제] 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees
where department_id is null;

select employee_id, last_name, department_id, location_id
from employees natural join departments; --부서번호에 매니저아이디도 같아야 조인

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d --테이블의 별명쓰기
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400; -- error. using칼럼에 접두사d 붙인게 원인

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400; --error . using칼럼 접두사X

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where manager_id = 100; --error

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where d.manager_id = 100; --using 아닌 공통칼럼에 접두사 붙이니까 됨.

select e.last_name, d.department_name
from employees e join departments d
using (department_id) --using equi join
where e.manager_id = 100; --접두사 d 쓸때보다 결과 많다.
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

-- 과제] 위 문장을, using 으로 refactoring 하라.
select employee_id, city, department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id --조건 1
where e.manager_id = 149; --조건 2

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149; --위랑 결과 같다.

-- 과제] Toronto 에 위치한 부서에서 일하는 사원들의
--      이름, 직업, 부서번호, 부서명을 조회하라.
select e.last_name, e.job_id, e.department_id,
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id --non equi join 가능
and l.city = 'Toronto'; 

-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG'; -- 다시보기
-----------------

-- self join. 접두사 필수. 2개 테이블인 척 해야해서.
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager -- 인 척
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; -- error

select last_name emp, last_name mgr
from employees worker join employees manager 
on worker.manager_id = manager.employee_id; -- error

-- 과제] 같은 부서에서 일하는 사원들의 이름, 부서번호, 동료의 이름을 조회하라.
select worker.last_name, department.department_id, coworker.last_name
from employees worker join employees coworker
on worker.last_name = coworker.last_name;