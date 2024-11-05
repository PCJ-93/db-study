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

-- 간단한 연습1 --
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

-- 간단한 연습2 --
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

-- 간단한 연습3 --
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

-- 숫자 => 문자 형변환
SELECT
    TO_CHAR(1234, '999999'),
    TO_CHAR(1234, '099999'),
    TO_CHAR(1234, '$99999'),
    TO_CHAR(1234, '99999.99'),
    TO_CHAR(1234, '999,999')
FROM dual;

SELECT
    empno,
    ename,
    sal,
    comm,
    TO_CHAR( (sal*12)+comm, '999,999' ) "연봉"
FROM emp
WHERE ename = 'ALLEN';

SELECT
    empno,
    ename,
    TO_CHAR(hiredate, 'YYYY-MM-DD') "HIREDATE",
    TO_CHAR( (sal*12)+comm, '$999,999' ) "SAL",
    TO_CHAR( (((sal*12)+comm)*1.15), '$999,999' ) "15%인상"
  --  TO_CHAR( (((sal*12)+comm) + ((sal*12)+comm)*0.15) , '$999,999' ) "15%인상"
FROM emp
WHERE comm IS NOT NULL
ORDER BY sal;


-- TO_DATE  문자 => 날짜 형변환
SELECT
    TO_DATE('2024-06-02') + 3,
    TO_DATE('2024/06/02') + 3,
    TO_DATE('240602') + 3,
    TO_DATE('20240602') + 3,
    LAST_DAY('19991231'),
    TO_DATE('24:06:02') + 3,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD'),
    TO_DATE('2024-01-05', 'YYYY-MM-DD'),
    TO_DATE('2024,01,05', 'YYYY,MM,DD'),
    TO_DATE('12/21/20', 'MM/DD/YY')
FROM dual;

-- NVL null을 원하는값으로 변환
SELECT
    sal,
    comm,
    sal*12+comm,
    sal*12+ NVL(comm, 0) -- 예시)문자형 NVL(직급null, '사원') // 날짜형 NVL(날짜null, '23/12/12')
FROM emp;

SELECT
    profno,
    name,
    pay,
    bonus,
    TO_CHAR ( (pay*12)+NVL(bonus,0), '999,999' ) "TOTAL"
FROM professor
WHERE deptno = 201;

-- NVL2  NVL2(col1 , null이아니면col2 , null이면col3)

SELECT
    NVL(null,10),
    NVL2(123, '있다', '없다'),
    NVL2(null, '있다', '널이다')
FROM dual;

-- 간단한 연습4 --
SELECT
    profno,
    name,
    pay,
    bonus,
    TO_CHAR ( (pay*12)+NVL(bonus,0), '999,999' ) "TOTAL"
FROM professor
WHERE deptno = 201;
    
SELECT
    empno,
    ename,
    comm,
    NVL2(comm, 'Exist', 'NULL') "NVL2"
FROM emp
WHERE deptno = 30;
-- 연습 끝 --

SELECT  -- NVL, NVL2 활용
    pay,
    bonus,
    NVL(bonus, 0) "BONUS",
    pay*12 + bonus "TOTAL",
    pay*12 + NVL(bonus, 0) "TOTAL1",
    pay*12 + NVL2(bonus, bonus, 0) "TOTAL2",
    NVL2(bonus, pay*12+bonus, pay*12) "TOTAL3"
FROM professor;


-- DECODE() 함수  // DECODE(a,b,'1',null) null은 생략가능 /// a가 b일경우 1 출력
SELECT
    DECODE('그냥','냥','같네','다르네'),
    DECODE('그냥','그냥','같네','다르네'),
    DECODE('그냥','그','같네'),
    DECODE('그냥','냥','같네',null),
    DECODE(10, 30, '30이다', 40, '40이다', 50, '50이다', '아니다'), -- 중첩사용가능
    DECODE(10, 30, '30이다', 40, '40이다', 50, '50이다', 60, '60이다', '아니다'),
    DECODE(10, 30, '30이다', 40, '40이다', 50, '50이다', 60, '60이다', null),
    DECODE(10, 30, '30이다', 40, '40이다', 50, '50이다', 60, '60이다')
