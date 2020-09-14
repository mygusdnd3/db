--day10

/*
    PL/SQL(PROCEDURE LANGUAGE/STRUCTURED QUERRY LANGUAGE
    ==> 자바의 프로그램처럼
        오라클에서 사용하는 질의명령을 여러개모아서
        순차적으로 실행시키는 일종의 프로그램을 말한다.
        
    장점 ]
        1. 프로그램화 해서 다수의 sql을 수행하게 하믕로
            수행 속도를 향상시킬 수 있다.
        2. 모듈화(부품화)가 가능해서
            필요한 기능만 골라서
            여러개의 프로그램을 연결해서 사용할 수 이삳.
            ==> 질의명령을 제작함에 있어서 편리하다.
        3. 동적 변수를 사용할 수 있기 때문에
            변경된 데이터를 이용해서 
            질의명령을 수행할 수 있다.
            ==> 동일한 질의 명령은 한번만 만든 후
                데이터만 바꿔서 실행할 수 있다.
        
        4. 예외처리가 가능해서
            문제가 발생할 경우 이것을 수정 처리할 수 있다.
    
    
        종류 ]
            1.익명(무명) 프로시져   - 재사용안됨
                ==>프로그램을 코드를 제작한 후(질의 명령을 모아놓은 후) 프로그램이 완료되면
                    즉시 실행할 수 있는 PL/SQL을 말한다.
            
            2. 일반(저장) 프로시져 --무명클래스에 이름을 붙여뒀다, 오라클에 객체로 저장
                ==> 프로시져에 이름을 부여한 것을 말하고
                    필요할 때 선택해서 실행할 수 있는 PL/SQL을 말한다.
                    오라클에 '개체'로 저장된다.(재사용가능)
            3. 함수(function)
                ==> 우리가 알고있는 함수의 개념이다
                    '사용자가 만든 사용자정의 함수로' 이야기하고
                    나중에 질의 명령을 처리할때 그 질의 명령에
                    포함시켜 사용하는 PL/SQL을 말한다
            4. 기타 프로시져
                ==> 트리거(특정상황에 실행) , 스케쥴러,..의 특별한 기능을 가진 PL/SQL을 말한다.
                
-----------------------------------------------------------------------------------

    PL/SQL의 구조
     기본형식]
        DECLEARE
            선언부( 프로그램에 필요한 변수, ...을 선언하는 부분)
        BEGIN
            실행부( 실제 필요한 질의 명령을 만들고 이것을 제어하는 부분 )
       [ EXCEPTION-써도되고 안해도되고
            예외처리부분 ]
        END;
        /
    1. 무명 프로시저
    
        형식 ]
            DECLARE
                변수 선언
            BEGIN
                실행부..
            END;
        
*/



--1. 무명 프로시져
DECLARE
    --선언부
    x NUMBER;
BEGIN
    x := 1000; -- PL/SQL 대입명령 연산자는 :=
    DBMS_OUTPUT.PUT_LINE('결과 = '); --PL/SQL 출력 명령어
    -- DBMS_OUTPUT.PUT_LINE() : JAVA의 PRINT()와 같은 함수
    DBMS_OUTPUT.PUT_LINE(x);
END;
/   -- 프로시져는 끝부분에는 반드시 '/'가 붙여져야 한다.
/*
    무명 프로시져 사용방법
        1. 프로시져를 만들어서 파일에 저장해 놓는다.
            이때 확장자는 중요하지 않다.
        2. sqlplus에서 실행한다.
            1.@파일경로
                ==> 실행결과만 출력한다.
                @C:\Users\Admin\Desktop\학원\학원선생님\db\dbcls\sql\test_prog01.sql
            2. run 파일경로
                ==> 실행 코드와 결과
            run C:\Users\Admin\Desktop\학원\학원선생님\db\dbcls\sql\test_prog01.sql
            3. get 파일경로
                ==> 실행경로만 출력한다.
            get C:\Users\Admin\Desktop\학원\학원선생님\db\dbcls\sql\test_prog01.sql
*/
/*
    SQLDEVELOPER에서 프로시져 화면을 보는방법
        보기 메뉴에서 --> 'DBMS 출력' -->'DBMSD 출력창'에서 '+'버튼을 클릭해서
        실행접속을 추가해준다.
        
    cmd에서 실행 결과 보려면보려면
    set serveroutput on 을 먼저 선언해주어야 한다.
*/
--파일에 저장된 무명 프로시져 실행하는 방법
--@C:\Users\Admin\Desktop\학원\학원선생님\db\dbcls\sql\test_prog01.sql



