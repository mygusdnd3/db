-- day03

/* 
    사원 이름, 급여, 커미션을 조회하세요.
    단 급여는 ##1,###의 형식으로 조회되게 하세요.
    
    참고 ] 
        TO_CHAR(숫자형식)
        
        형식문자
            0 - 무효숫자를 표현
            9 - 무효숫자 표현안함
            , - 자릿수
            . - 소숫점
        사원 이름, 급여, 커미션을 조회하세요.
    단 급여는 ##1,###의 형식으로 조회되게 하세요.
*/        
SELECT TO_CHAR(456789,'000,000,000') NO1, TO_CHAR(456789,'999,999,999.99')NO2
  FROM DUAL;
  
SELECT ENAME AS 사원이름
     , SUBSTR(TO_CHAR(SAL,'000,000'),-5) S
     --, LPAD(SAL,8,'#')||SUBSTR(TO_CHAR(SAL,'000,000'),-5) 급여, COMM 커미션
     , LPAD(SUBSTR(TO_CHAR(SAL,'000,000'),-5,-5),7,'#') 급여, COMM 커미션
FROM EMP;

--이름의 세번째 문자만 출력하고 나머지 문자는 *로 처리하세요
SELECT  RPAD(LPAD(SUBSTR(ENAME,3,1),3,'*'),LENGTH(ENAME),'*')
FROM EMP
;
SELECT RPAD(LPAD(SUBSTR(ENAME,3,1),3,'*'),LENGTH(ENAME),'*') FROM EMP;

SELECT EMPNO 
     , RPAD(  -- 전체 길이만큼 만들어주고 채운문자는 오른쪽에 *로 채워준다.
       LPAD(--꺼낸 문자의 왼쪽에 *을 채워준다)
       SUBSTR(ENAME,3,1),3,'*') --세번째문자만꺼낸다 
     , LENGTH(ENAME),'*')  이름
  FROM EMP;

SELECT LPAD('*',2,'*')||SUBSTR(ENAME,3,1)||RPAD('*',LENGTH(ENAME)-2,'*') A , ENAME
  FROM EMP;
  
/*
    세번째 날
    날짜함수
    
        **
        참고 ]
            SYSDATE - 시스템의 현재 날짜/ 시간을 알려주는 예약아
        참고 ]
            TO_CHAR(날짜데이터,형식문자) --날짜데이터를 문자열로 변환시켜주는 함수
            
            형식문자
            yyyy
            MM
            dd
            MON
            DAY
            
            AM|PM
            HH|HH12 -- 12시간으로 표현
            HH24    -- 24시간으로 표현
            mi      -- 분(0~59분)
            ss      -- 초(0~59초)
        참고]
            TO_DATE(날짜형식 문자열, 형식문자열)    --> 문자데이터를 날짜데이터로 변환해주는함수
        주의사항 ]
            날짜 데이터를 만들때 시간을 정하지 않으면 0시 0분 0초로 셋팅이 된다.
------------------------------------------------------------------------------------
    참고 ]
        날짜 - 날짜의 연산식을 허락한다.
        날짜 연번끼리 - 연산을한다.
    참고 ]
        오라클에서 날짜를 기억하는 방법
        1970년 1월 1일 0시 0분 0초에서
        지정한 날짜까지의 날짜연번을 이용해서 기억한다.
        
        날짜 연벼이란
        날수.시간 의 형태로 숫자로 표현된 것.
    
    참고 ] 
        날짜 - 날짜는 허락하지만 -만쓴다
        날짜 +(*,/)날짜는 하락하지 않는다.
        
    참고 ]
        날짜 + 숫자의 연산은 허락한다.
        ==> 날짜 연번은 숫자이므로
            결국 날짜에서 원하는 숫자만큼 이동된 날짜를 표시한다.
--------------------------------------------------------------------------

*/
SELECT SYSDATE AS 오늘날짜 FROM  DUAL;--SQLDEVELOPER가 표시형식이 날짜라 날짜만나옴
SELECT TO_CHAR(SYSDATE, 'yyyy/MM/dd DAY HH:mi:ss') AS 오늘날짜 FROM  DUAL;--형식을 수정해주면 나옴

SELECT TO_DATE('2020/08/25 09:30:00', 'YYYY/MM/DD HH24:MI:SS') 오늘날짜 FROM DUAL;

