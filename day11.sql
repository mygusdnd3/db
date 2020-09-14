--day11

/*
    for 명령
    
        형식 ]
            FOR 변수이름 IN (질의명령) LOOP
                처리내용
                ...
            END LOOP;
            
            의미 ]
                질의 명령의 결과를 변수에 한줄씩 기억한 후
                원하는 내용을 처리하도록 한다.
            참고 ]
                for 명령에서 사용할 변수는 미리 만들지 않아도 된다.
                이 변수는 자동적으로 %ROWTYPE 변수가 된다. 
                %ROWTYPE 변수는 묵시적으로 멤버변수를 가지게 된다.
                
            예]
            
            FOR e IN (SELECT * FROM emp) LOOP
                처리내용
            END LOOP;
            ==> 이때 변수 e는 자동적으로 %ROWTYPE 변수가 되고
                e에는 멤버변수 empno, ename, sal, mgr,..을 가지게 된다.
                따라서 꺼낼때는 e.empno, e.ename,e.sal,...
                의 형식으로 사용해야 한다.
        형식2 ]
            for 변수이름 IN 시작값 ... 종료값 LOOP
                처리내용    
                ...
            END LOOP;
        의미 ]
            시작값부터 종료값까지 1씩 증가시켜서 
            처리내용을 반복한다.
            
            

*/


-- 사원들의 이름을 출력하는 무명 프로시져를 작성하세요

DECLARE  
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR data IN (SELECT rownum rno,ename, 200 num FROM emp)LOOP--변수는 인라인뷰라고 생각하자
    --인라인뷰처럼 다뤄야 되더라
        DBMS_OUTPUT.PUT_LINE(data.rno||' 번째 사원]' ||data.ename||(data.rno+data.num));
    END LOOP;
END;
/


-- 1부터 10까지 출력해주는 무명 프로시져를 작성하고 실행하세요
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR no IN 1..10 LOOP
    DBMS_OUTPUT.PUT_LINE(no);
    END LOOP;
END;
/


/*
    WHILE 명령
        형식 1]
            WHILE 조건식 LOOP
                처리내용
            END LOOP;
            
            의미]
                조건식이 참인경우 처리내용을 반복해서 실행하세요 
            
        형식 2]
            WHILE 조건식1 LOOP
                처리내용
                EXIT WHEN 저건식2
            END LOOP;
            
                의미 ]
                    조건식1이면 참이면 반복하지만
                    만약 조건식 2가 참이면 반복을 종료한다.
                    즉, 자바의 BREAK와 같은 기능을 하는 명령이
                        EXIT WHEN
                    구문이다.
        
    LOOP(DO~WHILE같은 기능) 명령
        형식 ]
            
            LOOP
                처리내용
                EXIT WHEN 조건식;
            END LOOP
        

--------------------------------------------------------------------------------

    조건문
        IF 명령
            형식 1 ]
                IF 조건식 THEN
                    처리내용
                END IF;
            형식 2 ]
                IF 조건식 THEN
                    처리내용1
                ELSE
                    처리내용2
                END IF;
            형식 3 ]
                IF 조건식 THEN
                    처리내용1
                ELSIF 조건식 THEN
                    처리내용2
                ...
                ELSE
                    처리내용N
                END IF;


*/

-- 사원번호를 입력하면 사원이름, 부서번호, 직급을 조회하는 무명프로시져를 작성해서 실행하세요
-- 단 , 없는 번호를 입력하면 존재하지 않는 사원입니다라고 출력되게 하세요
DECLARE
    i_emp emp%ROWTYPE,
    cnt NUMBER
BEGIN

END;
/
;

CREATE OR REPLACE PROCEDURE e_info03
    (eno emp.empno%TYPE
    )
    
IS
    cnt NUMBER;
    i_emp EMP%ROWTYPE;
    
