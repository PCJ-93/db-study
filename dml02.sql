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
ON (m.w_date = s.w_date)
WHEN MATCHED THEN  -- 조건이 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN  -- 조건에 일치하는게 없으면
    INSERT VALUES (s.w_date, s.s_code, s.sales);
    
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


--날짜구분 코드