SELECT
    TO_CHAR(TO_DATE('2020/08/25','YYYY/MM/DD'), 'YYYY/MM/DD HH24:MI:SS') 오늘시간
FROM
    DUAL; -- 시간을 셋팅하지않으면 0시 0분으로 셋팅된다.


-- 사원의 이름, 사원의 근무일수를 계산해서 출력하세요

SELECT ENAME AS 사원이름 ,HIREDATE AS 입사일
     , CONCAT(FLOOR(SYSDATE - HIREDATE),' 일') AS 근무일수
          -- 이 경우 (FLOOR(SYSDATE - HIREDATE)는 숫자데이터이고 형변환함수(TO_CHAR())가 자동 호출되어서 작동된다
  FROM EMP
;

-- 문제 ] 개강일부터 오늘까지 날수를 조회하세요
SELECT FLOOR(SYSDATE - TO_DATE('2020/07/16', 'YYYY/MM/DD')) 출석날짜 FROM DUAL;

SELECT 
    TO_CHAR(SYSDATE+7,'YYYY/MM/DD HH24:MI:SS') 일주일뒤날짜
FROM
    DUAL
;

-----------------------------------------------------------------------------
/*
    날짜함수
        1. ADD_MONTHS
            ==> 현재 날짜에 지정한 달 수를 더하거나 뺀 날짜를 알려준다.
            형식 ]
                ADD_MONTH(날짜데이터, 개월수)
                참고 ] 
                    더할 개월수가 음수이면 뺀 날짜를 알려준다.
                    


*/

--오늘 날짜에서 3개월 후의 날짜를 조회하세요
SELECT
    ADD_MONTHS(SYSDATE,3)
FROM 
    DUAL;
    
-- 사원의 이름, 입사일에서 2개월 이전은 몇일인가

SELECT ENAME AS 사원이름
     , HIREDATE AS 고용일
     , ADD_MONTHS(HIREDATE,-2) 고용일2개월전
  FROM EMP
;
/*
    2. MONTHS_BETWEEN
        ==> 두 날짜 사이의 간격을 월 단위로 알려주는 함수
        
        형식 ]
            MONTHS_BETWEEN(날짜, 날짜)
*/
-- 자신이 태어난 날부터 몇개월 됬는지 조회하세요
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('1989/02/18','YYYY/MM/DD'))) 개월수
  FROM DUAL
;

--문제 ] 사원의 입사일은 몇개월 전인지 조회하세요
SELECT ENAME, CONCAT(FLOOR(MONTHS_BETWEEN(SYSDATE, HIREDATE)),' 개월 재직중') AS 재직월수
  FROM EMP
;

/*
    3. LAST_DAY
        ==> 지정한 날짜가 포함된 월의 가장 마짐가 날짜를 알려주는 함수
        형식 ]
            LAST_DAY(날짜)
*/
-- 올 2월의 마지막 날짜를 조회하세요
SELECT LAST_DAY(TO_DATE('2020/02', 'YYYY/MM')) AS "2월 마지막 날" FROM DUAL;

-- 사원의 이름, 급여, 첫 급여일을 조회하세요
--급여일은 해당 월의 마지막 날로 한다.
SELECT ENAME, SAL, LAST_DAY(HIREDATE) AS "첫 급여일" FROM EMP;

/*
    4. NEXT_DAY
        ==> 지정한 날 이후에 가장 처음 만나는 지정한 요일이 몇일인지를 알려주는 함수
        형식 ]
            NEXT_DAY(날짜,'요일')
        참고 ]
            요일 지정하는 방법
                1. 우리는 한글환경으로 세팅이 된 오라클을 사용ㅎ고 있으므로
                    '월,'화'...
                    '월요일','화요일'
                2. 영문권에서는
                    'MON','TUES'...
                    'MONDAY',...
*/

-- 다움주 토요일은 몇일인지 조회하세요
SELECT NEXT_DAY(TO_DATE('2020/09/01','YYYY/MM/DD'),'토') AS "다음주 토요일"
  FROM EMP
;
SELECT SUBSTR(NEXT_DAY(SYSDATE,'토'),-2) AS "이번주 토요일"
  FROM DUAL;

SELECT NEXT_DAY(NEXT_DAY(SYSDATE,'월'),'토') AS "다음주 토요일" FROM DUAL;
-- 다가오는 월요일 계산(다음주가됨)그주의토요일..

