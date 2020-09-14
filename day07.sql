/*
    수업 참여 실시 시간
    
        1. 9:30 ~ 12:30
        
        2. 13:30 ~ 16:30
        
        3. 16:30 ~ 18:30

*/



/*
    DDL 명령
    

*/

--1. 테이블 만들기
/* 
    형식 1 ] - 제약조건 없이 칼럼만 만드는 방법
    
        CREATE TABLE 테이블 이름(
            필드이름    데이터타입(길이),
            필드이름    데이터탙입(길이),
            ...
            );
            
    형식 2 ] -제약조건을 추가해서 만드는 방법
        CREATE TABLE 테이블 이름(
        필드이름    데이터타입(길이) [DEFAULT 데이터]
            CONSTRAINT 제약조건이름 제약조건
            CONSTRAINT 제약조건이름 제약조건,
        필드이름    데이터타입(길이)
            CONSTRAINT 제약조건이름 제약조건
            CONSTRAINT 제약조건이름 제약조건,
            ...
        );
*/
--DEFAULT
CREATE TABLE AVT
AS
    SELECT
        *
    FROM
        AVATAR
    WHERE
     1=2 --언제나 거짓인조건
;

    SELECT
        *
    FROM
        avatar
    WHERE
     1=2 --언제나 거짓인조건 결국 구조만 가져온다
;

CREATE TABLE avatar(
    ano NUMBER(2)
        CONSTRAINT AVT_NO_PK PRIMARY KEY,
    aname VARCHAR2(30 CHAR)
        CONSTRAINT AVT_NAME_UK UNIQUE
        CONSTRAINT AVT_NAME_NN NOT NULL,
    afile VARCHAR2(50 CHAR)
        CONSTRAINT AVT_FILE_UK UNIQUE
        CONSTRAINT AVT_FILE_NN NOT NULL,
    dir VARCHAR2(50 CHAR)
        CONSTRAINT AVT_DIR_NN NOT NULL,
    len NUMBER
        CONSTRAINT AVT_LEN_NN NOT NULL,
    gen CHAR(1)
        CONSTRAINT AVT_GEN_NN NOT NULL
        CONSTRAINT AVT_GEN_CK CHECK(gen IN('M','F'))
);



INSERT INTO
        avatar
VALUES(
    (SELECT NVL(MAX(ano), 10)+1 FROM avatar),
    'man1', 'img_avatar1.png', '/img/avatar/',0,'M'
);
INSERT INTO
        avatar
VALUES(
    (SELECT NVL(MAX(ano), 10)+1 FROM avatar),
    'man2', 'img_avatar2.png', '/img/avatar/',0,'M'
);
INSERT INTO
        avatar
VALUES(
    (SELECT NVL(MAX(ano), 10)+1 FROM avatar),
    'man3', 'img_avatar3.png', '/img/avatar/',0,'M'
);
INSERT INTO
        avatar
VALUES(
    (SELECT NVL(MAX(ano), 10)+1 FROM avatar),
    'man4', 'img_avatar4.png', '/img/avatar/',0,'F'
);
INSERT INTO
        avatar
VALUES(
    (SELECT NVL(MAX(ano), 10)+1 FROM avatar),
    'man5', 'img_avatar5.png', '/img/avatar/',0,'F'
);
INSERT INTO
        avatar
VALUES(
    (SELECT NVL(MAX(ano), 10)+1 FROM avatar),
    'man6', 'img_avatar6.png', '/img/avatar/',0,'F'
);

select * from avatar;
commit;

create table avc(
    no number(2),
    name varchar2(10 char)
    );
    
desc avc;

insert into
    avc
values(
    10,'abc'
);

insert into
    avc(no)
values(
10
);
select * from avc;
/*
    이처럼 컬럼의 널값 입력 처리를 설정하지 않으면 기본적으로
    null 데이터가 입력되는 것이 허용이 된다.
*/
drop table avc;

ALTER TABLE
    avt
MODIFY
    dir default '/img/avatar/'
;

INSERT INTO
    avt(ano, aname, afile, len, gen)
VALUES(
    10,'man1','avt1.jpg',0,'M'
);

select * from avt;

/*
    테이블 수정
    
    참고 ]
        DDL 명령 - 
        데이터 정의 언어 : 데이터베이스의 개체를 다루는 명령
    테이블 수정
        1. 컬럼추가
            형식 ]
                ALTER TABLE 테이블이름
                ADD(
                    필드이름    데이터타입(길이)
                )
        2. 컬럼 이름 변경
            형식 ]
                ALTER TABLE 테이블 이름
                RENAME COLUMN 현재이름 TO 바꿀이름\
                
        3. 사이즈 변경
            형식 ]
                ALTER TABLE
                    테이블 이름
                MODIFY 현재필드이름 데이터타입(길이)
        4. 필드(컬럼)삭제
            형식 ]
                ALTER TABLE
                DROP COLUMN 필드(컬럼)이름;
*/
ALTER TABLE avt
ADD(
    idate DATE,
    ddate DATE
);
SELECT * FROM AVT;    