------------------------------------------------------------------------
/*
    함수 만들기
        ==> 함수는 오라클 내부에 함수를 저장한 후
            다른 질의 명령을 사용할 때 부가적으로 사용하는 것.
            
        형식 ]
        
            CREATE OR REPLACE FUNCTION 함수이름
            RETURN 타입
            AS
                변수 선언
            BEGIN
                실행부
            END;
            /
        참고 ]
            자바와 마찬가지로
            함수는 아무리 훌륭한 기능을 가지고 있어도
            호출하지 않으면 무용지물이다.
*/

-- 호출하면 999를 반환해주는 함수
CREATE OR REPLACE FUNCTION func01
RETURN NUMBER
AS
    x NUMBER;
BEGIN
    x := 999;
    RETURN X;
END;
/
--Function FUNC01이(가) 컴파일되었습니다.
-- 호출해야 실행된다 이말이야

SELECT FUNC01() 숫자 FROM DUAL;

SELECT
    EMPNO, ENAME SAL, COMM 커미션, NVL(COMM,0)+FUNC01 희망커미션
FROM 
    EMP
;

/*
    3. 일반(저장) 프로시져
        형식 ]
            CREATE OR REPLACE PROCEDURE 프로시져 이름
            (
                변수선언
            )
            AS
            BEGIN
                실행부
            END;
            /
            ==> 컴파일 해주고
            실행은 함수처럼 호출해서 실행해야한다.
            실행형식 ]
            
                execute 프로시져이름(파라미터);
                exec 프로시져이름(파라미터);
*/

-- 실습 준비 ] 이름, 나이를 저장한 PEOPLE 테이블을 만든다.
CREATE TABLE people(
    name VARCHAR2(10 CHAR),
    age NUMBER(3)
);

INSERT INTO PEOPLE VALUES('둘리',999);
INSERT INTO PEOPLE VALUES('희동이',3);

-- 나이를 입력받아서 그 나이에 해당하는 사람의 나이를 10살로 수정하는 프로시져를 만들어보자
CREATE OR REPLACE PROCEDURE PROC01
( -- 변수선언
    inage IN INTEGER
    )
    AS
    BEGIN
        UPDATE
            people  --어디있는얘를 바꿀건지
        SET
            age = 10
        WHERE
            age = inage
            ;
        DBMS_OUTPUT.PUT_LINE('***프로시져 실행 완료 ***');
    END;
  /
select * from people;  

exec PROC01(999);
exec PROC01(3);

-- 일반 프로시져를 만드는데 이름을 입력받아서 그 사람의 나이를 5살로 변경하는 프로시져를 작성하라
-- 프로시져 이름은 PROC03로 한다

CREATE OR REPLACE PROCEDURE PROC02(
    in_name IN STRING
)
AS
BEGIN
    UPDATE
        PEOPLE
    SET
        age = 5
    WHERE
        name = in_name;
    DBMS_OUTPUT.PUT_LINE('*****[ ' || in_name || ']]의 나이를 5세로 수정했습니다.***');
END;
/

exec proc02('둘리');
select * from EMP;
EXEC PROC02('SMITH');


-- emp01 테이블의 데이터를 모두 지우고, emp테이블에 있는 데이터로 대체하는 프로시져를 만든다.

CREATE OR REPLACE PROCEDURE R_EMP
AS
BEGIN
    DELETE FROM EMP01;
    INSERT INTO EMP01
    SELECT* FROM EMP;
END;
/

