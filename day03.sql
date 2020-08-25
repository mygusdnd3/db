-- day03

/* 
    ��� �̸�, �޿�, Ŀ�̼��� ��ȸ�ϼ���.
    �� �޿��� ##1,###�� �������� ��ȸ�ǰ� �ϼ���.
    
    ���� ] 
        TO_CHAR(��������)
        
        ���Ĺ���
            0 - ��ȿ���ڸ� ǥ��
            9 - ��ȿ���� ǥ������
            , - �ڸ���
            . - �Ҽ���
        ��� �̸�, �޿�, Ŀ�̼��� ��ȸ�ϼ���.
    �� �޿��� ##1,###�� �������� ��ȸ�ǰ� �ϼ���.
*/        
SELECT TO_CHAR(456789,'000,000,000') NO1, TO_CHAR(456789,'999,999,999.99')NO2
  FROM DUAL;
  
SELECT ENAME AS ����̸�
     , SUBSTR(TO_CHAR(SAL,'000,000'),-5) S
     --, LPAD(SAL,8,'#')||SUBSTR(TO_CHAR(SAL,'000,000'),-5) �޿�, COMM Ŀ�̼�
     , LPAD(SUBSTR(TO_CHAR(SAL,'000,000'),-5,-5),7,'#') �޿�, COMM Ŀ�̼�
FROM EMP;

--�̸��� ����° ���ڸ� ����ϰ� ������ ���ڴ� *�� ó���ϼ���
SELECT  RPAD(LPAD(SUBSTR(ENAME,3,1),3,'*'),LENGTH(ENAME),'*')
FROM EMP
;
SELECT RPAD(LPAD(SUBSTR(ENAME,3,1),3,'*'),LENGTH(ENAME),'*') FROM EMP;

SELECT EMPNO 
     , RPAD(  -- ��ü ���̸�ŭ ������ְ� ä��ڴ� �����ʿ� *�� ä���ش�.
       LPAD(--���� ������ ���ʿ� *�� ä���ش�)
       SUBSTR(ENAME,3,1),3,'*') --����°���ڸ������� 
     , LENGTH(ENAME),'*')  �̸�
  FROM EMP;

SELECT LPAD('*',2,'*')||SUBSTR(ENAME,3,1)||RPAD('*',LENGTH(ENAME)-2,'*') A , ENAME
  FROM EMP;
  
/*
    ����° ��
    ��¥�Լ�
    
        **
        ���� ]
            SYSDATE - �ý����� ���� ��¥/ �ð��� �˷��ִ� �����
        ���� ]
            TO_CHAR(��¥������,���Ĺ���) --��¥�����͸� ���ڿ��� ��ȯ�����ִ� �Լ�
            
            ���Ĺ���
            yyyy
            MM
            dd
            MON
            DAY
            
            AM|PM
            HH|HH12 -- 12�ð����� ǥ��
            HH24    -- 24�ð����� ǥ��
            mi      -- ��(0~59��)
            ss      -- ��(0~59��)
        ����]
            TO_DATE(��¥���� ���ڿ�, ���Ĺ��ڿ�)    --> ���ڵ����͸� ��¥�����ͷ� ��ȯ���ִ��Լ�
        ���ǻ��� ]
            ��¥ �����͸� ���鶧 �ð��� ������ ������ 0�� 0�� 0�ʷ� ������ �ȴ�.
------------------------------------------------------------------------------------
    ���� ]
        ��¥ - ��¥�� ������� ����Ѵ�.
        ��¥ �������� - �������Ѵ�.
    ���� ]
        ����Ŭ���� ��¥�� ����ϴ� ���
        1970�� 1�� 1�� 0�� 0�� 0�ʿ���
        ������ ��¥������ ��¥������ �̿��ؼ� ����Ѵ�.
        
        ��¥ �����̶�
        ����.�ð� �� ���·� ���ڷ� ǥ���� ��.
    
    ���� ] 
        ��¥ - ��¥�� ��������� -������
        ��¥ +(*,/)��¥�� �϶����� �ʴ´�.
        
    ���� ]
        ��¥ + ������ ������ ����Ѵ�.
        ==> ��¥ ������ �����̹Ƿ�
            �ᱹ ��¥���� ���ϴ� ���ڸ�ŭ �̵��� ��¥�� ǥ���Ѵ�.
--------------------------------------------------------------------------

*/
SELECT SYSDATE AS ���ó�¥ FROM  DUAL;--SQLDEVELOPER�� ǥ�������� ��¥�� ��¥������
SELECT TO_CHAR(SYSDATE, 'yyyy/MM/dd DAY HH:mi:ss') AS ���ó�¥ FROM  DUAL;--������ �������ָ� ����

