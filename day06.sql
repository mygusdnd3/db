--day06

/*
DML(data manipulation language)명령
==> 데이터를 처리(조작)하는 명령
    이 명령안에는 Insert, update, deleteㅁ여령도 포함되어있다.
    
    1. INSERT 명령
        ==> 새로운 데이터를 입력하는 명령
        
        형식1 ] -- > 모든 필드의 데이터가 준비되어있는 경우.
            INSERT INTO
                테이블
            VALUES(
                데이터1,데이터2,...
                
        형식 2] --일부만 데이터가준비되어있는 경우
            INSERT INTO
                테이블이름(필드이름1, 필드이름2,...)
            VALUES(
                준비된데이터1,데이터2...
            );
        의미]
        지정한 테이블의 지정한 필드에 데이터를 입력하세요.
        
        주의사항]
            필드의 갯수와 데이터의 갯수는 반드시 일치해야 한다.
            
        실습준비 ]
            EMP 테이블을 구조만 복사해서 샘플테이블을 만들고
            그 테이블에 데이터를 추가하고 수정하고 삭제한다.
            
            기존 테이블의 구조만 복사해서 테이블을 만드는 명령
            
            CREATE TABLE 테이블이름
            AS
                SELECT
                    *
                FROM
                    복사해올 테이블이름
                WHERE
                    항상 거짓인 조건식
                    
        참고]
            만약 데이터가 준비되지 않아서 데이터가 부족할 경우에는
            1.NULL로 그 부분은 대신채우면된다.
            2. 필드이름을 지정할때 생략하면된다.
*/

--EMP 테입ㄹ의 구조만 복사해서

CREATE TABLE
    SAMPLE01
AS 
    SELECT
        *
    FROM EMP
    WHERE
        1=2
;
desc emp;
SELECT *
FROM EMP
WHERE 1=2
;
SELECT *
FROM SAMPLE01;

/*
    INSERT 명령
        구조만 복사된 테이블 SAMPLE01에 사원 한명의 데이터를 채워보자.

*/

INSERT INTO
    SAMPLE01
VALUES(
    1000, 'JOY','SINGER',999,SYSDATE,100,2000,10,0,null
    );

INSERT INTO
    SAMPLE01
VALUES(
    9999,'EUNS', 'BOSS',NULL,sysdate,1000,200,20,0,null
    );
COMMIT;

SELECT * FROM SAMPLE01;    


--오혜찬씨입사
INSERT INTO
    SAMPLE01(EMPNO,ENAME,JOB,MGR,HIREDATE,DEPTNO)
VALUES(
    1001,'CHAN','MANAGER',9999,SYSDATE,30
);
COMMIT;
SELECT * FROM SAMPLE01;


CREATE TABLE
    BOOSEO
AS
SELECT
    *
FROM
    DEPT
WHERE
    1=2

;

INSERT INTO
    SAMPLE01(EMPNO,ENAME) --> 필드이름을 기술하지않은 필드는 NULL 데이터로 채워지게된다
VALUES(
    'CHOI',100 --> 필드이름의 순서와 데이터의 입력순서가 일치하지 않기 때문에 입력이 안된다.
);

INSERT INTO
    SAMPLE01(ENAME, EMPNO)
VALUES(
    'JWOO',1002
);


/*
    UPDATE
    ==> 기존 데이터의 내용을 수정하는 명령
    
    형식 ]
        UPDATE
            테이블이름
        SET
            필드이름 - 수정데이터,
            필드이름 - 수정데이터,
            필드이름 - 수정데이터,
        [ WHERE
            조건식
        ]
        ;
        
        ***
        주의사항 ]
            WHERE 조건이 없으면
            테이블의 모든 데이터의 내용이 수정이된다.
*/

-- JWOO 사원의 부서번호를 10번으로 수정 --> UPDATE
UPDATE
    SAMPLE01
SET
    DEPTNO = 10
;---모든사원이 10번이됨
SELECT * 
FROM SAMPLE01;

ROLLBACK;
SELECT * 
FROM SAMPLE01;

UPDATE
    SAMPLE01
SET
    DEPTNO = 10
WHERE
    ENAME ='JWOO'
 ;
  SELECT * 
FROM SAMPLE01;


