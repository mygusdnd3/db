--day09


/*
    INDEX(인덱스)
    ==> 검색 속도를 빠르게 하기 위해서 B-TREE기법으로
        색인을 만들어서 SELECT 조회질의명령을 빠른속도로 처리할 수 있도록 하는 것
        
    참고 ]
        인덱스를 만듦면 안되는 경우
            1. 데이터의 양이 적은 경우는 오히려 속도가 떨어진다.
               시스템에 따라 달라지지만
               최소한 몇십만개의 행이 있는 테이블의 경우에만 속도가 빨라진다. 
            2. 데이터의 입출력이 빈번한 경우 오히려 속도가 떨어진다.
               왜냐하면 데이터가 입력될 때 마다
               계속해서 색인(인덱스)를 수정해야 하므로 오히려 불편해진다.
               
    참고 ]
        인덱스를 만들면 효과가 좋아지느 ㄴ경우
            1. JOIN등에 많이 사용되는 필드가 존재하는 경우
            2. NULL 데이터가 많이 존재하는 경우
            3. WHERE 조건절에 많이 사용되는 필드가 존재하는 경우
            
            
    참고 ]
        무결성검사를 할때 PK(기본키 제약조건) 등록을 하면
        자동적으로 인덱스가 만들어진다.

-----------------------------------------------------------------------------
    인덱스 만들기
    
        형식 1 ] --> 일반적인 인덱스 만들기(NON UNIQUE 인덱스)
        
        CREATE INDEX 인덱스이름
        ON
            테이블이름(인덱스에 사용할 필드이름)
        
        예 ] 
            EMP테이블의 ENAME을 이용해서 인덱스를 만드세요
            ==>
                CREATE INDEX enameIdx
                ON
                    emp(ename);
            참고 ]
                일반 인덱스는 데이터가 중복되어도 상관이 없다. 
                
        형식 2 ] --> UNIQUE 인덱스 만들기.
            ==> 인덱스용 데이터가 반드시 UNIQUE하다는 보장이 있을때 만드는 방법
            
            CREATE UNIQUE IDX 인덱스이름
            ON
                테이블이름(필드이름);
            
            참고] 
                지정한 필드이름은 반드시 필드의 내용이 유일하다는 보장이 있어야 한다.
                
            장점]
                일반 인덱스보다 처리속도가 빨라진다. 
                <== 이진 검색을 사용하기 때문에 그렇다.
            
        형식 3] --> 결합 인덱스
            ==> 여러개의 필드를 결합해서 하나의 인덱스를 만드는 방법
                이때도 전제조건이
                여러개의 필드의 조합이 유일해야 한다. 
                
                즉, 하나의 필드만 가지고는 유니크 인덱스를 만들지 못하는 경우 
                여러개의 필드를 합쳐서 유니크 인덱스를 만들어서 사용하는 방법
                
            CREATE UNIQUE INDEX 인덱스이름
            ON
                테이블이름(필드이름, 필드이름, 필드이름,...);
                
        형식 4 ] --> 비트 인덱스
            ==>주로 필드의 데이터의 갯수가 정해진경우에 사용하는 방법
                예 ]
                    GEN 필드의 경우 도메인이 'M','F'만 입력을 해야 한다.
                예 ]
                    EMP테이블의 DEPTNO의 경우는 10,20,30,40만 입력할 수 있다.
            
            이 경우 내부적으로 데이터를 이용해서 인덱스를 만들어서 사용하는 방법이다.
            
            CREATE BITMAP INDEX 인덱스이름
            ON
                테이블이름(필드이름)
            

*/

INSERT INTO emp (
    empno,
    ename,
    deptno
) VALUES (
    9000,
    'DOL',
    50
);

--------------------------------------------------------------------------
--EMP 테이블을 복사해서 EMP 00이라는 테이블을 만들자
CREATE TABLE EMP00
AS
SELECT * FROM EMP;


DESC EMP00;


ALTER TABLE EMP00
MODIFY
    EMPNO NUMBER(6)
    ;

-- 사원번화와 부서번호에 제약조건을 추가해주세요
ALTER TABLE EMP00
ADD CONSTRAINT E00_NO_PK PRIMARY KEY(EMPNO);

ALTER TABLE EMP00
ADD CONSTRAINT E00_DNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO);

-- 시퀀스를 만든다. 시작값은 8000, 증가값은 1씩 증가하고 최대값은 9999, 반복과 캐시는 허용하지 않는다.
CREATE SEQUENCE E_SEQ
    START WITH 8000
    MAXVALUE 999999
    NOCYCLE
    NOCACHE
