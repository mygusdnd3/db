--day05

/*
    JOIN(조인)
    ==> 두개 이상의 테이블에 있는 내용을 동시에 검색하는 방법
    
    참고]
        오라클은 ER(ENTITY RELATION) 형테의 데이터베이스라고 한다. ( 관계형 데이터베이스)
        
        ER 형태란?
        엔티티 끼리의 릴레이션십 관계를 이용해서 데이터를 관리한다.
        
        예를 들어 쇼핑몰에서 판매관리를 하고자 하면
        
        누가          - 이름, 주소, 전화번호 
        언제          - 주문일자
        무엇을         - 상품이름, 가격, 제조회사..
        몇개
        
        전은석 서울시 관악구 010-1234-4556 20/08/27 에르메스 애플 워치
        윤요셉 서울시 마포구 010-2344-2392 20/08/27 선풍기  애플  워치
        이지우 인천시 부평구 010-2344-1211 20/08/07 LG그램 LG 노트북
        전은석 서울시 관악구 010-1234-3456 20/08/07 LG그램 LG 노트북
        --
        중복이..
        원래 이렇게 저장해 놓아야 하는데
        중복데이터는 다른 테이블로 보관하도록 한다.
        
        구매정보 ---> 엔티티
            전은석  에르메스    1 20/08/27
            윤요셉  에르메스    3 20/08/27
            이지우  그램        1 20/08/27
            전은석  그램        5 20/08/27
        구매자정보
        전은석 서울시 관악구 010-1234-4556
        윤요셉 서울시 마포구 010-2344-2392
        이지우 인천시 부평구 010-2344-1211
        
        상품정보
        에르메스 애플 워치
        LG그램 LG 노트북
        
        의 형태로 분리해서 저장한다.
        
        참고 ]
            오라클은 처음부터 여러개의 테이블을 동시에 검색하는 기능은 이미 가지고 있다.
            ==> 이처럼 두개 이상의 테이블을 동시에 검색하면
                Cartesian Product - 데카르트..
                가 만들어지고 그 결과를 검색하게 된다.
        조인이란
            Cartesian Product 에 의해서 탄생된 결과물 중에서
            원하는 결과물만 뽑아내는 기술
        1. Inner Join       ---Cartesian Product의 결과 집합 안에서 데이터를 주출하는 주인
            ==> 가장 일반적인 조인방식
                두개의 테이블 중에서 같은 데이터만 골라서 조회하는 조인
                
            형식 ]
                SE
            1) Equi join
                --> 동등비교 연상자로 데이터를 추출하는 조인
                
            2) Non-Equi Join
                --> 동등비교연산자가 아닌 연산자로 데이터를 추출하는 조인
                
        2. Outer Join   ---Cartesian Product의 결과 집합 안에 없는 데이터를 주출하는 주인
        
        3. SELF JOIN
                - 하나의 테이블을 여러번 나열해서 원하는 데이터를 조회하는 조인
*/

SELECT
    *
FROM
    EMP, DEPT
;

SELECT
    *
FROM 
    EMP e, EMP s
WHERE
    e.MGR = s.EMPNO
;
-- Non-equi join
SELECT 
    *
FROM
    EMP, SALGRADE
WHERE
    SAL BETWEEN LOSAL AND HISAL
;
-----------------------------------------------------------------------------
-- Equi Join
-- 사원의 이름, 직급, 급여, 부서번호, 부서 이름을 조회하세요
SELECT
    ENAME AS 직급, JOB AS 직급, SAL 급여 , emp.deptno AS 부서번호, DNAME AS 부서이름
FROM
    EMP, DEPT
WHERE
    -- 조인조건
    EMP.DEPTNO = DEPT.DEPTNO
;
-- Non - Equi Join
-- 사원의 사원번호, 사원이름, 사원직급, 사원급여, 급여등금을 조회하세요
SELECT 
    EMPNO AS 사원번호, ENAME AS 사원이름, JOB AS 사원직급, SAL AS 사원급여, GRADE AS 급여등금
FROM 
    EMP, SALGRADE
WHERE
 SAL >= LOSAL
 AND SAL <= HISAL
 ;
 /*
    조인에서도 조인 조건 이외의 일반조건을 얼마든지 사용할 수 있다.
 */
 
 -- 81년 입사한 사람의 사원이름, 직급, 부서번호, 부서위치를 조회하세요
 SELECT
    ENAME, JOB,HIREDATE, e.DEPTNO,LOC AS 부서위치
 FROM
    EMP e, DEPT d
 WHERE
    e.DEPTNO = d.DEPTNO
    AND TO_CHAR(HIREDATE, 'YY') = '81'
 ;
 
 
