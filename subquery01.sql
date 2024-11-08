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
















