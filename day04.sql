-- 조건처리 함수를 사용해서 해결하세요

/*
    사원의 직급을 우리말로 조회하세요.
    
        MANAGER - 관리자
        SALESMAN - 영업직
        CLERK   - 사원
        ANALYST - 분석가
        PRESIDENT   - 사장

*/
SELECT DECODE(JOB, MA
FROM EMP
;

SELECT ENAME
     , DECODE(JOB, 'MANAGER',   '관리자'
                 , 'SALESMAN',  '영업직'
                 , 'CLERK',     '사원'
                 , 'ANALYST',   '분석가'
                 , 'PRESIDENT', '사장'
                 
            ) AS 직급
FROM EMP
;

/*
    2. 각 부서별로 보너스를 다르게 적용해서 지급하려 한다.
    
        10 - 급여의 10%
        20 - 급여의 15%
        30 - 급여의 20%
        를 기존 커미션에 더해서 지급하려고 한다
        만약 커미션이 없는 사람은 0으로 계산해서 계산하기로 하고
        사원의
            이름, 부서번호, 기존커미션, 적용커미션
            을 조회하세요

*/

SELECT ENAME AS 사원이름, DEPTNO AS 부서번호, NVL(COMM,0) FROM EMP;

SELECT ENAME AS 사원이름, DEPTNO AS 부서번호, SAL AS 급여 ,NVL(COMM ,0)AS 기존커미션,
        CASE DEPTNO WHEN 10 THEN NVL(COMM,0) +(SAL*1.10)
                    WHEN 20 THEN NVL(COMM,0) +(SAL*1.15)
                    WHEN 30 THEN NVL(COMM,0) +(SAL*1.20)
            END AS 적용커미션
FROM 
    EMP
--WHERE
    --NVL(COMM,0);
    ;

/*
    3. 입사년도를 기준으로
        80 -'A'
        81 -'B'
        82 - 'C'
        그외에 입사한 직원은 'D' 등급으로 
        
        사원들의
            사원이름, 입사일, 사원등급
        을 조회하세요.
        
*/
SELECT ENAME , HIREDATE, 
    DECODE (TO_CHAR(HIREDATE,'YY'), '80','A'
                                 , '81','B'
                                 , '82','C'
                                 , 'D'
           ) AS "사원 등급"                      
FROM 
    EMP
;

/*
    4. 사원의 이름이 4글자이면 'MR.' 를 이름앞에 붙이고
        4글자가 아니면 이름 뒤에 '사원'을 붙여서 조회하기로 한다.
        사원들의 
        사원번호, 사원이름, 사원이름 글자수?
        를 조회하세요.
*/
SELECT EMPNO, LENGTH(ENAME) AS 글자수
     , CASE LENGTH(ENAME) WHEN 4 THEN 'MR. '||ENAME
                          ELSE ENAME||' 사원'
            END AS 사원이름
FROM EMP
;
--까리하지못함
SELECT EMPNO, ENAME , LENGTH(ENAME)
    , DECODE( ENAME, LENGTH(ENAME)=4, 'MR.'||ENAME )
    
FROM EMP
;

/*
    5. 부서번호가 10 또는 20 이면 급여 + 커미션의 결과를 출력하고
    커미션이 없으면 0으로 계산)
    그 이외의 부서는 급여만 출력하도록 작성하시도
    
    사원이름, 부서번호, 급여, 커미션, 지급금액, 을 조회하시오
*/
SELECT ENAME, DEPTNO , SAL,NVL(COMM,0)AS 커미션
    , DECODE(DEPTNO, 10,SAL+NVL(COMM,0)
                   , 20,SAL+NVL(COMM,0)
                   , 30,SAL+NVL(COMM,0)
                   
            )AS 지급금액
FROM EMP;
/*
    6. 입사한 요일이 토요일, 일요일인 사원들의 급여를 20% 증가해서 지급하고
        그이외의 사원들은 10%증가해서 지급하려고 한다.
        
        사원들의
            사원이름, 입사일, 입사요일 , 급여 ,계산급여
        를 조회한다.
*/
SELECT ENAME, HIREDATE, TO_CHAR(HIREDATE, 'DAY'), SAL AS 급여
     , CASE TO_CHAR(HIREDATE, 'DAY') WHEN '토요일' THEN SAL*1.20
                                     WHEN '일요일',SAL*1.20
                                     ELSE SAL*1.10
            END AS 계산급여
  FROM EMP;
  
SELECT ENAME, HIREDATE, TO_CHAR(HIREDATE, 'DAY'), SAL AS 급여,
    DECODE(TO_CHAR(HIREDATE, 'DAY'),'토요일',SAL*1.20
                                  
                                   ,SAL*1.10) AS 계산급여
FROM EMP;
/*
    7. 근무개월수가 470개월 이상이면 커미션을 500 추가해서 지급하고
        커미션이없으면 0으로 계산한다. 
        근무 개월수가 470개월 미만인 커미션을 현재 커미션만 지급하도록 하려 한다. 
        사원들의
            사원이름, 커미션, 입사일, 입사개월수, 지급커미션
        을 조회하세요.
*/
  SELECT FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE) AS 숫자, 
            DECODE(숫자,숫자>470, NVL(COMM,0)+500
                        , NVL(COMM,0)
    ) AS 지급커미션 FROM EMP;
    ;
