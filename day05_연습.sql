SELECT e1.ename as 사원이름
     , e1.job as 직급
     , e1.sal 급여
     , e2.ename 상사이름
     , dname 부서이름
     , loc 부서위치
     , grade 급여등급
from emp e1, emp e2 ,DEPT, salgrade
where
    e1.mgr = e2.empno(+)
    AND e1.DEPTNO = DEPT.DEPTNO
    AND E1.SAL BETWEEN LOSAL AND HISAL
    and E1.sal > (select avg(sal) from emp)
;
-- 급여가 부서 평균급여보다 많은 사원의 
--      사원번호, 사원이름, 급여, 부서번호, 
--      부서평균급여, 부서사원수, 부서급여합계 를 조회하세요.
 
    
SELECT
   EMPNO, ENAME, SAL, DEPTNO,
    ROUND((SELECT AVG(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO))부서평균,
    (SELECT COUNT(*) FROM EMP WHERE DEPTNO = E.DEPTNO) 부서사원수,
    (SELECT SUM(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO) 부서금액합계
FROM 
    EMP E
WHERE
    SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO)
    ;
    SELECT AVG(SAL) FROM EMP GROUP BY DEPTNO


;
SELECT * FROM EMP, DEPT;

SELECT * FROM EMP CROSS JOIN DEPT
;

SELECT ENAME, JOB, DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
;

SELECT ENAME, JOB, DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE 
    ENAME ='WARD'
;

SELECT
E.ENAME,E.JOB,E.MGR,E.COMM,D.ENAME,D.JOB,D.COMM
FROM
EMP E  LEFT OUTER JOIN  EMP D 
ON
E.MGR = D.EMPNO
;


SELECT
    ENAME, JOB, SAL, E.DEPTNO, LOC, GRADE
--FROM EMP , DEPT, SALGRADE
FROM DEPT D INNER JOIN EMP E 
ON E.DEPTNO = D.DEPTNO
INNER JOIN
SALGRADE
ON
SAL BETWEEN LOSAL AND HISAL
;


SELECT
    ENAME , JOB , SAL, E.DEPTNO, DNAME, LOC,GRADE
    ,ROUND((SELECT AVG(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO),2)부서별급여평균
FROM 
    EMP E INNER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    INNER JOIN SALGRADE
    ON SAL BETWEEN LOSAL AND HISAL
WHERE
SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO)
;

SELECT ENAME, DNAME
FROM EMP NATURAL JOIN DEPT;

SELECT
    ename 사원이름, job 직급, deptno 부서번호, dname 부서이름, loc 부서위치
FROM
    emp INNER JOIN dept
USING (deptno)
;