/*
    ROUND
    ==> 날짜를 지정한 부분에서 반올림 하느 ㄴ함수
        지정한 부분이란?
            년, 월,일,....
    형식 ]
        ROUND(날짜, '기준')
            기준
                YEAR
                MONTH
                DD
                DAY
                HH
                ...
        참고 ]
            년도 기준 반올림은
            <<== 6월 이전은 현재년도, 7월이후는 다음해.
            
            월기준 반올림은
            <<== 15이전은 현재달, 16 이후는 다음달
            
            DAY - 요일 기준
            DD  - 날짜기준
*/
-- 오늘 날짜를 년도를 기준으로 반올림해서 조회하세요.
SELECT ROUND(SYSDATE,'YEAR') AS 년반올림
     , ROUND(SYSDATE,'MONTH') AS 월반올림
     , ROUND(SYSDATE,'DAY') AS 일반올림 --이번주 첫재날로 표기됨
  FROM DUAL
;

SELECT TO_CHAR(ROUND(SYSDATE,'MI'),'YYYY/MM/DD HH24:MI:SS') FROM DUAL;
/*
    문제 ] 사원정보를 조회하세요.
        1필드 사원정보는
            사원이름 : xxx, 사원급여 : XXXX
        의 형태로 조회되게 하세요.
        
        급여는 7자리로 표현하고 
        뒤의 두자리만 표시하고 나머지는 *로 표현한다.
        */
---------------------------------------------------------------------------
SELECT INSTR((TO_CHAR(SAL,'000,000')),',',-1)
  FROM EMP
;
SELECT TRANSLATE(TO_CHAR(SAL,'000,000'),',','a')

  FROM EMP
;
SELECT CONCAT(CONCAT('사원이름 : ', ENAME), CONCAT(' 사원급여 : ',LPAD(SUBSTR(TO_CHAR(SAL),-2),LENGTH(TO_CHAR(SAL,'000,000')),'*'))) AS 사원정보 

  FROM EMP
;

SELECT 
CONCAT(
    CONCAT('사원이름 :',ENAME),
    CONCAT(' 급여 : ',LPAD(
    CONCAT(',',SUBSTR(TO_CHAR(SAL,'000,000'), -3)),LENGTH(TO_CHAR(SAL,'000,000')),'*')
    ))
FROM EMP
;
/*
    변환함수
    ==> 함수는 데이터 형태에 따라서 사용하는 함수가 달라진다.
        그런데 만약 사용하려는 함수에 필요한 데이터가 아닌 경우는 어떻게??
        이럴때 사용하는 것이 형변환 함수이다.
        ==> 데이터의 형태를 바꿔서 특정 함수에 사용할 수 있도록 만들어 주는 함수
        
        1. TO_CHAR
            ==> 날짜나 숫자를 ㅁ누자 데이터로 변환시켜주는 함수
            
            형식 1]
            
            TO_CHAR(날짜 혹은 숫자 데이터)
            
            형식 2]
            
            TO_CHAR(날짜 혹은 숫자, '형식')
            ==> 변환할 때 문자열의 형식을 만들어서 변환시키는 방법
            TO_CHAR(SAL,'$999,999,999')
*/
-- 사원중 5월에 입사한 사원의 정보를 조회하세요 단, 형변환 함수를 사용해서
SELECT ENAME, HIREDATE, TO_CHAR(HIREDATE) 입사날짜

FROM EMP

WHERE
    TO_CHAR(HIREDATE) LIKE '%/05/%'
;
-- 급여가 100~999사이인 사원의 이름 급여를 조회하세요

SELECT
    ENAME, SAL
FROM
EMP
WHERE
    --TO_CHAR(SAL) LIKE '___'
    LENGTH(TO_CHAR(SAL))=3;
    
-- 사원의 이름 급여를 조회하세요, 단 급여는 세자리마다,로 구분해주고앞에는 $를 붙여주세요
SELECT ENAME AS 사원이름,TO_CHAR(SAL,'$000,000,000'), TO_CHAR(SAL,'$999,999,999') AS 사원급여
  FROM EMP
;

-- 사원의 이름, 입사일, 입사요일을 조회하세요.
SELECT ENAME AS 사원이름, HIREDATE AS 입사일, TO_CHAR(HIREDATE,'DAY')AS 입사요일
  FROM EMP
;