EXEC R_EMP;
SELECT * FROM EMP01;
ALTER TABLE EMP01;
DELETE FROM EMP01 WHERE EMPNO=1001;
-------------------------------------------------------------------------
/*
    위 세가지를 혼합해서 사용할 수 있다.
    
    1. 무명 프로시져 내부에 함수를 포함해서 만드는 방법
    
    2. 무명 프로시져 내부에 일반 프로시져를 포함하는 방법
    
    3. 무명 프로시져 내부에 무명 프로시져를 포함해서 만드는 방법
*/
-- 1. 무명 프로시져 내부에 함수를 포함해서 만드는 방법
set serveroutput on;
run @C:\Users\Admin\Desktop\학원\학원선생님\db\dbcls\sql\TEST01.SQL;

--   2. 무명 프로시져 내부에 일반 프로시져를 포함하는 방법


@C:\Users\Admin\Desktop\학원\학원선생님\db\dbcls\sql\TEST02.SQL;

--3. 무명 프로시져 내부에 무명 프로시져를 포함해서 만드는 방법
@C:\Users\Admin\Desktop\학원\학원선생님\db\dbcls\sql\TEST03.SQL

/*
    일반(저장) 프로시져 만드는 방법
    ==> 장점 ]
            한번만 만들면 필요할 때 언제든지 그 이름을 이용해서 사용할 수 잇따.
            
    형식 ]
    
        CREATE OR REPLACE PROCEDURE 프로시져이름(
            파라미터변수선언(넘겨받을변수)
        )
        IS
            프로시져 내부에서 사용할 변수를 선언
        BEGIN
            -- 실행부 : 처리내용을 기술하는 부분
        [EXCEPTION
            예외처리 ]
        END;
        /
        
        참고 ]
            파라미터 변수
                형식 ]
                  변수이름 IN 또는 OUT 또는 IN OUT 변수타입;
            의미]
                이 프로시져를 실행할 때 전달되어지는 값이나(IN)
                데이터를 전달 할(OUT) 수 있으며
               ...
                
                이 프로시져를 실행할 때 전달되어지는 값이나(IN)
                이 프로시져의 결과를 알려줄때 사용할 변수(OUT) 선언
                
            예 ]
                EXEC TEST(100);
                ==> 이처럼 프로시져를 실행하는 순간
                    데이터를 전달할 수 있으며
                    이 전달된 데이터를 기억할 변수를 파라미터 변수라고 이야기한다.
                    
        참고 ]
        
            내부 변수 선언
            ==> 프로시져를 실행할 때 필요한(내부적으로 사용하게될) 변수를 선언하는 부분
                
                형식1 ]   -- 선언만
                    변수이름    변수타입;
                    예 ]
                        age NUMBER;
                형식2 ]   --선언과 동시에 초기화
                    변수이름    변수타입    := 데이터;
                    예
                    name VARCHAR2(10 CHAR) := '홍길동';
                
                형식3 ]
                    변수이름    변수타입    NOT NULL : = 데이터
                    
                    ==> 일반 변수는 값을 기억하지 않으면 NULL 값을 가지게 되는데
                        이 변수는 NULL 을 허용하지 않는 변수로
                        반드시 초기화가 되어야 하는 변수임을 밝히는 것이다.
                    (초기화를 강제로 하면 NOT NULL을 쓰지 않아도 되지만 가독성을 위한 것이다)
                    
                형식4 ]
                    변수이름 CONSTNT    변수타입 := 값;
                    ==> 자바에서의 FINAL 변수에 해당하는 것으로,
                        데이터를 바꿀 수 없는 변수를 이야기 한다.
                        
        참고 ]
            변수 타입은 오라클 변수 타입도 사용할 수 있고
            ANSI 타입도 사용할 수 잇다.
            예]
                BOOLEAN,INTEGER,...
            
*/

--EMP01의 사원중 급여가 입력되는 급여 미만 사원은 급여를 10% 인상처리하는 프로시져를 작성하세요