SELECT ENAME, COMM, HIREDATE, FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS 개월수
        ,CASE WHEN FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) >470 THEN NVL(COMM,0)+500
             ELSE NVL(COMM,0)
             END AS ABC
FROM EMP
;

/*
    8. 이름의 글자수가 5글자 이상인 사람은 이름을 3글자**를 붙이고 
        4글자 이하인 사람은 이름을 그대로 조회하려고한다.
        
        사원들의
            사원이름, 이름글자수, 변경이름
        을 조회하시오
*/
SELECT 

---------------------------------------------------------------------------------
--day04

/*
    그룹함수
    ==여러행의 데이터를 하나로 만들어서 뭔가를 계산하는 함수
    
    ***
    참고 
      그룹함수는 오직 결과가 한개만 나오게 된다.
      따라서 그룹함수는 결과가 여러개 나오는 경우와 혼용해서 사용할 수 없다.
      (==> 필드, 단일행 함수와 같이 사용할 수 없다.)
      오직 결과가 한 행으로만 나오는 것과만 혼용할 수 있다.
      그룹함수아만 같이 사용할 수 있다.
*/

SELECT ENAME FROM EMP;  -- 14개의 결과가 조회
SELECT SUM(SAL) AS 급여총합 FROM EMP; -- 한개의 결과가 조회
SELECT ENAME, SUM(SAL)FROM EMP; ---X 이렇게 쓰면 안된다.
SELECT 
    ENAME, SUM(SAL)
FROM
    EMP
WHERE
    ENAME = 'SMITH' ;    ------컴퓨터가 생각하기엔 여러개가 나올수있다. 역시안됨

/*
    1. SUM
        ==> 데이터의 합계를 반환해주는 함수 
        형식 ]
            SUM(필드이름)
*/

SELECT SUM(SAL) AS 급여합계
  FROM EMP
WHERE DEPTNO = 10
;

SELECT DEPTNO, SAL, EMPNO FROM EMP;
/*
    2. AVG
        ==> 데이터 평균을 구하는 함수
        형식 ]
            AVG(필드이름)
            
        참고 ]
            NULL 데잍는 평균을 계산하는 부분에서 완전히 제외된다.
*/
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS 숫자
     , DECODE(숫자, 숫자>470,COMM+500
                 , COMM)
FROM EMP;
    
SELECT SUM(SAL) AS 급여합계, AVG(SAL) 급여평균
  FROM EMP;
  
SELECT SUM(COMM) AS 커미션합계
     , FLOOR(AVG(NVL(COMM,0))) --AVG(COMM)
  FROM EMP
;
/*
    결과값 550은 커미션이 있는 사원수로 나눈 결과값이다.
    이유는 NULL은 모든 연산에서 제외가 되기 때문에
    사원수에 카운트 되지 ㅇ낳는다. 
*/
-- 커미션이 있는 사원수
SELECT 
    COUNT(COMM) AS "커미션이있는 사원수"
FROM
    EMP
;

/*
    3. COUNT
        ==> 지정한 필드중에서 데이터가 존재하는 필드의 갯수를 반환해주는 함수.
        예 ]
            사원중에서 커미션을 받는 사원의 수를 조회
            SELECT COUNT(COMM) FROM EMP;
        참고 ]
            필드이름 대신에 *를 사용하면
            각각의 필드의 카운트를 따로 구한 후 
            그 결과중에서 가장 큰값을 알려주게 된다.
*/

-- 사원중 상사가 존재하는 사원수
SELECT COUNT(MGR) FROM EMP;
-- 사원 수를 조회하세요
SELECT COUNT(*) FROM EMP;

