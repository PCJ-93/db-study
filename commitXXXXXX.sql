SELECT
    e.empno,
    e.ename,
    d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;


SELECT
    s.name,
    p.name
FROM student s, professor p
WHERE s.profno = p.profno(+);

SELECT
    s.name,
    d.dname,
    p.name
FROM student s, professor p, department d
WHERE s.profno = p.profno
    AND p.deptno = d.deptno
ORDER BY s.deptno1;

SELECT 
    s.deptno1,
    s.name,
    p.profno,
    p.name
FROM student s, professor p
WHERE s.deptno1 = p.deptno
AND s.deptno1 = 101;

SELECT
    c.gname,
    TO_CHAR(c.point, '999,999'),
    g.gname
FROM customer c, gift g
WHERE c.point BETWEEN g_start AND g_end;

SELECT *
FROM customer;

SELECT
    s.name,
    sc.total,
    h.grade
FROM student s, score sc, hakjum h
WHERE s.studno = sc.studno
    AND sc.total BETWEEN min_point AND max_point
ORDER BY sc.total desc;

SELECT
    s.name,
    p.name
FROM student s, professor p
WHERE s.profno = p.profno(+)
ORDER BY p.name, s.name;

SELECT
    deptno 부서번호,
    AVG(sal) 평균급여
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;

SELECT
    *
FROM panmae;

SELECT
    TO_DATE(p_date, 'YYYY-MM-DD') 판매일자,
    SUM(p_qty) 판매수량,
    TO_CHAR(SUM(p_total),'999,999') 판매금액
FROM panmae
GROUP BY p_date
ORDER BY p_date;

--SELECT
--    p_date 판매일자,
--    p_code 상품코드,
--    SUM(p_qty) 판매수량,
--    SUM(p_total) 판매금액
--FROM panmae
--GROUP BY ROLLUP( p_date, p_code );
================================================================================
================================================================================
================================================================================
SELECT
    studno,
    name,
    TO_CHAR(birthday, 'YYYY-MM-DD')
FROM student
WHERE TO_CHAR(birthday, 'MM') = '01';

SELECT
    empno,
    ename,
    hiredate
FROM emp
WHERE TO_CHAR(hiredate,'MM') IN(01,02,03);

SELECT
    studno,
    name,
    id
FROM student
WHERE height BETWEEN 160 AND 175
UNION ALL
SELECT
    profno,
    name,
    id
FROM professor
WHERE deptno IN(101,102,103,201) AND bonus IS NULL;

SELECT
    '이름:'||name,
    '아이디:'||id,
    '주민번호:'||jumin
FROM student;

SELECT
    empno,
    ename,
    TO_CHAR(hiredate, 'YYYY-MM-DD'),
    TO_CHAR( ( (sal*12)+comm ), '$999,999'),
    TO_CHAR( ( (sal*12)+comm )*1.15, '$999,999')
FROM emp
WHERE comm IS NOT NULL;

SELECT
    profno,
    name,
    pay,
    bonus,
    (pay*12)+NVL(bonus,0)
FROM professor
WHERE deptno = 201;

SELECT 
    empno,
    ename,
    comm,
    NVL2(comm, 'Exist', 'NULL')
FROM emp
WHERE deptno = 30;

