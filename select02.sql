/*
단일행 함수
임시로 사용하는 테이블(테스트용) dual
*/
--INITCAP 첫글자 대문자로 변환
SELECT 
    ename,
    INITCAP('ABCDE') "테스트",
    INITCAP(ename) "첫글자대문자"
FROM emp;

-- LOWER 전부 소문자로 변환 , UPPER 전부 대문자로 변환
SELECT 
    name,
    INITCAP(name),
    LOWER(name),
    UPPER(name)
FROM student;

--LENGTH 글자 길이
SELECT
    LENGTH('abcdefaef') --확인 하는데 불필요하게 dept테이블구성에 맞게 4행씩이나 나옴
FROM dept;

SELECT
    LENGTH('abcdefaef') "단어길이",
    LENGTHB('abcdefaef') "단어길이의 바이트값",
    LENGTH('점심'),
    LENGTHB('점심')
FROM dual;  -- dual 테이블 안만들고 기능 확인용 테이블 1행만 출력

SELECT *
FROM emp   --emp테이블에서 이름이 5글자 이상인 사람들 찾기
WHERE LENGTH(ename) >= 5;

-- CONCAT ||과 동일한기능 이지만 매개변수2개까지 받음
SELECT '아침' || '점심', CONCAT('아침', '점심')
FROM dual;

SELECT '아침' || '점심' || '저녁', CONCAT('아침', '점심')   --CONCAT함수는 매개변수가 2개라서 3개이상은 못넣음
FROM dual;

SELECT '아침' || '점심' || '저녁', CONCAT( CONCAT('아침', '점심'), '저녁')   --CONCAT함수는 매개변수가 2개라서 3개이상은 못넣음 더 추가하려면 묶어서 써줘야함
FROM dual;

--SUBSTR (대상, 시작지점, 자리수) 첫글자가 1번
SELECT 
    SUBSTR('abcdefg', 2, 3), --b로 시작해서 d까지
    SUBSTR('abcdefgehtgfyihsergfhreid', 3, 5),
    SUBSTR('abcdefgehtgfyihsergfhreid', -6, 5)  -- -붙이면 뒤에서부터 몇번째
FROM dual;

SELECT 
    name,
    SUBSTR(jumin, 3, 4) Birthday,  -- 주번 3번째 글자부터시작해서 4번째까지 읽음
    SUBSTR(jumin, 3, 4) -1 "Birthday - 1"
FROM student
WHERE deptno1 = 101;

--INSTR (대상, 찾을거, 시작(1=글자맨처음부터), 몇번째찾을꺼나올때까지)
SELECT
    INSTR('2024/11/04 10/45/45', '/', 1),
    INSTR('2024/11/04 10/45/45', '/', 6),
    INSTR('2024/11/04 10/45/45', '/', 1, 4),
    INSTR('2024/11/04 10/45/45', '/', 6, 2),
    INSTR('2024/11/04 10/45/45', '/', 1, 5),
    INSTR('2024/11/04 10/45/45', '/', 16, 2)
FROM dual;

SELECT  -- student 테이블에서 전공넘버가 201애들중 tel의 ) 표시가 몇번째에 적혀있는지 찾기
    name,
    tel,
    INSTR(tel, ')')
FROM student
WHERE deptno1 = 201;

-- 간단한 연습 --
SELECT *
FROM student;

SELECT
    name "이름",
    SUBSTR(jumin, 1, 2) "년도",
    SUBSTR(jumin, 3, 2) "월",
    SUBSTR(jumin, 5, 2) "일"
FROM student;

SELECT
    name,
    tel,
    INSTR( tel, ')' ) "괄호위치"
FROM student
WHERE deptno1 = 201;

SELECT
    name,
    tel,
    INSTR( tel, '3', 1, 1) "'3' 이 처음 나오는 위치"
FROM student
WHERE deptno1 = 101;

SELECT
    name,
    tel,
    SUBSTR(tel, 1, INSTR( tel, ')')-1 ) "지역번호"
FROM student
WHERE deptno1 = 201;
-- 연습 끝 --

-- LPAD 왼쪽에 문자채움  RPAD 오른쪽에 문자채움
SELECT
    LPAD('문자', 10, '*'),
    LPAD(123, 5, 0),
    LPAD(33, 3, 0)