;
SELECT * FROM EMP;
INSERT INTO
    EMP00
SELECT
    E_SEQ.NEXTVAL,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO
FROM 
EMP
;
INSERT INTO
    EMP00
SELECT
    E_SEQ.NEXTVAL,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO
FROM 
EMP00
;
-- 인덱스를 만들기 전 조회 시간을 체크한다.
SELECT 
    EMPNO,ENAME
FROM
    EMP00
WHERE
    ENAME = 'SMITH'
;


-- 이름을 이용해서 인덱스를 만들어 보자.
CREATE INDEX ename_idx01
ON
    EMP00(ename);
SELECT 
    EMPNO,ENAME
FROM
    EMP00
WHERE
    ENAME = 'SMITH'
;

--EMP00을 복사해서 EMP01 테이블을 만든다.
CREATE TABLE EMP01
AS
    SELECT
        *
    FROM
        EMP00
;

SELECT 
    EMPNO,ENAME
FROM
    EMP00
WHERE
    ENAME = 'SMITH'
;--000006.47
SELECT 
    EMPNO,ENAME
FROM
    EMP01
WHERE
    ENAME = 'SMITH'
    --000006.57
;
DROP TABLE EMP00;
DROP SEQUENCE E_SEQ;




/*
    SQLPLUS 접속 방법
    
        방법 1] --> 로컬에 오라클이 설치되어있는 경우
        SQLPLUS 계정이름/비번
        방법 2] --> 다른 컴퓨터에 오라클이 설치되어 있는 경우
        SQLPLUS 계정이름/비번@DB서버주소:포트번호/SID
*/

INSERT INTO
    EMP01
SELECT
    E_SEQ.NEXTVAL,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO
FROM 
EMP01
;--20.368

INSERT INTO
    EMP00
SELECT
    E_SEQ.NEXTVAL,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO
FROM 
EMP00
;--17.544   --인덱스 추가작업이 새로이 이루어진다. 근데 왜 빠르지

SELECT * FROM EMP01 ORDER BY EMPNO DESC;

CREATE BITMAP INDEX dno_idx01
ON 
    emp00(deptno);
    
SELECT DISTINCT DEPTNO 부서번호 FROM EMP00;--0.053
SELECT DISTINCT DEPTNO 부서번호 FROM EMP01; --0.049 ??????????


----------------------------------------------------------------------