/*
UPDATE

SET
    (필드리음,필드이름..) = (
                                SELECT
                                    필드이름,필드이름..
                                FROM
                                    테이블이름
                                WHERE
                                    조건식
                            )
[WHERE
    조건식
]
)

참고 ]
    변경할 데이터는 수식을 이용해서 처리할 수 있다.
*/
--EMP 테이블의 WARD 사원으ㅐ JOB, HIREDATE, SAL, COMM의 데이터로 JWOO 사원의 데이터를 수정하자


UPDATE
    SAMPLE01
SET
 (JOB,HIREDATE,SAL,COMM) = (
                                SELECT
                                    JOB, HIREDATE,SAL,COMM
                                FROM
                                    EMP
                                WHERE
                                    ENAME = 'WARD'   
                            )
WHERE
    ENAME = 'JWOO'
;
-- 수정결과 조회
SELECT*FROM SAMPLE01;

UPDATE
    SAMPLE01
SET
    MGR = '9999',
    HIREDATE =SYSDATE-1
WHERE
    ENAME ='JWOO'
;

SELECT * FROM SAMPLE01;

/*
SELECT*FROM SAMPLE01;

UPDATE
    SAMPLE01
SET
    (MGR,hiredate) = (select '9999',to_date(날짜,'yyy) from dual)
WHERE
    ENAME ='JWOO'
;

SELECT * FROM SAMPLE01;
*/

UPDATE
    SAMPLE01
SET
    MGR = '9999',
    HIREDATE =SYSDATE-1
WHERE
    ENAME ='CHAN'
;
/*
    문제 ]
        chan 사원의 급여를 최그급여에서 100을 뺀 금액으로 하고
        커미션은 jwoo사원의 커미션과 같은 커미션으로 추가하세요
*/

UPDATE 
    SAMPLE01
SET
    SAL = ( SELECT MAX(SAL)-100 FROM SAMPLE01),
    COMM = (SELECT COMM FROM SAMPLE01 WHERE ENAME ='JWOO')
WHERE
    ENAME ='CHAN'
;
COMMIT;
SELECT * FROM SAMPLE01;
/*
    참고 ] 
        날짜 형식의 데이터를 입력해야할 필드에 
        문자형식의 데이터를 입력하는 경우는
        오라클이 날짜형식의 데이터로 형변환 해주는 TO_DATE() 팜ㅅ를 자동으로 호출해서
        그 결과값을 해당 필드의 데이터로 입력하게 된다.
        이경우 특정 형식에 맞는 문자데이터만날짜데이터로 변환이되므로
        그 이외의 형식의 문자데이터는 날짜데이터로 변환이 안된다.
        ==> 이런경우는 형변환함수를 직접 호출해서 처리해줘야한다.
*/

-----------------------------------------------------------------------
/*
    DELETE 명령
        ==> 현재 데이터 중에서 필요하지 않는 데이터를 삭제하는 명령
        
        형식 ]
            DELETE
            
            FROM
            
            [WHERE
                조건식
            ]
            ;
            ***
            주의사항 ]
            조건을 제시하지 않으면 수정명령과 마찬가지로
            모든 데이터가 삭제된다.
*/

DELETE FROM SAMPLE01;
SELECT * FROM SAMPLE01;
ROLLBACK;

-- JOY 사원의 데이터를 삭제하세요
DELETE FROM SAMPLE01
WHERE
    ENAME = 'JOY';
COMMIT;  

-----------------------------------------------------------------------------------