BEGIN
    SELECT
        COUNT(*)
    INTO
        cnt
    FROM
        emp01
    WHERE
        empno = eno
    ;
    IF cnt = 1 THEN
    SELECT
        *
    INTO
        i_emp
    FROM
        emp01
    WHERE
        empno = eno
        ;
    DBMS_OUTPUT.PUT_LINE(' 사원이름 | 부서번호 | 직급 ');
    DBMS_OUTPUT.PUT_LINE(RPAD('-',25,'-'));
    DBMS_OUTPUT.PUT_LINE(RPAD(i_emp.ename, 10, ' ') ||'|'||RPAD(i_emp.deptno,10,' ')||'|'|| i_emp.job);
    ELSE
        DBMS_OUTPUT.PUT_LINE('존재하지 않는 사원입니다');
    END IF;

END;
/

exec e_info03(8000);


/*
    문제 1]
        for loop문을 사용해서 구구단 5단을 출력하세요
        
        심화 ]
            구구단을 출력하세요
    문제 2]
        IF~ELSEIF 구문을 사용해서
            emp01 테이블의 사원의 정보를 조회하는데
            사원번호, 사원이름, 부서번호, 부서이름
            의 형식으로 조회하고
            부서번호가 10이면 '회계부
                    20 -개발부
                    30 - 영업부
                    40 - 운영부
            
*/
/*
      의미 ]
            시작값부터 종료값까지 1씩 증가시켜서 
            처리내용을 반복한다.
  */
--1  
  DECLARE
  BEGIN
    FOR e IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE('5 * ' || e || ' = ' ||5*e);
    END LOOP;
  END;
  /
  DECLARE
  BEGIN
    FOR i IN 1..10 LOOP
    DBMS_OUTPUT.PUT_LINE(i||' 단');
       FOR j IN 1..10 LOOP 
         DBMS_OUTPUT.PUT_LINE(i||' * ' || j || ' = ' ||i*j);
            END LOOP;
        DBMS_OUTPUT.PUT_LINE('***************************');
    END LOOP;
  END;
  /
  
--2
/*
    문제 2]
        IF~ELSEIF 구문을 사용해서
            emp01 테이블의 사원의 정보를 조회하는데
            사원번호, 사원이름, 부서번호, 부서이름
            의 형식으로 조회하고
            부서번호가 10이면 '회계부
                    20 -개발부
                    30 - 영업부
                    40 - 운영부
*/

CREATE OR REPLACE PROCEDURE i_emp
IS
    iemp emp%rowtype;
BEGIN
        SELECT 
            empno, ename, emp.deptno,dname
        INTO 
            iemp 
        FROM 
            EMP,dept
        WHERE
            emp.deptno = dept.deptno
             ;
END;
/
exec i_emp();

DECLARE
    i_emp emp%ROWTYPE
BEGIN
    SELECT * INTO i_emp FROM EMP;
END
;
/

DECLARE
    part VARCHAR2(20 CHAR);
BEGIN

    FOR e IN (SELECT empno no,ename name,deptno dno FROM emp01) LOOP
        IF (e.dno = 10) THEN
            part :='회계부';
        ELSIF (e.dno = 20) THEN
            part :='개발부';
        ELSIF (e.dno = 30) THEN
            part :='영업부';
        ELSE
            part :='운영부';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(e.no||'||'||e.name||'||'||e.dno||'||'||part);
    END LOOP;
END;
/

-- 입사년도를 입력하면 해당 해에 입사한 사원들의 ..사원번호 사원이름, 입사일을 출력하는
-- 저장 프로시져 proc01을 제작후 실행

CREATE OR REPLACE PROCEDURE proc01(
    hnum NUMBER
)
IS
    
BEGIN
    FOR e IN(SELECT empno eno, ename name, hiredate hdate FROM emp01 
            WHERE TO_DATE(hnum,'YY') >= hdate
            AND TO_DATE(hnum+1,'YY')< hdate
            ) LOOP
        DBMS_OUTPUT.PUT_LINE(hdate)
        END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE proc01( --풀이
    indate VARCHAR2
)
IS
    
BEGIN
    FOR data IN (SELECT empno, ename name, hiredate hdate FROM emp01
                 WHERE TO_CHAR(hiredate,'YY') =indate) LOOP
        DBMS_OUTPUT.PUT_LINE(data.empno||'||'||data.name||'||'||data.hdate);
    END LOOP;   
