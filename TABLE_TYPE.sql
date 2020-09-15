CREATE OR REPLACE PROCEDURE TEST_T(
    iname emp01.ename%type   
)
IS
    TYPE T IS RECORD(
        vnum emp01.empno%type,
        vname emp01.ename%type,
        vsal emp01.sal%type
    );
    
    cnt BINARY_INTEGER := 0;
    TYPE VT IS TABLE OF T
    INDEX BY BINARY_INTEGER;
    
    vres VT;
    
    
BEGIN
    FOR data IN (SELECT EMPNO,ENAME, SAL FROM EMP01)LOOP
        CNT:=CNT+1;
        
        vres(cnt).vnum := data.empno;
        vres(cnt).vname := data.ename;
        vres(cnt).vsal := data.sal;
    END LOOP;
    
    FOR i IN 1..cnt LOOP
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||vres(i).vnum||
                        ' 사원이름 : '||vres(i).vname||
                         '사원급여 : '||vres(i).vsal);
    END LOOP;
END;
/

EXEC TEST_T('SMITH');

/*
    사원이름과 급여를 입력.받아서
    입력받은 사원의 소속 부서의 최소급여자의 급여를 입력급여로 변경하는
    프로시져를 만들고 실행하세요
    단, 커서를 이용한 조건처리구문(WHERE CURRENT OF)을 사용해서 처리하세요

*/

/*
    CURSOR 예제 ]
        부서번호를 입력하면
        부서이름, 평균급여, 사원수를 출력하는 프로시져를 작성하세요.
        단, 질의명령을 커서를 이용해서 처리하세요
        
        차
*/