/*
    4. MAX / MIN
        ==> 지정한 필드의 데이터 중에서 가장 큰 또는 작은 데이터를 반환하는 함수
*/
--사원중 최고급여와 최소급여를 조회하세요
SELECT MAX(SAL),MIN(SAL) FROM EMP;

/*
    5. STDDEV ==> 표준편차를 반환해준다.
    
    6. VARIANCE ==>  분산을 반환해준다.
*/

-- 문제 ] 사원들의 직급의 가지수를 조회하세요.
SELECT COUNT(DISTINCT JOB) FROM EMP;
----------------------------------------------------------------------------

/* 
    GROUB BY
    ==> 그룹함수에 적용되는 그룹을 지정하는 절.
    
    예}
        부서별로 급여의 합계를 구하고자 한다.
        직책별로 급여의 평균을 조회하고자 한다.
    형식 ]
        SELECT
            그룹함수,그룹기준 필드
        FROM
            테이블 이름
        [WHERE]
        
        GROUB BY
            필드이름.
        [ORDER BY]
        
        ;
*/
SELECT 
    DEPTNO AS 부서번호, SUM(SAL)AS 부서급여합계
FROM 
    EMP
GROUP BY
    DEPTNO
;
-- 직급별 급여 평균
SELECT
    JOB AS 직급, ROUND(AVG(SAL),2) AS 급여평균
FROM
    EMP
GROUP BY
    JOB
;
-- 직급별직급, 사원수, 급여총액 , 급여 평균을 조회하세요
SELECT
    JOB AS 직급, COUNT(*) AS 사원수, SUM(SAL) AS 급여총액, ROUND(AVG(SAL),2) AS 급여평균
FROM
    EMP
GROUP BY
    JOB
;

/*
    1. 각 부서별로 최소 급여를 조회하세요.
*/
SELECT DEPTNO, MIN(SAL)
FROM EMP
GROUP BY
    DEPTNO
;

/*
    2. 각 직책별 급여의 총액과 평균급여를 조회하세요.
*/
SELECT JOB AS 직책, SUM(SAL), ROUND(AVG(SAL),2)
FROM EMP
GROUP BY
    JOB
 ;

/*
    3. 입사년도별로 평균 급여와 총 급여를 조회하세요
        입사년도, 평균급여, 총급여
*/
SELECT TO_CHAR(HIREDATE,'YY') AS 입사년도
     , ROUND(AVG(SAL),3) AS 평균급여
     , SUM(SAL) AS 총급여 ,MAX(SAL),MIN(SAL),COUNT(*)
  FROM EMP
GROUP BY
    TO_CHAR(HIREDATE,'YY')

ORDER BY
    평균급여 DESC
    
;
/*
    4. 각 년도별 입사한 사원수를 조회하세요
        입사년도, 사원수
*/
SELECT TO_CHAR(HIREDATE,'YY')AS 입사년도 ,COUNT(*) AS 사원수
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YY')
;

/*
    5. 사원 이름의 글자수가 4,5 개인 사원의 수를 조회하세요
*/
SELECT COUNT(*) AS 사원의수
FROM EMP
GROUP BY 
    ENAME
HAVING 
    LENGTH(ENAME) = 4 
    or LENGTH(ENAME) = 5
;
/*
    6. 81년도에 입사한 사원의 수를 직책별로 조회하세요
*/

SELECT
    JOB AS 직급, COUNT(*) AS 사원수
FROM
    EMP
WHERE HIREDATE BETWEEN '1981/01/01' AND ' 1982/01/01'
GROUP BY
    JOB
;
SELECT JOB AS 직책 , COUNT(*) AS 사원수
FROM EMP
GROUP BY
    JOB ,TO_CHAR(HIREDATE,'YY')
HAVING 
    TO_CHAR(HIREDATE,'YY')=81  

;

----------------------------------------------------------------

/*
    HAVING
    ==> GROUP BY 절로 그룹화한 경우 계산된 그룹중에서
        조회결과에 적용될 그룹을 지정하는 조건식
        
        **
        참고 ]
            WHERE 조건은 계산에 포함'될' 데이터를 선택하는 조건
            HAVING 조건은 계산을 끝낸 후 조회 결과를 보여줄지 말지 결정하는 조건절
*/

SELECT 
    JOB AS 직급, COUNT(*) AS 직원수
FROM
    EMP
WHERE 
    DEPTNO = 10
