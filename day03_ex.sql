/*
    1. 1년은 365일이라고 가정하고
        사원의 근무일 수를 년 단위로 표시하고
        대신 소수 이하는 버리세요
        
        표시형식 ]
            사원이름    입사일     근무년수
            SMITH       80/00/00    40년 
            
*/

SELECT ENAME AS 사원이름, TO_CHAR(HIREDATE,'YY/MM/DD') AS 입사일, CONCAT(TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(HIREDATE,'YYYY'),'년') AS 근무년수
FROM EMP;

SELECT ENAME AS 사원이름, HIREDATE AS 입사일, TO_CHAR(SYSDATE, 'YYYY')- TO_CHAR(HIREDATE,'YYYY')||' 년' AS 근무년수
FROM EMP
;
/*
    2. 사원의 이름, 입사일 , 근무일을 조회하세요
        단, 근무일은 년, 월 단위로 표현하세요

*/
SELECT ENAME AS 사원이름, HIREDATE AS 입사일, TO_CHAR(SYSDATE,'YYYY')-TO_CHAR(HIREDATE,'YYYY') AS 년
     , FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS 입사개월
FROM EMP
;
SELECT ENAME AS 사원이름, HIREDATE AS 입사일, TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(HIREDATE,'YYYY') AS 년
     , FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS 입사개월 FROM EMP;
/*
    3. 사원이 첫 급여를 받을 때 까지 근무일 수를 조회하세요
*/
SELECT ENAME, LAST_DAY(HIREDATE)-HIREDATE AS "첫 급여전 근무일"
FROM EMP
;
SELECT ENAME, LAST_DAY(HIREDATE)     FROM EMP;
/*
    4. 사원이 입사후 맞이하는 첫 토요일을 조회하세요
*/
SELECT ENAME, HIREDATE, NEXT_DAY(HIREDATE,'토')AS 첫번째토요일
FROM EMP
;

/*
    5. 근무년수는 입사한 달의 1일을 기준으로 산출해야한다.
        사원의 근무년수 기준일을 조회하세요.
        단, 15일 이전입사자는 해당 월을 기준일로 하고
            16일 이후 입사자는 해당 월의 다음달을 기준으로 한다.
*/
SELECT ENAME, ROUND(HIREDATE,'MM'),HIREDATE
FROM EMP
;


/*
    6. 사원중 월요일에 입사한 사원의 이름, 입사일, 입사 요일을 조회하세요
*/

SELECT TO_CHAR(HIREDATE, 'day') FROM EMP;
SELECT ENAME, HIREDATE FROM EMP
WHERE
 TO_CHAR(HIREDATE,'DAY') = '월요일'
 ;

/*
    7 사원 급여중에서 백단위가 0인 사원의 사원이름, 급여를 조회하세요
    
    힌트 ]
        문자열로 변환후 처리한다.
*/
SELECT ENAME, SAL

FROM EMP

WHERE
 SUBSTR(TO_CHAR(SAL),-3,1) != 0;

 


/*
    8. 사원의 사원이름, 급여, 커미션을 조회하세요.
        단, 커미션이 없는 사원은 NONE 으로 표시되게 하세요.
        
        
*/     
SELECT ENAME, SAL, COMM,COALESCE(TO_CHAR(COMM),'NONE')

FROM EMP
;

SELECT 
    ENAME AS 사원이름 , SAL 사원급여, COMM AS 커미션
    ,DECODE(COMM,NULL,'NONE'
                ,TO_CHAR(COMM)
        )AS "커미션 여부"
FROM EMP
;
    