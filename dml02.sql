-- dm102 merge

-- 신발가게 날짜별 매출 
CREATE TABLE SHOE_M
(
    w_date DATE,
    s_code NUMBER(3),  --매장고유코드
    sales NUMBER(10)
);

-- 옷가게 날짜별 매출
CREATE TABLE CLOT_M
(
    w_date DATE,
    s_code NUMBER(3),  --매장고유코드
    sales NUMBER(10)
);

-- 본사 전체 매출
CREATE TABLE COMP_M
(
    w_date DATE,
    s_code NUMBER(3), --매장고유코드
    sales NUMBER(10)
);


CREATE TABLE COMP_M
(
    w_date DATE,
    s_code NUMBER(3), --매장고유코드
    sales NUMBER(10),
    type VARCHAR2(2) -- 가게 구분 코드 'C' 옷가게, 'S' 신발가게
);


--하나의가게
--날짜별 여러가게
--날짜구분 코드
INSERT ALL
INTO SHOE_M VALUES (TO_DATE('2024-11-01'), 1, 5000)
INTO SHOE_M VALUES (TO_DATE('2024-11-02'), 1, 10000)
INTO SHOE_M VALUES (TO_DATE('2024-11-03'), 1, 20000)
SELECT * FROM dual;

UPDATE SHOE_M
SET sales = 9000
WHERE w_date = '2024-11-02';

INSERT ALL
INTO CLOT_M VALUES (TO_DATE('2024-11-04'), 50, 9000)
INTO CLOT_M VALUES (TO_DATE('2024-11-05'), 50, 13000)
INTO CLOT_M VALUES (TO_DATE('2024-11-06'), 50, 95000)
SELECT * FROM dual;

UPDATE CLOT_M
SET sales = 94000
WHERE w_date = '2024-11-06';

SELECT * FROM SHOE_M;
SELECT * FROM CLOT_M;
SELECT * FROM COMP_M;

INSERT INTO COMP_M
SELECT * FROM CLOT_M;

SELECT SUM(sales)
FROM COMP_M
WHERE TO_CHAR(w_date, 'MM') = 11;

---- MERGE 사용 ----
--하나의가게 + 날짜 중복x
MERGE INTO comp_m m
USING SHOE_M s
ON (m.w_date = s.w_date) -- ON 에 들어간 조건은 아래에 업데이트에서 사용 불가 //on에 넣은 조건으로 비교하는데 바꾸겠다고하는거라서 안됨
WHEN MATCHED THEN  -- 조건이 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN  -- 조건에 일치하는게 없으면
    INSERT VALUES (s.w_date, s.s_code, s.sales); -- using에있는 테이블 데이터 추가
    
MERGE INTO comp_m m
USING CLOT_M s
ON (m.w_date = s.w_date)
WHEN MATCHED THEN  -- 조건이 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN  -- 조건에 일치하는게 없으면
    INSERT VALUES (s.w_date, s.s_code, s.sales);
    
--날짜별 여러가게
--날짜별 데이터추가
INSERT ALL
INTO SHOE_M VALUES (TO_DATE('2024-11-01'), 2, 15000)
INTO SHOE_M VALUES (TO_DATE('2024-11-02'), 2, 20000)
INTO SHOE_M VALUES (TO_DATE('2024-11-03'), 2, 80000)
SELECT * FROM dual;

UPDATE SHOE_M
SET sales = 9000
WHERE w_date = '2024-11-02';

INSERT ALL
INTO CLOT_M VALUES (TO_DATE('2024-11-04'), 60, 19900)
INTO CLOT_M VALUES (TO_DATE('2024-11-05'), 60, 33000)
INTO CLOT_M VALUES (TO_DATE('2024-11-06'), 60, 68000)
SELECT * FROM dual;

SELECT * FROM SHOE_M;
SELECT * FROM CLOT_M;
SELECT * FROM COMP_M;

MERGE INTO comp_m m
USING SHOE_M s
ON (m.w_date = s.w_date AND m.s_code = s.s_code)  --날짜와코드가 동시에 일치하면 
WHEN MATCHED THEN  -- 조건이 일치하면
    UPDATE SET m.sales = s.sales                  --sales 를 comp_m에 업데이트
WHEN NOT MATCHED THEN  -- 조건에 일치하는게 없으면
    INSERT VALUES (s.w_date, s.s_code, s.sales);  --날짜,코드,sales를 생성 USING SHOE_M에서 가져와서..
    
MERGE INTO comp_m m
USING CLOT_M s
ON (m.w_date = s.w_date AND m.s_code = s.s_code) --날짜와코드가 동시에 일치하면
WHEN MATCHED THEN  -- 조건이 일치하면
    UPDATE SET m.sales = s.sales                 --sales 를 comp_m에 업데이트
