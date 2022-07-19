-- set
select employee_id, job_id --숫자, 문자
from employees
union --중복제거
select employee_id, job_id --위아래 두개 테이블 구조 같다. 둘 다 숫자, 문자다.
from job_history; --employeesㅇ도 잇고 j_h에도 잇는 사람 두명 제거

select employee_id, job_id
from employees
union all --중복포함 전체
select employee_id, job_id
from job_history;

-- 과제] 과거 직업을 현재 갖고 있는 사원들의 사번, 이름, 직업을 조회하라.
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;

select employee_id, last_name, job_id --다시보기
from employees e
where job_id in (select job_id
                from job_history j
                where e.employee_id = j.employee_id);

select employee_id, job_id
from employees
intersect -- 교집합
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
minus -- 차집합
select employee_id, job_id
from job_history;
-----------------

select location_id, department_name
from departments
union --부서명과 주 명이 섞여있다.. 업무진행불가.
select location_id, state_province
from locations; --persistence로는 숫자, 문자라서 문제없음. but service에서는 문제다.

-- 과제] 위 문장을, service 관점에서 고쳐라.
--      union 을 사용한다.
select location_id, department_name, null state
from departments
union
select location_id, null, state_province
from locations;

select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history; --error

-- 과제] 위 문장을 persistence 관점에서 고쳐라. 데이터타입같은..
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, null --null 또는 0
from job_history
order by salary;
