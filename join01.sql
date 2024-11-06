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


