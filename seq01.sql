-- seq01
-- 시퀀스
CREATE TABLE seq_test
(
    no NUMBER(3) PRIMARY KEY,
    name VARCHAR2(32)
);

SELECT * FROM seq_test;

-- 수동으로 일일이 저장
INSERT INTO seq_test VALUES (1, '가이름');
-- 다음가입자 이름 '나이름' 저장
INSERT INTO seq_test VALUES (2, '나이름');

-- 서브쿼리로 갯수 활용
SELECT COUNT(*) FROM seq_test; --현재 저장된 갯수
SELECT COUNT(*)+1 FROM seq_test; --다음 저장할 차례 값
-- PRIMARY KEY 가 적용된 no에 위의 쿼리를 서브쿼리로 사용
INSERT INTO seq_test VALUES ( (SELECT COUNT(*)+1 FROM seq_test), '다이름' );
INSERT INTO seq_test VALUES ( (SELECT COUNT(*)+1 FROM seq_test), '라이름' );
INSERT INTO seq_test VALUES ( (SELECT COUNT(*)+1 FROM seq_test), '마이름' );

-- 테이블 관리 ( 데이터 삭제 or 데이터 삭제를 기록 )
-- seq_test가 데이터 삭제로 관리하는 테이블 이라면
SELECT * FROM seq_test;
-- '다' 탈퇴 -> 삭제

--DELETE FROM seq_test
WHERE no = 3;

INSERT INTO seq_test VALUES ( (SELECT COUNT(*)+1 FROM seq_test), '바이름'); --오류

-- 서브쿼리로 갯수세지말고 -> no PK 값을 따져보고 활용
SELECT no FROM seq_test; -- PK값으로 따지겠다
SELECT MAX(no) FROM seq_test; -- 제일 큰 PK 값
SELECT MAX(no)+1 FROM seq_test; -- 제일 큰 PK 값 다음 값

INSERT INTO seq_test VALUES ( (SELECT MAX(no)+1 FROM seq_test), '바이름'); --정상
INSERT INTO seq_test VALUES ( (SELECT MAX(no)+1 FROM seq_test), '사이름');

--DELETE FROM seq_test
WHERE no = 7;

INSERT INTO seq_test VALUES ( (SELECT MAX(no)+1 FROM seq_test), '아이름');

--DELETE FROM seq_test;

INSERT INTO seq_test VALUES ( (SELECT MAX(no)+1 FROM seq_test), '자이름');

SELECT NVL( MAX(no),0 )+1 FROM seq_test;

INSERT INTO seq_test VALUES ( (SELECT NVL( MAX(no),0 )+1 FROM seq_test), '하1이름');

SELECT * FROM seq_test;

SELECT *
--DELETE 
FROM seq_test
WHERE no = 1;

-------========================================================
순차적으로 중복되지 않는 값을 사용 -> 시퀀스 ( 한번만들면 건들일 거의 없음 )
CREATE SEQUENCE 만들시퀀스명
INCREMENT BY 1 -- 증가될 수 ex) 2 : 1 3 5 7 ..
START WITH 1;  -- 시작할 수
--min/max 체크X  -- max:최대 값(사이클돌때 최대값도달시 처음값부터시작.    min:사이클 돌때 시작될 값
--nocycle   -- 반복
--cache 20

CREATE SEQUENCE seq_test_pk_seq
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 10
CYCLE
CACHE 5;
--NOCYCLE;
--CACHE

--DROP 
SEQUENCE seq_test_pk_seq;

SELECT시퀀스이름.nextval 다음값 호출(사용)
시퀀스이름.currval 현재값 확인

SELECT seq_test_pk_seq.nextval FROM dual;
SELECT seq_test_pk_seq.currval FROM dual;

CREATE SEQUENCE seq_test_pk_seq
INCREMENT BY 1
START WITH 1;
--min/max 체크X
--nocycle
--cache 20

INSERT INTO seq_test VALUES ( seq_test_pk_seq.nextval , 'A이름' );

SELECT * 
--DELETE 
FROM seq_test;

INSERT INTO seq_test VALUES ( seq_test_pk_seq.nextval , 'g이름' );

--만든시퀀스 조회하기-
SELECT *
FROM user_sequences;
-------------------

----- 시퀀스초기화 ---(1부터시작하고싶음)--- 지웠다 다시만드는게 편하다
-- 현재 시퀀스 값 확인
SELECT seq_test_pk_seq.currval FROM dual;  --현재 4 일경우
-- 1이될수있도록 증가값을 변경
ALTER SEQUENCE seq_test_pk_seq INCREMENT BY -4;  -- / 실행시 -4 되게
ALTER SEQUENCE seq_test_pk_seq MINVALUE 0;  -- min 0 으로 설정해줘야 0값될수있음
-- 시퀀스 1회 실행
SELECT seq_test_pk_seq.nextval FROM dual;
-- 다시 증가값 설정 변경
ALTER SEQUENCE seq_test_pk_seq INCREMENT BY 1;
-- 설정 완료 후 시퀀스 확인
SELECT seq_test_pk_seq.nextval FROM dual;
--============ 이거 쓰지말고 그냥 지우고 다시 세팅하는게 편하다 =================

-- 간단한 연습 --
--1. 아래 조건에 테이블 생성
--* item_name 은 null 불가
--* create_date 는 기본값 현재
--* PK 는 no
--T_ITEM_LIST 테이블
--no NUMBER(6)
--item_name VARCHAR2(24)
--price NUMBER(6)
--create_date DATE
CREATE TABLE T_ITEM_LIST
(
    no NUMBER(6) PRIMARY KEY,
    item_name VARCHAR(24) NOT NULL,
    price NUMBER(6),
    create_date DATE DEFAULT SYSDATE
);

--2. 다음 조건에 맞는 시퀀스를 생성하시오.
--시퀀스명 : T_ITEM_LIST_PK_SEQ
--*상세조건
--1부터 시작하며 1씩 증가한다.
--값의 범위는 1~999999
--순환하지 않도록 한다.
CREATE SEQUENCE T_ITEM_LIST_PK_SEQ
INCREMENT BY 1 
START WITH 1
MINVALUE 1
MAXVALUE 999999
NOCYCLE;

--3. 생성한 시퀀스의 값을 불러서 사용하는 방법을 작성하시오.
SELECT T_ITEM_LIST_PK_SEQ.nextval FROM dual;
SELECT T_ITEM_LIST_PK_SEQ.currval FROM dual;

--4. 해당 시퀀스를 활용하여, 테이블에 INSERT 처리 하는 쿼리문을 작성하시오.
INSERT INTO T_ITEM_LIST
VALUES ( T_ITEM_LIST_PK_SEQ.nextval,'아이템2',4000,SYSDATE );

SELECT * FROM T_ITEM_LIST;
-- 연습 끝 --















