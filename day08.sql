/*
    뷰 (view)
    ==> 질의 명령의 결과를 하나의 창문으로 바라볼 수 있는 창문을 의미한다.
    
        예 ]
            SELECT * FROM AVATAR;
            ==> 이 질의 명령을 실행하면 결과가 나오는데 이 결과중에 일부분만 볼수있는
                창문을 만들어서 사용 하는 것
                
            ==> 자주 사용하는 복잡한 질의 명령을 따로 저장해 놓고
                이 질의 명령의 결과를 손쉽게 처리할 수 있도록 하는 것.
                
            뷰의 종류
                1. 단순 뷰
                    ==> 하나의 테이블만 이용해서 만들어진 뷰
                        따라서 모든 DML 명령에 가능하다.
                        SELECT UPDATE DELET ....
                        
                        참고 ]***
                        단순 뷰라도 '그룹함수'(연동)로 만들어진 뷰는 SELECT 이외의 DML 명령은
                        사용이 불가하다.
                        
                2. 복합 뷰
                    ==> 두개 이상의 테이블을 이용해서(조인해서) 만들어진 뷰
                        **
                        SELECT만 가능하고 다른 DML 명령은 사용이 불가능하다.
-----------------------------------------------------------------------------  
 참고]
    원칙적으로 사용자 계정은 관리자가 허락한 일만 할 수 있다.
    즉, 관리자는 각각의 계정마다 그 계정의 권한에 따라서 사용할 수 있는 명령을 지정할 수 있다.
    
    현재 SCOTT 계정은 SELECT, UPDATE, DELETE, INSERT, CREAT TABLE
        SELECT ANY TABLE, ALTER TABLE, DROP TABLE,....
        등이 허락된 상태이다.
        
        문제는 뷰를 만드는 명령은 현재 SCOTT,HELLO 계정에 허락된 상태가 아니다.
        **
        따라서
        관리자 계정에서 특정 계정이 사용할 수 있는 명령의 권한을 부여해 줘야 한다.
        
        권한 부여 방법
            형식 ]
                GRANT 권한, 권한, ...TO 계정이름;  //기본형식
                
        --> SYSTEM 계정으로 접속해서
        
            GRANT CREATE VIEW TO HELLO
            GRANT CREATE VIEW TO SCOTT
            GRANT CREATE VIEW TO FREE
*/

SELECT ANO, ANAME FROM AVATAR WHERE GEN = 'M';

SELECT * FROM HELLO.AVATAR;

GRANT CREATE VIEW TO HELLO;
GRANT CREATE VIEW TO SCOTT;
GRANT CREATE VIEW TO FREE --FREE어딧니
;


/*
    뷰 만드는 방법
        형식 1]
         CREATE VIEW 뷰이름 
         AS 
            뷰에서 사용할 데이터를 가져올 질의명령
        ;
*/

-- SCOTT 계정의 EMP 테이블에서 사원번호, 사원이름, 급여만 보는 뷰를 만들어 보자.

CREATE VIEW esal
AS 
    SELECT
        EMPNO, ENAME,SAL
    FROM
        SCOTT.EMP
;

SELECT
    *
FROM
    ESAL
;
-- 사원들의 부서별 부서 최대급여, 부서 최소급여, 부서 평균급여, 부서 급여합계, 부서원수, 부서번호
-- 볼수있는 뷰를 만들어보자

CREATE VIEW DSAL
AS
    SELECT
        DEPTNO, MAX(SAL) max, MIN(SAL) min, AVG(SAL) avg, 
        SUM(sal) sum, COUNT(*) cnt
    FROM
        SCOTT.EMP
    GROUP BY
        DEPTNO
        ;
        
SELECT * FROM DSAL;
INSERT INTO
    ESAL
VALUES(9000,'DALO',20
);

CREATE TABLE EMP
AS
    SELECT
        *
    FROM
        SCOTT.EMP
;

DROP VIEW ESAL;

CREATE VIEW ESAL
AS
    SELECT
        EMPNO, ENAME, SAL
    FROM
        EMP
;

