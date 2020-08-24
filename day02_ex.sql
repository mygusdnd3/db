-- 숫자함수--

-- 1. 사원의 이름, 직급, 입사일, 급여를 조회하세요
--   급여가 많은 사람부터 조회되게 하세요.
SELECT ename 이름, job 직급, hiredate 입사일, sal 급여
FROM emp
ORDER BY
    sal DESC;

/*
    2. 사원의 이름, 직급, 입사일, 부서번호를 조회하세요
        단, 부서번호 순으로 정렬해서 조회하고
        같은 부서면 입사일 순서대로 조회되게 하세요
*/
SELECT ename, job, hiredate, deptno
FROM 
emp
    
ORDER BY
    deptno DESC , hiredate ASC;

/*
    3. 입사월이 5월인 사원의 이름, 직급, 입사일을 조회하세요
        단, 입사일이 빠른 사람부터 조회되게 하세요
*/
SELECT ename 사원이름, job 직급, hiredate 입사일
FROM emp
WHERE hiredate LIKE '__/05/__'--??
ORDER BY hiredate DESC;



/*
    4. 커미션을 27% 인상하여
        사원의 이름, 급여, 커미션, 인상 커미션을 조회하세요.
        단, 커미션이 없는 사람은 100으로 하고 계산하기로 한다.
        단, 반올림해서 소수 2째 자리까지 표현하고 3째자리에서 반올림한다.
        -ROUND(NVL(comm+100,comm*1.27),3) 인상커미션
*/
SELECT ename, sal, comm, ROUND((NVL(comm,100)*1.2777),2)
FROM emp;

/*
    5. 사원의 이름, 급여, 커미션, 급여합계를 조회하세요.
        급여합계는 커미션 + 급여로 계산하고
        커미션이 없는 사원은 0을 커미션으로 받는것으로 한다.
        단, 소수 첫째자리에서 버림을 해서 조회
*/
SELECT ename , sal, comm, ROUND(SUM(sal+NVL(comm,0)),1)
FROM emp;


/*
    6. 급여가 짝수인 사람만
        사원이름, 급여를 조회하세요
        단, 단일행 함수를 이용해서 처리하세요
*/
SELECT ename, sal 
FROM 
    emp
WHERE
    MOD(sal,2) = 0;

/*
    7. 급여가 100으로 나눠 떨어지는 사원의 
        사원번호, 사원이름, 급여를 조회하세요.
        단, 단일행 함수를 이용해서 처리하세요
*/

SELECT empno AS 사원번호, ename AS 사원이름 , sal AS 급여
FROM emp 
WHERE MOD(sal, 100)=0;

----------------------------------------------------------------

--문자열 처리 함수--
/*
    8. 사원의 이름이 5글자 이하인 사원의
    사원번호, 사원이름, 부서번호를 조회하세요
    
*/
SELECT empno
     , ename
     , deptno
  FROM emp
 WHERE LENGTH(ename)<5
;

/*
    9. 사원이름이 'N'으로 끝나는 사원의
        사원번호, 사원이름을 조회하세요
*/
SELECT empno
     , ename
  FROM emp
 WHERE ename LIKE '%N';

/*
    10. 사원이름에 'A' 가 들어있는 사원의 
        사원번호, 사원이름, 사원급여를 조회하세요
*/
SELECT 
    empno, ename, sal
FROM 
    emp
WHERE 
    ENAME LIKE '%A%';

/*
    11. 사원들의
        사원번호, 이름, 을 조회하세요
        사원이름은 마지막 두글자는 표현하고
        나머지 문자는 *로 교체해서 조회하세요
        
        예 ]
            SMITH
            ==>***TH
*/
SELECT empno
     , LPAD('',(LENGTH(ENAME)-2),'*')||SUBSTR(ename,-2)
FROM EMP;


/*
    12. 사원의 사원번호, 사원이름을 조회하세요.
        사원 이름은 첫글자와 마지막 글자는 표현하고
        나머지는 문자로 * 로 교체해서 조회하세요.
*/
SELECT EMPNO
      ,SUBSTR(ENAME,1)||RPAD('',(LENGTH(ENAME)-2,'*'))||SUBSTR(ENAME,-1)
FROM EMP;

/*
    13. 사원의 사원이름, 급여를 조회하세요
        급여는 첫자리만 표현하고 나머지는 #으로 대체해서 처리하세요
*/
SELECT EMPNO
     , SUBSTR(SAL,1)||RPAD('',(LENGTH(ENAME),'*'))
FROM EMP;