/*
    사용자 관리(계정&권한)
    ==> 관리자 모드에서 사용자에게 권한을 설정하는 방법
    
        계정이란?
        ==> 은행의 통장과 같은 개념이다.
            하나의 통장은 한사람이 사용할 수 있듯이
            계정은 한사람이 사용할 수 있는 가장 작은 단위이다.
            
            오라클의 경우
                데이터베이스
                    |
                    |
            ------------------
            |       |        |
           계정     계정     계정
           |
        -------
        |  |  |
    테이블 테이블 테이블
    
    
            MYSQL의 경우
            ------------            ---------------------
            |     |    |            |   |   |   |   |   |
            계정 계정  계정          DB   DB  DB  DB  DB  DB
                                    |
                                -------
                                |  |  |
                            TABLE  TABLE TABLE
            
-------------------------------------------------------------------------------
    1. 사용자 계정 만들기
        1. 관리자 계정으로 접속한다. 
            1) SQLPLUS의 경우
                a)SQLPLUS SYSTEM/비번
                b)sqlplus / as sysdba
                
                sqlplus hello/hello@localhost:1521/orcl
            2) SQLDEVELOPER의 경우
                SYSTEM 계정으로 접속한다.
        2. 사용자를 만든다.
            CREATE USER 계정이름 IDENTIFIED BY 비밀번호 ;
            예]
                CREATE USER test01 IDENTIFIED BY increpas;
            참고 ]
                현재 접속한 계정이름을 알아보는 명령
                SHOW USER;
            참고 ]
                계정을 만들어 두면
                만든 계정은 아무 권한도 가지고 있지 않다.
                따라서 오라클에 접속할 수 있는 권한 마저도 가지고 있지 않게 된다.
                오라크레ㅔ 접속할 수 있는 권한은
                    CREATE SESSION
                    이라는 권한이다.
        3. 권한 부여하기
            형식 ]
                GRANT 권한이름 , 권한이름,...TO 계정이름;
             예 ]   
                GRANT CREATE SESSION TO TEST01;
            참고 ]
                SQLPLUS에서 접속 계정을 바꾸는 명령
                    CONNECT 계정이름/ 비번;
                    CONN 계정이름/비밀번호;
            참고 ]
                계정이 가지고 있는 테이블 리스트 조회하기
                    SELECT TNAME FROM TAB;
                    
            참고 ]
                SESSION
                ==> 오라클에 접속하면 오라클이 제공하는 권리를 이야기하며
                    오라클의 가격이 달라지는 것은 바로 세션의 갯수에 따라서 가격이 달라진다.
            참고 ]
                오라클에서는 계정을 만들더라도
                데이터베이스에 접속할 수 있는 권한이 없는 상태로 계정이 만들어진다.
                계정을 만든 직후에 세션을 만들 수 있는 권한을 부여받지 않으면
                오라클에 접속할 수 없는 상태가 된다.
                따라서 계정을 만든다음 접속 할 수 있는 권한을 부여해 줘야 한다.
                
    
---------------------------------------------------------------------------------

    참고 ]
        권한을 부여할 때 사용되는 옵션
            1. WITH ADMIN OPTION 
                ==> 관리자 권한까지 위임 받을 수 있도록 하는 옵션
                    (관리자에게 받은 권한만 다른데다 만들수있다)
                예 ] 
                    TEST01계정에게 테이블을 만들 수 있는 권한을 부여하고 
                    +
                    관리자 권한도 부여해 보자
                    
                    GRANT CREATE TABLE TO TEST01 WITH ADMIN OPTION;
                    
            2. WITH GRANT OPTION
                ==> 관리자에게 부여받은 권한을 다른계정에게 전파할 수 있는 권한
                
------------------------------------------------------------------------------

    다른 계정의 테이블 사용하기
        ==> 원칙적으로 하나의 계정은 자신의 계정에 있는 테이블만 사용할 수 있도록 되어있다.
            하지만 여러계정에서 다른 계정의 테이블을 공동으로 사용할 수 있다
            이때, 사용할 수 있는 권한을 설정해줘야 하는데
            
            방법
                GRANT SELECT ON 계정.테이블이름 TO계정;
                
            예
                -- SELECT ANY TABLE 권한을 TEST01에게서 회수를 하고,
                --> SCOTT계정이 가지고 있는 EMP 테이블을 조회할 수 있는 권한을 TEST01 계정에게 부여
                
                REVOKE SELECT ANY TABLE FROM TEST01;
                GRANT SELECT ON SCOTT.EMP TO TEST01;
                
                
-----------------------------------------------------------------------------
 권한 회수하기
 
    형식 ]
        REVOKE 권한이름 FROM 계정이름;
-----------------------------------------------------------------------------
 계정 삭제하기
    형식 ]
        DROP USER 계정이름 CASCADE;

-----------------------------------------------------------------------------
*


/*
    
SQL> exit
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options에서 분리되었습니다.

C:\Users\Admin>sqlplus system/1234

SQL*Plus: Release 11.2.0.1.0 Production on 목 9월 10 11:53:50 2020

Copyright (c) 1982, 2010, Oracle.  All rights reserved.


다음에 접속됨:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> exit
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options에서 분리되었습니다.

C:\Users\Admin>sqlplus / as sysba

SQL*Plus: Release 11.2.0.1.0 Production

Copyright (c) 1982, 2010, Oracle.  All rights reserved.

SQL, PL/SQL 및 SQL*Plus 문을 실행하려면 SQL*Plus를 사용하십시오.

사용법 1: sqlplus -H | -V

    -H             SQL*Plus 버전과 사용법 도움말을
                   표시합니다.
    -V             SQL*Plus 버전을 표시합니다.

사용법 2: sqlplus [ [<option>] [{logon | /nolog}] [<start>] ]

  <option> : [-C <version>] [-L] [-M "<options>"] [-R <level>] [-S]

    -C <version>   영향을 받는 명령의 호환성을
                   <version>에 의해 지정된 버전으로 설정합니다.
                   해당 버전의 형식은 "x.y[.z]"입니다(예: -C 10.2.0).
    -L             오류에 대한 메시지를 다시 표시하는 대신
                   한 번만 로그온을 시도합니다.
    -M "<options>" 출력의 자동 HTML 마크업을 설정합니다.
                   옵션의 형식은 다음과 같습니다.
                   HTML [ON|OFF] [HEAD text] [BODY text] [TABLE text]
                   [ENTMAP {ON|OFF}] [SPOOL {ON|OFF}] [PRE[FORMAT] {ON|OFF}]
    -R <level>     제한 모드를 설정하여 파일 시스템과
                   상호 작용하는 SQL*Plus 명령을 사용 안함으로 설정합니다.
                   레벨은 1, 2 또는 3일 수 있습니다. 가장 제한적인 모드는 -R 3이며
                   이 모드는 파일 시스템과 상호 작용하고 있는
                   모든 사용자 명령을 사용 안함으로 설정합니다.
    -S             SQL*Plus 배너의 표시, 프롬프트 및
                   명령 표시를 숨기는 자동 모드를
                   설정합니다.

  <logon>: {<username>[/<password>][@<connect_identifier>] | / }
              [AS {SYSDBA | SYSOPER | SYSASM}] [EDITION=value]

    데이터베이스 접속에 필요한 데이터베이스 계정 사용자 이름, 비밀번호 및
    접속 식별자를 지정합니다. 접속 식별자를 지정하지 않으면
     식별자, SQL*Plus는 기본 데이터베이스에 접속합니다.

    AS SYSDBA, AS SYSOPER 및 AS SYSASM 옵션은 데이터베이스
    관리 권한입니다.

    <connect_identifier>는 네트 서비스 이름
    또는 쉬운 접속 형식이 될 수 있습니다.

      @[<net_service_name> | [//]Host[:Port]/<service_name>]

        <net_service_name>은 접속 기술자로 분석되는
        서비스에 대한 단순 이름입니다.

        예: 네트 서비스 이름을 사용하여 데이터베이스에 접속하십시오.
                 데이터베이스 네트 서비스 이름은 ORCL입니다.

           sqlplus myusername/mypassword@ORCL

        Host는 데이터베이스 서버 컴퓨터의 호스트 이름 또는 IP 주소를
        지정합니다.

        Port는 데이터베이스 서버의 수신 포트를 지정합니다.

        <service_name>은 액세스할 데이터베이스의 서비스 이름을
        지정합니다.

        예: 쉬운 접속을 사용하여 데이터베이스에 접속하십시오.
                 서비스 이름은 ORCL입니다.

           sqlplus myusername/mypassword@Host/ORCL

    /NOLOG 옵션은 데이터베이스에 접속하지 않고 SQL*Plus를
    시작합니다.

    EDITION은 세션 에디션에 대한 값을 지정합니다.


  <start>: @<URL>|<filename>[.<ext>] [<parameter> ...]

    웹 서버(URL) 또는 스크립트의 대체 변수에 지정될
    특정 매개변수를 가진 로컬 파일 시스템(filename.ext)에서
    지정된 SQL*Plus 스크립트를 실행합니다.

SQL*Plus가 시작되면 CONNECT 명령 후
사이트 프로파일(예: $ORACLE_HOME/sqlplus/admin/glogin.sql) 및
사용자 프로파일(예: 작업 디렉토리의 login.sql)이 실행됩니다.
파일에 SQL*Plus 명령이 포함되어 있을 수 있습니다.

자세한 내용은 SQL*Plus User's Guide and Reference를 참조하십시오.

C:\Users\Admin>sqlplus / as sysdba

SQL*Plus: Release 11.2.0.1.0 Production on 목 9월 10 11:54:36 2020

Copyright (c) 1982, 2010, Oracle.  All rights reserved.


다음에 접속됨:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> exit
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options에서 분리되었습니다.

C:\Users\Admin>sqlplus / as sysdba

SQL*Plus: Release 11.2.0.1.0 Production on 목 9월 10 11:55:30 2020

Copyright (c) 1982, 2010, Oracle.  All rights reserved.


다음에 접속됨:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> CREATE USER test01 IDENTIFIED BY increpas
  2  ;

사용자가 생성되었습니다.

SQL> SHOW USER;
USER은 "SYS"입니다
SQL> GRANT CREATE SESSION TO TEST01;

권한이 부여되었습니다.

SQL> CONN TEST01/increpas
연결되었습니다.
SQL> SELECT tname FROM tab;

선택된 레코드가 없습니다.

SQL> SHOW USER
USER은 "TEST01"입니다
SQL> CREATE TABLE TEST00(
  2  NO NUMBER(4)
  3  );
CREATE TABLE TEST00(
*
1행에 오류:
ORA-01031: 권한이 불충분합니다


SQL> CONNECT SYS/1234
ERROR:
ORA-28009: connection as SYS should be as SYSDBA or SYSOPER


경고: 이제는 ORACLE에 연결되어 있지 않습니다.
SQL> CONN SYS/1234 AS SYSDBA
연결되었습니다.
SQL> SHOW USER
USER은 "SYS"입니다
SQL> GRANT CREATE TABLE TO TEST01 WITH ADMIN OPTION;

권한이 부여되었습니다.

SQL> CONN TEST01;
비밀번호 입력:
ERROR:
ORA-01017: invalid username/password; logon denied


경고: 이제는 ORACLE에 연결되어 있지 않습니다.
SQL> CONN test01/test01
ERROR:
ORA-01017: invalid username/password; logon denied


SQL> CONN test01/increpas
연결되었습니다.
SQL> create table test00(
  2  no number(2)
  3  );

테이블이 생성되었습니다.

SQL> insert into test00
  2  values(
  3  11
  4  );
insert into test00
            *
1행에 오류:
ORA-01950: 테이블스페이스 'USERS'에 대한 권한이 없습니다.


SQL> grant insert any table to test00
  2  ;
grant insert any table to test00
*
1행에 오류:
ORA-01031: 권한이 불충분합니다


SQL> conn  /as sysdba
연결되었습니다.
SQL> show user
USER은 "SYS"입니다
SQL> CREATE USER test02 IDENTIFIED BY increpas;

사용자가 생성되었습니다.

SQL> GRANT CREATE SESSION TO TEST02;

권한이 부여되었습니다.

SQL> CONN TEST01/increpas
연결되었습니다.
SQL> GRANT CREATE TO TEST02;
GRANT CREATE TO TEST02
      *
1행에 오류:
ORA-01919: 롤 'CREATE'(이)가 존재하지 않습니다


SQL> GRANT CREATE TO TEST02;
GRANT CREATE TO TEST02
      *
1행에 오류:
ORA-01919: 롤 'CREATE'(이)가 존재하지 않습니다


SQL> GRANT CREATE TABLE TO TEST02;

권한이 부여되었습니다.

SQL> SHOW USER
USER은 "TEST01"입니다
SQL> GRANT SELECT ANY TABLE TO TEST02;
GRANT SELECT ANY TABLE TO TEST02
*
1행에 오류:
ORA-01031: 권한이 불충분합니다


SQL> GRANT CREATE SESSION TO TEST02;
GRANT CREATE SESSION TO TEST02
*
1행에 오류:
ORA-01031: 권한이 불충분합니다


SQL> CON SYS/INCREPAS
SP2-0734: "CON SYS/IN..."(으)로 시작되는 알 수 없는 명령 - 나머지 줄은 무시되었습니다.
SQL> CON SYS/increpas as sysdba
SP2-0734: "CON SYS/in..."(으)로 시작되는 알 수 없는 명령 - 나머지 줄은 무시되었습니다.
SQL> conn sys/increpas as sysdba
연결되었습니다.
SQL> grant create session to test 00 with admin option;
grant create session to test 00 with admin option
                             *
1행에 오류:
ORA-00933: SQL 명령어가 올바르게 종료되지 않았습니다


SQL> grant create session to test00 with admin option;
grant create session to test00 with admin option
                        *
1행에 오류:
ORA-01917: 사용자 또는 롤 'TEST00'(이)가 존재하지 않습니다


SQL> grant create session to test01 with admin option;

권한이 부여되었습니다.

SQL> conn test01
비밀번호 입력:
연결되었습니다.
SQL> grant create session to test02;

권한이 부여되었습니다.

SQL> conn sys/increpas as sysdba
연결되었습니다.
SQL> create user test03 identified by increpas;

사용자가 생성되었습니다.

SQL> conn test01
비밀번호 입력:
연결되었습니다.
SQL> show user
USER은 "TEST01"입니다
SQL> grant create session to test03;

권한이 부여되었습니다.

SQL> conn test02/increpas
연결되었습니다.
SQL> grant create session to test03;
grant create session to test03
*
1행에 오류:
ORA-01031: 권한이 불충분합니다


SQL> conn test01/increpas
연결되었습니다.
SQL> show user
USER은 "TEST01"입니다
SQL> revoke create session from test03;

권한이 취소되었습니다.

SQL> exit
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options에서 분리되었습니다.

C:\Users\Admin>sqlplus test03/increpas

SQL*Plus: Release 11.2.0.1.0 Production on 목 9월 10 13:53:48 2020

Copyright (c) 1982, 2010, Oracle.  All rights reserved.

ERROR:
ORA-01045: user TEST03 lacks CREATE SESSION privilege; logon denied


사용자명 입력: test01
비밀번호 입력:

다음에 접속됨:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> grant create session to test03;

권한이 부여되었습니다.

SQL> exit
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options에서 분리되었습니다.

C:\Users\Admin>sqlplus test03/increpas

SQL*Plus: Release 11.2.0.1.0 Production on 목 9월 10 13:55:24 2020

Copyright (c) 1982, 2010, Oracle.  All rights reserved.


다음에 접속됨:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> CREATE TABLE TO TEST02 WITH GRANT OPTION;
CREATE TABLE TO TEST02 WITH GRANT OPTION
             *
1행에 오류:
ORA-00903: 테이블명이 부적합합니다


SQL> GRANT CREATE TABLE TO TEST02 WITH GRANT OPTION;
GRANT CREATE TABLE TO TEST02 WITH GRANT OPTION
                                  *
1행에 오류:
ORA-01939: ADMIN OPTION만이 지정될 수 있습니다


SQL> REVOKE SELECT ANY TABLE FROM TEST01;
REVOKE SELECT ANY TABLE FROM TEST01
*
1행에 오류:
ORA-01031: 권한이 불충분합니다


SQL> CONN sys/increpas as sysdba
연결되었습니다.
SQL> REVOKE SELECT ANY TABLE FROM TEST01;
REVOKE SELECT ANY TABLE FROM TEST01
*
1행에 오류:
ORA-01952: 시스템 권한이 'TEST01'에 허가되지 않았습니다


SQL> GRANT SELECT ON scott.emp TO test01;

권한이 부여되었습니다.

SQL> conn test01/increpas
연결되었습니다.
SQL> SELECT * FROM scott.emp;

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM
---------- ---------- --------- ---------- -------- ---------- ----------
    DEPTNO
----------
      7369 SMITH      CLERK           7902 80/12/17        800
        20

      7499 ALLEN      SALESMAN        7698 81/02/20       1600        300
        30

      7521 WARD       SALESMAN        7698 81/02/22       1250        500
        30


     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM
---------- ---------- --------- ---------- -------- ---------- ----------
    DEPTNO
----------
      7566 JONES      MANAGER         7839 81/04/02       2975
        20

      7654 MARTIN     SALESMAN        7698 81/09/28       1250       1400
        30

      7698 BLAKE      MANAGER         7839 81/05/01       2850
        30


     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM
---------- ---------- --------- ---------- -------- ---------- ----------
    DEPTNO
----------
      7782 CLARK      MANAGER         7839 81/06/09       2450
        10

      7788 SCOTT      ANALYST         7566 87/04/19       3000
        20

      7839 KING       PRESIDENT            81/11/17       5000
        10


     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM
---------- ---------- --------- ---------- -------- ---------- ----------
    DEPTNO
----------
      7844 TURNER     SALESMAN        7698 81/09/08       1500          0
        30

      7876 ADAMS      CLERK           7788 87/05/23       1100
        20

      7900 JAMES      CLERK           7698 81/12/03        950
        30


     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM
---------- ---------- --------- ---------- -------- ---------- ----------
    DEPTNO
----------
      7902 FORD       ANALYST         7566 81/12/03       3000
        20

      7934 MILLER     CLERK           7782 82/01/23       1300
        10


14 개의 행이 선택되었습니다.

SQL> SELECT * FROM scott.dept;
SELECT * FROM scott.dept
                    *
1행에 오류:
ORA-00942: 테이블 또는 뷰가 존재하지 않습니다


SQL> conn sys/increpas as sysdba
연결되었습니다.
SQL> grant select on scott.dept to test01;

권한이 부여되었습니다.

SQL> conn test01/increpas;
연결되었습니다.
SQL> select * from scott.dept;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        10 ACCOUNTING     NEW YORK
        20 RESEARCH       DALLAS
        30 SALES          CHICAGO
        40 OPERATIONS     BOSTON

SQL> select * from dept;
select * from dept
              *
1행에 오류:
ORA-00942: 테이블 또는 뷰가 존재하지 않습니다


SQL> conn sys/increpas as sysdba;
연결되었습니다.
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL> grant select on scott.emp to test01 with admin option
  2  ;
grant select on scott.emp to test01 with admin option
                                         *
1행에 오류:
ORA-00993: GRANT 키워드가 없습니다


SQL> show user
USER은 "SYS"입니다
SQL> grant select on scott.emp to test01 with grant option
  2  ;

권한이 부여되었습니다.

SQL> conn test01/increpas
연결되었습니다.
SQL> grant select on scott.emp to test02;

권한이 부여되었습니다.

SQL> CON SYS/INCREPAS AS SYSDBA
SP2-0734: "CON SYS/IN..."(으)로 시작되는 알 수 없는 명령 - 나머지 줄은 무시되었습니다.
SQL> CONN SYS/INCREPAS AS SYSDBA
연결되었습니다.
SQL> DROP USER TEST03;

사용자가 삭제되었습니다.

SQL> GRANT CREATE TABLE TO TEST02;

권한이 부여되었습니다.

SQL> CONN TEST02;
비밀번호 입력:
ERROR:
ORA-01017: invalid username/password; logon denied


경고: 이제는 ORACLE에 연결되어 있지 않습니다.
SQL> CONN TEST03/INCREPAS
ERROR:
ORA-01017: invalid username/password; logon denied


SQL> CONN TEST02/INCREPAS
ERROR:
ORA-01017: invalid username/password; logon denied


SQL> CONN test02/increpas
연결되었습니다.
SQL> create table test(
  2  no num(2)
  3  );
no num(2)
      *
2행에 오류:
ORA-00907: 누락된 우괄호


SQL> create table test(
  2  no number(2)
  3  );

테이블이 생성되었습니다.

SQL> insert into test values(11);
insert into test values(11)
            *
1행에 오류:
ORA-01950: 테이블스페이스 'USERS'에 대한 권한이 없습니다.


SQL> con sys/increpas as sysdba
SP2-0734: "con sys/in..."(으)로 시작되는 알 수 없는 명령 - 나머지 줄은 무시되었습니다.
SQL> con\n sys/increpas as sysdba
SP2-0734: "con\n sys/..."(으)로 시작되는 알 수 없는 명령 - 나머지 줄은 무시되었습니다.
SQL> conn sys/increpas as sysdba
연결되었습니다.
SQL> grant resource to test02;

권한이 부여되었습니다.

SQL> conn test02/increpas
연결되었습니다.
SQL> insert into test values(11);

1 개의 행이 만들어졌습니다.

SQL> commit;

커밋이 완료되었습니다.

SQL> conn sys/increpas as sys dba
SP2-0306: 부적당한 옵션입니다.
사용법: CONN[ECT] [{logon|/|proxy} [AS {SYSDBA|SYSOPER|SYSASM}] [edition=value]]
설명: <logon> = <username>[/<password>][@<connect_identifier>]
      <proxy> = <proxyuser>[<username>][/<password>][@<connect_identifier>]
SQL> conn sys/increpas as sysdba
연결되었습니다.
SQL> drop user test02;
drop user test02
*
1행에 오류:
ORA-01922: 'TEST02'(을)를 삭제하려면 CASCADE를 지정하여야 합니다


SQL> drop user test02 cascade;

사용자가 삭제되었습니다.

SQL>
*/


