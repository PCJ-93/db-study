/*
1.조회 SELECT

SELECT 조회 대상 컬럼명 FROM 테이블명; (테이블명=왼쪽에있는 테이블 목록)


select * from dept;  
* : 전체(ALL)


테이블구조 확인 (Describe)
DESC 테이블명;


조회 데이터 리터럴 활용!
SELECT '문자', 3019 FROM 테이블명;


컬럼명 별도로 지정하기 (컬럼별칭)
SELECT 컬럼명 AS "컬럼별칭",
    컬럼명 "컬럼별칭",
    컬럼명 컬럼별칭
FROM 테이블명;


--cntl + enter 커서 선택되있는 명령어 실행
*/


select * from dept;  --dept 테이블에 있는 모든 컬럼을 조회

select * from dept2;  --dept2print_table테이블에 있는 모든 컬럼을 조회

select * from emp;

select mgr, sal from emp;  --emp 테이블에있는 mgr 과 sal 컬럼을 조회

--가독성 좋게 사용 예시
SELECT *
FROM emp;

SELECT
    empno,
    ename,
    job
FROM emp;

DESC emp; --emp 테이블의 구조를 보여달라


SELECT empno, ename, '그냥문자', 999 FROM emp;

SELECT '그냥문자', 999, q'[요기안에다21435'14246''ㅇㄹㄴㄹ']' FROM emp; --emp테이블에 있는 행만큼 리터럴값이 나온다
-- 문자에는 "~~" 쓰면 오류

SELECT ename AS "이름",
        empno "사번",
        job 직업,
        '그냥문자' 중요한의미,
        sal "직원의 월급" -- 별칭에 띄어쓰기 쓸때 큰따옴표가 사용된다(별칭에 띄어쓰기 거의사용안함)
FROM emp;


/*
중복값 제거 용도 select 바로뒤에 입력
DISTINCT
*/
select * from emp;

select DISTINCT job   --emp테이블 안의 job의 목록중 중복 제거하고 조회
FROM emp;

select DISTINCT(deptno) --emp테이블 안의 deptno 부서번호 중복제거하고 조회
from emp;

select DISTINCT deptno, job   -- emp테이블 안의 deptno와job 두개조합이 중복된것을 제거하고 조회( ex)20 ANALYST,20 ANALYST,20 ANALYST )
FROM emp;


--  || 연결연산자
Select '나는' || '배가고프다' FROM dept;

SELECT DEPTNO || DNAME AS "부서번호이름",
        DEPTNO || DNAME "부서번호이름",
        DEPTNO || DNAME 부서번호이름
FROM dept;

SELECT deptno+10,
        deptno+20,
        deptno+30
FROM dept;

SELECT (deptno+deptno+deptno)
FROM dept;

SELECT name || '''s ID : ' || id || ', WEIGHT is ' || weight || 'Kg' AS "ID AND WEIGHT"
FROM student;

SELECT ename || '(' || job || ') , ' || ename || '''' || job || '''' AS "NAME AND JOB"
FROM emp;

SELECT *
FROM emp;

SELECT ename || '''s sal is $' || sal AS "Name and Sal"
FROM emp;


/*
 WHERE 조건
 찾고싶은 조건 (결과 필터링)
select ...
from ,..
where ,,,
*/
select *
from emp; --comm 성과금

select *
from emp
where comm is null; --성과금을 받지 않는 사람들만 찾고싶다

select *
from emp
where comm is not null; --성과금 지급 대상인 사람들만 찾고싶다

select DISTINCT deptno from emp;


--부서번호 20번 부서에 속한 사람들의 이름과 급여를 보자
select ename, sal
from emp
where deptno = 20;


-- emp 테이블에서 급여가 2000보다 적게 받는 사람들 목록
select *
from emp
where sal < 2000;


--emp 테이블에서 직업이 CLERK 인 사람들만 취합
select *
from emp
where job = 'CLERK';


--emp 테이블에서 직업이 CLERK 이 아닌 사람들만 취합
select *
from emp
where job <> 'CLERK';
--where job != 'CLERK'; <>과 != 는 같은 것     null 비교는 is null , is not null


-- emp 테이블 급여가 2000~3000 인 사람들만 조회
select *
from emp
--where sal >= 2000 AND sal <=3000;
WHERE sal BETWEEN 2000 AND 3000;  --권장 사용방법


-- student 테이블에서 1학년과 3학년만 조회 (1학년 이거나 3학년 이거나~)
select *
from student
--where grade = 1 or grade = 3;
where grade IN (1,3);


-- student 테이블에서 1학년과 3학년만 제외하고 조회
select *
from student
--where grade IN (2,4);
--where grade <> 1 AND grade != 3;
where grade NOT IN (1,3);  -- IS NULL / IS NOT NULL


/*
LIKE 패턴 검색
LIKE
    %, _
    %: 아무거나 아무갯수 0~n개
    _: 그위치에 한개
*/
select *
from emp
--where ename = 'WARD';   WARD 를 검색
--where ename LIKE 'M%';  첫글자가 M 으로 시작하는 ename 선택
--where ename LIKE 'MI%';  -- 첫글자가 MI으로 시작하는 ename 선택
where ename LIKE '%MI%';  -- MI~ , ~MI, ~MI~  //MI가 앞이든뒤든중간이든 포함된 ename 선택