GROUP BY
    JOB
;
-- 부서별로 평균 급여를 계산하세요.
-- 단, 각 부서의 평균 급여가 2000이상인 부서만 조회하세요
SELECT
    DEPTNO 부서번호, ROUND(AVG(SAL),2) AS 부서평균급여
FROM
    EMP
GROUP BY
    DEPTNO
HAVING
    AVG(SAL) >=2000
;

-- 직급별로 사원수를 조회하세요.
-- 단, 사원수가 1명인 직급은 제외하고 조회하세요

SELECT JOB AS 직급, COUNT(*) AS 사원수
FROM  EMP
GROUP BY JOB
HAVING COUNT(*) != 1
    
;
---------------------------------------------------------------------------------
/*
    7. 사원 이름의 길이가 4, 5글자인 사원의 수를 부서별로 조회하세요
        단, 사원수가 한사람 미만인 부서는 출력에서 제외하고출려
*/

SELECT DEPTNO, COUNT(*) AS 사원수
FROM EMP
WHERE LENGTH(ENAME) IN (4,5)
GROUP BY DEPTNO
HAVING COUNT(*)>=1
;
SELECT DEPTNO, COUNT(*) AS 사원수
FROM EMP
WHERE
    LENGTH(ENAME) IN (4,5)
GROUP BY 
    DEPTNO
HAVING 
    DEPTNO != 1

;

/*
    8. 81년도에 입사한 사람의 전체 급여를 직급별로 조회하세요.
        단, 직급별 평균급여가 100미만인 직급은 조회해서 제외하세요
*/ -- 81년도의 사람 모두 꺼내고 그룹핑
SELECT
    JOB AS 직급, SUM(SAL)AS 전체급여 , AVG(SAL) AS 평균
FROM
    EMP
WHERE
    TO_CHAR(HIREDATE,'YY')='81'
GROUP BY
    JOB
HAVING
    AVG(SAL) >= 1000
;
SELECT JOB, AVG(SAL), SUM(SAL)
FROM EMP
GROUP BY
    JOB,TO_CHAR(HIREDATE,'YY')
HAVING
    TO_CHAR(HIREDATE, 'YY')= '81'

;


/*
    9. 81년도에 입사한 사람의 총 급여를 사원의 이름 문자수별로 그룹화하세요
        단, 총 급여가 2000미만인 경우는 제외하고
        총 급여가 높은 순서에서 낮은 순서로 내림차순으로 정렬해서 조회하세요
*/
SELECT LENGTH(ENAME), SUM(SAL) AS 전체급여, COUNT(*) AS 사원수
FROM EMP
WHERE TO_CHAR(HIREDATE,'YY')='81'
GROUP BY
    LENGTH(ENAME)
HAVING SUM(SAL) > 2000
ORDER BY
    SUM(SAL) DESC
;


SELECT 
   LENGTH(ENAME),  SUM(SAL) AS 전체급여, COUNT(*) AS 사원수
FROM
    EMP
GROUP BY
    LENGTH(ENAME),TO_CHAR(HIREDATE, 'YY')
HAVING
    SUM(SAL) >2000
    AND TO_CHAR(HIREDATE, 'YY') =81

;
/*
    10. 사원의 이름문자수가 4,5인 사원의 부서별 사원수를 조회하세요.
        단, 사원수가 0인 경우는 제외하고 부서번호 오름차순으로 정렬하세요
*/
SELECT
    DEPTNO AS 부서번호, COUNT(*) AS 사원수
FROM
    EMP
WHERE
    LENGTH(ENAME) IN (4,5)
GROUP BY
    DEPTNO
HAVING
    COUNT(*)<>0
;

/*
    EXTRA ]
        부서별로 급여를 조회하는데
            10번부서는 평균급여를 조회하고
                20번부서는 급여합계를 조외하고
                    30번 부서는 부서 최고급여를 조회해라
*/

---------------------------------------------------------------------------
/*
    서브질의
    ==> 질의명령 안에 다시 질의 명령이 포함된 것을 서브질의(서브쿼리)라 한다.
    참고 ]
        서브질의중 FROM절에 위치하는 서브질의를
            인라인뷰(INLINE VIEW)
        라고 부른다
        이때 이 서브질의는 질의의 결과를 테이블로 사용하게된다
*/

--'SMITH' 사원의 소속 부서의 사원들의 정보를 조회하세요

SELECT
    EMPNO, ENAME, HIREDATE, DEPTNO
FROM
    EMP
