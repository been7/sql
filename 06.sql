--join. 테이블 n개 결합(사실 레코드 결합)
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
where manager_id = 100; --error 접두사 없어서..

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

-- 과제] 같은 부서에서 일하는 사원들의 부서번호, 이름, 동료의 이름을 조회하라.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id != c.employee_id -- <> 다르다.
order by 1, 2, 3;

-- 과제] Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date;

-- 과제] 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명, 매니저입사일을 조회하라.
select w.last_name w_name, w.hire_date w_date,
    m.last_name m_name, m.hire_date m_date
from employees w join employees m
on w.manager_id = m.employee_id
and w.hire_date < m.hire_date;
---------------------- inner join 조인한 테이블만 조회.

--inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id; -- 이너조인. 그랜트빠짐

select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id; --왼쪽 그랜트 빠짐.

select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

-- 과제] 사원들의 이름, 사번, 매니저명, 매니저의사번을 조회하라.
--      king 사장도 테이블에 포함한다.
select w.last_name, w.employee_id, m.last_name, m.employee_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;
--------------- 1부 끝. 21c 문법

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in (20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id; --(+) right outer join

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); --left outer join

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id(+); --error

select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;