END;
/
EXEC PROC01('81');



SELECT
    *
FROM
    EMP01
WHERE
    --TO_DATE(HIREDATE,'YY') = 81
    --HIREDATE = TO_DATE('81','YY') 안됨, 아무도안나옴 HIREDATE에는 년도말고 다른게 많아
    --그래서 TODATE로 넣어서 비교하는건 애바임
    TO_CHAR(HIREDATE,'YY') ='81'
    -- HIREDATE의년도를 문자로 뽑아서 비교하는게좋ㅇ음.
;

/*
    문제 4
        부서번호를 입력하면 해당 부서 사원들의
            사원번호,사원이름,직급,부서번호,부서이름을
            출력하는저장 프로시져를 만드시오
*/

CREATE OR REPLACE PROCEDURE PROC02(
    inum varchar2
)
IS
    --empno eno, ename name, job ejob,deptno dno, dname ddname;
BEGIN
    FOR e IN (
        SELECT EMPNO, ENAME, JOB, D.DEPTNO dno , DNAME
       -- INTO eno,name,ejob,dno,ddname
        FROM EMP01, DEPT D
        WHERE
        EMP01.DEPTNO = D.DEPTNO
        AND emp01.deptno = inum
        ) LOOP
        
        DBMS_OUTPUT.PUT_LINE(e.empno||'||'||e.ename||'||'||e.job||'||'||e.dno||e.dname);
        END LOOP;
END;
/
exec proc02('10');

SELECT empno, ename,job,e.deptno,dname
       -- INTO eno,name,ejob,dno,ddname
FROM EMP01 e, DEPT d
WHERE
e.deptno = d.deptno
AND e.deptno = 10
;

CREATE OR REPLACE PROCEDURE PROC022(
    dno dept.deptno%type
)
IS
    buseo dept.dname%type;
    buseoloc dept.dname%type;
BEGIN
    SELECT
        dname,loc
    INTO
        buseo,buseoloc
    FROM
        dept
    WHERE
        deptno = dno
    ;
    FOR data IN (SELECT empno, ename, job FROM emp01 WHERE deptno = dno)LOOP
     DBMS_OUTPUT.PUT_LINE(data.empno||'||'||data.ename||'||'||data.job||'||'||buseo||'||'||buseoloc);
     END LOOP;
END;
/
exec proc022(10);
/*
    문제 5]
        사원 이름을 입력하면 해당 사원의 소속부서의
            부서최대급여, 부서최소급여, 부서평균급여,부서급여합계,부서원수
            를 출력하는 저장프로시져 PROC03을 제작하고 실행하시고
*/

--풀이

CREATE OR REPLACE PROCEDURE proc03 (
    iname emp01.ename%TYPE
) 
IS
    ideptno emp01.deptno%TYPE;
BEGIN
      SELECT
           deptno
      INTO 
           ideptno
      FROM
          emp01
      WHERE
          ename = iname
    ; 
    
    FOR data IN (
            SELECT
                MAX(sal)     max,
                MIN(sal)     min,
                AVG(sal)     avg,
                SUM(sal)     sum,
                COUNT(*)     cnt
                
            FROM
                emp01
            GROUP BY
                deptno
            HAVING
                deptno = ideptno

    ) LOOP 
       -- DBMS_OUTPUT.PUT_LINE();
        DBMS_OUTPUT.PUT_LINE('max : '||data.max||' min : '||data.min||
       ' avg : '||data.avg||' sum : '||data.sum||' cnt : '||data.cnt);
       --여기 비어있으면 안돌아가
    end loop;
     
END;
/
 

exec proc03('SMITH');
------------------------------------------


/*
    문제 6]
        직급을 입력하면
        해당 직급을 가진 사원들의
            사원이름, 급여, 부서이름
        출력 프로시져 proc04 제작
*/
CREATE OR REPLACE PROCEDURE PROC04(
    ijob emp01.job%type
)
IS
    NULLCHECK NUMBER;
