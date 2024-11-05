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