INSERT INTO ESAL
VALUES(8000,'DOOLY',50);

SELECT * FROM ESAL;
SELECT * FROM EMP;
ROLLBACK;

DROP VIEW DSAL;

CREATE VIEW DSAL
AS
    SELECT
        DEPTNO, MAX(SAL) max, MIN(SAL) min, AVG(SAL) avg, 
        SUM(sal) sum, COUNT(*) cnt
    FROM
        EMP
    GROUP BY
        DEPTNO
        ;
--SCOTT.DEPT 복사
CREATE TABLE DEPT
AS SELECT * FROM SCOTT.DEPT;

CREATE TABLE SALGRADE
AS SELECT * FROM SCOTT.SALGRADE;


-- EMP, DEPT 테이블을 사용해서
-- 사원번호, 사원이름, 급여, 부서번호, 부서이름, 부서위치를 볼수 있는 뷰를 만드세요
CREATE VIEW TEMP01
AS
    SELECT
        EMPNO, ENAME, SAL,E.DEPTNO,DNAME,LOC
    FROM
        EMP E , DEPT D
    WHERE
        E.DEPTNO = D.DEPTNO
    
;


--EMP, DEPT 테이블을 이용해서
-- 부서번호, 부서 최대급여, 부서 최소급여, 부서 급여 합계, 부서 평균급여,부서원수,부서이름,부서위치
-- 를 볼수 있는 뷰를 만든다.

SELECT 
    E.DEPTNO, MAX(SAL),MIN(SAL),AVG(SAL),SUM(SAL),COUNT(*),DNAME,LOC
FROM 
    EMP E, DEPT D
WHERE 
    E.DEPTNO = D.DEPTNO
GROUP BY
    DEPTNO
;  --안됨?
--인라인뷰를 넣어서해본다

CREATE VIEW DPTSAL
AS
SELECT 
    DEPTNO, MAX,MIN,AVG,SUM,CNT,DNAME,LOC
FROM 
    (
        SELECT
            DEPTNO DNO, MAX(SAL) MAX,MIN(SAL) MIN,AVG(SAL) AVG,SUM(SAL) SUM,COUNT(*) CNT
            FROM
                EMP
        GROUP BY
            DEPTNO
    )
            , DEPT D
WHERE 
    DNO = D.DEPTNO

;      

/*
    문제 1]
        EMP 테이블에 있는 사원중 부서번호가 10번인 사원들의 정보만 볼수있는
        뷰를 만드세요
*/
CREATE VIEW DNUM
AS
SELECT
*
FROM EMP
WHERE DEPTNO = 10
;
/*
    문제 2]
        사원중 이름이 4글자인 사원 정보만 볼수있는 뷰를 만드세요
*/
CREATE VIEW ENAM
AS
    SELECT *
    FROM EMP
    WHERE LENGTH(ENAME)=4
;
SELECT * FROM ENAM;

/*
    문제 3]
-- 뷰를 만들고 사용해서 사원중 부서 평균 급여보다 ㅁ낳이 받는 사원의 사원번호,
-- 사원이름, 부서번호 부서이름을 조회하세요
*/

    SELECT 
        deptno, MAX(sal) max, MIN(sal) min, AVG(SAL) avg, SUM(SAL)sum,count(*)cnt
    FROM
        emp
    GROUP BY
        deptno
        ;

--> 위의 결과를 뷰로 만들어 보자.
CREATE OR REPLACE VIEW DSAL
AS
  SELECT 
        deptno, MAX(sal) max, MIN(sal) min, AVG(SAL) avg, SUM(SAL)sum,count(*)cnt
    FROM
        emp
    GROUP BY
        deptno
  ;
  
SELECT 
    EMPNO, ENAME,E.DEPTNO, DNAME
FROM
    EMP E, DEPT D,DSAL DS
WHERE
  E.DEPTNO = DS.DEPTNO
  AND E.DEPTNO = D.DEPTNO
  AND SAL >AVG
  ;

  
