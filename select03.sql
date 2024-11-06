-- 복수행 함수

-- COUNT  // COUNT(대상) 갯수
SELECT
    COUNT(*)
FROM emp;

SELECT
  --ename, <- 이거 안됨 행 크기 안맞음
    COUNT(empno),
    COUNT(comm),
    COUNT(ename)
FROM emp;

SELECT
    COUNT(job),
    COUNT(mgr),
    COUNT(hiredate),
    COUNT(comm)
FROM emp;

-- SUM 함수
SELECT
    SUM(sal) "총급여",
    COUNT(empno) "직원수"
FROM emp;

-- 10번, 20번 부서 다니는애들 총 몇명? 걔네들 총급여 얼마?
SELECT
    COUNT(*),
    SUM(sal)
FROM emp
WHERE deptno IN(10, 20);


-- AVG MAX MIN
SELECT
    AVG(height), --평균값
    MAX(height),  --최대값
    MIN(height),  --최소값
    STDDEV(height),  --표준편차값
    VARIANCE(height) --분산값
FROM student;


-- GROUP BY 절
-- student 평균 키 계산하고싶은데..
-- 1, 2, 3, 4학년 별로 각학년 평균키 구하려면..
SELECT  -- GROUP BY 안쓴 노가다 코드
    '1학년' "학년",
    AVG(height) "평균키"
FROM student
WHERE grade = 1
UNION ALL
SELECT
    '2학년',
    AVG(height)
FROM student
WHERE grade = 2
UNION ALL
SELECT
    AVG(grade)||'학년',
    AVG(height)
FROM student
WHERE grade = 3
UNION ALL
SELECT
    AVG(grade)||'학년',
    AVG(height)
FROM student
WHERE grade = 4;
------------------
SELECT...
FROM...
WHERE...
GROUP BY...
ORDER BY...

SELECT
    grade,  -- group by 절에 사용된 컬럼은 같이 사용 가능
    AVG(height)
FROM student
GROUP BY grade
ORDER BY grade;

SELECT 
    studno,
    AVG(height) 
FROM student
GROUP BY studno;  -- studno는 중복된것이 없어서 그룹이 안지어짐


--- 간단한 연습1 ---
--emp 전체 sal 급여 평균
SELECT
    AVG(sal) "사원전체 평균급여"
FROM emp;
--emp 30번 부서 사람들 평균급여
SELECT
    AVG(deptno) "부서",
    AVG(sal) "평균급여"
FROM emp
WHERE deptno = 30;
--emp 각 부서별 평균 급여
SELECT
    deptno "부서",
    AVG(sal) "평균급여"
FROM emp
GROUP BY deptno
ORDER BY deptno;
--emp 각 부서별 인원과 평균 급여
SELECT
    deptno "부서",
    COUNT(*) "인원수",
    AVG(sal) "평균급여"
FROM emp
GROUP BY deptno
ORDER BY deptno;
--emp 각 직업별 평균급여
SELECT
    job "직업",
    AVG(sal) "평균급여"
FROM emp
GROUP BY job;
--emp 각 직업별 가장 높은 급여 얼마?
SELECT
    job "직업",
    MAX(sal) "가장높은급여"
FROM emp
GROUP BY job;
--emp 각 부서별 가장 높은 급여 얼마?
SELECT
    deptno "부서",
    MAX(sal) "가장높은급여"
FROM emp
GROUP BY deptno
ORDER BY deptno;
-- 연습 끝 --


--- 모닝 퀴즈 ---
/*emp2 테이블을 기준으로 아래 정보를 출력
사원들 중에 70년대 생이면서 지역번호를 기준으로 서울(02), 경기도(031)에 거주하는
사원들의 정보를 아래와 같이 출력하시오.
사번, 이름, 생년월일, 취미, 급여(pay), 성과급(급여의 150%)
, 직원분류(단, 가족과 같은 직원이라서 family로 표기)
,전화번호, 급여수준
(단, 급여수준은 아래와 같이 분류)
3500만 1원 ~ 4500만 : '하'
4500만 1원 ~ 6천만 : '중"
6000만 1원 이상 : '상'
그 외... : '화이팅'
*/
SELECT
    empno 사번,
    name 이름,
    birthday 생년월일,
    hobby 취미,
    pay 급여,
    pay*1.5 성과급,
    REPLACE(emp_type,'employee', 'family') 직원분류,
    --SUBSTR(emp_type, 1, INSTR(emp_type,' '))||'family' 직원분류,
    tel,
    CASE
        WHEN pay BETWEEN 35000001 AND 45000000 THEN '하'
        WHEN pay BETWEEN 45000001 AND 60000000 THEN '중'
        WHEN pay >60000000 THEN '상'
        ELSE '화이팅'
        END 급여수준
