-- day 12

/*
    커서(Cursor)
    ==> 실제 실행되는 질의 명령을 기억하는 변수
    
        자주 사용하는 질의명령을 한번만 만든 후
        이 질의명령을 변수에 기억해서
        마치 변수를 사용하듯이 질의명령을 실행하는 것.
        
    종류 ]
        1. 묵시적(암시적) 커서
            ==> 오라클에서 미리 만들어 놓고 제공해주는 커서를 말한다.
                우리가 지금까지 사용했듯이
                직접 만들어서 실행된 질의 명령 자체를 의미를 한다.
            참고 ]
            
                커서에는 내부 변수 (멤버변수)가 존재한다.
                
                SQL%ROWCOUNT
                ==> 실행결과가 나타난 레코드(행,ROW)의 개수를 기억하는 변수
                SQL%FOUND
                ==> 실행결과가 존재하는지 여부를 기억하는 변수
                
                SQL%NOTFOUND
                ==> 실행결과가 존재하지 않는지 여부를 기억하는 변수
                
                SQL%ISOPEN
                ==> 커서가 만들어졌는지 여부를 기억하는 변수
                
        2. 명시적 커서



*/

/*
    묵시적 커서 예제 ]
    
        사원번호를 입력하면
        그 사원의 이름을 알려주는 프로시져를 작성하세요.
        단, 사원번호가 잘못 입력되면 '해당사원은 없는 사원입니다.'가 출력되게 하세요
*/

-- 이전방법( : COUNT(*) 호출해서 처리하는방법)
CREATE OR REPLACE PROCEDURE proc11 (
    eno emp01.empno%TYPE
) IS
    --이름 기억할 변수
        name  emp01.ename%TYPE;
    
    -- 카운트 기억할 변수
        cnt   NUMBER;
BEGIN
    -- 사원의 카운트 조회
        SELECT
        COUNT(*),
        ename
    INTO
        cnt,
        name
    FROM
        emp01
    WHERE
        empno = eno
    GROUP BY
        ename;
    
    -- 카운트에 따른 조건처리
        IF cnt >= 1 THEN
      /*      
        SELECT
            ename
        INTO
            name
        FROM
            emp01
        WHERE
            empno = eno
        ;
        */
                dbms_output.put_line('사원번호 : ' || eno);
        dbms_output.put_line('사원이름 : ' || name);
    ELSE
        dbms_output.put_line(eno || '번] 사원은 없는 사원입니다.');
    END IF;

END;
/

EXEC proc11(8000);

-- 묵시적 커서를 사용하는 방법
CREATE OR REPLACE PROCEDURE proc11 (
    eno emp01.empno%TYPE
) IS
    name emp01.ename%TYPE;
BEGIN
    SELECT
        ename
    INTO name
    FROM
        emp01
    WHERE
        empno = eno;

    IF SQL%found THEN
        dbms_output.put_line('사원번호 : ' || eno);
        dbms_output.put_line('사원이름 : ' || name);
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line(eno || '번] 사원은 없는 사원입니다.');
END;
/

EXEC proc11(7839);

EXEC proc11(8000);

/*
    예제 ]
        부서번호를 입력하면 해당 부서의 사원들의 급여를 10% 인상하는 프로시져를 만드세요
        그리고 인상된 사원이 모두 몇명인지 출력하세요
*/

CREATE OR REPLACE PROCEDURE proc12 (
    dno emp01.deptno%TYPE
) IS
BEGIN
    dbms_output.enable;
    UPDATE emp01
    SET
        sal = sal * 1.1
    WHERE
        deptno = dno; -- 이 질의명령이 실행되는 순간 묵시적 커서가 생겨나게된다.
        
        dbms_output.put_line(dno
                         || '번 부서 '
                         || SQL%rowcount
                         || ' 명 급여 10% 인상 완료');
END;
/

ROLLBACK;

EXECUTE proc12(30);

SELECT
    *
FROM
    emp01;

