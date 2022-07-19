-- subquery

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');

-- 과제] Kochhar 에게 보고하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where manager_id = (select employee_id
                    from employees
                    where last_name = 'Kochhar');
                
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');
                
-- 과제] IT 부서에서 일하는 사원들의 부서번호, 이름, 직업을 조회하라.
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                        from departments
                        where department_name = 'IT');
                
-- 과제] Abel과 같은 부서에서 일하는 동료들의 이름, 입사일을 조회하라.
-- 이름 순으로 오름차순 정렬한다.
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name <> 'Abel'
order by last_name;

select last_name, salary
from employees
where salary > (select salary
                from employees --서브쿼리 리턴값은 하나. 둘이면 안됨.
                where last_name = 'King'); -- error. king이 두명이라서.
                
select last_name, job_id, salary
from employees
where salary = (select min(salary) --펑션 리턴값 하나.
                from employees); --그래서 서브쿼리 가능.

select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50);
                        
-- 과제] 회사 평균 월급 이상 버는 사원들의 사번, 이름, 월급을 조회하라.
--      월급 내림차순 정렬한다.
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                    from employees)
order by salary desc;
---------------------

--서브쿼리에서 n개 이상 리턴하는 연산자 공부
select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id); --error
                
select employee_id, last_name
from employees
where salary in (select min(salary) -- = 대신 in
                from employees
                group by department_id);
                
-- 과제] 이름에 u가 포함된 사원이 있는 부서에서 일하는 사원들의 사번, 이름을 조회하라.
select employee_id, last_name
from employees
where department_id in (select department_id --u가 포함된 부서는 여러개라서 in
                        from employees
                        where last_name like '%u%');
                    
-- 과제] 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700); --다시보기
                
select employee_id, last_name
from employees
where salary =any (select min(salary)
                  from employees
                  group by department_id);
                
select employee_id, last_name, job_id, salary
from employees
where salary <any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

-- 과제] 60번 부서의 일부 사원보다 급요가 많은 사원들의 이름을 조회하라.
select last_name
from employees
where salary >any (select salary
                    from employees
                    where department_id = 60);
                    
-- 과제] 회사 평균 월급보다, 그리고 모든 프로그래머보다 월급을 더 받는
--      사원들의 이름, 직업, 월급을 조회하라.
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees)
and salary >all (select salary
                from employees
                where job_id = 'IT_PROG');
--------------------

-- no row 서브쿼리에서 리턴되는 레코드가 없다?
select last_name
from employees
where salary = (select salary
                from employees
                where employee_id = 1);
                
select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT');
                
-- null 서브쿼리가 null이면
select last_name --매니저 출력하기.
from employees
where employee_id in(select manager_id
                        from employees); --서브쿼리 null이어도 다른값 있으면 널 빼고 걍 출력됨
                        
select last_name
from employees --in은 하나라도 일치, not in은 하나도 안일치.
where employee_id not in(select manager_id
                        from employees);
                        
-- 과제] 위 문장을 all 연산자로 refactoring 하라.
select last_name
from employees
where employee_id <>all (select manager_id
                        from employees);
---------------서브쿼리 리턴값 없으면 메인쿼리도 없다.

select count(*) --부서 개수
from departments;

select count(*) --사원 있는 부서
from departments d
where exists (select *
                from employees e
                where e.department_id = d.department_id);
                
select count(*) --사원 없는 부서
from departments d
where not exists (select *
                from employees e
                where e.department_id = d.department_id);

-- 과제] 직업을 바꾼 적이 있는 사원들의 사번, 이름, 직업을 조회하라.
select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id)
order by employee_id;

select *
from job_history
order by employee_id;