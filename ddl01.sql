-- DDL DML DCL
DCL 계정생성, 권한부여  Data Control Language 데이터 제어
DDL 테이블 생성 수정 삭제 Data Definition Language 데이터 정의
DML 데이터 삽입 수정 삭제 조회(SELECT는 별개로 볼수도 있다..) Data Manipulation Language 데이터조작
                   SELECT 는 어떤분류에서는 DQL Data Query Language 라고도 한다
                   
1군) VARCHAR2, NUMBER, DATE,/ 2군) CHAR, CLOB, BLOB --자주쓰는 데이터 타입
VARCHAR2 : 글자수만큼 용량차지 -- 이걸 더 많이 사용권장
CHAR : 정해진 용량만큼 차지 (  ex)5 지정.. 3자입력해도 5차지.. 용량낭비.. 6자이상입력시 오류,,)
;

-- DDL --
-- 테이블명으로 한글은 사용하지 않는게 좋다
-- 테이블 생성 --
CREATE TABLE new_table
(
    no NUMBER(3),
    name VARCHAR2(10),
    birth DATE
);

SELECT *
FROM new_table;

desc new_table;
                   
CREATE TABLE tt02
(
    no NUMBER(3,1) DEFAULT 0,
    name VARCHAR2(10) DEFAULT 'NO Name',
    hiredate DATE DEFAULT SYSDATE
);

SELECT *
FROM tt02;
                   
                   
-- 테이블 복사하기 --
--1) 테이블 전체복사하기
CREATE TABLE dept3
AS
SELECT * FROM dept2;

SELECT * FROM dept3;
----
--2)원하는 컬럼만 복사하기
CREATE TABLE dept4
AS
SELECT dcode, area FROM dept2;

SELECT * FROM dept4;

--3)컬럼만 가져오고 데이터는 안가져오기
SELECT *
FROM dept2
WHERE 1=2;  -- 컬럼구조만 복사하고 데이터는 안가져오고싶을때 일부러 거짓조건을 준다.
                   
CREATE TABLE dept5
AS
SELECT * FROM dept2
WHERE 1=2;

SELECT * FROM dept5;


-- 테이블 변경
-- 컬럼 추가하기 ALTER
ALTER TABLE dept4
ADD (location VARCHAR2(10));

ALTER TABLE dept4
ADD (location VARCHAR2(10)  DEFAULT 'Cheonan');

INSERT INTO dept4
VALUES (2000,'Cheonan Office');

--임시부서 여부 체크 컬럼명 temp_code 'Y'임시부서, 'N'정식부서
ALTER TABLE dept4
ADD (temp_code VARCHAR(2) DEFAULT 'N');

SELECT * FROM dept4;


-- 컬럼 삭제
-- DROP COLUMN 컬럼명
ALTER TABLE dept4
DROP COLUMN location;

CREATE TABLE dept6
AS
SELECT * FROM dept4;

SELECT * FROM dept5;
SELECT * FROM dept6;


-- 테이블 삭제 (rollback 불가/실행하는순간 자동 commit)
-- DROP  -- 테이블 자체를 삭제  -- 매우 주의해서 사용!! 테이블명 확인!!
DROP TABLE dept5;

-- TRUNCATE 테이블 내에 데이터를 삭제  -- 매우 주의해서 사용!!
TRUNCATE TABLE dept6;








                   
                   
                   