------------------------------------------------------------------------------
/*
    명시적 커서
    ==> 원래 커서의 의미처럼
        자주 사용하는 질의명령을 미리만든 후
        필요하면 질의 명령을 변수를 이용해서 실행하도록 하는 것
        
        명시적 커서의 처리 순서
        
            1. 명시적 커서를 만든다.
                (==> 명시적 커서를 정의한다.)
                
                형식 ] -- IS절에 기술
                    CURSOR 커서이름 IS
                        필요한 질의 명령
            2. 반드시 커서를 프로시저에서 실행가능하도록 조치한다.
                (커서를 오픈시킨다.)
                
                형식 ]    
                    OPEN 커서이름 ; -- BEGIN절에 기술
            
            3. 질의명령을 실행한다. ( 커서를 FETCH 시킨다.)
                
                형식 ]    --BEGIN절에 기술
                    FETCH   커서이름;
                    
            4. 사용이 끝난 커서는 회수한다.(커서를 CLOSE 시킨다.)
                형식 ]
                
                    CLOSE 커서이름;
            참고 ]
                만약 커서가 FOR LOOP 명령 안에서 사용되면
                자동 OPEN, FETCH, CLOSE가 된다.
                
            참고 ]
                명시적 커서에도 멤버 변수를 사용할수 있다.
                멤버 변수는 암시적 커서와 동일하다.
                    SQL%ROWCOUNT,SQL%FOUNT, SQL%NOTFOUND,SQL%ISOPEN....
            참고 ]
                커서도 필요하면 파라미터를 받아서 사용할 수 있다.
                (파라미터 변수를 선언할 수 있다.)
                형식 ]
                    CURSOR 커서이름(파라미터매개변수리스트) IS
                        질의명령
                        ;
        참고 ]
            WHERE CURRENT OF 절
            ==> 커서를 이용해서 다른 질의명령을 실행하기 위한 방법
                이를테면 서브질의처럼
                하나의 질의명령을 실행할 때 필요한 서브질의를
                커서를 이용해서 사용하는 방법
*/

/*
    CURSOR 예제 ]
        부서번호를 입력하면
        부서이름, 평균급여, 사원수를 출력하는 프로시져를 작성하세요.
        단, 질의명령을 커서를 이용해서 처리하세요
        
        차
*/

CREATE OR REPLACE PROCEDURE proc14 (
    idno emp01.deptno%TYPE
) IS
    -- 1. 커서 선언
        CURSOR cur01 IS
    SELECT
        dname  부서이름,
        avg    평균급여,
        cnt    사원수
    FROM
        dept,
        (
            SELECT
                deptno       dno,
                AVG(sal)     avg,
                COUNT(*)     cnt
            FROM
                emp01
            GROUP BY
                deptno
        )
    WHERE
            deptno = dno
        AND deptno = idno;
    
    -- 출력에 사용할 변수 선언
        buseo  dept.dname%TYPE;
    pavt   NUMBER;
    pcnt   NUMBER;
BEGIN
   --2. 커서 사용가능하도록 오픈하고
        OPEN cur01;
   --3. 질의명령 실행(커서를 FATCH 시킨다.)
       FETCH cur01 INTO
        buseo,
        pavt,
        pcnt;
   --출력한다.
       dbms_output.put_line('부서번호 : ' || idno);
    dbms_output.put_line('부서이름 : ' || buseo);
    dbms_output.put_line('평균급여 : ' || round(pavt, 2));
    dbms_output.put_line('부서원수 : ' || pcnt);
   --4. 사용이 끝난 커서 회수
       CLOSE cur01;
END;
/

EXEC proc14(20);
----------------------------------------------------------

    ----------
    
    SELECT
    deptno       dno,
    AVG(sal)     avg,
    COUNT(*)     cnt
FROM
    emp01
GROUP BY
    deptno;

SELECT
    dname,
    (
        SELECT
            AVG(sal)
        FROM
            emp01
        WHERE
            deptno = 10
    )  AS avg,
    (
        SELECT
            COUNT(*)
        FROM
            emp01
        WHERE
            deptno = 10
    )  AS cnt
FROM
    dept d
WHERE
    deptno = 10;
    
-- FOR LOOP 내에서의 커서
-- 예제 ]부서별로 부서이름, 부서평균급여, 사원수를 출력하세요
--  단, 커서를 이용하여 처리하세요
CREATE OR REPLACE PROCEDURE proc14 IS 
    --1. 커서 만든다.
        CURSOR d_info01 IS
    SELECT
        d.dname,
        round(AVG(sal), 2)          avg,
        COUNT(*)                   cnt
    FROM
        emp01  e,
        dept   d
    WHERE
        e.deptno = d.deptno
    GROUP BY
        dname -- 그룹함수와 같이 써야하기때문에, dname으로 해준다
        ;

BEGIN
    -- 2. 커서 연다.
 --   OPEN d_info01;
    -- 3. 커서 패치 
    --4. 커서 닫기  // for loop에서 자동처리가능
        FOR data IN d_info01 LOOP
        dbms_output.put_line(data.dname
                             || '|'
                             || data.avg
                             || '|'
                             || data.cnt);
    END LOOP;
END;
/

EXEC proc14;

---------------------------------------------------------------------------

/*
    명시적 커서도 멤버 변수를 사용할 수 있다.
    
    예제 ]
        사원의 이름, 직급, 급여를 출력하는 프로시져를 작성하고 실행하세요
        단, 커서를 이용해서 처리하고
        최종적으로 출력된 사원수를 같이 출력하도록 하세요.
*/

