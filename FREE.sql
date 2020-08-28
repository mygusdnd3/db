--DEPT 테이블 생성
CREATE TABLE DEPT(
    DEPTNO NUMBER(2)
        CONSTRAINT DPT_NO_PK PRIMARY KEY,
    DNAME VARCHAR2(10 CHAR)
        CONSTRAINT DPT_NAME_NN NOT NULL,
    LOC VARCHAR2(15 CHAR)
        CONSTRAINT DPT_LOC_NN NOT NULL

);

CREATE TABLE EMP(
    EMPNO NUMBER(4)
        CONSTRAINT EMP_ENOPK PRIMARY KEY,
    ENAME VARCHAR2(10 CHAR)
        CONSTRAINT EMP_NAME_NN NOT NULL,
    JOB VARCHAR2(15 CHAR)
            CONSTRAINT EMP_JOB_NN NOT NULL,--제약조건
    MGR NUMBER(4),
    HIREDATE DATE
            CONSTRAINT EMP_DAY_NN NOT NULL,
    SAL NUMBER(8) DEFAULT 3000000
        CONSTRAINT EMP_SAL_NN NOT NULL,
    COMM NUMBER(8),
    DEPTNO NUMBER(2)
        CONSTRAINT EMP_DNO_FK REFERENCES DEPT(DEPTNO)
);

-- SALGRADE 테이블 생성

CREATE TABLE SALGRADE(
    GRADE NUMBER(2)
        CONSTRAINT SGRD_GRD_PK PRIMARY KEY,
    LOSAL NUMBER(8)
        CONSTRAINT SGRD_LSAL_NN NOT NULL,
    HISAL NUMBER(8)
        CONSTRAINT SGRD_HSAL_NN NOT NULL
);


--부서별 테이블 데이터 입력

INSERT INTO
    DEPT
    VALUES(
        10, '기획부','수원' );
        INSERT INTO
    DEPT
    VALUES(
        20, '인사부','여의도' );
        INSERT INTO
    DEPT
    VALUES(
        30, '개발부','구로' );
        INSERT INTO
    DEPT
    VALUES(
        40, '회계부','강남' );
select * from dept;

-- 사원정보 테이블 데이터 입력

INSERT INTO
    EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,COMM,DEPTNO)
VALUES(
    1000,'전은석','BOSS',NULL,TO_DATE('2020/07/16','YYYY/MM/DD'),NULL,10
);

SELECT * FROM EMP;

INSERT INTO
    EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,COMM,DEPTNO)
VALUES(
    1001,'김주영','반장',1000,'2020/07/22',500,40
);
SELECT * FROM EMP;

-- 보스의 급여를 기존 급여의 400% 인상해주세요

UPDATE
    EMP
SET
    SAL = SAL * 4
WHERE
    MGR IS NULL
;

SELECT * FROM EMP;

INSERT INTO
    EMP
VALUES(
(SELECT NVL(MAX(EMPNO)+1,1000) FROM EMP)
,'이지우','학술부장',1001,SYSDATE,5000000,450,30
);



-----------------------------------

/*
    휴일과제 ]
        게시판 테이블을 구현하세요
        게시판은 댓글은 없는 기능으로 구현하기로 한다.
        회원테이블
        아바타테이블 ( 캐릭터 사진 이미지 )
        게시판테이블
        
    작성문서 ]
        ER MODEL
        ERD
        테이블 명세서
        DDL명령 SQL파일
        데이터 입역 DML 명령 SQL파일
*/

CREATE TABLE avatar(
    ano NUMBER(2)
        CONSTRAINT AVT_NO_PK PRIMARY KEY,
    aname VARCHAR2(30 CHAR)
        CONSTRAINT AVT_NAME_UK UNIQUE
        CONSTRAINT AVT_NAME_NN NOT NULL,
    gen char(1)
        CONSTRAINT AVT_GEN_CK CHECK( gen IN ('M','F'))
        CONSTRAINT AVT_GEN_NN NOT NULL
    );
    
INSERT INTO
    avatar
VALUES (
    11, 'avatar01.jpg','M'
);
SELECT * FROM AVATAR;