SELECT EMPNO, ENAME, E.DEPTNO, DNAME ,SAL,(SELECT MAX(SAL)FROM EMP) MAXSAL,
        ROUND((SELECT AVG(SAL) FROM EMP)) AVG
    
FROM EMP E,DEPT D

WHERE
 E.DEPTNO = D.DEPTNO
 AND SAL = (SELECT MIN(SAL) FROM EMP)
;
--서브질의
SELECT EMPNO, ENAME, E.DEPTNO, DNAME ,SAL,(SELECT MAX(SAL)FROM EMP) MAXSAL,
        ROUND((SELECT AVG(SAL) FROM EMP)) AVG
    
FROM EMP E,DEPT D
    ,(
        SELECT
            DEPTNO DNO,MIN(SAL)MIN
        FROM
            EMP
        GROUP BY
            DEPTNO
    )
WHERE
    E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = DNO
    --여기까지가 조인조건
    AND SAL = MIN
;
--뷰로만들어보자
CREATE OR REPLACE VIEW VIEW04
AS
      SELECT
            DEPTNO DNO,MIN(SAL)MIN
        FROM
            EMP
        GROUP BY
            DEPTNO
;

SELECT EMPNO, ENAME, E.DEPTNO, DNAME ,SAL

FROM EMP E,DEPT D, VIEW04
WHERE
    E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = DNO
    --여기까지가 조인조건
    AND SAL = MIN
;
-- 서브질의가 길어지면 가독성을 위해서 뷰를 사용하면 좋다.

--X
CREATE VIEW VIEW04
AS
SELECT EMPNO, ENAME, E.DEPTNO, DNAME
FROM EMP E , DEPT D
WHERE E.DEPTNO = D.DEPTNO
;

SELECT EMPNO
  
  
  
select
    *
from
    emp
where -- 한줄꺼내오면서 체크하는거..그룹바이져보다 먼저
    deptno =20
    and sal > max(sal) --맥스값은 다 꺼내온담에 해야한다
group by deptno




/*
    형식 2]
        DML 명령으로 데이터를 변경할 때
        변경된 데이터는 기본 테이블만 변경이 되므로
        뷰 입장에서보면 그 데이터를 실제로 사용할 수 없을수 있다.
        
        ==> 이런 문제를 해결하기 위한 방법
            자신이 사용할 수 없는 데이터는 수정이 불가능 하도록 할 수 있다.
            
        형식 ]
            CREATE VIEW 뷰이름
            AS 
                질의명령
            WITH CHECK OPTION;
*/
--20번 사원의 정보를 볼수있는 VIEW02를 만든다.

CREATE VIEW VIEW02
AS 
    SELECT
        *
    FROM 
        EMP
    WHERE
        DEPTNO = 20
;
UPDATE
    VIEW02
SET
    DEPTNO = 40
WHERE
    DEPTNO = 20
;--XX

DROP VIEW VIEW02;
CREATE VIEW VIEW02
AS 
    SELECT
        *
    FROM 
        EMP
    WHERE
        DEPTNO = 20
WITH CHECK OPTION
;
UPDATE
    VIEW02
SET
    DEPTNO = 40
WHERE
    DEPTNO = 20
;

-- 문제 3 ] 부서번호가 30번인 사원들의 사원이름, 직급,부서 번호를 볼수있는 뷰를 만드세요
--          단, 뷰의 데이터가 하나도 없어지지 않도록 수정할 수 없게 하세요
CREATE VIEW VIEW03
AS
SELECT
    ENAME,JOB,DEPTNO
FROM EMP
WHERE DEPTNO = 30
WITH CHECK OPTION
;
UPDATE VIEW03
SET DEPTNO = 40
WHERE DEPTNO = 30
;
SELECT * FROM VIEW03;
/*
    참고 ]
        테이블도 마찬가지지만 이미 존재하는 뷰 이름과 동일한 뷰이름으로는 뷰를 만들지 못한다.
        
        같은 이름의 뷰가 있어도 만들 수 있는 방법이 있긴한데,
        
            형식 ] 
                CREATE OR REPLACE VIEW 뷰이름
                AS
                    질의명령
                ;
*/
--문제 4 ] 부서번호가 10, 20번인 사원들의 사원이름, 직급, 부서번호를 볼수있는
-- view 03을 만드세요, 단 부서번호가 하나도 없어지지 않도록.
CREATE OR REPLACE VIEW VIEW03
AS
SELECT ename, job, deptno
FROM EMP
WHERE deptno IN (10,20) --between 10 and 20 // deptno =10 or deptno=20;
WITH CHECK OPTION
;
select * from view03;