-------------------------------------------------------------------------------
/*
    롤(ROLE)
    ==> 관련된 권한을 모아놓은 객체(권한들의 묵음,세트)를 의미
    
    따라서 롤을 사용한 권한부여란?
    여러개의 구너한을 한번에 동시에 부여하는 방법
--------------------------------------------------------------------------------
    롤을 이용한 권한 부여 방법
        1. 이미 만들어진 롤을 이용하는 방법
        
            1) CONNECT
                ==> 주로 CREATE와 관련된 권한을 모아놓은 ROLL
            2) RESOURCE
                ==> 사용자 객체 생성에 관련된 권한을 모아놓은 ROLL
            
            3) DBA
                ==> 관리자 계정에서 필요한 권한을 모아놓은 ROLL
                
            권한 부여 방법 ]
                GRANT 롤이름, 롤이름,... TO 계정이름;
        2. 직접 롤을 만들어서 권한을 부여하는 방법
            ==> 롤 안에 필요한 권한들을 사용자가 지정한 후 사용하는 방법.
            
            방법 ]
                1) 롤을 만든다.
                    CREATE ROLE 롤이름;
                2) 롤에 권한을 부여한다.
                    GRANT 권한, 권한,... TO 롤이름
                3) 계정에게 만들어진 롤로 권한을 부여한다.
                    GRANT 롤이름 TO 계정
*/
-----------------------------------------------------------------------------------
--> SYSTEM 계정에서 작업.
DROP USER TEST01 CASCADE;
DROP USER TEST02 CASCADE;
DROP USER TEST03 CASCADE;
DROP USER TEST04 CASCADE;