SELECT
    *
FROM EMP e,DEPT a
WHERE
    e.DEPTNO = a.DEPTNO
;

SELECT
    *
FROM EMP e,SALGRADE a
WHERE
    e.SAL BETWEEN a.losal AND a.hisal
;

--SELF JOIN
-- 사원의 사원번호, 사원이름, 사원직급, 부서번호, 상사이름 을 조회하세요
SELECT
    E.EMPNO AS 사원번호, E.ENAME AS 사원이름, E.JOB AS 사원직급, E.DEPTNO AS 부서번호, S.ENAME AS 상사이름
FROM
    EMP E, --사원정보 테이블
    EMP S  --상사정보 테이블
WHERE
    E.MGR = S.EMPNO ---MGR 번호가 이번차례 너의 S.ENAME이름이야
;


SELECT

FROM
    EMP E, EMP S
WHERE

;

/*
    Outer Join
        ==> 조회할 데이터가 Cartesian Product 내에 없는 데이터를 조회하는 조인
        형식 ]
            SELECT
                조회할 필드
            FROM
                테이블1,테이블2
            WHERE
                테이블1.필드(+) = 테이블2.필드(+) (NULL로 표시되어야할쪽에 붙인다)
            ;
            
            주의사항 ]
                (+) 기호는 NULL로 표시되어야할 데이터쪽에 붙여준다
*/

SELECT
    *
FROM
    emp e, emp s
WHERE
    e.mgr = s.empno(+)  --null로 표시되야될 테이블에다 +를 해준다
    ;
/*
    참고 ]
        테이블이 여러개 FROM 절에 나열이 되면
        대부분 추가된 테이블 갯수만큼 조인 조건이 부여되어야 한다. 
        이때 논리 연산자는 AND로 연결하면 된다.
*/

-- 사원의 사원이름, 입사일, 급여,급여등급, 부서번호, 부서이름을 조회하세요.
-- 급여등급은 SALGRADE, 부서이름은 DEPT테이블
SELECT
    ENAME AS 사원이름, HIREDATE AS 입사일, SAL, GRADE, d.DEPTNO, DNAME AS 부서이름
FROM
    EMP e, SALGRADE, DEPT d
WHERE
    -- 부서테이블과 사원테이블 조인
    e.DEPTNO = d.DEPTNO
    AND SAL BETWEEN LOSAL AND HISAL
;

-- 문제 ] 사원의 사원번호, 사원이름, 직급, 급여, 급여등급, 상사번호, 상사이름, 부서번호, 부서위치

SELECT e1.EMPNO AS 사원번호
     , e1.ENAME AS 사원이름
     , e1.SAL AS 급여
     , GRADE AS 급여등급
     , e1.MGR AS 상사번호
     , e2.ENAME AS 상사이름
     , e1.DEPTNO as 부서번호
     , LOC as 부서위치
FROM
    EMP e1, EMP e2, SALGRADE, DEPT d
WHERE
   e1.mgr = e2.empno(+)
   AND e1.sal BETWEEN losal AND hisal
   AND e1.deptno = d.deptno
   ;
-----------------------------------------------------------------------------------

 
    
/*
    문제 1 ]
        직급이 'MANAGER'인 사원의
        이름, 직급, 입사일, 급여, 부서이름을 조회하세요.
*/
SELECT ENAME AS 이름
     , JOB AS 직급
     , HIREDATE AS 입사일
     , SAL AS 급여
     , DNAME AS 부서이름
  FROM EMP, DEPT
WHERE
    EMP.DEPTNO = DEPT.DEPTNO
;
/*
    문제 2]
        급여가 가장 적은 사원의
        이름, 직급, 입사일, 급여, 부서이름, 부서위치를 조회하세요.
*/
SELECT ENAME AS 이름
     , JOB AS 직급
     , HIREDATE AS 입사일
     , SAL AS 급여
     , DNAME AS 부서이름
     , LOC AS 부서위치
FROM EMP, DEPT
WHERE 
    EMP.DEPTNO = DEPT.DEPTNO
    AND SAL = ( SELECT MIN(SAL)
                FROM EMP
                
                )
;

/*
    문제 3 ]
        사원이름이 5글자인 사원의 
        이름, 직급, 입사일, 급여, 급여등급을 조회하세요.
*/
SELECT ENAME AS 이름
     , JOB AS 직급
     , HIREDATE AS 입사일
     , SAL AS 급여
     , GRADE AS 급여등급
FROM EMP , SALGRADE
WHERE
    LENGTH(ENAME)IN(5)
    AND SAL BETWEEN LOSAL AND HISAL
;