SELECT TO_DATE('2020/08/25 09:30:00', 'YYYY/MM/DD HH24:MI:SS') ���ó�¥ FROM DUAL;

SELECT
    TO_CHAR(TO_DATE('2020/08/25','YYYY/MM/DD'), 'YYYY/MM/DD HH24:MI:SS') ���ýð�
FROM
    DUAL; -- �ð��� �������������� 0�� 0������ ���õȴ�.


-- ����� �̸�, ����� �ٹ��ϼ��� ����ؼ� ����ϼ���

SELECT ENAME AS ����̸� ,HIREDATE AS �Ի���
     , CONCAT(FLOOR(SYSDATE - HIREDATE),' ��') AS �ٹ��ϼ�
          -- �� ��� (FLOOR(SYSDATE - HIREDATE)�� ���ڵ������̰� ����ȯ�Լ�(TO_CHAR())�� �ڵ� ȣ��Ǿ �۵��ȴ�
  FROM EMP
;

-- ���� ] �����Ϻ��� ���ñ��� ������ ��ȸ�ϼ���
SELECT FLOOR(SYSDATE - TO_DATE('2020/07/16', 'YYYY/MM/DD')) �⼮��¥ FROM DUAL;

SELECT 
    TO_CHAR(SYSDATE+7,'YYYY/MM/DD HH24:MI:SS') �����ϵڳ�¥
FROM
    DUAL
;

-----------------------------------------------------------------------------
/*
    ��¥�Լ�
        1. ADD_MONTHS
            ==> ���� ��¥�� ������ �� ���� ���ϰų� �� ��¥�� �˷��ش�.
            ���� ]
                ADD_MONTH(��¥������, ������)
                ���� ] 
                    ���� �������� �����̸� �� ��¥�� �˷��ش�.
                    


*/

--���� ��¥���� 3���� ���� ��¥�� ��ȸ�ϼ���
SELECT
    ADD_MONTHS(SYSDATE,3)
FROM 
    DUAL;
    
-- ����� �̸�, �Ի��Ͽ��� 2���� ������ �����ΰ�

SELECT ENAME AS ����̸�
     , HIREDATE AS �����
     , ADD_MONTHS(HIREDATE,-2) �����2������
  FROM EMP
;
/*
    2. MONTHS_BETWEEN
        ==> �� ��¥ ������ ������ �� ������ �˷��ִ� �Լ�
        
        ���� ]
            MONTHS_BETWEEN(��¥, ��¥)
*/
-- �ڽ��� �¾ ������ ��� ����� ��ȸ�ϼ���
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('1989/02/18','YYYY/MM/DD'))) ������
  FROM DUAL
;

--���� ] ����� �Ի����� ��� ������ ��ȸ�ϼ���
SELECT ENAME, CONCAT(FLOOR(MONTHS_BETWEEN(SYSDATE, HIREDATE)),' ���� ������') AS ��������
  FROM EMP
;

/*
    3. LAST_DAY
        ==> ������ ��¥�� ���Ե� ���� ���� ������ ��¥�� �˷��ִ� �Լ�
        ���� ]
            LAST_DAY(��¥)
*/
-- �� 2���� ������ ��¥�� ��ȸ�ϼ���
SELECT LAST_DAY(TO_DATE('2020/02', 'YYYY/MM')) AS "2�� ������ ��" FROM DUAL;

