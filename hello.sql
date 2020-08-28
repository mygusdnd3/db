/*
hello 계정에서 작업하세요.
    scott계정이 가지고 있는 emp, dept 테이블을 데이터와 함께 복사해서
    semp, sdept 를 만들고
*/    

CREATE TABLE SEMP
AS 
SELECT *
FROM SCOTT.EMP;

CREATE TABLE SDEPT
AS 
SELECT *
FROM SCOTT.DEPT;

SELECT * FROM SEMP;
UPDATE
    SEMP
SET
    SAL = SAL * 1.10;

--   2. 급여를 10% 더 인상하고
        --입사일을 오늘 날짜로 변경하세요.
UPDATE
    SEMP
SET
    SAL = SAL*1.10
    ,HIREDATE = SYSDATE;
SELECT * FROM SEMP;

UPDATE
    SEMP
SET
    JOB = 'SALES'
WHERE
    JOB = 'SALESMAN'
;
SELECT * FROM SEMP;

UPDATE
   SEMP
SET
    DEPTNO = NULL
WHERE
    DEPTNO = 10
;
SELECT * FROM SEMP;