BEGIN
   SELECT COUNT(*) CNT INTO NULLCHECK FROM EMP01 WHERE IJOB = JOB;
   IF(NULLCHECK =0)THEN
   DBMS_OUTPUT.PUT_LINE('값을 입력해주세요');
    END IF;
    FOR data IN (
            SELECT
                ename,sal,dname 
            FROM 
                emp01,dept
            where
                emp01.deptno=dept.deptno
                AND job = ijob
            ) LOOP
    DBMS_OUTPUT.PUT_LINE('입력하신 직급 :'||ijob);
    DBMS_OUTPUT.PUT_LINE('사원 이름 :'||data.ename);
    DBMS_OUTPUT.PUT_LINE('사원 급여 :'||data.sal);
    DBMS_OUTPUT.PUT_LINE('부서 이름 :'||data.dname);
    END LOOP;
            
END;
/

exec proc04('PRESIDENT');
exec proc04('');

/*
    문제 7 ]
        이름을 입력하면
        해당 사원의
            사원번호, 사원이름, 직급, 급여,급여등급
        출력 프로시져 proc05
*/

CREATE OR REPLACE PROCEDURE PROC05(
    iname emp01.ename%type
)
IS
    vno emp.empno%type;
    vname emp.ename%type;
    vjob emp.job%type;
    vsal emp.sal%type;
    vgrade salgrade.grade%type;
BEGIN
    SELECT EMPNO, ENAME, JOB, SAL, S.GRADE
    INTO   vno,vname,vjob,vsal,vgrade
    FROM EMP01,SALGRADE S
    WHERE
        ename = iname
        AND SAL BETWEEN S.LOSAL AND S.HISAL
        ;
        
     DBMS_OUTPUT.PUT_LINE('입력하신 이름 :'||iname);
     DBMS_OUTPUT.PUT_LINE('사원 번호 :'||vno);
    DBMS_OUTPUT.PUT_LINE('사원 이름 :'||vname);
    DBMS_OUTPUT.PUT_LINE('사원 직급 :'||vjob);
    DBMS_OUTPUT.PUT_LINE('사원 급여 :'||vsal);
    DBMS_OUTPUT.PUT_LINE('급여 등급 :'||vgrade);
END;
/
EXEC PROC05('SMITH');
--또는
CREATE OR REPLACE PROCEDURE PROC05(
    iname emp01.ename%type
)
IS
BEGIN
    FOR data IN(
                    SELECT
                        EMPNO ENO, JOB,SAL, GRADE
                    FROM
                        EMP01,SALGRADE
                    WHERE
                    sal BETWEEN LOSAL AND HISAL
                    AND ENAME = iname
                    ) LOOP
    DBMS_OUTPUT.PUT_LINE(data.eno||'|'||iname||'|'||data.job
                            ||'|'||data.sal||'|'||data.grade);
    END LOOP;
END;
/

EXECUTE PROC05('ADAMS');


------------------------------------------------------
/*
    참고
        자바에서 배열을 만드는방법
            데이터타입[] 변수이름 = new 데이터타입[길이];
    형식 ]
        type 이름 IS TBLE OF 데이터타입1
        IDEX BY 데이터타입2;
        
        참고 ]
            데이터타입1
            ==> 변수에 기억될 데이터의 형태
            
            데이터타입2
            ==> 배열의 인덱스로 사용할 데이터의 형태
                (99.9% BINARY_INTEGER : 0,1,2,3,4,....)
    형식 2]
        변수이름    테이블이름;
        ==> 정의된 테이블이름의 형태로 변수를 만드세요
    참고 ]
        사실 테이블타입이란 변수는 존재하지는 않느다.
        따라서 먼저 테이블을 정의하고
        정의된 테이블타입을 이용해서 변수를 선언해야한자
*/