SELECT
    deptno,
    name,
    DECODE( deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!') )
FROM professor;

SELECT
    name,
    deptno,
    DECODE( deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!', 'GOOD!'))
FROM professor;

SELECT
    deptno,
    name,
    DECODE( deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!', 'GOOD!'), 'N/A' )
FROM professor;

SELECT
    name,
    jumin,
    DECODE( SUBSTR(jumin,7,1), 1, '남자', '여자')
FROM student
WHERE deptno1 = 101;

SELECT 
    name,
    tel,
    DECODE( SUBSTR( tel, 1, (INSTR(tel,')')-1) ) , '02', '서울', '031', '경기', '051', '부산', '052', '울산', '055', '경남' )
FROM student
WHERE deptno1 = 101;

SELECT
    name,
    jumin,
    birthday,
    CASE
        WHEN TO_CHAR(birthday,'MM') IN('01','02','03') THEN '1분기'
        WHEN TO_CHAR(birthday,'MM') IN('04','05','06') THEN '2분기'
        WHEN TO_CHAR(birthday,'MM') IN('07','08','09') THEN '3분기'
        WHEN TO_CHAR(birthday,'MM') IN('10','11','12') THEN '4분기'
    END
FROM student;

SELECT
    empno,
    ename,
    sal,
    CASE
        WHEN sal BETWEEN 1 AND 1000 THEN 'Level 1'
        WHEN sal BETWEEN 1001 AND 2000 THEN 'Level 2'
        WHEN sal BETWEEN 2001 AND 3000 THEN 'Level 3'
        WHEN sal BETWEEN 3001 AND 4000 THEN 'Level 4'
        WHEN sal > 4001 THEN 'Level 5'
        END
FROM emp;

SELECT
    AVG(sal)
FROM emp;

SELECT
    AVG(sal)
FROM emp
WHERE deptno = 30;

SELECT
    deptno,
    AVG(sal)
FROM emp
GROUP BY deptno;

SELECT
    deptno,
    count(*),
    AVG(sal)
FROM emp
GROUP BY deptno;

SELECT
    job,
    AVG(sal)
FROM emp
GROUP BY job;

SELECT
    job,
    MAX(sal)
FROM emp
GROUP BY job;

SELECT
    deptno,
    MAX(sal)
FROM emp
GROUP BY deptno;

SELECT
    empno,
    name,
    birthday,
    hobby,
    pay,
    pay*1.5,
    SUBSTR(emp_type,1,INSTR(emp_type,' '))||'family',
    tel,
    CASE
        WHEN pay BETWEEN 35000001 AND 45000000 THEN '하'
        WHEN pay BETWEEN 45000001 AND 60000000 THEN '중'
        WHEN pay > 60000001  THEN '상'
        ELSE '화이팅'
    END
FROM emp2
WHERE SUBSTR( TO_CHAR(birthday,'YY'), 1,1) = 7
AND
SUBSTR(tel, 1, INSTR(tel,')')-1) IN('02', '031');

===============================================================================
===============================================================================
--SELECT                    -- 학점연결
--    s.studno,
--    s.name,
--    sc.total,
--    h.grade
--FROM student s, score sc, hakjum h
--WHERE s.studno = sc.studno
--AND sc.total BETWEEN min_point AND max_point;

SELECT                    -- 학점연결
    s.studno,
    s.name,
    sc.total,
    h.grade
FROM student s, score sc, hakjum h
WHERE s.studno = sc.studno
AND sc.total BETWEEN min_point AND max_point
AND s.deptno1 IN(101,102);

SELECT
    s.name,
    s.grade,
    p.name,
    p.deptno,
    d.dname
FROM student s, professor p, department d
WHERE s.profno = p.profno
AND p.deptno = d.deptno
AND p.deptno <> 301;

SELECT 
   s.studno,
   s.name,
   sc.total,
   h.grade
FROM student s, score sc, hakjum h
WHERE s.studno = sc.studno
AND sc.total BETWEEN min_point AND max_point
AND s.deptno1 IN(101,102)
ORDER BY sc.total desc;

SELECT
    s.name,
    s.grade,
    p.name,
    p.deptno,
    d.dname
FROM student s, professor p, department d
WHERE p.profno = s.profno
AND p.deptno = d.deptno
AND p.deptno <> 301;

SELECT *
FROM emp;

SELECT
    deptno,
    AVG(sal)
FROM emp
GROUP BY deptno
HAVING AVG(sal) > 2000;

SELECT *
FROM panmae;

SELECT
    p_date,
    SUM(p_qty),
    SUM(p_total)
FROM panmae
GROUP BY p_date
ORDER BY p_date;

====================================================================
--3. panmae 테이블
--판매일자 기준으로 각 상품코드당 총 판매수량과 총 판매금액을 보여주세요.
--판매일자 기준으로 모든 상품의 판매수량과 판매금액의 소계를 출력하고,
--마지막에 전체 판매수량과 판매금액의 합계도 보여주세요.
--SELECT 
--    p_date,
--    p_code,
--    SUM(p_qty),
--    SUM(p_total)
--FROM panmae
--GROUP BY ROLLUP (p_date, p_code);
====================================================================;

SELECT *
FROM student;
SELECT *
FROM department;

SELECT 
    s.name,
    s.deptno1,
    d.dname
FROM student s, department d
WHERE s.deptno1 = d.deptno
ORDER BY s.deptno1;

SELECT *
FROM p_grade;

SELECT
    e.name,
    p.position,
    e.pay,
    p.s_pay,
    p.e_pay
FROM emp2 e, p_grade p
WHERE e.position IS NOT NULL
AND e.pay BETWEEN p.s_pay AND p.e_pay;


SELECT 
    SUM(p_qty),
    SUM(p_total)
FROM panmae
GROUP BY p_date;

SELECT
    p_date,
    p_code,
    SUM(p_qty),
    SUM(p_total)
FROM panmae
GROUP BY ROLLUP (p_date,p_code);

SELECT 
    s.name,
    s.deptno1,
    d.dname
FROM student s, department d
WHERE s.deptno1 = d.deptno
ORDER BY s.deptno1;

==========================================================================
--2. emp2 테이블과 p_grade 테이블을 조회하여
--현재 직급이 있는 사원의 이름과 직급, 현재 연봉,
--해당 직급의 연봉의 하한금액과
--상한 금액을 아래 결과 화면과 같이 출력하세요.
--SELECT * FROM emp2;
--SELECT * FROM p_grade;

--SELECT 
--    e.name,
--    e.position,
--    e.pay,
--    p.s_pay,
--    p.e_pay
--FROM emp2 e, p_grade p
--WHERE e.position IS NOT NULL
--AND e.position = p.position(+);
==========================================================================

SELECT
    e.name,
    2010 - SUBSTR( TO_CHAR(e.birthday,'YYYY'),1,4 ) + 1 한국나이,
    e.position 지금포지션,
    p.position 나이에맞는포지션
FROM emp2 e, p_grade p
WHERE ( 2010 - SUBSTR( TO_CHAR(e.birthday,'YYYY'),1,4 ) + 1 ) BETWEEN s_age AND e_age
ORDER BY 한국나이;

SELECT * FROM emp2;
SELECT * FROM p_grade;


SELECT * FROM customer;
SELECT * FROM gift;

SELECT 
    c.gname,
    c.point,
    ( SELECT gname FROM gift WHERE gno = 7 )
FROM customer c, gift g
WHERE c.point BETWEEN g_start AND g_end
AND c.point > ( SELECT g_start FROM gift WHERE gno = 7 );


SELECT 
    profno,
    name,
    hiredate,
    RANK() OVER(ORDER BY hiredate)-1
FROM professor;


select COUNT(*)
from professor
where hiredate < (select hiredate
                    from professor
                    where name = 'Nicole Kidman');


SELECT 
    empno,
    ename,
    hiredate,
    RANK() OVER(ORDER BY hiredate)-1
FROM emp;


SELECT
    s.name,
    s.deptno1,
    d.dname
FROM student s, department d
WHERE (SELECT deptno1 FROM student WHERE name = 'Anthony Hopkins') = deptno1
AND s.deptno1 = d.deptno;

SELECT * FROM department;


SELECT
    p.name,
    p.hiredate,
    d.dname
FROM professor p, department d
WHERE ( SELECT hiredate FROM professor WHERE name = 'Meg Ryan' ) < p.hiredate
AND p.deptno = d.deptno
ORDER BY hiredate;


SELECT
    name,
    weight
FROM student
WHERE ( SELECT
            avg(weight)
        FROM student
        WHERE deptno1 = 201 ) < weight;

--============================================================================
/*
참조 테이블 : panmae, product, gift
출력 데이터 : 상품명, 상품가, 구매수량, 총금액,
적립포인트, 새해2배적립포인트, 사은품명, 포인트 범위

- panmae 테이블을 기준으로 포인트를 보여준다.
- 포인트는 구매한 금액 1원당 100의 포인트를 부여한다.
(단, 01월 01인 경우는 새해 이벤트로 인해 1원당 200의 포인트를 부여한다.)
- 적립포인트와 새해2배적립포인트를 모두 보여준다.
(이 경우, 이벤트 날인 01월 01일을 제외하고는 포인트가 동일 할 것이다.)
- 새해2배적립포인트를 기준으로 해당 포인트 기준으로 받을수 있는 사은품을 보여준다.
- 사은품 명 옆에 해당 사은품을 받을 수 있는 포인트의 범위를 함께 보여준다.

* 출력 양식과 컬럼 헤더에 표기되는 이름 확인!
*/

--SELECT * FROM panmae;
--SELECT * FROM product;
--SELECT * FROM gift;
--
--SELECT 
--    p.p_date,
--    p.p_code,
--    pd.p_name,
--    pd.p_price,
--    p.p_qty,
--    p.p_total,
--    p.p_total*100,
--    DECODE(TO_CHAR(TO_DATE(p.p_date,'YYYYMMDD'),'MMDD'),0101,p.p_total*200,p.p_total*100 ),
--    g.gname,
--    g.g_start,
--    g.g_end
--FROM panmae p, product pd, gift g
--WHERE p.p_code = pd.p_code
--AND ( DECODE(TO_CHAR(TO_DATE(p.p_date,'YYYYMMDD'),'MMDD'),0101,p.p_total*200,p.p_total*100 ) ) BETWEEN g.g_start AND g.g_end
--ORDER BY p.p_date;
--============================================================================

SELECT *
FROM panmae;
SELECT *
FROM product;
SELECT *
FROM gift;

SELECT
    p.p_date,
    p.p_code,
    pd.p_name,
    pd.p_price,
    p.p_qty,
    p.p_total,
    p.p_total*100,
    DECODE(SUBSTR(p_date,5),'0101', p_total*200, p_total*100 ),
    g.gname,
    g.g_start,
    g.g_end
FROM panmae p, product pd, gift g
WHERE DECODE(SUBSTR(p_date,5),'0101', p_total*200, p_total*100 ) BETWEEN g.g_start AND g.g_end
AND p.p_code = pd.p_code
ORDER BY p.p_date;

SELECT
TO_CHAR(TO_DATE(p_date,'YYYYMMDD'),'MMDD')
FROM panmae;

SELECT
    DECODE(TO_CHAR(TO_DATE(p_date,'YYYYMMDD'),'MMDD'), 0101, p_total*200, p_total*100)
FROM panmae;
SELECT
    DECODE(SUBSTR(p_date,5),'0101', p_total*200, p_total*100 )
FROM panmae;


SELECT MIN(pay)
FROM emp2
WHERE position = 'Section head';

SELECT
    name,
    position,
    pay
FROM emp2
WHERE pay > ( SELECT MIN(pay)
                FROM emp2
                WHERE position = 'Section head' )
ORDER BY pay desc;


SELECT
    MIN(weight)
FROM student
WHERE grade = 2;

SELECT
    name,
    grade,
    weight
FROM student
WHERE weight < ( SELECT
                        MIN(weight)
                    FROM student
                    WHERE grade = 2 );
                    
                    
SELECT
    MIN(AVG(pay))
FROM emp2
GROUP BY deptno;

SELECT
    d.dname,
    e.name,
    e.pay
FROM emp2 e, dept2 d
WHERE pay < ( SELECT
                    MIN(AVG(pay))
                FROM emp2
                GROUP BY deptno )
AND e.deptno = d.dcode
ORDER BY pay desc;


SELECT *
FROM professor;
SELECT *
FROM department;

SELECT MIN(hiredate)
FROM professor
GROUP BY deptno;

SELECT
    p.deptno,
    p.name,
    d.dname,
    p.hiredate
FROM professor p, department d
WHERE hiredate IN( SELECT MIN(hiredate)
                    FROM professor
                    GROUP BY deptno )
AND p.deptno = d.deptno
ORDER BY p.hiredate;


SELECT MAX(pay)
FROM emp2
WHERE position is not null
GROUP BY position;

SELECT
    name,
    position,
    pay
FROM emp2
WHERE pay IN ( SELECT MAX(pay)
                FROM emp2
                WHERE position is not null
                GROUP BY position )
ORDER BY pay;

--=============================================================================
--1.
--student, department 테이블 활용
--학과 이름, 학과별 최대키, 학과별 최대키를 가진 학생들의 이름과 키를 출력 하세요.
SELECT deptno1, MAX(height)
FROM student
group by deptno1;

SELECT
    d.dname,
    s.height,
    s.name,
    s.height
FROM student s, department d
WHERE (s.deptno1,s.height) IN ( SELECT deptno1, MAX(height)
                                    FROM student
                                    group by deptno1 )
AND s.deptno1 = d.deptno;


--2.
--student 테이블에서 학생의 키가 동일 학년의 평균 키 보다 큰 학생들의 학년과 이름과 키,
--해당 학년의 평균 키를 출력 하세요.
--(학년 컬럼으로 오름차순 정렬해서 출력하세요)
SELECT grade, AVG(height)
FROM student
GROUP BY grade;

SELECT
    
FROM student
WHERE ;
--=============================================================================

SELECT *
FROM emp2;
SELECT *
FROM dept2;

SELECT
    e.empno,
    e.name,
    e.deptno,
    d.dname,
    d.area,
    e.pay
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
AND e.pay > ( SELECT
                    AVG(e.pay)
                FROM emp2 e, dept2 d
                WHERE area = ( SELECT
                                    d.area
                                FROM emp2 e, dept2 d
                                WHERE e.name = 'AL Pacino'
                                AND e.deptno = d.dcode ) );

SELECT
    d.area
FROM emp2 e, dept2 d
WHERE e.name = 'AL Pacino'
AND e.deptno = d.dcode;

SELECT
    AVG(e.pay)
FROM emp2 e, dept2 d
WHERE area = ( SELECT
                    d.area
                FROM emp2 e, dept2 d
                WHERE e.name = 'AL Pacino'
                AND e.deptno = d.dcode );
                
                
--=============================================================================
--=============================== CRUD =========================================
CREATE TABLE tst_table2222
(
    no NUMBER(3) PRIMARY KEY,
    name VARCHAR2(24) NOT NULL,
    hiredate DATE DEFAULT SYSDATE
);

SELECT * FROM tst_table2222;

INSERT INTO tst_table2222
VALUES (2,'다이름',SYSDATE);

UPDATE tst_table2222
SET name = '나이름'
WHERE no = 1;

DELETE
FROM tst_table2222
WHERE no = 2;

SELECT * FROM T_MENU_12
ORDER BY id;

UPDATE T_MENU_12
SET price = 8550
WHERE id = 4;

INSERT INTO T_MENU_12
VALUES ( 5,'라면',2000,'밀가루',SYSDATE );

DELETE FROM t_menu_12
WHERE id = 5;


SELECT * FROM dept2;

SELECT * FROM professor4;

SELECT profno, name, pay
FROM professor
WHERE profno < 3000;

insert into professor4
SELECT profno, name, pay
FROM professor
WHERE profno < 3000;

SELECT * FROM professor;

update professor
set bonus = 100
where name = 'Sharon 스톤';


SELECT * FROM student;
SELECT * FROM score;
SELECT * FROM hakjum;

SELECT 
    s.studno,
    s.name,
    sc.total,
    h.grade
FROM student s, score sc, hakjum h
WHERE s.studno = sc.studno
AND sc.total BETWEEN h.min_point AND h.max_point
ORDER BY sc.total desc;


SELECT * FROM panmae;

SELECT
    p_date,
    p_code,
    SUM(p_qty),
    SUM(p_total)
FROM panmae
GROUP BY ROLLUP (p_date,p_code);


SELECT * FROM emp2;
SELECT * FROM p_grade;

SELECT 
    e.name,
    e.position,
    e.pay,
    p.s_pay,
    p.e_pay
FROM emp2 e, p_grade p
WHERE e.position IS NOT NULL
AND e.position = p.position(+);


SELECT * FROM panmae;
SELECT * FROM product;
SELECT * FROM gift;

SELECT
    p.p_date,
    pd.p_name,
    pd.p_price,
    p.p_qty,
    p.p_total,
    p.p_total*100,
    DECODE( TO_CHAR(TO_DATE(p_date),'MMDD'), 0101, p.p_total*200, p.p_total*100) ewe,
    g.gname,
    g.g_start,
    g.g_end
FROM panmae p, product pd, gift g
WHERE p.p_code = pd.p_code
AND DECODE( TO_CHAR(TO_DATE(p_date),'MMDD'), 0101, p.p_total*200, p.p_total*100) BETWEEN g.g_start AND g.g_end
ORDER BY p.p_date;


SELECT * FROM student;
SELECT * FROM department;

SELECT
    d.dname,
    MAX(s.height),
    s.name,
    s.height
FROM student s, department d
WHERE s.deptno1 = d.deptno
AND (s.deptno1, s.height) IN ( SELECT deptno1, MAX(height) FROM student GROUP BY deptno1 )
GROUP BY s.deptno1, d.dname, s.name, s.height
ORDER BY height desc;


--=============================================================================
select s.grade, s.name, s.height, t.avg_height
from 
    (select grade, AVG(height) avg_height
    from student
    group by grade) t, student s
where t.grade = s.grade
AND t.avg_height < s.height
ORDER BY s.grade;

select 
    s.grade,
    s.name, 
    s.height, 
    (select AVG(t.height)    --내 학년 평균 키
            from student t
            where t.grade = s.grade
            ) avg_height
from student s
where s.height > (select AVG(t.height)    --내 학년 평균 키
                    from student t
                    where t.grade = s.grade
                    );
--=============================================================================

CREATE SEQUENCE tt_tt_tseq
START WITH 1
INCREMENT 1
MINVALUE
MAXVALUE
CYCLE
CACHE