SELECT ENAME AS 사원이름
     , TO_CHAR(HIREDATE, 'YYYY-mm-dd') AS 입사일
     , TO_CHAR(HIREDATE, 'YYYY.mm.dd') AS 입사일
     , TO_CHAR(HIREDATE, 'YYYY/mm/dd') AS 입사일
     , TO_CHAR(HIREDATE, 'YYYYmmdd') AS 입사일
FROM EMP
;
/*
    2. TO_DATE
        ==> 문자로 된 내용을 날짜 데이터로 변환해 주는 함수
        
        형식 1]
            TO_DATE(날짜형식 문자)
        형식 2]
            TO_DATE(날짜형식 문자, '형식)
            ==> 문자데이터가 오라클이 지장하는 형식의 날짜처럼
                되어있지 않은 경우 사용하는 방법
            예]
                '08/25/20'처럼 월/일/년 의 순서로 문자가 만들어진 경우
                
*/            


-- 당신이 태어난지 몇일 째 인지 조회하세요.
SELECT FLOOR(SYSDATE - TO_DATE('1989/02/18'))FROM DUAL;

SELECT FLOOR(TO_DATE(SYSDATE,'MM/DD/YY')-TO_DATE('02/18/89','mm/dd/yy')) FROM DUAL;

/*
    3. TO_NUMBER
        ==> 문자로된 내용을 숫자 데이터로 변환시켜주는 함수
            <<--문자데이터는 +,- 연산이 되지 않는다.
            
        형식 1 ]
            TO_NUMBER(문자데이터)
        형식 2]
            TO_NUMBER(문자데이터, 형식)
*/
--'123' 과 '789'를 더한 값을 조회하세요.
SELECT TO_NUMBER('123')+TO_NUMBER('789')FROM DUAL;

-- '123,456' - '5,678'

SELECT TO_NUMBER('123,456','999,999') - TO_NUMBER('5,678','9,999') FROM DUAL;

---------------------------------------------------------

/*
    기타함수
    
    1. NVL
        ==> NULL 데이터는 모든 연산(함수)에서 제외가된다.
            이 문제를 해결하기 위한 방법으로 제공되는 함수
        의미]
            NULL 데이터면 강제로 지정한 데이터로 교체해서
            연산, 함수에 적용을 시켜주세요
        
        형식 ]
            NVL(데이터, 바뀔내용)
            
        ***
        주의사항 ]
            지정한 데이터와 바뀔 내용은 데이터의 타입이 같아야 한다.
    2. NVL2
        형식 ]
            NVL2(필드이름, 처리내용1, 처리내용2)
        의미 ]
            필드의 내용이 NULL이면 처리내용2를 실행하고
            내용이 있으면(NULL이 아니면)처리내용1을 실행하세요.
            
    3. NULLIF
        형식]
            NULLIF(데이터1, 데이터2)
            
        의미]
            두 데이터가 같으면 NULL로 처리하고 
            다르면 데이터1으로 처리하세요
            
    4. COALESCE
        형식]
            COALESCE(데이터1, 데이터2.....)
        의미]
            여러개의 데이터중 가장 첫번째 나오는 NULL이 아닌 데이터를 출력하라
             COALESCE(COMM, SAL, 0) 커미션이 널이면 SAL을 출력해라 0으로?
*/

