SELECT
    ENAME, JOB, HIREDATE, E.DEPTNO, LOC
FROM
    EMP E, DEPT D
WHERE
    E.DEPTNO = D.DEPTNO
    AND TO_CHAR(HIREDATE,'YY')='81'
;
SELECT  *
FROM EMP E, SALGRADE S
WHERE 
    SAL BETWEEN LOSAL AND HISAL
;
--  E.EMPNO AS 사원번호, E.ENAME AS 사원이름 , E.JOB AS 사원직급 ,E.DEPTNO AS 부서번호, 
SELECT
  S.ENAME 상사이름 ,S.JOB , E.ENAME, E.JOB    
FROM 
    EMP E,
    EMP S
WHERE
    E.MGR = S.EMPNO
ORDER BY
    S.ENAME
;



SELECT
    ENAME, JOB, SAL, E.DEPTNO, DNAME
FROM EMP E, DEPT
WHERE 
    E.DEPTNO = DEPT.DEPTNO
;

SELECT
    EMPNO,ENAME,JOB,SAL,GRADE
FROM EMP, SALGRADE
WHERE
SAL BETWEEN LOSAL AND HISAL
;
/*
    참고 ]
        테이블이 여러개 FROM 절에 나열이 되면
        대부분 추가된 테이블 갯수만큼 조인 조건이 부여되어야 한다. 
        이때 논리 연산자는 AND로 연결하면 된다.
*/
SELECT
    E.EMPNO,E.ENAME,E.JOB,E.HIREDATE,E.SAL,GRADE,E.DEPTNO, DNAME,LOC, E1.ENAME AS 상사이름
FROM
    EMP E, DEPT D, SALGRADE , EMP E1
WHERE
    E.DEPTNO = D.DEPTNO
    AND TO_CHAR(E.HIREDATE,'YY') = '81'
    AND E.MGR = E1.EMPNO(+)
    AND E.SAL BETWEEN LOSAL AND HISAL
ORDER BY
 상사이름
;

SELECT ENAME, JOB, HIREDATE, SAL, DNAME
FROM EMP, DEPT
WHERE 
    EMP.DEPTNO = DEPT.DEPTNO
;

SELECT ENAME , JOB, HIREDATE, SAL, GRADE, DNAME
FROM EMP , SALGRADE, DEPT
WHERE
    EMP.DEPTNO = DEPT.DEPTNO
    AND SAL BETWEEN LOSAL AND HISAL
;

SELECT ENAME, JOB, HIREDATE, SAL, GRADE, DNAME,LOC
FROM EMP, SALGRADE, DEPT
WHERE
    EMP.DEPTNO = DEPT.DEPTNO
    AND TO_CHAR(HIREDATE,'YY')='81'
    AND JOB = 'CLERK'
    AND SAL BETWEEN LOSAL AND HISAL
;

SELECT E.ENAME AS 사원이름
     , E.SAL AS 사원급여
     , E1.ENAME AS 상사이름
     , D.DNAME AS 부서이름
     , GRADE AS 급여등급
FROM EMP E, EMP E1, DEPT D, SALGRADE
WHERE 
    E.MGR = E1.EMPNO
    AND E.DEPTNO = D.DEPTNO
    AND E.SAL BETWEEN LOSAL AND HISAL
;

SELECT E.ENAME AS 사원이름 , E1.ENAME AS 상사이름 , GRADE AS 급여등급
FROM EMP E, EMP E1, DEPT D, SALGRADE
WHERE 
    E.MGR = E1.EMPNO
    AND E.SAL BETWEEN LOSAL AND HISAL
;










SELECT
    empno, ename, sal, deptno, --2.메인 FROM을 돌면서 deptno 를 꺼내온다 한사람꺼냈을때 그사람의 부서번호
    (
        SELECT
            AVG(SAL)
        FROM
            emp
        WHERE
            deptno = e.deptno --3. 현재 deptno = e.deptno ( deptno = 10/20/30(순차증가)
            )AS 부서평균급여,
            ( SELECT COUNT(*) FROM emp WHERE deptno = e.deptno)AS 수서원수
            
FROM EMP e --q별칭 부여한 이유는 안에 서브질의에서 다시 불러오게 하기위한
WHERE
    SAL > (
            SELECT
                AVG(SAL)
            FROM EMP
            WHERE
                DEPTNO=e.deptno
            )
            
;            

SELECT          -- 한줄 나올때 나오는건 emp가 가지고 있는 첫뻔째 deptno
    empno, ename, sal, deptno, --2.메인 FROM을 돌면서 deptno 를 꺼내온다 한사람꺼냈을때 그사람의 부서번호
    (
        SELECT
            AVG(SAL)
        FROM
            emp
        WHERE
            deptno = EMP.deptno --3. 현재 deptno = e.deptno ( deptno = 10/20/30(순차증가)
            )AS 부서평균급여,
            ( SELECT COUNT(*) FROM emp WHERE deptno = EMP.deptno)AS 수서원수
            
FROM EMP e --q별칭 부여한 이유는 안에 서브질의에서 다시 불러오게 하기위한
WHERE
    SAL > (
            SELECT AVG(SAL)
            FROM EMP
            WHERE DEPTNO=EMP.deptno
            )
            
;            

-- 급여가 부서 평균급여보다 많은 사원의
-- 사원번호, 사원이름, 급여, 부서평균급여, 부서사원수, 부서급여합계
SELECT EMPNO, ENAME , SAL
,ROUND((SELECT AVG(SAL) FROM EMP WHERE DEPTNO = e.DEPTNO),2)AS 부서평균급여
,(SELECT COUNT(*) FROM EMP WHERE DEPTNO = e.DEPTNO)AS 부서사원수
,(SELECT SUM(SAL) FROM EMP WHERE DEPTNO = e.DEPTNO)AS 부서급여합계

FROM EMP e

WHERE
    SAL > ( SELECT AVG(SAL) FROM EMP WHERE DEPTNO = e.DEPTNO)