ALTER TABLE AVT
RENAME COLUMN IDATE TO INSERTDAY;
DESC AVT;

ALTER TABLE
    AVT
MODIFY ANO NUMBER(3);
DESC AVT;

ALTER TABLE AVT
DROP COLUMN INSERTDAY;

ALTER TABLE AVT
DROP COLUMN DDATE;


-- 문제 ] ANO의 길이를 숫자 2자리로 변경하세요

ALTER TABLE AVT
MODIFY ANO NUMBER(2);
-- 현재 좀아까 세자릿수로 사이즈를 늘려 놓은 상태이다

TRUNCATE TABLE AVT;
ALTER TABLE AVT
MODIFY ANO NUMBER(2);
-- 데이터를 비우고 하면 된다
-- 큰 사이즈를 변경하는건 문제가 안된다. 하지만 작은사이즈로 변경할때는
-- 비워줘야 한다.

----------------------------------------------------------------------
/*
    4. 테이블 이름 변경
        형식 ]
            ALTER TABLE 테이블이름
            RENAME TO 바뀔 테이블 이름.
*/
-- AVT 테이블을 AVT01로 수정
ALTER TABLE AVT
RENAME TO AVT01;

SELECT TNAME FROM TAB;

/*
    테이블 삭제하기 
    
    4. DROP 
        형식 ]
            DROP 삭제할개체유형(?) 개체이름;
        예]
            DROP TABLE(개체유형) AVT01(개체이름)
        형식 2]
            DROP TABLE 테이블이름 PURGE; => 휴지통에 넣지말고 완전삭제..
*/

DROP TABLE AVT01;
DROP TABLE DEPT;
-- 이러한 DDL 명령은 명령이 실행이되면 바로 데이터베이스에 적용이되기때문에
-- 자동 COMMIT이 된다. 조심

-- USER01이라는 계정을 만들어보자
CREATE USER user01 IDENTIFIED BY ABCD; --시스템 계정으로 실행해야 권한이생긴다.

DROP USER USER01;
-- DROP,CREATE, ALTER 명령은 테이블만 지우는 명령어가 아니다.
CREATE USER user01 IDENTIFIED BY ABCD;

ALTER USER USER01 IDENTIFIED BY user ACCOUNT UNLOCK; -- ACCOUNT UNLOCK
-- ACCOUNT UNLOCK계정 잠금 해제
/*
    IDENTIFIED BY - 비밀번호 적용하는 명령
    ACCOUNT UNLOCK - 계정 잠금을 해제하는 명령
*/

---------------------------------------------------------------
/*
      참고 ]
        오라클은 10G 부터 휴지통 개념을 이용해서
        삭제된 테이블을 휴지통에 보관하도록 해 놓았다.
    휴지통 관리
    
        1. 휴지통에 있는 모든 테이블을 완전 지우기
            PURGE RECYCLEBIN;
        2. 휴지통에 있는 특정 테이블만 완전 삭제하기
            PURGE TABLE 테이블 이름
        3. 휴지통 확인하기
            SHOW RECYCLEBIN;
        4. 휴지통에 버린 테이블 복구하기
            FLASHBACK TABLE AVT01 TO BEFORE DROP;

*/
PURGE RECYCLEBIN;
--AVATAR 테이블을 복사해서 테이블을 만들고 삭제
CREATE TABLE AVT01
AS
SELECT * FROM AVATAR;
DESC AVT01;
DROP TABLE AVT01;
--휴지토엥서 AVT01 테이블을 완전 삭제한다.
PURGE TABLE AVT01;

-- 휴지통보기
SHOW RECYCLEBIN;
-- 완전 삭제하기
PURGE TABLE AVT01;

--복구하기
CREATE TABLE AVT01
AS
SELECT * FROM AVATAR;
DESC AVT01;
DROP TABLE AVT01;
--복구
FLASHBACK TABLE AVT01 TO BEFORE DROP;
SELECT * FROM AVT01;\