FROM dual;

SELECT 
    deptno,
    name,
    DECODE(deptno, 101, '컴퓨터공학', '다른학과'),
    DECODE(deptno, 101, '컴퓨터공학', 102, '컴공'),
    DECODE(deptno, 101, '컴퓨터공학'),
    DECODE(deptno, 101, '컴퓨터공학', null)
FROM professor;

SELECT
    deptno,
    name,
    DECODE(deptno, 101, '컴퓨터공학과', 102, '멀티미디어학과', 103, '소브트웨어학과', 'ETC') "학과",
    deptno "학과번호"
FROM professor;

-- 간단한 연습5 --
SELECT
    deptno,
    name,
    DECODE(name, 'Audie Murphy', DECODE(deptno,101,'BEST!'), 'NULL') "DECODE"
FROM professor;

SELECT
    deptno,
    name,
    DECODE( name, 'Audie Murphy', 'BEST!', DECODE(deptno,101,'GOOD!') ) "비고"
FROM professor;

SELECT
    deptno,
    name,
    DECODE( name, 'Audie Murphy', 'BEST!', DECODE(deptno,101,'GOOD!','N/A') ) "비고"
FROM professor;

SELECT
    deptno1,
    name,
    jumin,
    DECODE( SUBSTR(jumin,7,1), 1, '남자', 2, '여자') "성별"
FROM student
WHERE deptno1 = 101;

SELECT
    name,
    tel,
    DECODE( SUBSTR(tel, 1, INSTR(tel, ')')-1 ), '02', '서울', '031', '경기', '051', '부산', '052', '울산', '055', '경남') "지역명"
FROM student
WHERE deptno1 = 101;

SELECT 
    tel,
    INSTR(tel, ')')-1,
    SUBSTR(tel, 1, INSTR(tel, ')')-1 )
FROM student;
-- 연습 끝 --


-- CASE 함수
SELECT
    CASE '1234' when '1234' then '4321'
    END
FROM dual;

-- grade 학년 
--1 1학년 2 2학년 3 3학년 4 4학년
--1 저학년 2 저학년 3 고학년 4 고학년
SELECT   -- || 활용
    grade,
    grade || '학년' "학년구분"
FROM student;

SELECT  -- DECODE 활용
    grade,
    DECODE(grade, 1, '저학년', 2, '저학년', 3, '고학년', 4, '고학년') "학년구분"
FROM student;

SELECT -- CASE 활용
    grade,
    CASE grade  -- 방법1
        WHEN 1 THEN '저학년'
        WHEN 2 THEN '저학년'
        WHEN 3 THEN '고학년'
        WHEN 4 THEN '고학년'
        END "학년구분",
        
    CASE  -- 방법2
        WHEN grade IN(1,2) THEN '저학년'
        WHEN grade BETWEEN 3 AND 4 THEN '고학년'
    END "학년구분"
FROM student;

-- 간단한 연습6 --
SELECT
    name,
    jumin,
    birthday,
    CASE 
        WHEN TO_CHAR(birthday,'MM') BETWEEN 01 AND 03 THEN '1분기'
        WHEN SUBSTR(jumin,3 ,2) IN(04,05,06) THEN '2분기'
        WHEN TO_CHAR(birthday,'MM') BETWEEN 07 AND 09 THEN '3분기'
        WHEN SUBSTR(jumin,3 ,2) IN(10,11,12) THEN '4분기'
        END "분기"
FROM student;

SELECT
    empno,
    ename,
    TO_CHAR(sal,'999,999') "sal",
    CASE 
        WHEN sal BETWEEN 1 AND 1000 THEN 'Level 1'
        WHEN sal BETWEEN 1001 AND 2000 THEN 'Level 2'
        WHEN sal BETWEEN 2001 AND 3000 THEN 'Level 3'
        WHEN sal BETWEEN 3001 AND 4000 THEN 'Level 4'
        WHEN sal > 4000 THEN 'Level 5'
        END "급여등급"
FROM emp;
-- 연습 끝 --



