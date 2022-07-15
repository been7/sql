-- single function 리턴값 레코드

desc dual
select * from dual; --필드 하나로 구성된 레코드 하나 들어있는 테이블 받은거.

select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select initcap('SQL course')
from dual;

select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees --lower 107번 실행
where lower(last_name) = 'higgins'; --lower function 리턴값이 피연산자.

select concat('Hello', 'World')
from dual;

select substr('HelloWorld', 2, 5)
from dual;
select substr('Hello', -1, 1)
from dual;

select length('Hello')
from dual;

select instr('Hello', 'l') --처음발견된 두번째파라미터 리턴.,
from dual;
select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*')
from employees;
select rpad(salary, 5, '*')
from employees;

-- 과제] 사원들의 이름, 월급그래프를 조회하라.
--      그래프는 $1000 당 * 하나를 표시한다.
select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees;

-- 과제] 위 그래프를 월급 기준 내림차순 정렬하라.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc; --또는 2

select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello')
from dual;
select trim('l' from 'Hello')
from dual;
select trim(' ' from ' Hello ')
from dual;
-- 과제] 위 query에서 ' '가 trim 됐음을 눈으로 확인할 수 있게 조회하라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;
select trim(' Hello World ') --주로 이렇게 쓴다.
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- 과제] 아래 문장에서, where 절을 like 로 refactoring 하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- 과제] 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 조회하라.
--      이름은 첫글자는 대문자, 나머지는 소문자로 출력한다.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';
----------------------------

select round(45.926, 2) --반올림
from dual;
select trunc(45.926, 2) --소수점이하 자리수
from dual;

select round(45.923, 0), round(45.923) --정수만들겠다. 0 생략가능
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;

-- 과제] 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수), 인상액(Increase)을 조회하라.
select last_name, salary,
    round(salary * 1.155) "New Salary",
    round(salary * 1.155) - salary "Increase"
from employees;
---------------------- 숫자 함수

select sysdate --많이 쓴다.
from dual;

select sysdate + 1
from dual;
select sysdate - 1
from dual;

select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- 과제] 90번 부서 사원들의 이름, 근속년수를 조회하라.
select last_name, trunc((sysdate - hire_date) / 365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2021/12/31') --몇개월 차이인지
from dual;

select add_months('2022/07/14', 1) --개월 더하기
from dual;

select next_day('2022/07/14', 5) --날짜 이후 첫번째 요일
from dual;

select next_day('2022/07/14', 'thursday')
from dual;

select next_day('2022/07/14', 'thu')
from dual;

select last_day('2022/07/14') --월말일
from dual;

-- 과제] 20년 이상 재직한 사원들의 이름, 첫월급일을 조회하라.
--      월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;
--where ((sysdate - hire_date) / 365) >= 20;