---------------------------------------------------------
/*
     제약조건(무결성 체크)
     ==> 데이터베이스는 프로그램등 전산에서 작업할 때 필요한 데이터를 제공해주는 보조 프로그램이다.
         따라서 데이터베이스가 가진 데이터는 완벽한(결함이없는)데이터여야한다.
         하지만 데이터를 입력하는 것은 사람의 몫이고,
         따라서 완벽한 데이터를 보장 할 수 없게 된다.
         
         각각의 테이블에 들어가서는 안될 데이터나, 빠지면 안되는 데이터 등을 미리 결정해 놓으므로써
         데이터를 입력하는 사람이 잘못 입력할 경우
         그 데이터는 아예 입력을 시키지 못하도록방지하는 역할을 하는 기능
         
         ==> 데이터 베이스의 이상현상을 되도록이면 제거할 목적으로 하는 작업이다. 
         
         따라서 이 기능은 반드시 필요한 기능은 아니다.
         (입력하는 사람이 정신차리고 입력하면 해결이 된다.)
         하지만, 실수를 미연에 방지할 수 있도록 하는 기능이다.
         
         종류 ]
            NOT NULL
            ==> 이 제약조건이 지정된 필드는 반드시 데이터가 존재해야 하는 필드임을 밝하는 것
                이 무결성 체크가 있는 필드에 데이터가 입력이 되지 않으면, 
                입력한 한 행의 데이터를 모두 입력할 수 없게 된다.
            UNIQE
            ==> 이 제약 조건이 지정된 필드는 다른 데이터와 반드시 구분 될 수 있어야 한다.
                즉, 해당 필드의 값이 다른 행의 해당 필드의 값과 구분이 되어야 한다.
                따라서 같은 데이터가 입력되지 못하도록 막는 기능을 가지고 있다.
            PRIMARY KEY
            ==> NOT NULL + UNIQE
                테이블에서 하나의 컬럼에만 부여해줄 수 있는 제약 조건
            FOREIGN KEY
            ==> 다른테이블의 기본키(PRIMARY KEY) 또는 유일키(UNIQE)를 참조해만 하는 제약조건
                참조하는 테이블의 데이터 이외의 데이터가 입력되는 것을 방지하는 기능
                
                참고 ]
                    테이블을 생성할 때도 참조하는 데이터가 있는 테이블이 먼저 만들어져야 한다.
                    입력되어있는 데이터만 참조하더라?
                    아하 없는 부서번호를 입력하면 안된다~
                    
                    사원정보테이블에
                    emp 에있는 테이블번호는 부서정보에있는 값만 입력할수있도록 제한
                    유니크 제한조건이 설정되어있는 컬럼은 참조할 수있다.
            CHECK
            ==> 데이터가 미리 정해놓은 데이터만 입력 할 수 있도록 하는 제약조건
            
*/

INSERT INTO
AVATAR
VALUES(
    17,'man7','img_avatar7.png','/img/avatar/',0,'F'
);

-- 참조키 제약조건 ( ==> SCOTT 계정에서 테스트)
INSERT INTO
  EMP(EMPNO, ENAME, DEPTNO)  
VALUES(
    (SELECT NVL(MAX(EMPNO)+1,1000) FROM EMP),
    'HONG',50
);

SELECT NVL(MAX(EMPNO)+1,1000) FROM EMP;
SELECT * FROM EMP;
rollback;
-- HELLO 계정 테스트
INSERT INTO
    AVATAR
VALUES(
    18,'man8','img_avatar8.png','/img/avatar/',0,'A'
);

--------------------------------------------------
/*
    제약조건 지정하는 방법
     1. 테이블을 만들 때 지정하는 방법
       1) 무명 제약조건 지정방법
         ==> 오라클은 필드에 제약조건을 지정할때 이름을 따로 만들지 않으면
             오라클이 만드는 이름을 지정하게 되어 있다.
             
            형식 ]
                CREATE TABLE 테이블이름(
                    필드이름 타입(길이) 제약조건
                    ...
                );-- 이름을 지가알아서 만들어버림
       2) 명시적 제약조건 지정방법(<==권장방법)

*/

CREATE TABLE ABC(
    ANO NUMBER(2) PRIMARY KEY,
    NAME VARCHAR2(10 CHAR)NOT NULL
);
INSERT INTO ABC(ANO)
VALUES(
    10
);

INSERT INTO ABC
VALUES(
    10,'ABC'
);

INSERT INTO ABC
VALUES(
    20,'ABC'
);

INSERT INTO ABC
VALUES(
    10,'ABC'
);
DROP TABLE ABC;
/*
    2) 명시적 제약조건 지정방법( <== 권장방법 )
    
        형식1 ]
            CRATE TABLE 테이블이름(
                필드이름    타입(길이)
                    CONSTRAINT 제약조건이름 제약조건
                    CONSTRAINT 제약조건이름 제약조건
                    ...,
                필드이름    타입(길이)
                    CONSTRAINT 제약조건이름 제약조건
                    CONSTRAINT 제약조건이름 제약조건
                    ...,
                    
            );
        형식 2 ]
            CREATE TABLE 필드이름(
                필드이름 타입(길이),
                필드이름 타입(길이),
                ...
                CONSTRAINT 제약조건이름 제약조건(필드이름)

*/
--명시적 제약조건
--형식1
CREATE TABLE ABC(
    ANO NUMBER(4)
        CONSTRAINT ABC_NO_PK PRIMARY KEY,
    NAME VARCHAR2(10 CHAR)
        CONSTRAINT ABC_NN_NN NOT NULL
);
INSERT INTO ABC(ANO)
VALUES(
    10
);