-- TEST01 계정을 만든다
CREATE USER TEST01 IDENTIFIED BY INCREPAS;
--TEST01에 CONNECT 롤을 부여한다
GRANT CONNECT TO TEST01;
-- 접속이 되면 CREATE SESSION 권한을 가지고 있다는 것이 된다.

GRANT RESOURCE TO TEST01;
-- CMD창 SQLPLUS에서
--CREATE TABLE TMP00 을 해본다
CREATE TABLE TMP00(
    NO NUMBER(2)
    )
    ;
-- SYSTEM 계정에서 TEST01에게 모든 테이블을 조회할수 있는 권한을 준다.
GRANT SELECT ANY TABLE TO TEST01;
--SYSTEM 계정에서
CREATE USER TEST02 IDENTIFIED BY INCREPAS;

--권한부여
GRANT CONNECT, RESOURCE, SELECT ANY TABLE TO TEST02;


------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- 롤을 만들어서 권한을 부여하는 방법
--TEST02를 만든다.
DROP USER TEST02 CASCADE;
CREATE USER TEST02 IDENTIFIED BY INCREPAS;

--롤을 만든다 LOL로 만든다.
CREATE ROLE LOL;
-- 롤에 권한을 부여한다
GRANT CONNECT, RESOURCE,SELECT ANY TABLE TO LOL;
-- 계정에 만들어진 롤로 권한을 부여한다.
GRANT LOL TO TEST02;