-- ����� �̸�, �޿�, ù �޿����� ��ȸ�ϼ���
--�޿����� �ش� ���� ������ ���� �Ѵ�.
SELECT ENAME, SAL, LAST_DAY(HIREDATE) AS "ù �޿���" FROM EMP;

/*
    4. NEXT_DAY
        ==> ������ �� ���Ŀ� ���� ó�� ������ ������ ������ ���������� �˷��ִ� �Լ�
        ���� ]
            NEXT_DAY(��¥,'����')
        ���� ]
            ���� �����ϴ� ���
                1. �츮�� �ѱ�ȯ������ ������ �� ����Ŭ�� ��뤾�� �����Ƿ�
                    '��,'ȭ'...
                    '������','ȭ����'
                2. �����ǿ�����
                    'MON','TUES'...
                    'MONDAY',...
*/

-- �ٿ��� ������� �������� ��ȸ�ϼ���
SELECT NEXT_DAY(TO_DATE('2020/09/01','YYYY/MM/DD'),'��') AS "������ �����"
  FROM EMP
;
SELECT SUBSTR(NEXT_DAY(SYSDATE,'��'),-2) AS "�̹��� �����"
  FROM DUAL;

SELECT NEXT_DAY(NEXT_DAY(SYSDATE,'��'),'��') AS "������ �����" FROM DUAL;
-- �ٰ����� ������ ���(�����ְ���)�����������..

/*
    ROUND
    ==> ��¥�� ������ �κп��� �ݿø� �ϴ� ���Լ�
        ������ �κ��̶�?
            ��, ��,��,....
    ���� ]
        ROUND(��¥, '����')
            ����
                YEAR
                MONTH
                DD
                DAY
                HH
                ...
        ���� ]
            �⵵ ���� �ݿø���
            <<== 6�� ������ ����⵵, 7�����Ĵ� ������.
            
            ������ �ݿø���
            <<== 15������ �����, 16 ���Ĵ� ������
            
            DAY - ���� ����
            DD  - ��¥����
*/
-- ���� ��¥�� �⵵�� �������� �ݿø��ؼ� ��ȸ�ϼ���.
SELECT ROUND(SYSDATE,'YEAR') AS ��ݿø�
     , ROUND(SYSDATE,'MONTH') AS ���ݿø�
     , ROUND(SYSDATE,'DAY') AS �Ϲݿø� --�̹��� ù�糯�� ǥ���
  FROM DUAL
;

SELECT TO_CHAR(ROUND(SYSDATE,'MI'),'YYYY/MM/DD HH24:MI:SS') FROM DUAL;
/*
    ���� ] ��������� ��ȸ�ϼ���.
        1�ʵ� ���������
            ����̸� : xxx, ����޿� : XXXX
        �� ���·� ��ȸ�ǰ� �ϼ���.
        
        �޿��� 7�ڸ��� ǥ���ϰ� 
        ���� ���ڸ��� ǥ���ϰ� �������� *�� ǥ���Ѵ�.
        */
---------------------------------------------------------------------------
SELECT INSTR((TO_CHAR(SAL,'000,000')),',',-1)
  FROM EMP
;
SELECT TRANSLATE(TO_CHAR(SAL,'000,000'),',','a')

  FROM EMP
;
SELECT CONCAT(CONCAT('����̸� : ', ENAME), CONCAT(' ����޿� : ',LPAD(SUBSTR(TO_CHAR(SAL),-2),LENGTH(TO_CHAR(SAL,'000,000')),'*'))) AS ������� 

  FROM EMP
;

SELECT 
CONCAT(
    CONCAT('����̸� :',ENAME),
    CONCAT(' �޿� : ',LPAD(
    CONCAT(',',SUBSTR(TO_CHAR(SAL,'000,000'), -3)),LENGTH(TO_CHAR(SAL,'000,000')),'*')
    ))