WHEN NOT MATCHED THEN  -- 조건에 일치하는게 없으면
    INSERT VALUES (s.w_date, s.s_code, s.sales); --날짜,코드,sales를 생성 USING CLOT_M에서 가져와서..


-- 가게구분 코드
SELECT *
FROM comp_m
ORDER BY w_date;

MERGE INTO comp_m m
USING SHOE_M s
ON (m.w_date = s.w_date AND m.s_code = s.s_code)  --날짜와코드가 동시에 일치하면 
WHEN MATCHED THEN  -- 조건이 일치하면
    UPDATE SET m.sales = s.sales                  --sales 를 comp_m에 업데이트
WHEN NOT MATCHED THEN  -- 조건에 일치하는게 없으면
    INSERT VALUES (s.w_date, s.s_code, s.sales, 'S');  --날짜,코드,sales를 생성 USING SHOE_M에서 가져와서..
    
MERGE INTO comp_m m
USING CLOT_M s
ON (m.w_date = s.w_date AND m.s_code = s.s_code) --날짜와코드가 동시에 일치하면
WHEN MATCHED THEN  -- 조건이 일치하면
    UPDATE SET m.sales = s.sales                 --sales 를 comp_m에 업데이트
WHEN NOT MATCHED THEN  -- 조건에 일치하는게 없으면
    INSERT VALUES (s.w_date, s.s_code, s.sales, 'C');

SELECT type, s_code, sum(sales)
FROM comp_m
GROUP BY type, s_code;


-- 간단한 연습 --
INSERT INTO dept2
VALUES (9010, 'temp_10', 1006, 'temp area');

INSERT INTO dept2 (dcode, dname, pdept)
VALUES (9020, 'temp_20', 1006);
--INSERT INTO dept2
--VALUES (9020, 'temp_20', 1006, null);

SELECT * FROM dept2;
--=============
-- ITAS
CREATE TABLE professor4
AS
SELECT profno, name, pay
FROM professor
WHERE 1=2;

INSERT INTO professor4
SELECT profno, name, pay FROM professor
WHERE profno <= 3000;

SELECT *
FROM professor4;

-- CTAS
CREATE TABLE professor4
AS
SELECT profno, name, pay
FROM professor
WHERE profno <= 3000;

--===========
SELECT *
FROM professor
WHERE name = 'Sharon Stone';

UPDATE professor
SET bonus = 100
WHERE name = 'Sharon Stone';
-- 연습 끝 --


-- 모닝 퀴즈 --
CREATE TABLE TABLE_DATA_1
(
no number(10),
create_date DATE
);

CREATE TABLE TABLE_DATA_2
(
no number(10),
create_date DATE
);

CREATE TABLE TABLE_COLC
(
std_date DATE,
CHECK_DATA1 VARCHAR2(6),
CHECK_DATA2 VARCHAR2(6)
);

INSERT INTO TABLE_DATA_1 VALUES (1, '2023-04-01');
INSERT INTO TABLE_DATA_1 VALUES (2, '2023-04-02');
INSERT INTO TABLE_DATA_1 VALUES (3, '2023-04-03');
INSERT INTO TABLE_DATA_1 VALUES (4, '2023-04-04');

INSERT INTO TABLE_DATA_2 VALUES (1, '2023-04-02');
INSERT INTO TABLE_DATA_2 VALUES (2, '2023-04-03');
INSERT INTO TABLE_DATA_2 VALUES (3, '2023-04-04');
INSERT INTO TABLE_DATA_2 VALUES (4, '2023-04-05');

SELECT *
FROM TABLE_COLC
ORDER BY std_date;

-- A 업체 기준 머지
MERGE INTO TABLE_COLC C
USING TABLE_DATA_1 D
ON (C.std_date = D.create_date)  -- ON 에 들어간 조건은 아래에 업데이트에서 사용 불가 //on에 넣은 조건으로 비교하는데 바꾸겠다고하는거라서 안됨
WHEN MATCHED THEN -- 일치하면 업데이트
    UPDATE SET  C.check_data1 = 'Y'
WHEN NOT MATCHED THEN -- 일치하는게 없으면 추가
    INSERT VALUES (D.create_date, 'Y', 'N');

-- B 업체 기준
MERGE INTO TABLE_COLC C
USING TABLE_DATA_2 D
ON (C.std_date = D.create_date)
WHEN MATCHED THEN -- 일치하면 업데이트
    UPDATE SET  C.check_data2 = 'Y'