CREATE OR REPLACE PROCEDURE proc15 IS
    -- 커서만든다
        CURSOR e_info IS
    SELECT
        ename,
        job,
        sal
    FROM
        emp01;

BEGIN
    -- FOR LOOP 에서는 OPEN,FETCH,CLOSE가 필요 없다 <- 자동으로 처리
    -- ==> 반복문이 종료될때 커서를 닫아버리므로 결과를 알수 없게 되어버린다.
    -- 따라서 일반 반복문으로 처리한다. 아래 새로.
        dbms_output.put_line('---------------------------');
    FOR data IN e_info LOOP
        dbms_output.put_line('사원이름 : '
                             || data.ename
                             || '사원직급 : '
                             || data.job
                             || '사원급여 : '
                             || data.sal);

        dbms_output.put_line('---------------------------');
    END LOOP;
    -- 조회된 결과 수를 출력한다.
        dbms_output.put_line('*****총 사원수 : '
                         || e_info%rowcount
                         || ' *****');
    --xxxx FOR LOOP에서 닫아버린다.
    
    
END;
/

EXEC proc15;

----
/*
    명시적 커서도 멤버 변수를 사용할 수 있다.
    
    예제 ]
        사원의 이름, 직급, 급여를 출력하는 프로시져를 작성하고 실행하세요
        단, 커서를 이용해서 처리하고
        최종적으로 출력된 사원수를 같이 출력하도록 하세요.
*/

CREATE OR REPLACE PROCEDURE proc15 IS
    -- 커서만든다
        CURSOR e_info IS
    SELECT
        ename,
        job,
        sal
    FROM
        emp01;
        
    -- 레코드 타입 선언
        TYPE e01 IS RECORD (
        name  emp01.ename%TYPE,
        ejob  emp01.job%TYPE,
        esal  emp01.sal%TYPE
    );
    
    -- 레코드 변수 선언
        data e01;
BEGIN
    -- FOR LOOP 에서는 OPEN,FETCH,CLOSE가 필요 없다 <- 자동으로 처리
    -- ==> 반복문이 종료될때 커서를 닫아버리므로 결과를 알수 없게 되어버린다.
    -- 따라서 일반 반복문으로 처리한다.
    --커서열고
        OPEN e_info;
    dbms_output.put_line('---------------------------');
    LOOP
        --커서 패치
                FETCH e_info INTO data;
        dbms_output.put_line('사원이름 : '
                             || data.name
                             || '사원직급 : '
                             || data.ejob
                             || '사원급여 : '
                             || data.esal);

        dbms_output.put_line('---------------------------');
        --종료조건 기술
                EXIT WHEN e_info%notfound;
    END LOOP;
    -- 조회된 결과 수를 출력한다.
        dbms_output.put_line('*****총 사원수 : '
                         || e_info%rowcount
                         || ' *****');
    --커서닫고
        CLOSE e_info;
END;
/

EXEC proc15;
------------------------------------------------------------------
/*
    커서에서도 파라미터를 받아서 사용할 수 있다.
    
    예제 ]
        부서번호를 입력받아서 해당 부서의 사원이름을 출력하는 
        프로시져를 작성하고 실행하세요.
        단, 커서의 파라미터를 이용해서 처리하세요.
*/

CREATE OR REPLACE PROCEDURE proc16 IS
    CURSOR namelist (
        dno emp01.deptno%TYPE
    ) IS
    SELECT
        ename
    FROM
        emp01
    WHERE
        deptno = dno;

BEGIN
    --10번 부서 사원 출력
        dbms_output.put_line('### 10번 부서 사원 이름 ###');
    FOR data IN namelist(10) LOOP
        dbms_output.put_line(data.ename);
    END LOOP;
    --20번 부서 사원 출력
        dbms_output.put_line('### 20번 부서 사원 이름 ###');
    FOR data IN namelist(20) LOOP
        dbms_output.put_line(data.ename);
    END LOOP;
    
    --30번 부서 사원 출력
        dbms_output.put_line('### 30번 부서 사원 이름 ###');
    FOR data IN namelist(30) LOOP
        dbms_output.put_line(data.ename);
    END LOOP;

END;
/

EXEC proc16;

-----------------------------------------

/*

    WHERE CURRENT OF 절
        서브질의대신에 커서를 이용하는 방법
    예제 ]
        부서번호와 직급을 입력받아서
        해당부서의 최저급여자의 직급을 입력받은 직급으로 수정하는 프로시져를 만드시오
        
        
*/
 
