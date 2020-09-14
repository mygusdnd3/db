--3. 무명 프로시져 내부에 무명 프로시져를 포함해서 만드는 방법

DECLARE 
    --선언부
    err_flag BOOLEAN := false;
BEGIN
    --실행부
    DBMS_OUTPUT.PUT_LINE('100 ~ 1000 숫자 처리');
    -- 무명 프로시져는 호출해서 사용할 수 없기 때문에 만듦과 동시에 실행시켜야 한다.
    -- 따라서 선언부에 만드는 작업보다는, 실행부에서 만들고 실행해줘야 한다.
    DECLARE
        h_num NUMBER(1,-2);
    BEGIN
        h_num := 100;
        LOOP
            DBMS_OUTPUT.PUT_LINE(h_num);
            h_num := h_num+100;
            
            IF h_num > 1000 THEN
                exit;
            END IF;
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            err_flag := true;
    END;                -- 내부 무명 프로시져 종료
    
    IF err_flag THEN
        DBMS_OUTPUT.PUT_LINE('숫자를 계산할수 없습니다.');
    ELSE
    DBMS_OUTPUT.PUT_LINE('계산이 종료되었습니다.');
    END IF;
    
END;                    -- 외부 무명프로지셔 종료
/