/*
    트랜젝션 처리
        ==> 교과서적인 의미로는
            오라클이 처리(실행)하는 명령 단위이다.
            
            예를 들자면
            우리가 CREATE TABLE ??(...) 라는 명령을 내가ㅗ
            실행을 시키면 이것을 명령을 내리는 즉시 데이터 베이스에 적용이 된다.
            이것을 다른말로 표현하자면
                "트랜젝션이 실행되었다."
            라고 표현한다.
            
            위와 같이 대부분의 명령은 엔터키를 누르는 순간 명령이 실행되고
            그것은 트랜젝션이 실행된 것이므로
            결국 오라클은 명령 한줄이 곧 하나의 트랜젝션이 된다.
            
            그런데
            DML명령 만큼은 트랜젝션의 단위가 달라진다.
            ==> DML 명령은 명령을 내리면 바로 데이터베이스에 적용(실행) 디는 것이 아니고
                버퍼장소(임시기억장소 : 메모리)에 그 명령을 모아만 놓느다.
                
            따라서 DML 명령은 강제로 트렌젝션 실행 명령을 내려야한다.
            이때 트랜젝션은 한번만 일어나게 된다.
            
            왜??
                <<==
                    DML 명령은 데이터를 변경하는 명령이다.
                    데이터베이스에서 가장 중요한 개념은 무결성 데이터이다.
                    이런곳에 DML 명령이 한순간 트랜젝션되면
                    데이터의 무결성이 사라질 수 있다.
                    이런 문제점을 해결하기 위한 목적으로
                    트랜젝션 방식을 변경해놓았다.
                    
                버퍼에 모아놓은 명령을 트렌젝션 처리하는 방법
                
                    1. 자동 트랜젝션처리
                        1) 세션을 정상적으로 종료하는 순간 트랜젝션이 일어난다. (AUTO COMMIT)
                            ==> sqlplus >exit (자동커밋)
                        2) DDL 명령이나 DCL 명령이 내려지는 순간 오토커밋..
                            
                    2. 수동 트랜젝션 처리
                        1) COMMIT 이라고 강제로 명령을 내리는순간
                        
                    버퍼에 모아놓은 명령이 실행되지 않는 순간
                    ==> 데이터베이스에 적용이 안되는 경우
                        
                        자동
                            1. 정전등에 의해서 시스템이 셧다운 되는 순간(커밋안됨)
                            2. SQLPLUS를 비정상적으로 종료하는 순간
                        
                        수동
                            1. ROLLBACK 이라고 명령을 내리는 순간
                            
                정리]
                    DML 명령을 내린 후 다시 검토해서 완벽한 명령이라고 판단되면
                    COMMIT 이라고 명령해서 트랜젝션을 일으키고
                    만약 검토후 완벽한 명령이 아니다 라고 하면
                    ROLLBACK 이라고 명령해서 잘못된 명령을 취소한다고 한다.
------------------------------------------------------------------------------

        참고 ]
            TRUNCATE 와 DELET의 차이첨
            ==> TRUNCATE : DDL 소속 명령(하는순간 적용)
                DELET :  DML 소속 명령(커밋을해야한다)
                    
*/
ROLLBACK;
CREATE TABLE SMP01
AS
    SELECT
    *
    FROM 
    EMP
;
SELECT * FROM SMP01; -- 메모리에만 적용된 상태, 따라서 되돌릴수 있다.

ROLLBACK;
DELETE FROM SMP01;

SELECT * FROM SMP01;

------------------------------------------------
/*
    ROLLBACK 시점 만들기
    ==> DML 명령을 내릴때 특정 위치에 책갈피를 만들어 놓을 수 있으며
        이후 이 책갈피를 이용해서 ROLLBACK 할 부분을 지정할 수 있다.
        
        시점만들기
            형식 ]
                SAVEPOINT 포인트이름;
                
        시점까지 ROLLBACK 시키기
            형식 ]
                ROLLBACK TO 포인트이름;
                
        예 ]
            SAVEPOINT A;
                (1) DML
                (2) DML
                (3) DML
            SAVEPOINT B;
                (4) DML
                (5) DML
                (6) DML
            SAVEPOINT C;
                (7) DML
                (8) DML
                (9) DML
            ROLLBACK TO C; --> 789만 취소된다.
            ROLLBACK TO B; --> 456만 취소된다.
            ROLLBACK TO A; --> 123만 취소된다.
            
        참고 ]
            트랜젝션 처리를 하면 SAVEPOINT는 자동 파괴된다.
            예]
                         SAVEPOINT A;
                (1) DML
                (2) DML
                (3) DML
            SAVEPOINT B;
                (4) DML
                (5) DML
                (6) DML
            SAVEPOINT C;
                (7) DML
                (8) DML
                (9) DDL --> AB포인트가 즉시 삭제된다.
*/

---------------------------------------------------
--계정만들기
--SYSTEM 계정으로 접속해서 작업한ㄷ.ㅏ

CREATE USER hello IDENTIFIED BY hello ACCOUNT UNLOCK;

-- 계정에 권한을 부여
GRANT resource, connect, SELECT ANY TABLE TO hello;

/*
    권한 부여 명령
    GRANT 권한이름 또는 룰, 권한이름 또는 룰... TO 계정이름;
    
    DROP TABLE EMP; 테이블 완전히 삭제
*/