FROM EMP
;
/*
    ��ȯ�Լ�
    ==> �Լ��� ������ ���¿� ���� ����ϴ� �Լ��� �޶�����.
        �׷��� ���� ����Ϸ��� �Լ��� �ʿ��� �����Ͱ� �ƴ� ���� ���??
        �̷��� ����ϴ� ���� ����ȯ �Լ��̴�.
        ==> �������� ���¸� �ٲ㼭 Ư�� �Լ��� ����� �� �ֵ��� ����� �ִ� �Լ�
        
        1. TO_CHAR
            ==> ��¥�� ���ڸ� ������ �����ͷ� ��ȯ�����ִ� �Լ�
            
            ���� 1]
            
            TO_CHAR(��¥ Ȥ�� ���� ������)
            
            ���� 2]
            
            TO_CHAR(��¥ Ȥ�� ����, '����')
            ==> ��ȯ�� �� ���ڿ��� ������ ���� ��ȯ��Ű�� ���
            TO_CHAR(SAL,'$999,999,999')
*/
-- ����� 5���� �Ի��� ����� ������ ��ȸ�ϼ��� ��, ����ȯ �Լ��� ����ؼ�
SELECT ENAME, HIREDATE, TO_CHAR(HIREDATE) �Ի糯¥

FROM EMP

WHERE
    TO_CHAR(HIREDATE) LIKE '%/05/%'
;
-- �޿��� 100~999������ ����� �̸� �޿��� ��ȸ�ϼ���

SELECT
    ENAME, SAL
FROM
EMP
WHERE
    --TO_CHAR(SAL) LIKE '___'
    LENGTH(TO_CHAR(SAL))=3;
    
-- ����� �̸� �޿��� ��ȸ�ϼ���, �� �޿��� ���ڸ�����,�� �������ְ�տ��� $�� �ٿ��ּ���
SELECT ENAME AS ����̸�,TO_CHAR(SAL,'$000,000,000'), TO_CHAR(SAL,'$999,999,999') AS ����޿�
  FROM EMP
;

-- ����� �̸�, �Ի���, �Ի������ ��ȸ�ϼ���.
SELECT ENAME AS ����̸�, HIREDATE AS �Ի���, TO_CHAR(HIREDATE,'DAY')AS �Ի����
  FROM EMP
;

SELECT ENAME AS ����̸�
     , TO_CHAR(HIREDATE, 'YYYY-mm-dd') AS �Ի���
     , TO_CHAR(HIREDATE, 'YYYY.mm.dd') AS �Ի���
     , TO_CHAR(HIREDATE, 'YYYY/mm/dd') AS �Ի���
     , TO_CHAR(HIREDATE, 'YYYYmmdd') AS �Ի���
FROM EMP
;
/*
    2. TO_DATE
        ==> ���ڷ� �� ������ ��¥ �����ͷ� ��ȯ�� �ִ� �Լ�
        
        ���� 1]
            TO_DATE(��¥���� ����)
        ���� 2]
            TO_DATE(��¥���� ����, '����)
            ==> ���ڵ����Ͱ� ����Ŭ�� �����ϴ� ������ ��¥ó��
                �Ǿ����� ���� ��� ����ϴ� ���
            ��]
                '08/25/20'ó�� ��/��/�� �� ������ ���ڰ� ������� ���
                
*/            


-- ����� �¾�� ���� ° ���� ��ȸ�ϼ���.
SELECT FLOOR(SYSDATE - TO_DATE('1989/02/18'))FROM DUAL;

SELECT FLOOR(TO_DATE(SYSDATE,'MM/DD/YY')-TO_DATE('02/18/89','mm/dd/yy')) FROM DUAL;

/*
    3. TO_NUMBER
        ==> ���ڷε� ������ ���� �����ͷ� ��ȯ�����ִ� �Լ�
            <<--���ڵ����ʹ� +,- ������ ���� �ʴ´�.
            
        ���� 1 ]
            TO_NUMBER(���ڵ�����)
        ���� 2]
            TO_NUMBER(���ڵ�����, ����)
*/
--'123' �� '789'�� ���� ���� ��ȸ�ϼ���.
SELECT TO_NUMBER('123')+TO_NUMBER('789')FROM DUAL;