select *
from emp
--where ename LIKE '_MI';   -- 3글자 2~3번째가 MI     SMI 가능 SSMI 불가능 SMITH불가능
--where ename LIKE '_MI__';  -- 5글자 2~3번째가 MI    언더바 수에 맞는 글자수 SMITH가능 MITH불가능
where ename LIKE '_MI%';   --n개~글자수 2~3번째가 MI   MI뒤로 오는 글자수는 신경안씀


-- 부등호 <, > , <= ,> ,=..
select *
from emp
--where hiredate = '81/05/01';
where hiredate < '1981-05-01';   --// xxxx-xx-xx로 날짜 검색


/*
정렬 ORDER BY
*정렬을 사용하지 않으면 순서보정X
ORDER BY 정렬할 기준이되는 컬럼명 ASC or DESC =[오름차순(기본)|내림차순] ASC는 기본적용이라 잘 안씀

a b c d ... 
가 나 다 라 ...
1 2 3 4 ...
SELECT ...  필수
FROM ...    필수 
WHERE ...   선택
ORDER BY ...선택
*/

select *
from student
ORDER BY name;  -- name 기준 오름차순 정렬 a b c d ..

select *
from student
ORDER BY name DESC; -- name 기준 내림차순 정렬  w t s r ..

select *
from student
ORDER BY grade DESC; -- 학년기준 내림차순

select *
from student
ORDER BY birthday;  -- 생일기준 오름차순   먼저태어난애부터 늦게태어난애까지

select *
from student
ORDER BY birthday DESC;  -- 생일기준 내림차순  늦게태어난애부터 먼저태어난애까지

select *
from student
WHERE grade IN (1,2,3) -- 1,2,3학년만 조회
ORDER BY grade, height DESC;   -- 학년 오름차순 정렬 후 - 키순은 내림차순 정렬


-- 간단한연습 --    해설 practice01
SELECT *
FROM emp
ORDER BY ename;

SELECT *
FROM emp
ORDER BY deptno, sal DESC;

SELECT *
FROM emp
WHERE sal > 2000
ORDER BY sal DESC;

SELECT *
FROM student
--WHERE grade != 1
WHERE grade <> 1
ORDER BY birthday DESC;
-- 연습끝 --


/*
집합연산자
UNION 합집합 (중복제거)
UNION ALL 합집합 (중복제거X) --기본적으로 많이쓰임
INTERSECT 교집합
MINUS 차집합
*/
-- 학생들중에 101번 학과 학생들과 102번 학과 학생들 조회
SELECT *
FROM student
WHERE deptno1 IN (101,102);
------------
SELECT *
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT *
FROM student
WHERE deptno1 = 102;
------------
-----집합연산자------
--각 테이블 조회 결과 갯수/타입이 일치하는 형태로 만들어서 결합(컬럼의 갯수와 컬럼데이터형이 동일해야함)
SELECT studno, name, deptno1    --숫자/문자/숫자     -- 타입의 순서도 양쪽 맞춰야함(숫자,문자...)
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT profno, name, deptno     --숫자/문자/숫자
FROM professor
WHERE deptno = 101;

SELECT studno, name, deptno1    --숫자/문자/숫자     -- 타입의 순서도 양쪽 맞춰야함(숫자,문자...)
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT profno, name, 0         --숫자/문자/숫자   안맞으면 인위적으로 숫자넣어서 맞춤
FROM professor
WHERE deptno = 101;


SELECT 
    studno idno,
    name,
    deptno1 deptno,
    null email     --인위적으로라도 맞춤
FROM student
WHERE deptno1 = 101
UNION ALL
select
    profno,
    name,
    deptno,
    email
from professor
WHERE deptno = 101
ORDER BY idno;
------------------------ UNION ALL
SELECT 
    studno idno,
    name,
    deptno1 deptno,
    null email,
    1 divtype      -- 1:학생 2:교수   코드관리하기에는 숫자-영문-한글 순으로 편리하다
FROM student
WHERE deptno1 = 101
UNION ALL
select
    profno,
    name,
    deptno,
    email,
    2
from professor
WHERE deptno = 101;
-------------- INTERSECT
SELECT *
FROM student
WHERE deptno1 = 101
INTERSECT
SELECT *
FROM student
WHERE deptno2 = 201;

SELECT *  --위와 같은 결과.. 교집합안써도 AND절로 더 간단하게 사용 가능 INTERSECT 잘안씀
FROM student
WHERE deptno1 = 101 AND deptno2 = 201;
--------------
--------------MINUS
SELECT *
FROM emp
WHERE job = 'SALESMAN' AND comm > 400
MINUS
SELECT *
FROM emp   --그동안 포상을 받은 직원 목록 이라고 했을때 ex) emp_cele 였다면.. MINUS사용하긴함.. 거의 없음
WHERE hiredate < '1982-01-01';