/*
    문제 4 ]
        입사일이 81년이면서 직급이 CLERK 인 사원의
        이름, 직급, 입사일, 급여, 급여등급, 부서이름, 부서위치를 조회하세요.
*/
SELECT ENAME , JOB, HIREDATE, SAL, GRADE, DNAME, LOC
FROM EMP , SALGRADE, DEPT
WHERE
    EMP.DEPTNO = DEPT.DEPTNO
    AND SAL BETWEEN LOSAL AND HISAL
    AND JOB = 'CLERK'
    ;


/*
    문제 5 ]
        사원의 이름, 직급, 급여, 상사이름, 급여등급을 조회하세요.
*/

SELECT e.ENAME AS 사원이름, e.SAL AS 사원급여, d.ENAME as 상사이름, GRADE as 급여등급,b.deptno,e.deptno
FROM 
    EMP e , EMP d , SALGRADE, DEPT b
WHERE 
    --큰거
   e.deptno = b.deptno
   AND e.mgr = d.empno(+)
   AND e.SAL BETWEEN losal AND hisal
   
   
;
/*
    문제 6 ]
        사원의
        이름, 직급, 급여, 상사이름, 부서이름, 부서위치, 급여등급을 조회하세요.
*/
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


/*
    문제 7 ]
        사원의
        이름, 직급, 급여, 상사이름, 부서이름, 부서위치, 급여등급을 조회하는데
        회사 평균급여보다 급여가 높은 사원만 조회하세요.
*/
SELECT
    e.ename, e.job, e.sal, s.ename , dname, loc, grade
FROM
    emp e, emp s, salgrade, dept d
WHERE
    e.mgr = s.empno
    AND e. deptno = d.deptno
    AND e.sal BETWEEN losal AND hisal
    AND e.sal >  (
                SELECT
                    AVG(SAL)
                    FROM
                        emp
            )
;

/*
    문제 8
        사원의 이름, 직급, 급여, 부서번호, 부서이름, 부서위치를 조회하세요
*/

SELECT
    ename, job, sal, d.deptno, dname, loc
FROM
    emp e, dept d
WHERE
    e.deptno(+) = d.deptno
;

-- 급여가 부서 평균급여보다 많은 사원의
-- 사원번호, 사원이름, 급여, 부서평균급여, 부서사원수, 부서급여합계
/*
    인라인뷰도 조인에 사용할 수 있다.
*/
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
--인라인뷰
-- 사원번호, 사원이름, 급여, 부서평균급여, 부서사원수, 부서급여합계
SELECT
    empno, ename, sal, deptno, ROUND(avg,2), cnt,sum
FROM
    EMP e,
    (
        SELECT
            DEPTNO dno,MAX(SAL) max , MIN(sal) min, AVG(sal) avg, COUNT(*) cnt,SUM(sal) sum
        FROM
            emp
        GROUP BY
            DEPTNO
       )  t   
WHERE
    e.deptno = dno
;
            
-- 사원수가 가장 많은 부서의 번호, 부서급여합계 부서원수를 조회하세요
SELECT DEPTNO, SUM(SAL),COUNT(*)
FROM emp
GROUP BY
 DEPTNO
HAVING -----------------HAVING절엔 그룹함수가 들어가지는데 WHERE 절엔 안들어간다
 COUNT(*) = (SELECT MAX(COUNT(*)) FROM emp GROUP BY deptno)
   
;


SELECT
    DEPTNO , SUM(SAL)AS 부서금액합계, COUNT(*)AS 부서원수
FROM EMP
GROUP BY
    DEPTNO
HAVING
    COUNT(*) = (
                    SELECT
                        MAX(COUNT(*))
                    FROM
                        EMP
                    GROUP BY
                        DEPTNO
                )
;

-- firs_name의 두번째 글자가 'a'인 사원의 정보

SELECT *
FROM EMP
WHERE
   -- first_name LIKE'_A%'
    --ENAME LIKE '_A%'
    SUBSTR(ENAME,2,1) = 'A'
;

/*
    ANSI JOIN
    ==> 질의명령은 데이터베이스(DBMS)에 따라서 문법이 달라진다.
    
        ANSI SQL 이란?
        미국의 ANSI 협회에서 공통적으로 실행 가능한 질의명령을 만들어서
        사용하도록 해 놓은 것
        
        1. CROSS JOIN
            ==> 오라클의 CARTESION PRODUCT를 만들어내는 조인과 같은 조인
            
            형식 ]
                SELECT
                
                FROM
                    테이블1    CROSS JOIN 테이블2 --크로스조인 명시
                ;
*/
-- oracle cross join
SELECT
    *
FROM
    emp, dept
;

-- Ansi Cross Join
SELECT
    *