/*
    레코드타입 (row type)
    ==> 강제로 멤버를 가지는 변수를 만드는 방법
    
        %ROWTYPE은 하나의 테이블을 이용해서
        멤버변수를 자동으로 만드는 방법이었다.
        레코드타입은 사용자가 지정한 멤버 변수를 만들 수 있다는 차이가 있다.
        
        만드는 방법 ]
        
            1. 레코드 타입을 정의한다
                형식 ]
                    TYPE 레코드이름 IS RECODE(
                        멤버변수이름 데이터타입,
                        멤버변수이름 데이터타입,
                    );
            2. 정의된 레코드 타입을 이용해서 변수를 선언한다.
                형식 ]
                    변수이름 레코드타입이름
                
*/

/*

    레코드 타입의 변수를 사용하여 처리
*/

CREATE OR REPLACE PROCEDURE PROC07(
    dno emp01.deptno%type
    --입력 데이터 파라미터 변수 선언
)
IS
    --1. 레코드 타입 정의
    TYPE e_record IS RECORD(
        vname emp01.ename%TYPE,
        vjob  emp01.job%TYPE,
        vsal  emp01.sal%TYPE
    );
    --2. 레코드 타입을 이용해서 변수를 선언한다.
    
    --dsal e_record;--이안에는 vname,vjob,vsal이라는 필드가 들어있다. 안썻네?;
    --3. 테이블 타입을 정의한다.
    TYPE etab IS TABLE OF e_record
    INDEX BY BINARY_INTEGER; 
    
    --4. 테이블 타입 변수를 만든다.
    result etab;
    
    cnt BINARY_INTEGER :=0; --생성후 바로 초기화
BEGIN
    FOR data IN (SELECT ename vname, job vjob,sal vsal FROM emp01 WHERE deptno = dno) LOOP
        DBMS_OUTPUT.PUT_LINE(CNT);
        cnt := cnt +1;
      
      /*
      result(cnt).vname := data.ename;
        result(cnt).vjob := data.job;
        result(cnt).vsal := data.sal;
        */
        result(cnt) := data;
        DBMS_OUTPUT.PUT_LINE(CNT);
        DBMS_OUTPUT.PUT_LINE('--------------------');
        
    END LOOP;
    
    -- 출력
    FOR i IN 1..cnt LOOP
        DBMS_OUTPUT.PUT_LINE(result(i).vname||result(i).vjob||result(i).vsal);
    END LOOP;
    

END;
/

exec proc07(30);


/*
    문제 8 ]
        사원이름을 입력하면
            이름, 직급,급여,급여등륵
            을 출력해주는 프로시져를 제작하고 실행
        단, 레코드타입으로

*/

CREATE OR REPLACE PROCEDURE PROC08(
    iname emp01.ename%type
)
IS  --1.레코드 타입을 만든다.
     TYPE e_record IS RECORD(
        vname  emp01.ename%type,
        vjob  emp01.job%type,
        vsal  emp01.sal%type,
        vgrade salgrade.grade%type
     );
    -- 2. 레코드타입의 변수를 만든다.
    vemp e_record;
     
     
BEGIN
    --3. 질의명령을 보내고 결과를 레코드 타입 변수에 담는다.
    SELECT ename, job,sal,grade
    INTO vemp.vname,vemp.vjob,vemp.vsal,vemp.vgrade
    FROM emp01 ,salgrade
    where ename=iname
    AND sal BETWEEN LOSAL AND HISAL
    ;
   
   DBMS_OUTPUT.PUT_LINE(vemp.vname||'||'||vemp.vjob||'||'||vemp.vsal||'||'||vemp.vgrade);
    
END;
/
exec proc08('SMITH');
----------------
-- 몇개수정
CREATE OR REPLACE PROCEDURE PROC08(
    iname emp01.ename%type
)
IS  --1.레코드 타입을 만든다.
     TYPE e_record IS RECORD(
        vname  emp01.ename%type,
        vjob  emp01.job%type,
        vsal  emp01.sal%type,
        vgrade salgrade.grade%type
     );
    -- 2. 레코드타입의 변수를 만든다.
    vemp e_record;
     
     