WHEN NOT MATCHED THEN -- 일치하는게 없으면 추가
    INSERT VALUES (D.create_date, 'N', 'Y');
-- 모닝 퀴즈 끝 --

-- DB쿼리 연습 from.programmers --
CREATE TABLE product_quiz
(
product_id INTEGER NOT NULL,
product_code VARCHAR(8) NOT NULL,
price INTEGER NOT NULL
);

INSERT INTO product_quiz VALUES (1, 'A1000011', 10000);
INSERT INTO product_quiz VALUES (2, 'A1000045', 9000);
INSERT INTO product_quiz VALUES (3, 'C3000002', 22000);
INSERT INTO product_quiz VALUES (4, 'C3000006', 15000);
INSERT INTO product_quiz VALUES (5, 'C3000010', 30000);
INSERT INTO product_quiz VALUES (6, 'K1000023', 17000);

SELECT * FROM product_quiz;

SELECT *
FROM product_quiz
WHERE price BETWEEN 0 AND 9999;

SELECT *
FROM product_quiz
WHERE price BETWEEN 10000 AND 19999;

SELECT *
FROM product_quiz
WHERE price BETWEEN 20000 AND 29999;

SELECT *
FROM product_quiz
WHERE price BETWEEN 30000 AND 39999;

ALTER TABLE product_quiz ADD price_group NUMBER(10);

UPDATE product_quiz
SET price_group = 0
WHERE price < 9999;

CREATE TABLE product_quiz2
AS
SELECT price_group
FROM product_quiz;

SELECT * FROM product_quiz;
SELECT * FROM product_quiz2;

ALTER TABLE product_quiz2 ADD products NUMBER(3);

SELECT 
    p2.price_group,
    COUNT(p1.price_group)
FROM product_quiz p1, product_quiz2 p2
WHERE p2.price_group = p1.price_group
GROUP BY p2.price_group;

-- DB쿼리 연습 끝 --
-- DB쿼리 풀이 --

-- 1. 단순 계산먼저 /쉽지만 쿼리 길다(노가다)
    SELECT 0 price_group, COUNT(*) products
    FROM product_quiz
    WHERE price BETWEEN 0 AND 9999
UNION ALL
    SELECT 10000, COUNT(*)
    FROM product_quiz
    WHERE price BETWEEN 10000 AND 19999
UNION ALL
    SELECT 20000, COUNT(*)
    FROM product_quiz
    WHERE price BETWEEN 20000 AND 29999
UNION ALL
    SELECT 30000, COUNT(*)
    FROM product_quiz
    WHERE price BETWEEN 30000 AND 39999;

-- 2. GROUP BY 로 잘 묶은 풀이
만의 자리수를 뽑아내면?
SELECT * FROM product_quiz;
10000 1
9000  0
22000 2
15000 1
30000 3
17000 1; --얘들끼리 묶으면 1이 몇개 2가몇개 .. 찾을수있다
SELECT TRUNC(price/10000), price/10000 -- trunc : 소수점 날리기
FROM product_quiz; --얘들끼리 묶으면 1이 몇개 2가몇개 .. 찾을수있다2
-- 찾고나서 그룹바이로 풀이
SELECT TRUNC(price/10000)*10000 price_group,COUNT(*) products
FROM product_quiz
GROUP BY TRUNC(price/10000)
ORDER BY price_group;

-- 2-2 CASE문 활용 그룹바이 조회
SELECT CASE
            WHEN price BETWEEN 0 AND 9999 THEN 0
            WHEN price BETWEEN 10000 AND 19999 THEN 10000
            WHEN price BETWEEN 20000 AND 29999 THEN 20000
            WHEN price BETWEEN 30000 AND 39999 THEN 30000
        END price_group, -- 그룹바이에 들어가서 그룹바이형식으로 사용가능
        COUNT(*) products
FROM product_quiz
GROUP BY CASE
            WHEN price BETWEEN 0 AND 9999 THEN 0
            WHEN price BETWEEN 10000 AND 19999 THEN 10000
            WHEN price BETWEEN 20000 AND 29999 THEN 20000
            WHEN price BETWEEN 30000 AND 39999 THEN 30000
        END
ORDER BY price_group;

-- 3. group by 인데 subquery 를 곁들인
SELECT * FROM product_quiz;

SELECT price price_group, COUNT(*) products
FROM ( SELECT product_id,
            product_code,
            TRUNC(price/10000) * 10000 price
        FROM product_quiz )
GROUP BY price
ORDER BY price;

SELECT price price_group, COUNT(*) products
FROM ( SELECT 
            TRUNC(price/10000) * 10000 price
        FROM product_quiz )
GROUP BY price
ORDER BY price;