-- '123,456' - '5,678'

SELECT TO_NUMBER('123,456','999,999') - TO_NUMBER('5,678','9,999') FROM DUAL;

---------------------------------------------------------

/*
    ��Ÿ�Լ�
    
    1. NVL
        ==> NULL �����ʹ� ��� ����(�Լ�)���� ���ܰ��ȴ�.
            �� ������ �ذ��ϱ� ���� ������� �����Ǵ� �Լ�
        �ǹ�]
            NULL �����͸� ������ ������ �����ͷ� ��ü�ؼ�
            ����, �Լ��� ������ �����ּ���
        
        ���� ]
            NVL(������, �ٲ𳻿�)
            
        ***
        ���ǻ��� ]
            ������ �����Ϳ� �ٲ� ������ �������� Ÿ���� ���ƾ� �Ѵ�.
    2. NVL2
        ���� ]
            NVL2(�ʵ��̸�, ó������1, ó������2)
        �ǹ� ]
            �ʵ��� ������ NULL�̸� ó������2�� �����ϰ�
            ������ ������(NULL�� �ƴϸ�)ó������1�� �����ϼ���.
            
    3. NULLIF
        ����]
            NULLIF(������1, ������2)
            
        �ǹ�]
            �� �����Ͱ� ������ NULL�� ó���ϰ� 
            �ٸ��� ������1���� ó���ϼ���
            
    4. COALESCE
        ����]
            COALESCE(������1, ������2.....)
        �ǹ�]
            �������� �������� ���� ù��° ������ NULL�� �ƴ� �����͸� ����϶�
             COALESCE(COMM, SAL, 0) Ŀ�̼��� ���̸� SAL�� ����ض� 0����?
*/

