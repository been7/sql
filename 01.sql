-- select

select * from departments;

select department_id, location_id
from departments;

select location_id, department_id
from departments;

desc departments --리스판스로 테이블구조 받기.

-- 과제] employees 구조를 확인하라.

desc employees

select last_name, salary, salary + 300
from employees;
-- 과제] 사원들의 월급, 연봉을 조회하라.
select salary, salary * 12
from employees;

select last_name, salary, 12 * salary + 100
from employees;
select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees;
select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees; --피연산자 중 하나라도 널이면 결과는 널.

select last_name as name, commission_pct as comm
from employees;
select last_name "Name", salary * 12 "Annual Salary"
from employees;
-- 과제] 사원들의 사번, 이름, 직업, 입사일(STARTDATE)을 조회하라.
select employee_id, last_name, job_id, hire_date startdate
from employees;
-- 과제] 사원들의 사번(Emp #), 이름(Name), 직업(Job), 입사일(Hire Date)을 조회하라.
select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

select last_name || job_id -- 붙이기 연산자 ||
from employees;
select last_name || ' is ' || job_id --'상수포함'
from employees;
select last_name || ' is ' || job_id employee
from employees;
select last_name || null --붙이기는 널이어도 널안나옴.
from employees;
select last_name || commission_pct
from employees; --문자랑 문자랑 붙은거.
select last_name || salary
from employees; --뒤에 숫자아니고 문자
select last_name || hire_date
from employees; --문자 + 문자로 자동변환
select last_name || (salary * 12)
from employees;
-- 과제] 사원들의 '이름, 직업'(Emp & Title)을 조회하라.
select last_name || ', ' || job_id "Emp and Title"
from employees;