-- 프로시져 작성 SAL_UP
CREATE OR REPLACE PROCEDURE SAL_UP(
    vsal IN NUMBER
    -- 이 프로시져를 실행할때 입력되는 급여를 기억할 변수를 선언하는 부분
)
IS
    -- 프로시져 내부에 사용할 목적으로 만드는 변수를 선언하는 부분
    -- 내용이 없으면 아무것도 안써도 무방하다.
    -- 단, IS 는 반드시 써놔야한다.
BEGIN
    --실행부 -- 실행할 질의명령이 기술되는 부분.
    UPDATE
        EMP01
    SET
        SAL = SAL*1.1   
        WHERE
        SAL <VSAL
    ;
    --위의 업데이트 구문이 실행된 상태로 이 프로시져가 종료가 되면
    --트랜젝션 처리는 되지 않고 실행이 끝나버린다.
    --따라서 필요하다면 트랜젝션을 강제로 일으켜야 한다.
    COMMIT;
    --이렇게 처리하면 이 프로시져가 실행되면 바로 데이터베이스에 적용까지 시켜버린다.
    
    --메세지 출력
    DBMS_OUTPUT.PUT_LINE('['|| VSAL ||'] 미만 사원의 급여를 10% 인상했습니다');
END;
/

EXEC SAL_UP(1000);
SELECT * FROM EMP01;


-- 사원 번호를 알려주면 그 사원의 이름과 직급, 급여를 출력해주는 프로시져를 만드세요
CREATE OR REPLACE PROCEDURE e_info(
    --입력 데이터를 기억할 변수를 선언
        no IN NUMBER
)
IS
    --출력에 사용할 변수를 준비
    vname VARCHAR2(10 CHAR);
    vjob VARCHAR(10 CHAR);
    vsal NUMBER;
BEGIN
    -- 결과를 출력하기 위해선 SQLPLUS가 출력가능 상태가 되어야 한다.
    -- 출력가능 상태로 만드는 명령이 필요하다
    -- 즉, 이 프로시저에서 출력가능하도록 하기 위한 조치
    DBMS_OUTPUT.ENABLE;
    
    SELECT
        ename,job,sal
    INTO
        vname,vjob,vsal
    FROM
        EMP01
    WHERE
     no = EMPNO
     ;
     -- 출력한다.
     DBMS_OUTPUT.PUT_LINE('입력된 사원번호 : '|| no);
     DBMS_OUTPUT.PUT_LINE('사원 이름 : '|| vname);
     DBMS_OUTPUT.PUT_LINE('사원 직급 : '|| vjob);
     DBMS_OUTPUT.PUT_LINE('사원 급여 : '|| vsal);
     
END;
/
--프로시져 실행
exec e_info(7499);

/*
    문제 1]
        emp01 테이블에서 이름이 특정 글자수인 사람들의 급여를 20%인상하는
        프로시져를 작성해서 실행하세요
        
    문제 2]
        사원 번호를 입력하면 사원의 이름, 직급, 부서이름, 부서위치를 출력해주는 프로시져
        E_INFO02를 작성하여실행하세요
*/

CREATE OR REPLACE PROCEDURE SAL_UP02(
    namecnt IN NUMBER
)
IS
    
BEGIN
    UPDATE
        EMP01
    SET 
        SAL = SAL*1.2
    WHERE
        LENGTH(ename) = NAMECNT
    ;
    
    DBMS_OUTPUT.PUT_LINE('이름이 '|| namecnt||'인 사원의 급여를 20%인상했습니다');
    
END;
/

EXEC SAL_UP02(4);
SELECT* FROM EMP01 WHERE LENGTH(ENAME)=4;

/*
 문제 2]
        사원 번호를 입력하면 사원의 이름, 직급, 부서이름, 부서위치를 출력해주는 프로시져
        E_INFO02를 작성하여실행하세요
*/

CREATE OR REPLACE PROCEDURE e_info02(
    vempno IN NUMBER
)
IS
    vename VARCHAR2(10 CHAR);
    vjob VARCHAR2(10 CHAR);
    vdname VARCHAR2(10 CHAR);
    vloc VARCHAR2(10 CHAR);