SELECT
   -- ENAME, COMM, NVL(COMM+100,'Ŀ�̼Ǿ���') --------X Ÿ���� ���ƾ��Ѵ�(����((COMM�� 100�� �����ٰǵ�, �������Ұ�)
FROM EMP
;

SELECT
    ENAME, COMM, NVL2(COMM, COMM+100, 0) AS ����Ŀ�̼�
FROM
    EMP
;
SELECT 
    NULLIF('A','A') AS ����1, NULLIF('A','B') AS ����2 
FROM 
    DUAL
;

--CCOALESCE ] Ŀ�̼��� ��ȸ�ϴµ� ���� Ŀ�̼��� NULL�̸� �޿��� ��� ����ϵ��� ����
SELECT
    ENAME,SAL ,COMM,COALESCE(COMM, SAL,0) ����
FROM 
    EMP
;
---------------------------------------------------------------------------
/*
    ���� 1]
        COMM�� �����ϸ� ���� �޿��� 10%�� �λ��ѱݾ� + Ŀ�̼��� ����ϰ�
        Ŀ�̼��� �������� ������ ���� �޿��� 5%�� �λ��ѱݾ� +100�� ����Ͻÿ�
*/
SELECT ENAME, NVL(COMM*1.10,(SAL*1.05)+100)AS �λ�Ŀ�̼�, SAL AS ����, COMM AS Ŀ�̼� FROM EMP;
SELECT ENAME, ROUND(NVL2(COMM, COMM*1.10,(SAL*1.05)+100)) AS �λ�Ŀ�̼� FROM EMP;
SELECT ENAME, COMM, COALESCE(COMM*1.10,(SAL*1.05)+100,0) AS �λ�Ŀ�̼� FROM EMP;
SELECT ENAME, COMM, COALESCE(COMM*1.10,SAL,(SAL*1.05)+100) AS �λ�Ŀ�̼� FROM EMP;

/*
    ���� 2]
        COMM�� 50%�� �߰��ؼ� �����ϰ��� �Ѵ�.
        ���� Ŀ�̼��� �������� ������
        �޿��� �̿��ؼ� 10%�� �����ϼ���
*/

SELECT ENAME, SAL, COMM,NVL(COMM*1.50,SAL*1.10) AS Ŀ�̼� FROM EMP;
SELECT ENAME, SAL, COMM, NVL2(COMM,COMM*1.50,(SAL*1.10)) AS �λ�Ŀ�̼� FROM EMP;
SELECT ENAME, SAL, COMM, COALESCE(COMM*1.50,SAL*1.10) AS ����Ŀ�̼� FROM EMP;

SELECT COALESCE('HELLO','HI','HESASIBURI')AS NULLTEST1
     , COALESCE(NULL,'HI','HESASIBURI')AS NULLTEST2
     , COALESCE('NINANO',NULL,'HESASIBURI')AS NULLTEST3
     , COALESCE(NULL,NULL,'HESASIBURI')AS NULLTEST4
     , COALESCE(NULL,NULL,NULL,'HESASIBURI')AS NULLTEST5
     , COALESCE('HELL',NULL,NULL,'HESASIBURI')AS NULLTEST6
     , COALESCE(NULL,NULL,NULL,3) AS NULLTEST7
      , COALESCE(NULL,NULL,NULL,NULL) AS NULLTEST8
  FROM DUAL
;

---------------------------------------------------------------------------
/*
    ���� ó�� �Լ�
        1. DECODE
            ���� ]
                DECODE(������, ������1, ó������1,
                              ������2, ó������2,
                              ������3, ó������3,
                              ...
                              ��Ÿó������)
            �ǹ� ]
                �����Ͱ� 
                    ������1�� ������ ó������ 1�� �����ϰ�,
                    ������2�� ������ ó������ 2�� �����ϰ�,
                    ������3�� ������ ó������ 3�� �����ϰ�,
                    ..
                    �� �̿��� ���̸� ��Ÿ ó�������� �����ϼ���

*/

/*
    �μ���ȣ�� 10���̸� ������
             20���̸� �ѹ���
             30���̸� �����
             �� �̿��� ���̸� ����
             ��ȸ�ǰ� �ϼ���.
             
*/
SELECT
    EMPNO AS �����ȣ, ENAME AS ����̸�, DEPTNO �μ���ȣ, 
    DECODE(DEPTNO, 10, '������',
                   20, '�ѹ���',
                   30, '�����',
                   '���Ͻ�'
    ) AS �μ��̸�
FROM
    EMP
;

/*
    2. CASE
        ���� 1]
            CASE    WHEN ���ǽ�1 THEN ����1
                    WHEN ���ǽ�2 THEN ����2
                    WHEN ���ǽ�3 THEN ����3
                    ...
                    ELSE ����N
            END
            (�ݵ�ý�����Ѵ�END)
        �ǹ� ]
            ���ǽ� 1�� ���̸� ����1�� ����
            ���ǽ� 2�� ���̸� ����2�� ����
            ���ǽ� 3�� ���̸� ����3�� ����
            ...
            �� �̿��� ������ ����N�� �����ϼ���
            
        ���� 2]
            CASE �ʵ��̸� WHEN ��1 THEN ����1
                         WHEN ��2 THEN ����2
                         WHEN ��3 THEN ����3
                         ...
                        ELSE ���� n
            END
            
        �ǹ� [ 
            DECODE�� ����� �ǹ�
            ���������� = ��� ���Ǹ� ����ϴ� ���

*/

SELECT 
    ENAME AS ����̸�, DEPTNO AS �μ���ȣ,
    CASE WHEN DEPTNO = 10 THEN '������'
         WHEN DEPTNO = 20 THEN '�ѹ���'
         WHEN DEPTNO = 30 THEN '�����'
         ELSE '����'
    END AS �μ��̸�
    
FROM
    EMP
;
SELECT 
    ENAME AS ����̸�, DEPTNO AS �μ���ȣ,
    CASE DEPTNO WHEN 10 THEN '������'
                WHEN  20 THEN '�ѹ���'
                WHEN  30 THEN '�����'
                ELSE '����'
    END AS �μ��̸�
    
FROM
    EMP
;