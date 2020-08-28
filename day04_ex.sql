-- day04 과제

/*
    1. SMITH 사원과 동일한 직급을 가진 사원의 정보를 조회하세요
*/
SELECT ENAME AS 사원이름, JOB AS 직급, SAL AS 연봉, HIREDATE AS 입사일
FROM EMP
WHERE
    JOB IN (
            SELECT
               JOB
            FROM
                EMP
            WHERE 
                ENAME = 'SMITH'
                
            )
    
;
/*
    2. 사원들의 평균급여보다 적게받는 사원의 정보를 출력하세요
*/
SELECT ENAME AS 사원이름, JOB AS 직급, SAL AS 연봉, HIREDATE AS 입사일
FROM EMP
WHERE
   SAL< ( 
                SELECT
                    AVG(SAL)
                FROM
                    EMP
        
                    
                )
;
/*
    3. 최고 급여자의 정보를 조회하세요.
*/

SELECT ENAME AS 사원이름, JOB AS 직급, SAL AS 연봉, HIREDATE AS 입사일
FROM EMP
WHERE
    SAL IN(
            SELECT 
                MAX(SAL)
            FROM
                EMP
            )

;
/*
    4. KING 사원보다 늦게 입사한 사원의 정보를 조회하세요    
*/

SELECT ENAME AS 사원이름, JOB AS 직급, SAL AS 연봉, HIREDATE AS 입사일
FROM EMP
WHERE
    HIREDATE >(
                SELECT HIREDATE FROM EMP WHERE ENAME = 'KING'
                )
;

/*
    5. 각 사원의 급여와 평균급여의 차이를 조회하세요,   
*/

SELECT ENAME AS 사원이름, JOB AS 직급, SAL AS 연봉 
      ,SAL-(    
            SELECT
                MAX(SAL)
            FROM 
                EMP
        ) AS 급여차이
FROM EMP
;

------------------풀이
SELECT
    EMPNO, ENAME,
    SAL -(SELECT
        AVG(SAL)
    FROM
        EMP)
    
FROM EMP
;

SELECT (10  - (SELECT 9/3 FROM DUAL)) FROM DUAL;
/*
    6. 부서의 급여합계가 가장 높은 부서의 사원들의 정보를 조회하세요  
*/
SELECT *
FROM EMP
WHERE
     DEPTNO IN (
                SELECT MAX(SUM(SAL))
                FROM EMP
                GROUP BY
                    DEPTNO
                     
                    )

            
;

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE
    DEPTNO = (
                SELECT
                    DEPTNO
                FROM
                    EMP
                GROUP BY
                    DEPTNO
                HAVING
                    SUM(SAL) = (
                                    SELECT
                                        MAX(SUM(SAL))
                                    FROM
                                        EMP
                                    GROUP BY
                                        DEPTNO
                                    )
            )
;
/*
    7. 커미션을 받는 직원이 한사람이라도 있는 부서의 소속 사운들의 정보를 조회하세요  
*/
SELECT  ENAME AS 사원이름, JOB AS 직급, SAL AS 연봉, COMM,HIREDATE AS 입사일, DEPTNO
FROM EMP
WHERE
    COMM IS NULL
    
    
;
---풀이
SELECT
    *
FROM
    EMP
WHERE
    DEPTNO IN (
                SELECT
                    DISTINCT DEPTNO
                FROM
                    EMP
                WHERE
                    COMM IS NOT NULL
               )
;
/*
    8. 평균 급여보다 급여가 높고, 이름이 4글자 또는 5글자인 사원의 정보를 조회하세요.
*/
SELECT ENAME AS 사원이름, JOB AS 직급, SAL AS 연봉, COMM,HIREDATE AS 입사일, DEPTNO
FROM EMP
WHERE
    SAL > (SELECT AVG(SAL) FROM EMP)
    AND LENGTH(ENAME) IN (4,5)
    
;


------------------풀이
SELECT
ENAME AS 사원이름, JOB AS 직급, SAL AS 연봉, COMM,HIREDATE AS 입사일, DEPTNO 
, ROUND((SELECT AVG(SAL) FROM EMP),2) AS 연봉평균
FROM
    EMP
WHERE
     SAL > (SELECT AVG(SAL) FROM EMP )
           AND LENGTH(ENAME) IN(4,5)
;
/*
    9. 사원의 이름이 4글자로된 사원과 같은 직급의 사원들의 정보를 조회하세요  
*/
SELECT ENAME AS 사원이름, JOB AS 직급, SAL AS 연봉, COMM,HIREDATE AS 입사일
FROM EMP
WHERE
    ENAME IN ( SELECT ENAME FROM EMP WHERE LENGTH(ENAME) =4)

    
;

/*
    10. 입사년도가 81년이 아닌 사원과 같은 부서에 있는 사원의 정보를 조회하세요  
*/

SELECT
    *
FROM
    EMP
WHERE 
    DEPTNO IN (
SELECT 
    DISTINCT DEPTNO
FROM
    EMP
WHERE
    HIREDATE NOT BETWEEN '1981/01/01' AND '1982/01/01')
  --  TO_CHAR(HIREDATE, 'YY') != '81')
    /*
        부정연산자
            <>
            !=
            ^=
            NOT
    */
;

/*
    11. 직급별 평균 급여보다 조금이라도 많이 받는 사원의 정보를 조회하세요 --ANY
*/

/*
    12. 모든 입사년도 평균급여보다 많이 받는 사원의 정보를 조회하세요.--ALL
*/

/*
    13. 최고 급여자의 이름 길이와 같은 이름 길이를 갖는 사원이 존재하면 
        모든 사원의 정보를 조회하고, 
        아니면 조회하지 마세요.   ---EXISTS
*/
SELECT
*
FROM
EMP
WHERE
     EXISTS( SELECT
            *
            FROM
            EMP
            WHERE
                LENGTH(ENAME) = ( 
                                    SELECT
                                    LENGTH(ENAME)
                                  FROM
                                    EMP
                                    WHERE
                                        SAL = (
                                                SELECT
                                                    MAX(SAL)
                                                    FROM
                                                        EMP
                                                   
                                                    )
                                    )
                                                    
                 )