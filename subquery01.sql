-- Sub Query --

SELECT
    s.name STUD_NAME,
    s.deptno1 DEPT_NO,
    d.dname DEPT_NAME
FROM student s, department d
WHERE s.deptno1 = d.deptno
AND s.deptno1 = ( SELECT deptno1
                    FROM student
                    WHERE name = 'Anthony Hopkins' );

SELECT 
    deptno1
FROM student
WHERE name = 'Anthony Hopkins';


SELECT
    p.name,
    p.hiredate,
    d.dname
FROM professor p, department d
WHERE p.hiredate > (SELECT hiredate
                        FROM professor
                        WHERE name = 'Meg Ryan')
GROUP BY p.name, p.hiredate, d.dname;



