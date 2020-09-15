CREATE TABLE EMP01
AS
SELECT *
FROM SCOTT.EMP
;

CREATE TABLE DEPT
AS
SELECT *
FROM SCOTT.DEPT
;


CREATE OR REPLACE PROCEDURE PROC10(
    iname IN emp01.ename%type
)
IS
    TYPE T IS RECORD(
     vname emp01.ename%type,
     vempno emp01.empno%type
     
     );
    TYPE vtable IS TABLE OF T
    INDEX BY BINARY_INTEGER;
    vres vtable;
    
    cnt BINARY_INTEGER :=0;
    
BEGIN    
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('111111111111111111111111111111');
    FOR data IN(SELECT 
                    ENAME,empno
                FROM 
                    EMP01 E , DEPT D
                WHERE 
                   ename = iname
                   
                   
                )LOOP
                cnt := cnt+1;
                DBMS_OUTPUT.PUT_LINE(cnt);
            vres(cnt).vname :=data.ename;
            vres(cnt).vempno :=data.empno;
            
                 
                            
    END LOOP;
    FOR i IN 1..cnt LOOP
    DBMS_OUTPUT.PUT_LINE(VRES(i).vname);
    DBMS_OUTPUT.PUT_LINE(VRES(i).vempno);
  
    END LOOP;
      
END;
/


CREATE OR REPLACE PROCEDURE PROC10(
    iname IN emp01.ename%type
)
IS
    TYPE T IS RECORD(
     vname emp01.ename%type,
     vempno emp01.empno%type
    
     );
     cnt BINARY_INTEGER :=0;
    TYPE vtable IS TABLE OF T
    INDEX BY BINARY_INTEGER;
    vres vtable;
    
    
    
BEGIN    
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('111111111111111111111111111111');
    FOR data IN(SELECT 
                    ENAME,empno
                FROM 
                    EMP01 
                WHERE 
                    ename = iname
                   
                )LOOP
                cnt := cnt+1;
                DBMS_OUTPUT.PUT_LINE(cnt);
                vres(cnt).vname := data.ename;
                vres(cnt).vempno := data.empno;
                 
                            
    END LOOP;
    FOR i IN 1..cnt LOOP
    DBMS_OUTPUT.PUT_LINE(vres(i).vname);
    DBMS_OUTPUT.PUT_LINE(vres(i).vempno);
    DBMS_OUTPUT.PUT_LINE('444444444444444444444444444444');
   
    END LOOP;
        DBMS_OUTPUT.PUT_LINE('55555555555555555555555555553');
END;
/
select empno from emp01;
EXEC PROC10('SMITH');

EXEC PROC10(7902);


CREATE OR REPLACE PROCEDURE TABLE_TEST
IS
    I BINARY_INTEGER := 0;
    
    TYPE  dept_table_type IS TABLE OF dept%ROWTYPE
    INDEX BY BINARY_INTEGER;
    
    dept_table dept_table_type;
    
BEGIN
    FOR dept_list IN (SELECT * FROM DEPT) LOOP
        I:= I+1;
        
        dept_table(I).deptno := dept_list.deptno;
        dept_table(i).dname := dept_list.dname;
        dept_table(i).loc := dept_list.loc;
    END LOOP;
    
    FOR cnt IN 1..i LOOP
    
    DBMS_OUTPUT.PUT_LINE('부서번호 :' || dept_table(cnt).deptno||
                        ' 부서명 :' || dept_table(cnt).dname||
                        ' 위치 :' || dept_table(cnt).loc);
    END LOOP;
    
END;
/
        
EXEC TABLE_TEST;