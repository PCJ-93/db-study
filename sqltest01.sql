-- sql평가 --
-- 1)
CREATE TABLE T_PERSON_INFO
(
    no NUMBER(8) PRIMARY KEY,
    name VARCHAR2(24) NOT NULL,
    age NUMBER(3),
    dname VARCHAR2(50)
);

INSERT INTO T_PERSON_INFO
VALUES(20210034,'이상형',21,'법학과');
INSERT INTO T_PERSON_INFO
VALUES(20220011,'김건우',24,'물리학과');
INSERT INTO T_PERSON_INFO
VALUES(20240109,'전지훈',20,'컴퓨터공학과');
INSERT INTO T_PERSON_INFO
VALUES(20230002,'강순구',21,'건축학과');

SELECT * FROM T_PERSON_INFO;

-- 2)
CREATE TABLE board_list
(
    board_list_id NUMBER(5) PRIMARY KEY,
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(2000),
    writer VARCHAR2(60) NOT NULL,
    create_time NUMBER(13) NOT NULL
);

-- 3)
SELECT
    e.empno 사원번호,
    e.ename 사원명,
    e.sal 급여,
    d.dname 부서명,
    d.loc "부서 위치"
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.sal >= 2000
ORDER BY e.sal desc;

-- 4)
1. COMMIT;
2. ROLLBACK;

-- 5)
1. ORCL
2. 127.0.0.1
3. 1521
4. scott
5. tiger

SELECT SYS_CONTEXT('USERENV', 'IP_ADDRESS') FROM DUAL;

SELECT utl_inaddr.get_host_address( SYS_CONTEXT('USERENV', 'SERVER_HOST')) IP FROM dual;






