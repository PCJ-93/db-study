-- 제약조건
--NOT NULL  null 금지
--UNIQUE    중복 금지
--CHECK     설정한값만 허용 나머지 금지
--PRIMARY KEY - 기본키, pk 라고 많이 부름 notnull+unique 의 특징 테이블당1개만 설정가능
--FOREIGN KEY - 외래키 라고 많이 부름 / 다른테이블을 참조 ex)student 테이블 , professor 테이블 //professor 테이블의 prfno라는 PK를 student 테이블의 profno FK로 참조
--FOREIGN KEY 사용 = REFERENCE 참조된 테이블 의 데이터를 지울수 없음 (다른테이블에서 참조중이라서..) 참조하는 테이블의 데이터값만 입력 가능 ex)10 20 30 ==> 11 50 40 XX
CREATE TABLE tt01
(
    no NUMBER(3) UNIQUE, --겹치는거 허용x
    name VARCHAR2(10) NOT NULL, --null 허용x
    hiredate DATE
);

INSERT INTO tt01
VALUES (1, '이름1', SYSDATE);

INSERT INTO tt01
VALUES (2, '이름2', SYSDATE);

INSERT INTO tt01
VALUES (3, '이름3', SYSDATE);

SELECT * 
FROM tt01;

CREATE TABLE tt03
(
    no NUMBER(3)
        CONSTRAINT tt03_no_uk UNIQUE,
    name VARCHAR2(10)
        CONSTRAINT tt03_name_nn NOT NULL,
    --score NUMBER(3) CHECK (score BETWEEN 0 AND 100)
    score NUMBER(3)
        CONSTRAINT tt03_score_ck CHECK (score BETWEEN 0 AND 100),
    pass VARCHAR(2)
        CONSTRAINT tt03_pass_ch CHECK (pass IN('Y', 'N'))
);

-- oracle DB 는 숫자/문자/날짜 타입은있는데 boolean 타입이 없다..
--1:true 0:false
--Y:true N:false
--T:true F:false
--true:true false:false
--그래서 이런식으로 쓰자~~ (2분화)
--CHECK 타입으로 2글자 지정해서 true & false 로 사용.
--ex) CHECK no>=0 AND no<=1 0과1 두개만 사용하게 해서 true/false 구분

SELECT *
FROM tt03;

INSERT INTO tt03  -- 입력 잘 된 케이스
VALUES (1, '이름1', 50, 'Y');

-- 잘못된 케이스 -- 제약조건위배
INSERT INTO tt03
VALUES (1, '이름1', 50, 'Y'); -- no중복 unique

INSERT INTO tt03  
VALUES (1, null, 50, 'Y');  -- 이름 not null /null금지

INSERT INTO tt03  
VALUES (1, '이름1', 500, 'Y'); -- score 범위 0~100 내만

INSERT INTO tt03  
VALUES (1, '이름1', 50, 'T'); -- pass 'Y' 'N'만 가능


-- 모닝퀴즈 --
CREATE TABLE

INSERT INTO
VALUES

UPDATE
SET
WHERE

DELETE
FROM
WHERE

SELECT
FROM
WHERE

CREATE TABLE T_MENU_12
(
    id NUMBER(5) PRIMARY KEY,  -- primary key = 기본키!!
    name VARCHAR2(128) NOT NULL,
    price NUMBER(10),
    menu_list VARCHAR2(64),
    dv_date DATE
);

INSERT INTO T_MENU_12
VALUES (1, '싸이버거', 6000, '완전식품', SYSDATE);
INSERT INTO T_MENU_12
VALUES (2, '콩나물비빔밥', 7000, '탄수화물', SYSDATE);
INSERT INTO T_MENU_12
VALUES (3, '닭가슴살', 3000, '단백질', SYSDATE);
INSERT INTO T_MENU_12
VALUES (4, '베트남쌀국수', 8000, '탄수화물', SYSDATE);
INSERT INTO T_MENU_12
VALUES (5, '라면', 2000, '밀가루', SYSDATE);

SELECT *
FROM T_MENU_12;

UPDATE T_MENU_12
SET price = 8500
WHERE id = 4;

SELECT *
--DELETE
FROM T_MENU_12
WHERE id = 5;

commit;
-- 모닝퀴즈 끝 --

