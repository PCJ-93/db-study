--11.4
SELECT
    deptno "부서번호",
    dname "부서이름",
    loc "위치"
FROM dept;

SELECT 
    name || '(' || id || ')' "교수정보",
    position,
    hiredate "입사일자",
    email "이메일"
FROM professor;

SELECT *
FROM professor;