FROM
    emp CROSS JOIN  dept
;

/*
    ANSI INNER JOIN
        1. EQUI JOIN
        
        2. NON-EQUI JOIN
        
        3. SELF JOIN
-----------------------------------------------------------------------------------------------        
       INNER JOIN
        
        형식 ]
            SELECT
                조회할 필드,...
            FROM
                테이블1 INNER JOIN  테이블2
            ON
                조인조건식
            ;
        
    참고 ]
        ANSI JOIN 에서는 
        JOIN 조건은 ON  절에 기술하고
        일반 조건은 WHERE 절에 기술하는 것을 원칙으로 한다.
            
*/

-- 사원의 이름, 직급, 부서이름을 조회하세요.
SELECT
    ename 사원이름, job 직급, dname 부서이름
FROM
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
;

-- WARD 사원의 이름, 직급, 부서이름을 조회하세요.
SELECT
    ename 사원이름, job 직급, dname 부서이름
FROM
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
WHERE
    ename = 'WARD'
;

/*
    ANSI OUTER JOIN
    ==> ORACLE OUTER JOIN고 같은 조인
        조인 조건식에 만족하는 데이터만 조회하고
        조인 조건식에 맞지 않는 데이터는 결과에서 제외한다.
        이런 경우 조인 조건식에 포함되지 않는 데이터도 
        조회에 포함되도록 하는 조건식이 OUTER JOIN 이다.
        
    형식 ]
        SELECT
        
        FROM
            테이블1 [ LEFT | RIGHT | FULL ] OUTER JOIN 테이블2
        ON
            조인조건식
        ;
        
        참고 ]
            LEFT | RIGHT : FULL 의 의미
            오라클 조인의 (+) 와 정반대의 사용법
            조건에 맞지 않아서 조회에서 제외된 데이터의 위치를 지정한다.
            즉 왼쪽테이블에 있는 데이터를 포함할지
                오른쪽테이블에 있는 데이터를 포함할지를 결정하는 것이다.
                
        참고 ]
            오라클 조인에서는 풀아우터 조인을 사용하지 못했지만
            ANSI JOIN 에서는 양쪽 모두 붙일 수 있도록 하고 있으며
            이때 FULL 이라고 쓰면 된다.
*/

-- 사원의 사원이름, 직급, 상사번호, 상사이름, 상사직급을 조회하세요.

SELECT
    e.ename 사원이름, e.job 사원직급, e.mgr 상사번호, s.ename 상사이름, s.job 상사직급
FROM
    emp e LEFT OUTER JOIN emp s
ON
    e.mgr = s.empno
;

-- 사원의 사원이름, 직급, 급여, 부서번호, 부서위치, 급여등급을 조회하세요.
SELECT
    ename, job, sal, e.deptno, loc, grade
FROM
    dept d
INNER JOIN 
    emp e 
ON
    e.deptno = d.deptno
INNER JOIN 
    salgrade
ON
    sal BETWEEN losal AND hisal
;
-------------------------------------------------------------------------
/*
    NATURAL JOIN
    ==> 자동조인으로 해석하면 된다.
        반드시 조인 조건식에 사용하는 필드의 이름이 동일하고
        반드시 동일한 필드가 한개인 경우에 한해서 할수 있는 조인
        
        형식 ]
            SELECT
                필드이름,...
            FROM
                테이블1 NATURAL JOIN 테이블2
            ;
        참고 ]
            ON이 없는 이유는?
            위에서 말한 전제조건 때문이다.
            즉, 두 테이블에 같은 이름의 필드가 '딱 한개만 있다'는 전제조건으로
            자동적으로 그 필드를 이용해서 조인하게 된다.
*/

-- 사원의 사원이름, 직급, 부서이름, 부서위치를 조회하세요.

SELECT
    ENAME AS 사원이름, JOB AS 직급, DNAME AS 부서이름, LOC AS 부서위치
FROM
    EMP
NATURAL JOIN
    DEPT
;

/*
    USING JOIN
        ==> 반드시 조인 조건식에 사용하는 필드의 이름이 동일한 경우
            같은 이름의 필드가 여러개 존재해도 무방
            
            형식 ]
                SELECT
                    조회필드,...
                FROM
                    테이블1 JOIN 테이블2
                USING
                    (조인조건식에 사용할 필드이름)
                ;

*/

-- 사원의 사원이름, 직급, 부서번호,부서이름, 부서위치를 조회하세요. 어거지로해봄
SELECT
    ENAME,JOB,DEPTNO AS 부서번호 ,DNAME,LOC
FROM
    EMP E JOIN DEPT D
USING
    (DEPTNO)
;