-- ddl 03 --
-- FOREIGN KEY 외래키, 참조키

-- 외래키 참조하는 테이블(부모)에 있는 값만 입력 가능 (+null 가능)
-- 외래키 설정된 테이블(부모)에서 자신을 참조하는 데이터가 존재(자식)하는 경우, 삭제 불가

-- 외래키 삭제조건
--ON DELETE CASCADE;  부모테이블에서 데이터 삭제시, 그 값을 참조하는 자식테이블의 데이터도 같이 삭제
--ON DELETE SET NULL; 부모테이블에서 지워지면 자식테이블에 있는 외래키값은 null로 자동변경
-- 잘 사용하지는 않는다.. 테이블 데이터 수정하다가 다른 테이블의데이터까지 손상될수 있기때문에..

-- 실무에서는 외래키(REFERENCES) 안거는 곳도 있다.. 조인할때 반드시 필요한것은 아니기때문..
-- 슈퍼키/후보키/대체키/기본키
CREATE TABLE T_MEMBER
(
    id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(30),
    club_id REFERENCES T_CLUB(id) ON DELETE CASCADE
);

CREATE TABLE T_CLUB
(
    id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(30)
);

SELECT * FROM t_club;

INSERT INTO T_CLUB
VALUES (1, '독서');
INSERT INTO T_CLUB
VALUES (2, '등산');
INSERT INTO T_CLUB
VALUES (3, '낚시');

INSERT INTO T_MEMBER
VALUES (1, '가이름', 3);

INSERT INTO T_MEMBER
VALUES (2, '나이름', 3);

SELECT * FROM t_member m, t_club c
WHERE m.club_id = c.id;

INSERT INTO T_MEMBER
VALUES (3, '다이름', 1);

INSERT INTO T_MEMBER
VALUES (4, '라이름', null); -- null 은 참조키 상관없이 입력O / NOT NULL일경우 X

SELECT * -- 부모테이블에 참조된 키가 있어서 삭제가 안된다.
--DELETE
FROM t_club
WHERE id = 3;

SELECT *   -- 참조키 걸린 데이터 삭제 하려면 .. 부모테이블에 있는 참조된키 삭제하거나..
--delete
FROM T_MEMBER
WHERE id = 1;

UPDATE T_MEMBER  -- 자식테이블에 있는 참조키를 null로 변경후 삭제한다
SET club_id = null
WHERE id = 1;


---- DATA DICTIONARY 데이터 딕셔너리 ----
-- USER_ / DBA_ / ALL_  뒤에 아래 문 입력.
---- INDEXES / CONSTRAINTS / TABLES / SEQUENCES / SYNONYMS
---- VIEWS / ROLE_PRIVS
SELECT *
FROM USER_TABLES;

SELECT *
FROM USER_ROLE_PRIVS;

SELECT *
FROM TAB;  -- 테이블 이름 정보

SELECT *
FROM ALL_TABLES;

SELECT *
FROM TAB
WHERE tname like '%STU%';  -- stu 어쩌고.. 테이블이 있던거같은데.. 검색


------
--PRIMARY KEY 를 두개이상의 컬럼에 적용시키는 방법 (복합키) ex)이름&전화번호
CREATE TABLE tt05
(
    id number,
    no number,
    age number,
    CONSTRAINT tt05_pk PRIMARY KEY (id,no)  -- id,no 두개컬럼을 묶어서 PK
);

INSERT INTO tt05
VALUES (2,1,8);

SELECT *
FROM tt05;


-- MERGE 1테이블과 2테이블을 병합해서 새로운테이블을 만든다. // UNION ALL 은 조회만하는거 저장X
MERGE INTO 테이블명 별칭
USING 가져올테이블명 별칭
ON(테이블명 = 가져올테이블명)
WHEN MATCHED THEN -- 매치하면 가져올테이블에있는거 집어넣음
UPDATE SET
WHEN NOT MATCHED THEN -- 매치안하면 새로 생성
INSERT VALUES
;









