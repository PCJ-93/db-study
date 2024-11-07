-- JOIN 01
SELECT *
FROM emp;

SELECT *
FROM dept;

-- 조인기준 deptno 가 같은
--SELECT empno, ename, dname, loc, D.deptno  이렇게 써도 작동됨
    SELECT E.empno, E.ename, D.dname, D.loc, D.deptno  -- 컬럼앞에 테이블 별칭. 을 붙여줘서 확실하게 어느테이블에서 가져오는건지 써줘야 좋다
--SELECT *
FROM emp E, dept D            -- oracle 표기법 //보통 oracle표기법을 자주쓴다.
WHERE E.deptno = D.deptno;


SELECT E.empno, E.ename, D.dname, D.loc, D.deptno  -- 컬럼앞에 테이블 별칭. 을 붙여줘서 확실하게 어느테이블에서 가져오는건지 써줘야 좋다
--SELECT *
FROM emp E INNER JOIN dept D   -- ANSI 표기법  // 이거쓰는 곳에서는 이거 쓴다.
ON E.deptno = D.deptno;


-- 카디션 곱 // 잘못된사용.. 모든 결과가 다 출력
SELECT *
FROM emp E, dept D;
--WHERE E.deptno = D.deptno;  -- WHERE조건 을 빼먹고 할때..


-- student <-profno-> professor
SELECT *
FROM student;

SELECT COUNT(*)
FROM student;

SELECT *
FROM professor;

SELECT 
    S.profno,
    S.name,
    P.profno,
    P.name
FROM student S, professor P
WHERE S.profno = P.profno;

SELECT 
    S.profno,
    S.name,
    P.profno,
    P.name
FROM student S INNER JOIN professor P
ON S.profno = P.profno;


-- INNER JOIN  vs  OUTER JOIN
SELECT 
    S.profno,
    S.name,
    P.profno,
    P.name
FROM student S, professor P
--WHERE S.profno = P.profno;
WHERE S.profno = P.profno(+);
--WHERE S.profno(+) = P.profno;

SELECT 
    S.profno,
    S.name,
    P.profno,
    P.name
--FROM student S INNER JOIN professor P
FROM student S LEFT OUTER JOIN professor P
--FROM student S RIGHT OUTER JOIN professor P
ON S.profno = P.profno;

-- 3개 테이블 조인
SELECT *
FROM student;

SELECT *
FROM professor;

SELECT *
FROM department;

SELECT 
    S.name "STU_NAME",
    D.dname "DEPT_NAME",
    P.name "PROF_NAME"
FROM 
    student S 
    INNER JOIN professor P
    ON S.deptno1 = P.deptno
    INNER JOIN department D
    ON S.deptno1 = D.deptno;
-----
SELECT 
    s.name STU_NAME,
    p.name DEPT_NAME,
    d.dname PROF_NAME
FROM student s, department d, professor p
WHERE s.profno = p.profno
    AND
    s.deptno1 = d.deptno;  -- student 학과번호 = department 학과번호

SELECT 
    s.name STU_NAME,
    d.dname PROF_NAME,
    p.name DEPT_NAME
FROM student s, department d, professor p
WHERE s.profno = p.profno
    AND
    p.deptno = d.deptno;  -- professor 학과번호 = department 학과번호


-- 교수학과이름 , 학생학과이름
SELECT
    s.name,
    s.deptno1,
    d.dname,
    s.profno,
    p.profno,
    p.name,
    p.deptno,
    d2.dname
FROM student s, professor p, department d, department d2
WHERE s.profno = p.profno
    AND s.deptno1 = d.deptno
    AND p.deptno = d2.deptno;
    
    
--    NON-EQUI JOIN 비등가조인    ~~가 BETWEEN ~~와 AND ~~사이에 해당되는곳이 어디인지 확인후 선별 조인
SELECT *
FROM customer;

SELECT *
FROM gift;

SELECT 
    c.gname,
    c.point,
    g.gname
FROM customer c, gift g
WHERE c.point BETWEEN g.g_start AND g.g_end;

SELECT *
FROM student;

SELECT *
FROM score;

SELECT *
FROM hakjum;


-- 간단한 연습 --
SELECT
    s.studno 학번,
    s.name 이름,
    sc.total 점수,
    h.grade 학점
FROM student s, score sc, hakjum h
WHERE s.studno = sc.studno
    AND sc.total BETWEEN h.min_point AND h.max_point
ORDER BY total desc;

SELECT
    s.studno 학번,
    s.name 이름,
    sc.total 점수,
    h.grade 학점