WHERE
    DEPTNO =( SELECT
                DEPTNO       
                FROM 
                    EMP
                WHERE
                    ENAME = 'SMITH')
                    ;
                    
                    

SELECT
    DNO, MAX, MIN, AVG,CNT
FROM(

        SELECT
            
            DEPTNO DNO, MAX(SAL)AS MAX, MIN(SAL)AS MIN, AVG(SAL)AS AVG ,COUNT(*) AS CNT
        FROM
            EMP
        GROUP BY
            DEPTNO
            
    )
WHERE
   MAX = (
            SELECT
                MAX(SAL)   
            FROM EMP
        )
;
----------------------------------------------------------------------------
/*
    서브질의의 결과에 따른 사용법
    
    ***
    1. 서브질의의 조회결과가 오직 한개의 데이터인 경우
        ==>하나의 데이터로 보고 데이터를 사용할 수 있는 경우에는 모두 사용한다.
        
        1) SELECT 출력에 사용할 수 있다.
            이때 서브질의의 조회결과는 반드시 단일행 단일필드로 조회되어야 된다.
            
        2) 조건절에 사용할 수 있다. 
*/

-- 10번 부서 사원의 정보를 조회하는데
-- 사원번호, 사원이름, 급여, 부서번호, 부서 최고급여를 조회하세요
                                 -- 최고급여는 그룹핑 해야하는 함수라 따로 써야한다.
                                 

SELECT
    EMPNO, ENAME, SAL, DEPTNO,
    (
        SELECT
            MAX(SAL)        --최고급여를꺼내옴
        FROM
            EMP
        WHERE
            DEPTNO IN(  --스미스사원의 부서를 꺼내옴
                        SELECT
                            DEPTNO
                        FROM
                            EMP
                        WHERE
                            DEPTNO=20
                             
                             )
                      
    )AS 최고급여
FROM 
    EMP
    
WHERE
   DEPTNO=20
    
;



SELECT
    EMPNO, ENAME, 100*3
FROM
    EMP
;


/*
    2. 서브질의의 결과가 두행 이상 나오는 경우
            ==> 이 경우는 조건절에서만 사용 가능하다.
                이때, IN, ANY, ALL, EXIST 연산자를 사용해서 조건절에서 처리한다.
                
        참고 ]
            IN
                여러개의 데이터중 한개가 일치하면 되는 경우
                
            ANY
                여러개의 데이터중 한개만 맞으면 되는 경우
            
            ALL
                여러개의 데이터중 모두 맞아야 되는 경우
            EXIST
                여러개의 데이터중 하나만 맞으면 되는 경우
                비교대상이 없이 사용한다.
                서브질의의 결과가 있느냐 없느냐로 판단하는 연산자
*/

-- 직급이 'MANAGER'인 사원과 같은 부서에 속한 사원의 정보를 조회하세요

--직급이 'MANAGER'인 사원의 소속부서 조회

SELECT
    EMPNO, ENAME, DEPTNO, JOB
FROM
    EMP
WHERE
    DEPTNO IN(
        SELECT
            DEPTNO
        FROM 
            EMP
        WHERE
            JOB = 'CLERK'
            AND ENAME<>'JAMES')
;


-- 사원의 정보를 조회하는데 ,
-- 모든 부서의 평균급여보다 많이 받는 사원의 정보를 조회하세요

SELECT
*
FROM
    EMP
WHERE
/*
 SAL> ALL(
            SELECT
                AVG(SAL)
            FROM
                EMP
            GROUP BY
                DEPTNO
        ) -- >(???,???,???)
*/
    SAL > ALL(
                SELECT 
                MAX(AVG)
                FROM(
                     SELECT
                        AVG(SAL) AS AVG
                     FROM
                         EMP
                     GROUP BY
                        DEPTNO
                )
                
            );

-- 각 부서의 평균급여를 하나라도 많이 받는 사원의 정보를 조회하세요.



-- ALL

SELECT
    *
FROM
    EMP
WHERE
    EXISTS( --비교대상 없이 사용한다.
            SELECT
                *
                
            FROM
                EMP
            WHERE
                DEPTNO <> 40
            )
            
;

---------------------------------------------------------------------------

UPDATE
    EMP
SET
    SAL = (SELECT SAL FROM EMP WHERE ENAME = 'KING')
WHERE
    ENAME = 'SMITH'
    --SMITH 사원이 받는 급여를 KING사원이 받는 급여로다가   
;

ROLLBACK;