-- Sub Query --

SELECT
    s.name STUD_NAME,
    s.deptno1 DEPT_NO,
    d.dname DEPT_NAME
FROM student s, department d
WHERE s.deptno1 = d.deptno
AND s.deptno1 = ( SELECT deptno1
                    FROM student
                    WHERE name = 'Anthony Hopkins' );

SELECT 
    deptno1
FROM student
WHERE name = 'Anthony Hopkins';


SELECT
    p.name,
    p.hiredate,
    d.dname
FROM professor p, department d
WHERE p.hiredate > (SELECT hiredate
                        FROM professor
                        WHERE name = 'Meg Ryan')
AND p.deptno = d.deptno;


SELECT
    name,
    weight
FROM student
WHERE weight > (SELECT AVG(weight) FROM student WHERE deptno1 = 201);

SELECT AVG(weight)
FROM student
WHERE deptno1 = 201;

-- 모닝 퀴즈 --
SELECT 
    TO_CHAR(TO_DATE(p.p_date),'YYYY-MM-DD') 판매일자,
    pd.p_code 상품코드,
    pd.p_name 상품명,
    TO_CHAR(pd.p_price, '9,999') 상품가,
    p.p_qty 구매수량,
    TO_CHAR(p.p_total, '999,999,999') 총금액,
    TO_CHAR(p.p_total*100, '999,999,999') 적립포인트,
    TO_CHAR(
--        CASE
--            TO_CHAR(TO_DATE(p.p_date),'MMDD')
--            WHEN 0101 THEN p.p_total*200
--            ELSE p.p_total*100
--        END
        CASE
            WHEN TO_CHAR(TO_DATE(p.p_date),'MMDD')=0101 THEN p.p_total*200
            ELSE p.p_total*100
        END,'999,999,999') 새해2배적립포인트,
    g.gname 사은품명,
    TO_CHAR(g.g_start,'999,999') 포인트START,
    TO_CHAR(g.g_end, '999,999') 포인트END
FROM panmae p, product pd, gift g
WHERE p.p_code = pd.p_code
AND DECODE(TO_CHAR(TO_DATE(p.p_date,'YYYYMMDD'),'MMDD'),0101,p.p_total*200,p.p_total*100 ) BETWEEN g.g_start AND g.g_end
ORDER BY p.p_date;
-- 퀴즈 끝 --

-- 사번이 7844인 사원과 같은 부서 사람들 조회
SELECT 
    deptno
FROM emp
WHERE empno = 7844; -- 사원이 7844인 부서

SELECT *
FROM emp
WHERE deptno = ( SELECT deptno
                  FROM emp
                  WHERE empno = 7844 ); -- 위에서 찾은 7844사번의 부서번호를 찾은 쿼리를 넣음

-- IN --
SELECT *
FROM emp2;

SELECT *
FROM dept2
WHERE area = 'Pohang Main Office';

SELECT name, e.deptno, d.area 
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
AND deptno IN ( SELECT dcode
                    FROM dept2
                    WHERE area = 'Pohang Main Office');
                    
-- &, : 표시 -- JAVA scanner 랑 비슷하게 입력받아서 대입 & = 일회용, : = 마지막에 적은것 기록남아있음
SELECT *
FROM emp2
WHERE deptno = &dno;

SELECT *
FROM emp2
WHERE deptno = :dno;


-- Exist --
SELECT *
FROM emp2
WHERE EXISTS (SELECT dcode
                    FROM dept2
                    WHERE area = 'Pohang Main Office'
                    AND dcode = deptno);

-- 간단한 연습 --       
--SELECT name 이름, position 직급, pay 연봉
--FROM emp2
--WHERE pay >ANY ( SELECT pay
--                    FROM emp2
--                    WHERE position = 'Section head' );
                    
SELECT name 이름, position 직급, pay 연봉
FROM emp2
WHERE pay > ( SELECT MIN(pay) ---- 서브쿼리에 직접 계산해서 메인쿼리랑 비교하는 것을 선호한다
                    FROM emp2
                    WHERE position = 'Section head' );
----===============
--SELECT name 이름, grade 학년, weight 몸무게
--FROM student
--WHERE weight <ALL ( SELECT weight
--                    FROM student
--                    WHERE grade = 2 );

SELECT name 이름, grade 학년, weight 몸무게
FROM student
WHERE weight < ( SELECT MIN(weight)  -- 서브쿼리에 직접 계산해서 메인쿼리랑 비교하는 것을 선호한다
                    FROM student
                    WHERE grade = 2 );
----===============
SELECT 
    e.deptno 부서번호,
    AVG(e.pay) 평균연봉
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
GROUP BY e.deptno;