-------------------------------------------------------------------------------

/*
    롤을 회수하는 방법
    REVOKE 롤이름 FROM 계정이름
*/

REVOKE LOL FROM TEST02;
/*
    롤 삭제하는 방법
    DROP ROLE 롤이름
*/
DROP ROLE LOL;
------------------------------------------------------------------------------

/*
    동의어(SYNONYM)
    ==> 테이블 자체에 별칭을 부여해서 
        여러 사용자가 각각의 이름으로 하나의 테이블을 사용하도록 하는 것.
        
        즉, 실제 객체(테이블, 뷰, 시퀀스, 프로시져)등의 이름을 감추고
        사용자에게 별칭을 알려줘서
        객체를 보호하는 방법
        
        우리가 포털사이트에서 우리의 이름대신 ID를 사용하는 것과 마찬가지로 
        정보 보호를 목적으로 실제 이름을 감추기 위한 방법
        
    주로 다른 계정을 사용하는 사용자가
    테이블 이름을 알면 곤란하기 때문에
    이들에게는 거짓 테이블을 알려주어서
    실제 테이블 이름을 감추기 위한 목적으로 사용을 한다.
    
    형식 ]
        CREATE [PUBLIC] SYNONYM 동의어이름
        FOR
            실제 객체이름;
            
        설명
        PUBLIC - 생략되면 이 동의어는 같은 계정에서만 사용하는 동의어가 된다.
                (권한을 주면 다른 계정에서도 사용할 수 있긴 하다.)
                
                사용되면 자동적으로 다른 계정에서도 이 동의어를 이용해서 테이블을 사용할 수 있게 된다.
    
*/
GRANT CREATE ANY SYNONYM TO HELLO;
--> HELLO 계정에서 실행
CREATE SYNONYM T_EMP
FOR
    SCOTT.EMP;
    
SELECT * FROM T_EMP;

/*
    PUBLIC 동의어 만들기
    ==> 모든 계정에서 특정 객체(테이블, 뷰, 시퀀스,...)를 사용할 수 있도록 하는 것..
    
    예] hello 계정이 가지고잇는 뷰 dsal을 deptsal로 별칭을 만들어서 모든 계정에서
    사용하도록 해보자.
    
        방법 ]
            1. 사용할 객체를 public 사용이 가능하도록 등록한다.
            2. 관리자계정에서 사용할 객체의 별칭을 만든다.
            3. 사용할때는 별칭으로 사용하면 된다.
*/

--1.
GRANT SELECT ON DSAL TO PUBLIC;

--2.
CREATE PUBLIC SYNONYM DEPT_SAL
FOR HELLO.DSAL;

--3.
select * from dept_sal;

------------------------------------------------------------------------------