BEGIN
    DBMS_OUTPUT.ENABLE;
    SELECT 
        ename,job,dname,loc
    INTO 
        vename,vjob,vdname,vloc
    FROM
        EMP01,DEPT
    WHERE
        EMP01.DEPTNO = DEPT.DEPTNO
        AND vempno = empno;
        
    DBMS_OUTPUT.PUT_LINE('입력하신 사원 번호 :' ||vempno);    
    DBMS_OUTPUT.PUT_LINE('사원이름 :' || vename);
    DBMS_OUTPUT.PUT_LINE('사원직급 :' || vjob);
    DBMS_OUTPUT.PUT_LINE('부서이름 :' || vdname);
    DBMS_OUTPUT.PUT_LINE('부서위치 :' || vloc);
    
    
END;
/

exec e_info02(7902);

-----------------------------------------------------------------------------
/*
    INTO
        ==> SELECT 된 결과를 출력하기 위해서는 변수에 기억시켜야 하는데
            조회된 결과를 변수에 옮기기 위한 예약어가 INTO이다.
            
            규칙]
                SELECT절의 필드의 갯수, 타입이 동일해야한다.
                
-----------------------------------------------------------------------------
    
        %TYPE에 의한 변수 선언
            ==> 변수를 선언할 때 질의의 결과와 연관된 변수가 존재한다.
                이때 크기가 다르면 문제가 발생할 수 있다.
                그리고 이 문제는 데이터베이스가 변경이 되어버리면 이미 작성해둔
                프로시져들의 변수들도 수정을 해야한다
                
                이런 경우를 대비해서 테이블의 필드의 타입과 길이를 자동으로 지정해서
                변수를 선언하는 방법이 있다.
                    %TYPE
                에 의한 변수 선언 방법이다.
                이것은 이미 만들어진 타입을 그대로 복사해서
                동일한 타입의 변수로 만드는 방법이다.
                
                1. 이미 만들어진 변수와 동일한 방법으로 만드는 방법
                    나중변수    이전변수%TYPE;
                예 ]
                    INO NUMBER(3)   -만들었던거
                    VNO INO%TYPE;   - 새로이만드는?
                            - INO와 동일한 타입과 길이로 변수 VNO를 만든다.
                2. 데이터베이스에 정의된 필드와 동일한 타입으로 만드는 방법
                    형식]
                        변수이름    테이블이름.필드이름%TYPE
                        
                    예 ] 
                        BUSEO   DEPT.DNAME%TYPE
                        --> BUSEO변수를 DEPT테이블의 DNAME과 같은 타입으로 만들어주세요
                    
                        
*/
/*
 문제 2-1]
        사원 번호를 입력하면 사원의 이름, 직급, 부서이름, 부서위치를 출력해주는 프로시져
        E_INFO02를 작성하여실행하세요
*/


CREATE OR REPLACE PROCEDURE e_info021(
    --입력받을 사원번호 기억할 변수
    vempno emp.empno%type
)
IS
    vename emp.ename%type;
    vjob emp.job%type;
    vdname dept.dname%type;
    vloc dept.loc%type;

BEGIN
    DBMS_OUTPUT.ENABLE;
    SELECT 
        ename,job,dname,loc
    INTO 
        vename,vjob,vdname,vloc
    FROM
        EMP01,DEPT
    WHERE
        EMP01.DEPTNO = DEPT.DEPTNO
        AND vempno = empno;
        
    DBMS_OUTPUT.PUT_LINE('입력하신 사원 번호 :' ||vempno);    
    DBMS_OUTPUT.PUT_LINE('사원이름 :' || vename);
    DBMS_OUTPUT.PUT_LINE('사원직급 :' || vjob);
    DBMS_OUTPUT.PUT_LINE('부서이름 :' || vdname);
    DBMS_OUTPUT.PUT_LINE('부서위치 :' || vloc);
    
    
END;
/

exec e_info021(7902);