SELECT
    d.dname 부서명,
    e.name 직원명,
    e.pay 연봉
FROM emp2 e, dept2 d
WHERE pay <ALL ( SELECT 
                    AVG(pay)
                FROM emp2 
                GROUP BY deptno )
AND e.deptno = d.dcode;
-- 연습 끝 --

-- 다중컬럼 서브쿼리 --
SELECT *
FROM student
WHERE (grade, weight) IN ( SELECT grade, MAX(weight)
                            FROM student
                            GROUP BY grade );

SELECT
    p.profno,
    p.name,
    TO_CHAR(p.hiredate,'YYYY-MM-DD'),
    d.dname
FROM professor p, department d
WHERE p.deptno = d.deptno
AND (p.deptno,p.hiredate) IN ( SELECT deptno,MIN(hiredate)
                    FROM professor
                    GROUP BY deptno )
ORDER BY p.hiredate;

SELECT p.profno, p.name, d.dname, p.hiredate
FROM professor p, department d
WHERE (p.deptno, p.hiredate) IN (SELECT deptno, MIN(hiredate)
                                FROM professor 
                                GROUP BY deptno)
AND p.deptno = d.deptno
ORDER BY p.hiredate;
================================

SELECT name, position, 
    TO_CHAR(pay, '$999,999,999')
FROM emp2
WHERE (position, pay) IN ( SELECT position, MAX(pay)
                            FROM emp2
                            GROUP BY position )
ORDER BY pay;

SELECT position, MAX(pay)
FROM emp2
GROUP BY position;
====================================

-- 상호연관 서브쿼리 --
SELECT *
FROM emp2 e1
WHERE e1.pay >= ( SELECT AVG(e2.pay)
                FROM emp2 e2
                WHERE e1.position = e2.position );

SELECT AVG(pay)
FROM emp2
WHERE position = 'Section head';


SELECT *
FROM emp2;

SELECT *
FROM dept2;

--join 방법
SELECT e.name, d.dname
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode;

--subquery  SELECT안에들어가는 서브쿼리 방법 (스칼라서브쿼리)
SELECT dname
FROM dept2
WHERE dcode= 1006;

SELECT name, ( SELECT dname 
                FROM dept2 
                WHERE dcode = deptno ) 직급
               -- WHERE dcode > deptno 행이 여러개라 X   <, > 사용해도 결과가 행한개면 ㄱㅊ
FROM emp2;

-- FROM 에 들어가는 서브쿼리 ( 인라인 view )
SELECT AVG(pay)  --컬럼명이 AVG(pay) 로 읽는게아닌 AVG함수로 인식해서 작동 X
FROM (SELECT deptno, AVG(pay)
        FROM emp2
        GROUP BY deptno);
        
SELECT MIN(평균페이) -- AVG(pay)의 여러행에서 제일작은 수를 가져올수있다
FROM (SELECT deptno, AVG(pay) 평균페이  -- 별칭을 지어줘서 SELECT에서 부를 수 있게 만들어준다
        FROM emp2
        GROUP BY deptno);
        
SELECT *
FROM emp;

SELECT empno, ename, job, mgr, sal, comm, deptno
FROM emp;

SELECT *
FROM (SELECT empno, ename, job, mgr, sal FROM emp);

SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;

-- gropby 집계 -> join
SELECT e.deptno, e.max_sal, d.dname
FROM ( SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno ) e, dept d
WHERE e.deptno = d.deptno;

-- join -> groupby
SELECT deptno, MAX(sal), dname
FROM( SELECT e.sal, e.deptno, d.dname
        FROM emp e, dept d
        WHERE e.deptno = d.deptno )
GROUP BY deptno, dname;


-- 간단한 연습 --
SELECT deptno1, MAX(height)
FROM student
GROUP BY deptno1;


--1) 다중컬럼 비교
--1-1) join
SELECT d.dname, s.height MAX_HEIGHT, s.name, s.height
FROM student s, department d
WHERE (s.deptno1, s.height) IN ( SELECT deptno1, MAX(height)
                                FROM student
                                GROUP BY deptno1 )
AND s.deptno1 = d.deptno;
--1-2) 서브쿼리 (다중쿼리)
SELECT (SELECT dname from department WHERE deptno = deptno1) DNAME, height MAX_HEIGHT, name, height
FROM student
WHERE (deptno1, height) IN ( SELECT deptno1, MAX(height)
                                FROM student
                                GROUP BY deptno1 );

--2) 인라인뷰 (서브쿼리)
SELECT *
FROM(SELECT deptno1, MAX(height) max_height
        FROM student
        GROUP BY deptno1) t, student s
WHERE ;





