INSERT INTO ABC
VALUES(
    10,'ABC'
);

INSERT INTO ABC
VALUES(
    20,''
);

INSERT INTO ABC
VALUES(
    10,'ABC'
);
DROP TABLE ABC;
--형식2
CREATE TABLE ABC(
    ANO NUMBER(4),
    NAME VARCHAR2(10 CHAR)
        CONSTRAINT ABC_NN_NN NOT NULL,
    CONSTRAINT ABC_NOO_PK PRIMARY KEY(ANO)
    
);

INSERT INTO ABC
VALUES(10,'AB');

INSERT INTO ABC
VALUES(10,'AB');

DROP TABLE ABC;

/*
    2. 이미 만들어진 테이블에 제약조건을 추가하는 방법
    
        형식 1] 명시적 제약조건 등록--DDL소속명령
            ALTER TABLE 테이블이름
            ADD CONSTRAINT 제약조건이름 제약조건(필드이름)
        형식 2] 무명 제약조건 등록
            ALTER TABLE 테이블이름
            ADD 제약조건 (필드이름);
            
*/
--형식2
CREATE TABLE ABC(
    ANO NUMBER(4),
    NAME VARCHAR2(10 CHAR),
    TEL VARCHAR2(13 CHAR)
    
);
--명시적 제약조건 추가
ALTER TABLE ABC
ADD CONSTRAINT ABC_NO_PK PRIMARY KEY(ANO);

--무명제약조건 추가
ALTER TABLE ABC
    ADD UNIQUE(TEL);
/*
참고 ]
    NOT NULL 제약조건은 테이블이 만들어진 후에 추가하는게 아니고 
    테이블의 구조를 수정하는 개념이다
    왜냐하면 NOT NULL은 제약 조건을 등록하지않으면
    등록이 안된것이 아니고
    NULL을 허용하는 제약조건으로 등록이 된 상태이다
    따라서 NOT NULL은 필드의 속성을 수정하는 방법으로
    제약조건을 수정해야한다.
*/
ALTER TABLE ABC
MODIFY NAME
CONSTRAINT ABC_NAME_NN NOT NULL;

/*
    등록된 제약조건 확인하는 방법
    ==> 등록된 제약 조건은 오라클이 테이블을 이용해서 관리하고 있다.
        이 테이블이 이름이
        USER_CONSTRAINTS
        라는 테이블이다.
    참고 ]
        CONSTRAINT_TYPE 종류
        P - PRIMARY KEY
        R - FOREIGN KEY
        U - UNIQUE
        C - CHECK 또는 NOT NULL
*/

SELECT
    CONSTRAINT_NAME,CONSTRAINT_TYPE,TABLE_NAME --PUC PRIMARY UNIQ, CHK
FROM
    USER_CONSTRAINTS
WHERE
    TABLE_NAME='ABC';

/*
    제약조건 삭제하는 방법
        형식 ]
            ALTER TABLE 테이블이름
           xx DROP CONSTRAINT 제약조건이름;
           DROP UNIQUE(TEL);
        참고]
            기본키(PRIMARY KEY)의 경우 제약조건의 이름을 몰라도 삭제가능
            << 기본키는 한 테이블에 한개만 존재하기 때문에..
            
        형식 ]
            ALTER TABLE 테이블이름
            DROP PRIMARY KEY;
*/

ALTER TABLE ABC
DROP PRIMARY KEY;

SELECT *
FROM USER_CONSTRAINTS
WHERE
TABLE_NAME ='ABC';
ROLLBACK;
DROP TABLE ABC;
CREATE TABLE ABC(
    ANO NUMBER(4)
        CONSTRAINT ABC_NO_PK PRIMARY KEY,
    NAME VARCHAR2(10 CHAR)
    
);
INSERT INTO ABC
VALUES(11,'GREEN');
INSERT INTO ABC
VALUES(12,'BLUE');
INSERT INTO ABC
VALUES(13,'RED');

/*
    제약조건 이름 만드는 규칙
        [계정이름_]테이블이름_필드이름_제약조건
    
    예]
        ABC_NO_PK
*/
CREATE TABLE KCOLOR(
    KNO NUMBER(3)   -- 기본키
        CONSTRAINT KCLR_NO_PK PRIMARY KEY,
    CNAME VARCHAR(10 CHAR)
        CONSTRAINT KCLR_CNAME_NN NOT NULL,
    RCODE NUMBER(2)
        CONSTRAINT KCLR_RCODE_FK REFERENCES ABC(ANO)--(참조 키 추가)
        );