FROM emp2
WHERE 
    SUBSTR(TO_CHAR(birthday, 'YY'),1,1) = '7'
    AND
    SUBSTR(tel,1,(INSTR(tel,')')-1)) IN('02','031');

--- 모닝퀴즈 끝 ---

-- HAVING 절 --
SELECT... 4
FROM.. 1
WHERE... 2
GROUP BY.. 3
ORDER BY.. 5

SELECT... 5
FROM.. 1
WHERE... 2
GROUP BY.. 3
HAVING..4
ORDER BY.. 6

SELECT 
    deptno,
    AVG(sal)
FROM emp
--WHERE AVG(sal) >= 2000
GROUP BY deptno
HAVING AVG(sal)>=2000;

1) 급여가 1500 이상인 직원들만 대상으로, 부서별 평균 급여
SELECT 
    deptno,
    AVG(sal)
FROM emp
WHERE sal >= 1500
GROUP BY deptno;

2) 부서별 평균 급여가 1500 이상인 경우만, 부서별 평균 급여 보여주기
SELECT 
    deptno,
    AVG(sal)
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 1500;

각 학년별 평균 몸무게
평균몸무게 65키로 이상인 경우만 확인
SELECT
    grade,
    AVG(weight)
FROM student
GROUP BY grade
HAVING AVG(weight)>=65;

4학년을 제외하고
각 학년별 평균 몸무게
평균 몸무게 65키로 이상인 경우만 확인
SELECT
    grade,
    AVG(weight)
FROM student
WHERE grade <> 4
GROUP BY grade
HAVING AVG(weight)>=65;

SELECT
    grade,
    AVG(weight)
FROM student
GROUP BY grade
HAVING grade != 4 AND AVG(weight)>=65;


-- ROLLUP() 함수
SELECT
    deptno,
    job,
    ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno, job
ORDER BY deptno;

SELECT
    deptno,
    job,
    ROUND(AVG(sal),2)
FROM emp
GROUP BY ROLLUP(deptno,job);


GROUP BY ROLLUP(deptno,job);  --뒤에서부터 하나씩 없애면서 그룹화
1) deptno, job 그룹화 모은다
2) deptno 그룹화 => 계
3) () 그룹화 => 계  -- 리스트 전체 의 계 2)번의 계 아님
SELECT
    AVG(1300+2450+5000+800+3000+2975+950+2850+1400)
FROM dual;

GROUP BY ROLLUP(deptno,job,mgr);
1) deptno, job, mgr 그룹
2) deptno, job 계
3) deptno 계
4) () 계

SELECT 
    deptno,
    job,
    mgr,
    ROUND(AVG(sal),1)
FROM emp
GROUP BY ROLLUP(deptno,job,mgr);


--GROUP BY ROLLUP ( (deptno,job) );
1) (deptno,job) 그룹화
2) () 계
SELECT
    deptno,
    job,
    ROUND(AVG(sal),1)
FROM emp
GROUP BY ROLLUP ( (deptno,job) );

--GROUP BY ROLLUP ( deptno,(job,mgr) );
1) deptno, job, mgr 그룹
2) deptno 계
3) () 계
SELECT
    deptno,
    job,
    mgr,
    ROUND(AVG(sal),1)
FROM emp
GROUP BY ROLLUP ( deptno,(job,mgr) );

-- CUBE --  ROLLUP 이랑 비슷한데 모든 계를 출력해줌
SELECT
    deptno,
    job,
    mgr,
    ROUND(AVG(sal),1)
FROM emp
GROUP BY CUBE ( deptno,job,mgr );


-- RANK(), DENSE_RANK() 함수  일반적으로 OVER랑 같이 사용
순위 RANK() OVER (ORDER BY 정렬기준)
그룹단위로 순위 RANK() OVER (PARTITION BY 기준 ORDER BY 정렬기준)
                         --group by   PARTITION BY ~~ 그룹지은 기준에서 순위 매김

SELECT 
    ename,
    sal,
    RANK() OVER (ORDER BY sal DESC),  -- 같은등수이후 같은등수도 순서로치고 다음순서로 넘어감 7 8 9 9 11 12..
    DENSE_RANK() OVER (ORDER BY sal DESC) -- 같은 등수이후 순서에맞게 정리 7 8 9 9 10 11 ..
FROM emp;

SELECT 
    name,
    height,
--    RANK() OVER (ORDER BY height DESC) 순1,
--    DENSE_RANK() OVER (ORDER BY height DESC) 순2,
    grade,
    RANK() OVER (PARTITION BY grade ORDER BY height DESC) 순3,
    DENSE_RANK() OVER (PARTITION BY grade ORDER BY height DESC) 순4
FROM student
ORDER BY grade, height desc;