--CURSOR
CREATE OR REPLACE PROCEDURE proc17 (
    dno   IN  emp01.deptno%TYPE,
    ijob  IN  emp01.job%TYPE
) 
IS
    -- 조회 질의 명령을 커서로 선언한다.
 CURSOR no_cur IS SELECT
                          empno
                      FROM
                          emp01
                      WHERE
                              deptno = dno
                          AND sal = ( SELECT MIN(SAL) FROM EMP01 WHERE DEPTNO = dno)
                          
                         FOR UPDATE;
        -- 이 커서는 UPDATE 질의명령에 부가적으로 사용되는 커서임을 밝히는 구문
        
BEGIN
    FOR data IN no_cur LOOP
        UPDATE emp01
        SET
            job = ijob
        WHERE
            CURRENT OF no_cur;
        /*
            이 UPDATE 질의명령은 조건은 IS 절에 선언한 커서절을 이용해서
            커서의 결과를 이용하여 조건을 만든다.
        */
        
        END LOOP;
END;
/
SELECT * FROM EMP01 WHERE DEPTNO =10;
EXEC PROC17(10,'잡부');

ROLLBACK;

/*
    사원이름과 급여를 입력.받아서
    입력받은 사원의 소속 부서의 최소급여자의 급여를 입력급여로 변경하는
    프로시져를 만들고 실행하세요
    단, 커서를 이용한 조건처리구문(WHERE CURRENT OF)을 사용해서 처리하세요

*/

CREATE OR REPLACE PROCEDURE PROC18(
    iname   emp01.ename%type,
    isal    emp01.sal%type
    
)
IS
    CURSOR salchange IS
                       SELECT ENAME, SAL    --당사자 출력
                       FROM EMP01
                       WHERE
                        SAL = (     
                               SELECT 
                                    MIN(SAL)-- 부서의 최저급여 확인하고
                                FROM 
                                    EMP01
                                WHERE
                                    DEPTNO=
                                        (SELECT -- 이름이 포함된 부서 확인하고
                                            DEPTNO
                                        FROM 
                                            EMP01
                                        WHERE
                                            ename = iname
                                          
                                       )
                               )
                               
                    FOR UPDATE
                    ;

BEGIN
    
    
    FOR data IN SALCHANGE LOOP
        UPDATE
            EMP01
        SET
            SAL = isal
        WHERE CURRENT OF SALCHANGE;
        
    END LOOP;
    
    
    
    

END;
/
rollback;

EXEC PROC18('FORD',10); -- 동일 최저 급여자가 있을시 해당인원 전부 반영됨.


SELECT * FROM EMP01 WHERE DEPTNO = 20 ORDER BY SAL DESC;
rollback;
select * from emp01;

DROP TABLE EMP01;
CREATE TABLE EMP01
AS
    SELECT
        *
    FROM
        SCOTT.EMP
        ;
        
CREATE OR REPLACE PROCEDURE cursor_test01 IS

    CURSOR namelist (
        dno emp01.deptno%TYPE
    ) IS
    SELECT
        empno,
        ename,
        deptno
    FROM
        emp01
    WHERE
        deptno = dno;

BEGIN
    FOR data IN namelist(10) LOOP
        dbms_output.put_line('사원번호 : '
                             || data.empno
                             || '  사원이름 : '
                             || data.ename
                             || '  부서번호 : '
                             || data.deptno);
    END LOOP;

    FOR data IN namelist(20) LOOP
        dbms_output.put_line('사원번호 : '
                             || data.empno
                             || '  사원이름 : '
                             || data.ename
                             || '  부서번호 : '
                             || data.deptno);
    END LOOP;

    FOR data IN namelist(30) LOOP
        dbms_output.put_line('사원번호 : '
                             || data.empno
                             || '  사원이름 : '
                             || data.ename
                             || '  부서번호 : '
                             || data.deptno);
    END LOOP;

END;
/

EXEC cursor_test01;

CREATE OR REPLACE PROCEDURE CURSOR_TEST02(
    ideptno emp01.deptno%TYPE
)
IS
CURSOR D_SAL IS
    (SELECT
        DNAME ,AVG(SAL) ,COUNT(*)
    FROM 
        EMP01,DEPT
    WHERE
        EMP01.DEPTNO = DEPT.DEPTNO
          AND DEPT.DEPTNO = ideptno
    GROUP BY
        DNAME
    );
   vdname dept.dname%TYPE;
   vavg    NUMBER;
   vcnt    NUMBER;
    
BEGIN
    
    OPEN D_SAL;
    
    FETCH d_sal INTO
    vdname,vavg,vcnt;
    
    DBMS_OUTPUT.PUT_LINE('부서이름 : '||vdname||
                         ' 부서급여 평균 : '||ROUND(vavg,1)||
                         ' 부서원 수 : ' ||vcnt);
    DBMS_OUTPUT.PUT_LINE('프로세스 실행 횟수'||D_SAL%ROWCOUNT);
    
    CLOSE D_SAL;
    
    
    
END;
/

EXEC CURSOR_TEST02(10);