FROM student s, score sc, hakjum h
WHERE s.studno = sc.studno
    AND sc.total BETWEEN h.min_point AND h.max_point
    AND s.deptno1 IN(101,102)
ORDER BY total desc;

SELECT
    s.name NAME,
    s.grade GRADE,
    p.name NAME,
    p.deptno,
    d.dname
FROM student s, department d, professor p
WHERE p.deptno <> 301
    AND s.profno = p.profno
    AND p.deptno = d.deptno
ORDER BY deptno;
-- 연습 끝 --

--- 1:1 1:n n:1 n:m -- 따라 출력이 다르게 될수도 있다.
SELECT *
FROM student s, professor p
WHERE s.profno = p.profno;

SELECT *
FROM student s, professor p
WHERE s.profno(+) = p.profno;

SELECT *
FROM student s, professor p
WHERE s.profno = p.profno(+);

SELECT *
FROM student s, professor p
WHERE p.profno = s.profno(+);

SELECT *
FROM professor;

SELECT *
FROM student;


-- 모닝 퀴즈 --
SELECT
    deptno "부서번호",
    --ROUND(AVG(sal),2),
    TO_CHAR(AVG(sal),'9999.99') "평균급여"
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;

SELECT
    p_date 판매일자,
    SUM(p_qty) 판매수량,
    SUM(p_total) 판매금액
FROM panmae
GROUP BY p_date
ORDER BY p_date;

SELECT
    p_date 판매일자,
    p_code 상품코드,
    SUM(p_qty) 판매수량,
    SUM(p_total) 판매금액
FROM panmae
GROUP BY ROLLUP( p_date, p_code );
-- 퀴즈 끝 --

--SELF JOIN -- 같은 테이블이지만 두개의 테이블이라고 생각해서 사용하면 편할수도있다.

-- 내 사번, 내이름 , 내상사의사번 , 상사의이름
SELECT 
    e1.empno 내사번,
    e1.ename 내이름,
    e1.mgr 내상사의사번,
    e2.empno 상사의사번,
    e2.ename 상사의이름
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno;

-- 간단한 연습 --
SELECT
    s.name "STU_NAME",
    s.deptno1,
    d.dname "DEPT_NAME"
FROM student s, department d
WHERE s.deptno1 = d.deptno
ORDER BY deptno1;

SELECT
    e.name,
    e.position,
    TO_CHAR(e.pay,'999,999,999') "PAY",
    TO_CHAR(p.s_pay,'999,999,999') "LOW PAY",
    TO_CHAR(p.e_pay,'999,999,999') "HIGH PAY"
FROM emp2 e, p_grade p
WHERE e.position = p.position(+) AND e.position is not null
ORDER BY s_pay;

SELECT
    e.name NAME,
    TO_CHAR(TO_DATE('2010-05-30'),'YYYY') - TO_CHAR(e.birthday,'YYYY')+1 한국나이,
    --2010-TO_CHAR(e.birthday,'YYYY')+1 한국나이,
    e.position 지금포지션,
    p.position 그나이에맞는포지션
FROM emp2 e, p_grade p
WHERE TO_CHAR(TO_DATE('2010-05-30'),'YYYY') - TO_CHAR(e.birthday,'YYYY')+1 BETWEEN p.s_age AND p.e_age;


SELECT 
    c.gname,
    c.point,
    g.gname
FROM customer c, gift g
WHERE c.point >= g.g_start
AND g.gno = 7;
  --g.gname = 'Notebook';
--GROUP BY c.gname, point, g.gname
--HAVING g.gname = 'Notebook';


SELECT
    profno,
    name,
    hiredate,
    RANK() OVER (ORDER BY hiredate)-1
FROM professor
ORDER BY hiredate;


SELECT 
    p1.profno,
    p1.name,
    p1.hiredate,
    COUNT(p2.profno) COUNT
FROM professor p1, professor p2
WHERE p1.hiredate > p2.hiredate(+)
GROUP BY p1.profno, p1.name, p1.hiredate
ORDER BY p1.hiredate;


SELECT
    empno,
    ename,
    hiredate,
    RANK() OVER (ORDER BY hiredate)-1 COUNT
FROM emp;

SELECT
    e1.empno,
    e1.ename,
    e1.hiredate,
    COUNT(e2.empno) COUNT
FROM emp e1, emp e2
WHERE e1.hiredate > e2.hiredate(+)
GROUP BY e1.empno, e1.ename, e1.hiredate
ORDER BY e1.hiredate;