FROM dual;

SELECT
    LPAD(id, 10, '*'),
    RPAD(id, 10, '*')
FROM student;

SELECT
    ename,
    LPAD(ename, 9, 123456789)
FROM emp;

-- LTRIM 왼쪽에서 제거할 문자 RTRIM 오른쪽에서 제거할 문자
-- 불필요한 요소 제거함 ( 공백 제거용으로 많이 쓰임 ) ex)" 점심은 30분 후 "
SELECT
    LTRIM('abcd', 'a'),
    RTRIM('abcd', 'd'),
    RTRIM('abcdef', 'ef'),
    LTRIM(' ab cd '), -- 따로 지정을 안해줘도 왼쪽끝띄어쓰기를 제거해줌.
    RTRIM(' ab cd '), -- 따로 지정을 안해줘도 오른쪽끝띄어쓰기를 제거해줌.
    TRIM(' ab cd ') -- 따로 지정을 안해줘도 양쪽띄어쓰기를 제거해줌.
FROM dual;

-- REPLACE 지정한것을 다른 문자로 바꾸겠다
SELECT
    REPLACE('abcde', 'c', '*'),
    REPLACE('2024-11-04', '-', '/')
FROM dual;

SELECT
    ename,
    REPLACE(ename, SUBSTR(ename,1 ,2), '**') "REPLACE"
FROM emp;

-- 간단한 연습 --
SELECT *
FROM emp;

SELECT
    ename,
    REPLACE(ename, SUBSTR(ename,3,2), '--') "REPLACE"
FROM emp
WHERE deptno = 20;

SELECT 
    name,
    REPLACE( jumin, SUBSTR(jumin, 7), '-/-/-/-' ) "주민뒷자리숨김",
    SUBSTR(jumin,1,6) || '-/-/-/-' "주민뒷자리숨김2",
    CONCAT(SUBSTR(jumin, 1, 6), '-/-/-/-') "주민뒷자리숨김3"
FROM student
WHERE deptno1 = 101;

SELECT 
    name,
    tel,
    REPLACE(tel, SUBSTR(tel,5,3), '***') "REPLACE",
    SUBSTR(tel, 1, 4) || '***' || SUBSTR(tel, 8, 5) "숨김2",
    SUBSTR(tel, 1, 4) || '***' || SUBSTR(tel, -5, 5) "숨김3"
FROM student
WHERE deptno1 = 102;

SELECT
    name,
    tel,
    REPLACE(tel, SUBSTR(tel,-4,4), '****') "REPLACE",
    REPLACE(tel, SUBSTR(tel,9,4), '****') "REPLACE2",
    SUBSTR(tel, 1, 8) || '****' "숨김3"
FROM student
WHERE deptno1 = 101;

-- 심화문제 --
-- )다음위치 ~  -전위치  => 가운데 자리수
SELECT
    tel,
    INSTR(tel, ')') 괄호위치,
    INSTR(tel, '-') 빼기위치,
    INSTR(tel, '-')-INSTR(tel, ')') - 1  "가운데자리수갯수",
    SUBSTR(tel, INSTR(tel, ')')+1 , (INSTR(tel, '-')-INSTR(tel, ')') - 1) ) "가운데자리",
    SUBSTR(tel, 1, (INSTR(tel, ')')) ) || '*' || SUBSTR(tel, -5, 5),
    SUBSTR(tel, 1, INSTR(tel, ')')) || LPAD('*', (INSTR(tel, '-')- INSTR(tel, ')')-1), '*') || SUBSTR(tel,-5,5)
FROM student;                           --             이구간이 위의 '*' 구간             --
-- 연습 끝 --
SELECT
    LPAD('*', 4, '*')
FROM dual;
-----------------------
-- 숫자형함수
SELECT
    ROUND(1.66, 1),
    TRUNC(1.4567, 2),
    TRUNC(1.4566, 0),
    TRUNC(123.4567, -1),
    MOD(15,4),
    CEIL(123.133),
    FLOOR(123.1333),
    POWER(3,5)
FROM dual;

SELECT
    rownum,
    CEIL(rownum/3),
    CEIL(rownum/4),
    empno,
    ename
FROM emp;