SELECT
   -- ENAME, COMM, NVL(COMM+100,'커미션없음') --------X 타입이 같아야한다(구성((COMM에 100을 더해줄건데, 없으면할것)
FROM EMP
;

SELECT
    ENAME, COMM, NVL2(COMM, COMM+100, 0) AS 변경커미션
FROM
    EMP
;
SELECT 
    NULLIF('A','A') AS 문자1, NULLIF('A','B') AS 문자2 
FROM 
    DUAL
;

--CCOALESCE ] 커미션을 조회하는데 만약 커미션이 NULL이면 급열르 대신 출력하도록 하자
SELECT
    ENAME,SAL ,COMM,COALESCE(COMM, SAL,0) 봉급
FROM 
    EMP
;
---------------------------------------------------------------------------
/*
    문제 1]
        COMM이 존재하면 현재 급여의 10%를 인상한금액 + 커미션을 출력하고
        커미션이 존재하지 않으면 현재 급여의 5%를 인상한금액 +100을 출려하시오
*/
SELECT ENAME, NVL(COMM*1.10,(SAL*1.05)+100)AS 인상커미션, SAL AS 연봉, COMM AS 커미션 FROM EMP;
SELECT ENAME, ROUND(NVL2(COMM, COMM*1.10,(SAL*1.05)+100)) AS 인상커미션 FROM EMP;
SELECT ENAME, COMM, COALESCE(COMM*1.10,(SAL*1.05)+100,0) AS 인상커미션 FROM EMP;
SELECT ENAME, COMM, COALESCE(COMM*1.10,SAL,(SAL*1.05)+100) AS 인상커미션 FROM EMP;

/*
    문제 2]
        COMM에 50%를 추가해서 지급하고자 한다.
        만약 커미션이 존재하지 않으면
        급여를 이용해서 10%를 지급하세요
*/

SELECT ENAME, SAL, COMM,NVL(COMM*1.50,SAL*1.10) AS 커미션 FROM EMP;
SELECT ENAME, SAL, COMM, NVL2(COMM,COMM*1.50,(SAL*1.10)) AS 인상커미션 FROM EMP;
SELECT ENAME, SAL, COMM, COALESCE(COMM*1.50,SAL*1.10) AS 증감커미션 FROM EMP;

SELECT COALESCE('HELLO','HI','HESASIBURI')AS NULLTEST1
     , COALESCE(NULL,'HI','HESASIBURI')AS NULLTEST2
     , COALESCE('NINANO',NULL,'HESASIBURI')AS NULLTEST3
     , COALESCE(NULL,NULL,'HESASIBURI')AS NULLTEST4
     , COALESCE(NULL,NULL,NULL,'HESASIBURI')AS NULLTEST5
     , COALESCE('HELL',NULL,NULL,'HESASIBURI')AS NULLTEST6
     , COALESCE(NULL,NULL,NULL,3) AS NULLTEST7
      , COALESCE(NULL,NULL,NULL,NULL) AS NULLTEST8
  FROM DUAL
;

---------------------------------------------------------------------------
/*
    조건 처리 함수
        1. DECODE
            형식 ]
                DECODE(데이터, 데이터1, 처리내용1,
                              데이터2, 처리내용2,
                              데이터3, 처리내용3,
                              ...
                              기타처리내용)
            의미 ]
                데이터가 
                    데이터1과 같으면 처리내용 1을 실행하고,
                    데이터2과 같으면 처리내용 2을 실행하고,
                    데이터3과 같으면 처리내용 3을 실행하고,
                    ..
                    그 이외의 값이면 기타 처리내용을 실행하세요

*/

/*
    부서번호가 10번이면 영업부
             20번이면 총무부
             30번이면 전산부
             그 이외의 값이면 인턴
             조회되게 하세요.
             
*/
SELECT
    EMPNO AS 사원번호, ENAME AS 사원이름, DEPTNO 부서번호, 
    DECODE(DEPTNO, 10, '영업부',
                   20, '총무부',
                   30, '전산부',
                   '인턴쉽'
    ) AS 부서이름
FROM
    EMP
;

/*
    2. CASE
        형식 1]
            CASE    WHEN 조건식1 THEN 내용1
                    WHEN 조건식2 THEN 내용2
                    WHEN 조건식3 THEN 내용3
                    ...
                    ELSE 내용N
            END
            (반드시써줘야한다END)
        의미 ]
            조건식 1이 참이면 내용1을 실행
            조건식 2가 참이면 내용2를 실행
            조건식 3이 참이면 내용3을 실행
            ...
            그 이외의 내용은 내용N을 실행하세요
            
        형식 2]
            CASE 필드이름 WHEN 값1 THEN 실행1
                         WHEN 값2 THEN 실행2
                         WHEN 값3 THEN 실행3
                         ...
                        ELSE 실행 n
            END
            
        의미 [ 
            DECODE와 비슷한 의미
            묵시적으로 = 라는 조건만 사용하는 명령

*/

SELECT 
    ENAME AS 사원이름, DEPTNO AS 부섭너호,
    CASE WHEN DEPTNO = 10 THEN '영업부'
         WHEN DEPTNO = 20 THEN '총무부'
         WHEN DEPTNO = 30 THEN '전산부'
         ELSE '인턴'
    END AS 부서이름
    
FROM
    EMP
;
SELECT 
    ENAME AS 사원이름, DEPTNO AS 부섭너호,
    CASE DEPTNO WHEN 10 THEN '영업부'
                WHEN  20 THEN '총무부'
                WHEN  30 THEN '전산부'
                ELSE '인턴'
    END AS 부서이름
    
FROM
    EMP
;