/*
    뷰 삭제하기
        형식 ]
            drop view 뷰이름;
*/
DROP VIEW VIEW03;

select 
sal
from 
emp
group by deptno
having SAL>(select avg(sal)from emp)
;

CREATE VIEW VTABLE
AS
SELECT  EMPNO, ENAME, E.DEPTNO, DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;


CREATE VIEW ASAL
AS
SELECT
    DEPTNO, ROUND(AVG(SAL))
FROM EMP
GROUP BY DEPTNO
; 
  
CREATE VIEW TSAL
AS
SELECT DEPTNO,AVG(SAL)평균급여
FROM EMP
GROUP BY DEPTNO
;
SELECT * FROM TSAL;

--뷰를 만들고 사용해서 사원중 부서 평균 급여보다 ㅁ낳이 받는 사원의 사원번호,
-- 사원이름, 부서번호 부서이름을 조회하세요

SELECT
    DNAME
FROM 
    TSAL t
WHERE SAL > (SELECT AVG FROM TSAL)
    ;
    
-----------------------------------------------------------------------\
/*
    인라인 뷰(INLINE VIEW)
    ==> SELCT 질의 명령을 보내면 원하는 결과가 조회가 된다.
        이것을 인라인 뷰라고 이야기한다.
        
        즉, 뷰은 인라인 뷰중에서 자주 사용하는 인라인 뷰를 기억시켜놓고 사용하는 개념이다
        
        조회 질의명령의 결과로 만들어지는 데이터 집합을 인라인뷰라 이야기한다.
        *
        인라인 뷰는 하나의 가상 테이블이다.
        (테이블이란 필드와 레코드로 구성된 데이터를 입력하는 단위)
        따라서 인라인 뷰는 하나의 테이블로 다시 재사용이가능하다.
        결국 테이블을 사용해야 하는 곳에는 인라인 뷰를 사용해도 된다.
        
        예 ]
            SELECT
                EMPNO
            FROM
                (
                    SELECT
                        EMPNO,ENAME, DEPTNO
                    FROM
                        EMP
                )
            WHERE
                DEPTNO =10
                ;
                
                SELECT 
                    ENAME,SAL   --에러 
                FROM
                (
                    SELECT
                        EMPNO,ENAME,JOB
                    FROM 
                        EMP
                ) --이경우는 에러가 난다. 왜냐하면 테이블의 내용에 
                    SAL 필드가 존재하지 않기 때문이다.
                    
-------------------------------------------------------------------------------
    인라인 뷰를 사용해야 하는 이유
        실제 테이블에 존재하지 않는 데이터를 추가적으로 사용해야 하는 경우에
        특히 인라인 뷰를 사용한다.

-------------------------------------------------------------------------------

참고 ]
    ROWNUM 
    ==> 실제로 물리적으로 존재하는 필드는 아니고
        오라클이 만들어주는 가상의 필드로
        데이터가 입력된 순서를 표시하는 필드이다.(넘버링해준다)
        
        예 ]
            SELECT 
                ROWNOM, ENAME,JOB
            FROM 
                ENAME
            
    
*/

SELECT 
    ROWNUM, ENAME,JOB
FROM 
    EMP
ORDER BY
    ENAME   --정렬은 ROWNUM이 붙여진 다음에 정렬이 된다.
;



SELECT ROWNUM NO , E.*
FROM
(SELECT 
    ENAME,JOB
FROM 
    EMP
ORDER BY
    ENAME)E
;
-- 문제 3 ] 사원들의 사원번호, 사원이름, 급여를 조회하세요.