-- 날짜관련함수들
SELECT
    null,
    SYSDATE, --  현재날짜
    SYSTIMESTAMP,  --현재날짜시간
    MONTHS_BETWEEN('2024-01-05', '2024-03-05') "ㅇ",
    MONTHS_BETWEEN('2024-03-05', '2024-01-05') "ㅇ",
    ADD_MONTHS(SYSDATE, 3) "ㅇ",
    LAST_DAY(SYSDATE)"ㅇ",--달의마지막날짜를확인    2월은 28까지 3월은 31까지 .. 확인할때 쓰임
    NEXT_DAY(SYSDATE, '수') "ㅇ", -- 오늘기준 다음에오는 수요일이 언제냐
    NEXT_DAY(SYSDATE, '토') "ㅇ",  -- 오늘기준 다음에오는 토요일이 언제냐
    LAST_DAY('2024-02-02')"ㅇ"
FROM dual;

SELECT
    ROUND(SYSDATE),  --24/11/04 15:50 12:00넘어서 반올림되서 내일날짜출력
    TRUNC(SYSDATE),   --24/11/04 15:50 시간안따지고 버려서 오늘날짜출력
    TRUNC(123.113, 1),
    TRUNC(SYSDATE, 'MM'),  --월 뒤로 버림 24/11/01
    TRUNC(SYSDATE, 'YY'),   --년 뒤로 버림 24/01/01
    ADD_MONTHS(SYSDATE, 1),
    SYSDATE + 3, --오늘날 로부터 3일뒤
    SYSDATE - 3, -- 3일전
    SYSDATE + 7, -- 1주일뒤
    --다음달의 첫날
    TRUNC(ADD_MONTHS(SYSDATE,1), 'MM'),
    LAST_DAY(SYSDATE)+1,  -- 이게좋다
    --전 월의 마지막 날
    TRUNC(SYSDATE, 'MM') - 1, -- 이게좋다
    LAST_DAY( ADD_MONTHS(SYSDATE,-1) )
FROM dual;

-- 형 변환 함수
-- 명시적 형 변환
-- 데이터타입 varchar2(n) number(p,s) date
SELECT 2 + '2'   --자동형변환
FROM dual;

SELECT 2 || '123a'
FROM dual;

SELECT
    TO_CHAR(123),
    TO_CHAR(34645.213),
    TO_CHAR(35.34),
    SYSDATE,
    TO_CHAR(SYSDATE),   --날짜 -> 문자
    TO_CHAR(SYSDATE, 'YYYY'),
    TO_CHAR(SYSDATE, 'MM'),
    TO_CHAR(SYSDATE, 'DD'),
    TO_CHAR(SYSDATE, 'YYYYMMDD'),
    TO_CHAR(SYSDATE, 'YYYY/MM/DD'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM dual;

SELECT
    SYSDATE,       --HH 시간 MI 분 SS초  
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),  -- HH24 24시간표기
    TO_CHAR( ROUND(SYSDATE), 'YYYY-MM-DD HH24:MI:SS')
FROM dual;

-- 간단한 연습 --
SELECT 
    studno,
    name,
    TO_CHAR(birthday, 'YYYY-MM-DD') "BIRTHDAY"
FROM student  -- 테이블의 정보 팝업창 shift + F4
WHERE TO_CHAR(birthday, 'MM') = '01';

SELECT 
    empno,
    ename,
    hiredate
FROM emp
WHERE TO_CHAR(hiredate, 'MM') IN('01', '02', '03');
--    TO_CHAR(hiredate, 'MM') = '01' OR
--    TO_CHAR(hiredate, 'MM') = '02' OR
--    TO_CHAR(hiredate, 'MM') = '03';

-- 연습 끝 --

-- 모닝퀴즈 2 --
SELECT 
    studno "번호",
    name "이름",
    id "아이디"
FROM student
WHERE height BETWEEN 160 AND 175
--WHERE height >= 160 AND height <= 175
UNION ALL
SELECT
    profno,
    name,
    id
FROM professor
WHERE (deptno IN(101,102,103,201)) AND bonus IS NULL;

SELECT 
    '이름:'||name "이름",
    '아이디:'||id "아이디",
    '주민번호:'||SUBSTR(jumin,1,6)||'-'||SUBSTR(jumin,7) "주민번호"
FROM student;
-- 모닝퀴즈 끝 --