BEGIN
    --3. 질의명령을 보내고 결과를 레코드 타입 변수에 담는다.
    SELECT ename, job,sal,grade
    INTO vemp   --이래해도 들어간다.고대로
    FROM emp01,salgrade
    where ename=iname
    AND sal BETWEEN LOSAL AND HISAL
    ;
   
   DBMS_OUTPUT.PUT_LINE(vemp.vname||'||'||vemp.vjob||'||'||vemp.vsal||'||'||vemp.vgrade);
    
END;
/
exec proc08('SMITH');


/*
    문제 9 ]
        사원번호를 입력하면
            사원이름, 사원직급, 부서번호, 부서위치
        를 출력해주는 프로시져 proc09
        단,레코드 타입의 변수를 선언
        
         --dsal e_record;--이안에는 vname,vjob,vsal이라는 필드가 들어있다. 안썻네?;
    --3. 테이블 타입을 정의한다.
    TYPE etab IS TABLE OF e_record
    INDEX BY BINARY_INTEGER; 
    
    --4. 테이블 타입 변수를 만든다.
    result etab;
    
    cnt BINARY_INTEGER :=0; --생성후 바로 초기화
*/

CREATE OR REPLACE PROCEDURE PROC09(
    inum emp01.empno%type
)
IS
    TYPE t IS RECORD(
    vname emp01.ename%type,
    vjob emp01.job%type,
    vdno emp01.deptno%type,
    vloc dept.loc%type
    );
    
    recordtest t;
        
BEGIN
    SELECT
        ename,job,e.deptno,loc
    INTO
        recordtest
    FROM
        EMP01 e,DEPT D
    WHERE
        e.DEPTNO = D.DEPTNO
        AND EMPNO = inum
        ;
    DBMS_OUTPUT.PUT_LINE(recordtest.vname||' | '||recordtest.vjob||' | '||
                         recordtest.vdno||' | '||recordtest.vloc);

END;
/
exec proc09(7566);

/*
문제 9 ]
        사원번호를 입력하면
            사원이름, 사원직급, 부서번호, 부서위치
        를 출력해주는 프로시져 proc09
        단, 테이블 타입과 레코드 타입의 변수를 선언
        힌트 ] 
            변수를 만들려면 먼저 타입이 만들어져야한다.
            1. 레코드타입선언
            2.레코드 타입을 기억할 테이블 선언
            3. 테이블타입 배열변수 선언.
                  --dsal e_record;--이안에는 vname,vjob,vsal이라는 필드가 들어있다. 안썻네?;
    --3. 테이블 타입을 정의한다.
    TYPE etab IS TABLE OF e_record
    INDEX BY BINARY_INTEGER; 
    
    --4. 테이블 타입 변수를 만든다.
    result etab;
    
    cnt BINARY_INTEGER :=0; --생성후 바로 초기화
*/

CREATE OR REPLACE PROCEDURE PROC10(
    ijob emp01.job%type
)
IS
    TYPE T IS RECORD(
     vname emp01.ename%type,
     vempno emp01.empno%type,
     vdeptno emp01.deptno%type,
     vloc dept.loc%type
     );
    TYPE vtable IS TABLE OF T
    INDEX BY BINARY_INTEGER;
    vres vtable;
    cnt BINARY_INTEGER :=0;
    
BEGIN    
    FOR data IN(SELECT 
                    ENAME,empno,e.DEPTNO,LOC 
                FROM 
                    EMP01 E , DEPT D
                WHERE 
                    job = ijob
                    AND E.DEPTNO = D.DEPTNO
                   
                )LOOP
             --vres(cnt) := data;
                DBMS_OUTPUT.PUT_LINE(cnt);
                 cnt := cnt+1;
                            
    END LOOP;
    FOR i IN 1..cnt LOOP
    DBMS_OUTPUT.PUT_LINE(VRES(i).vname);
    DBMS_OUTPUT.PUT_LINE(VRES(i).enpno);
    DBMS_OUTPUT.PUT_LINE(VRES(i).ijob);
    DBMS_OUTPUT.PUT_LINE(VRES(i).vdeptno);
    DBMS_OUTPUT.PUT_LINE(VRES(i).vloc);
    END LOOP;
END;
/