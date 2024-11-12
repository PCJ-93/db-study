-- DML

--데이터 저장 INSERT
--데이터 수정 UPDATE
--데이터 삭제 DELETE
--데이터 병합 MERGE

INSERT INTO 테이블명 (컬럼명..)
VALUES (데이터 값..);

INSERT INTO new_table (no, name, birth)
VALUES (1, '이름1', SYSDATE);

INSERT INTO new_table (name, birth, no)
VALUES ('이름2', SYSDATE, 2);

INSERT INTO new_table (no, name, birth)
VALUES (3, '이름3', '2002-02-15');

INSERT INTO new_table (no, name, birth)
VALUES ( 4, '이름4', TO_DATE('2001-10-25') );
            -- 날짜 입력시에는 TO_DATE 사용해서 명시적으로 입력해주는게 좋다

--컬럼명을 생략하는 경우
--전체 컬럼에 저장하는경우 + 전체 컬럼순서에 맞게 VALUES에 입력
INSERT INTO new_table --(컬럼명 생략)
VALUES (5, '이름5', SYSDATE);

INSERT INTO new_table (no, name) --생일 생략하고 두개만 입력
VALUES (6, '이름6'); --생일값은 null로 자동생성

INSERT INTO new_table -- 전체컬럼생략하고 번호,이름 만 입력하고싶을때
VALUES (7, '이름7', null); -- 생략한 부분에 null 입력

-----
INSERT INTO tt02 (no)
VALUES (1);

INSERT INTO tt02 (no, name, hiredate)
VALUES (2, null, null);


-- 데이터 변경하기
-- UPDATE 테이블명 SET 컬럼 = 값 WHERE 조건
UPDATE 테이블명
SET 컬럼명 = 값
WHERE 조건;

--임시부서 여부 체크 컬럼명 temp_code
--'Y'임시부서, 'N'정식부서
UPDATE dept4
SET temp_code = 'Y'
WHERE dcode = 2000;  --부서가 2000인 곳만 Y로 UPDATE

SELECT *
FROM dept4
WHERE temp_code = 'Y';

--===연습문제===--
CREATE TABLE professor2
AS
SELECT * FROM professor;

SELECT *
FROM professor2
WHERE position = 'assistant professor';

UPDATE professor2
--SET bonus = 200 --200으로저장
SET bonus = bonus + 200 --200을 인상
WHERE position = 'assistant professor';

commit; 
rollback; 

SELECT *
FROM dept4;

INSERT INTO dept4
VALUES (2001, 'Asan Office', 'Asan', 'Y');

UPDATE dept4
SET location = 'Asan'
WHERE dcode = 2000;

-- 데이터 삭제 DELETE --(rollback 가능 / 자동commit X)
SELECT * FROM dept4;

DELETE FROM dept4;


SELECT * -- delete 사용할때 select로 확실히 조건에 맞는지 확인후 delete 실행
--DELETE
FROM dept4
WHERE temp_code = 'Y';

SELECT *
FROM tt02;

INSERT ALL  -----   한번에 여러행 인서트.. 마지막에 셀렉트프롬듀얼 붙여줘야 작동됨..
INTO tt02 VALUES (7, '이름7', null)
INTO tt02 VALUES (8, '이름8', null)
INTO tt02 VALUES (9, '이름9', null)
INTO tt02 VALUES (10, '이름10', null)
SELECT * FROM dual;

INSERT INTO tt02  -- number3 varchar2 date
SELECT 11, '샘플', SYSDATE FROM dual;

INSERT INTO tt02
SELECT deptno, loc, SYSDATE FROM dept;













