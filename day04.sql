-- ����ó�� �Լ��� ����ؼ� �ذ��ϼ���

/*
    ����� ������ �츮���� ��ȸ�ϼ���.
    
        MANAGER - ������
        SALESMAN - ������
        CLERK   - ���
        ANALYST - �м���
        PRESIDENT   - ����

*/
SELECT DECODE(JOB, MA
FROM EMP
;

SELECT ENAME
     , DECODE(JOB, 'MANAGER',   '������'
                 , 'SALESMAN',  '������'
                 , 'CLERK',     '���'
                 , 'ANALYST',   '�м���'
                 , 'PRESIDENT', '����'
                 
            ) AS ����
FROM EMP
;

/*
    2. �� �μ����� ���ʽ��� �ٸ��� �����ؼ� �����Ϸ� �Ѵ�.
    
        10 - �޿��� 10%
        20 - �޿��� 15%
        30 - �޿��� 20%
        �� ���� Ŀ�̼ǿ� ���ؼ� �����Ϸ��� �Ѵ�
        ���� Ŀ�̼��� ���� ����� 0���� ����ؼ� ����ϱ�� �ϰ�
        �����
            �̸�, �μ���ȣ, ����Ŀ�̼�, ����Ŀ�̼�
            �� ��ȸ�ϼ���

*/

SELECT ENAME AS ����̸�, DEPTNO AS �μ���ȣ, NVL(COMM,0) FROM EMP;

SELECT ENAME AS ����̸�, DEPTNO AS �μ���ȣ, SAL AS �޿� ,NVL(COMM ,0)AS ����Ŀ�̼�,
        CASE DEPTNO WHEN 10 THEN NVL(COMM,0) +(SAL*1.10)
                    WHEN 20 THEN NVL(COMM,0) +(SAL*1.15)
                    WHEN 30 THEN NVL(COMM,0) +(SAL*1.20)
            END AS ����Ŀ�̼�
FROM 
    EMP
--WHERE
    --NVL(COMM,0);
    ;

/*
    3. �Ի�⵵�� ��������
        80 -'A'
        81 -'B'
        82 - 'C'
        �׿ܿ� �Ի��� ������ 'D' ������� 
        
        �������
            ����̸�, �Ի���, ������
        �� ��ȸ�ϼ���.
        
*/
SELECT ENAME , HIREDATE, 
    DECODE (TO_CHAR(HIREDATE,'YY'), '80','A'
                                 , '81','B'
                                 , '82','C'
                                 , 'D'
           ) AS "��� ���"                      
FROM 
    EMP
;

/*
    4. ����� �̸��� 4�����̸� 'MR.' �� �̸��տ� ���̰�
        4���ڰ� �ƴϸ� �̸� �ڿ� '���'�� �ٿ��� ��ȸ�ϱ�� �Ѵ�.
        ������� 
        �����ȣ, ����̸�, ����̸� ���ڼ�?
        �� ��ȸ�ϼ���.
*/
SELECT EMPNO, LENGTH(ENAME) AS ���ڼ�
     , CASE LENGTH(ENAME) WHEN 4 THEN 'MR. '||ENAME
                          ELSE ENAME||' ���'
            END AS ����̸�
FROM EMP
;
--���������
SELECT EMPNO, ENAME , LENGTH(ENAME)
    , DECODE( ENAME, LENGTH(ENAME)=4, 'MR.'||ENAME )
    
FROM EMP
;

/*
    5. �μ���ȣ�� 10 �Ǵ� 20 �̸� �޿� + Ŀ�̼��� ����� ����ϰ�
    Ŀ�̼��� ������ 0���� ���)
    �� �̿��� �μ��� �޿��� ����ϵ��� �ۼ��Ͻõ�
    
    ����̸�, �μ���ȣ, �޿�, Ŀ�̼�, ���ޱݾ�, �� ��ȸ�Ͻÿ�
*/
SELECT ENAME, DEPTNO , SAL,NVL(COMM,0)AS Ŀ�̼�
    , DECODE(DEPTNO, 10,SAL+NVL(COMM,0)
                   , 20,SAL+NVL(COMM,0)
                   , 30,SAL+NVL(COMM,0)
                   
            )AS ���ޱݾ�
FROM EMP;
/*
    6. �Ի��� ������ �����, �Ͽ����� ������� �޿��� 20% �����ؼ� �����ϰ�
        ���̿��� ������� 10%�����ؼ� �����Ϸ��� �Ѵ�.
        
        �������
            ����̸�, �Ի���, �Ի���� , �޿� ,���޿�
        �� ��ȸ�Ѵ�.
*/
SELECT ENAME, HIREDATE, TO_CHAR(HIREDATE, 'DAY'), SAL AS �޿�
     , CASE TO_CHAR(HIREDATE, 'DAY') WHEN '�����' THEN SAL*1.20
                                     WHEN '�Ͽ���',SAL*1.20
                                     ELSE SAL*1.10
            END AS ���޿�
  FROM EMP;
  
SELECT ENAME, HIREDATE, TO_CHAR(HIREDATE, 'DAY'), SAL AS �޿�,
    DECODE(TO_CHAR(HIREDATE, 'DAY'),'�����',SAL*1.20
                                  
                                   ,SAL*1.10) AS ���޿�
FROM EMP;
/*
    7. �ٹ��������� 470���� �̻��̸� Ŀ�̼��� 500 �߰��ؼ� �����ϰ�
        Ŀ�̼��̾����� 0���� ����Ѵ�. 
        �ٹ� �������� 470���� �̸��� Ŀ�̼��� ���� Ŀ�̼Ǹ� �����ϵ��� �Ϸ� �Ѵ�. 
        �������
            ����̸�, Ŀ�̼�, �Ի���, �Ի簳����, ����Ŀ�̼�
        �� ��ȸ�ϼ���.
*/
  SELECT FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE) AS ����, 
            DECODE(����,����>470, NVL(COMM,0)+500
                        , NVL(COMM,0)
    ) AS ����Ŀ�̼� FROM EMP;
    ;
SELECT ENAME, COMM, HIREDATE, FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS ������
        ,CASE WHEN FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) >470 THEN NVL(COMM,0)+500
             ELSE NVL(COMM,0)
             END AS ABC
FROM EMP
;

/*
    8. �̸��� ���ڼ��� 5���� �̻��� ����� �̸��� 3����**�� ���̰� 
        4���� ������ ����� �̸��� �״�� ��ȸ�Ϸ����Ѵ�.
        
        �������
            ����̸�, �̸����ڼ�, �����̸�
        �� ��ȸ�Ͻÿ�
*/
SELECT 

---------------------------------------------------------------------------------
--day04

/*
    �׷��Լ�
    ==�������� �����͸� �ϳ��� ���� ������ ����ϴ� �Լ�
    
    ***
    ���� 
      �׷��Լ��� ���� ����� �Ѱ��� ������ �ȴ�.
      ���� �׷��Լ��� ����� ������ ������ ���� ȥ���ؼ� ����� �� ����.
      (==> �ʵ�, ������ �Լ��� ���� ����� �� ����.)
      ���� ����� �� �����θ� ������ �Ͱ��� ȥ���� �� �ִ�.
      �׷��Լ��Ƹ� ���� ����� �� �ִ�.
*/

SELECT ENAME FROM EMP;  -- 14���� ����� ��ȸ
SELECT SUM(SAL) AS �޿����� FROM EMP; -- �Ѱ��� ����� ��ȸ
SELECT ENAME, SUM(SAL)FROM EMP; ---X �̷��� ���� �ȵȴ�.
SELECT 
    ENAME, SUM(SAL)
FROM
    EMP
WHERE
    ENAME = 'SMITH' ;    ------��ǻ�Ͱ� �����ϱ⿣ �������� ���ü��ִ�. ���þȵ�

/*
    1. SUM
        ==> �������� �հ踦 ��ȯ���ִ� �Լ� 
        ���� ]
            SUM(�ʵ��̸�)
*/

SELECT SUM(SAL) AS �޿��հ�
  FROM EMP
WHERE DEPTNO = 10
;

SELECT DEPTNO, SAL, EMPNO FROM EMP;
/*
    2. AVG
        ==> ������ ����� ���ϴ� �Լ�
        ���� ]
            AVG(�ʵ��̸�)
            
        ���� ]
            NULL ����� ����� ����ϴ� �κп��� ������ ���ܵȴ�.
*/
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS ����
     , DECODE(����, ����>470,COMM+500
                 , COMM)
FROM EMP;
    
SELECT SUM(SAL) AS �޿��հ�, AVG(SAL) �޿����
  FROM EMP;
  
SELECT SUM(COMM) AS Ŀ�̼��հ�
     , FLOOR(AVG(NVL(COMM,0))) --AVG(COMM)
  FROM EMP
;
/*
    ����� 550�� Ŀ�̼��� �ִ� ������� ���� ������̴�.
    ������ NULL�� ��� ���꿡�� ���ܰ� �Ǳ� ������
    ������� ī��Ʈ ���� �����´�. 
*/
-- Ŀ�̼��� �ִ� �����
SELECT 
    COUNT(COMM) AS "Ŀ�̼����ִ� �����"
FROM
    EMP
;

/*
    3. COUNT
        ==> ������ �ʵ��߿��� �����Ͱ� �����ϴ� �ʵ��� ������ ��ȯ���ִ� �Լ�.
        �� ]
            ����߿��� Ŀ�̼��� �޴� ����� ���� ��ȸ
            SELECT COUNT(COMM) FROM EMP;
        ���� ]
            �ʵ��̸� ��ſ� *�� ����ϸ�
            ������ �ʵ��� ī��Ʈ�� ���� ���� �� 
            �� ����߿��� ���� ū���� �˷��ְ� �ȴ�.
*/

-- ����� ��簡 �����ϴ� �����
SELECT COUNT(MGR) FROM EMP;
-- ��� ���� ��ȸ�ϼ���
SELECT COUNT(*) FROM EMP;

/*
    4. MAX / MIN
        ==> ������ �ʵ��� ������ �߿��� ���� ū �Ǵ� ���� �����͸� ��ȯ�ϴ� �Լ�
*/
--����� �ְ�޿��� �ּұ޿��� ��ȸ�ϼ���
SELECT MAX(SAL),MIN(SAL) FROM EMP;

/*
    5. STDDEV ==> ǥ�������� ��ȯ���ش�.
    
    6. VARIANCE ==>  �л��� ��ȯ���ش�.
*/

-- ���� ] ������� ������ �������� ��ȸ�ϼ���.
SELECT COUNT(DISTINCT JOB) FROM EMP;
----------------------------------------------------------------------------

/* 
    GROUB BY
    ==> �׷��Լ��� ����Ǵ� �׷��� �����ϴ� ��.
    
    ��}
        �μ����� �޿��� �հ踦 ���ϰ��� �Ѵ�.
        ��å���� �޿��� ����� ��ȸ�ϰ��� �Ѵ�.
    ���� ]
        SELECT
            �׷��Լ�,�׷���� �ʵ�
        FROM
            ���̺� �̸�
        [WHERE]
        
        GROUB BY
            �ʵ��̸�.
        [ORDER BY]
        
        ;
*/
SELECT 
    DEPTNO AS �μ���ȣ, SUM(SAL)AS �μ��޿��հ�
FROM 
    EMP
GROUP BY
    DEPTNO
;
-- ���޺� �޿� ���
SELECT
    JOB AS ����, ROUND(AVG(SAL),2) AS �޿����
FROM
    EMP
GROUP BY
    JOB
;
-- ���޺�����, �����, �޿��Ѿ� , �޿� ����� ��ȸ�ϼ���
SELECT
    JOB AS ����, COUNT(*) AS �����, SUM(SAL) AS �޿��Ѿ�, ROUND(AVG(SAL),2) AS �޿����
FROM
    EMP
GROUP BY
    JOB
;

/*
    1. �� �μ����� �ּ� �޿��� ��ȸ�ϼ���.
*/
SELECT DEPTNO, MIN(SAL)
FROM EMP
GROUP BY
    DEPTNO
;

/*
    2. �� ��å�� �޿��� �Ѿװ� ��ձ޿��� ��ȸ�ϼ���.
*/
SELECT JOB AS ��å, SUM(SAL), ROUND(AVG(SAL),2)
FROM EMP
GROUP BY
    JOB
 ;

/*
    3. �Ի�⵵���� ��� �޿��� �� �޿��� ��ȸ�ϼ���
        �Ի�⵵, ��ձ޿�, �ѱ޿�
*/
SELECT TO_CHAR(HIREDATE,'YY') AS �Ի�⵵
     , ROUND(AVG(SAL),3) AS ��ձ޿�
     , SUM(SAL) AS �ѱ޿� ,MAX(SAL),MIN(SAL),COUNT(*)
  FROM EMP
GROUP BY
    TO_CHAR(HIREDATE,'YY')

ORDER BY
    ��ձ޿� DESC
    
;
/*
    4. �� �⵵�� �Ի��� ������� ��ȸ�ϼ���
        �Ի�⵵, �����
*/
SELECT TO_CHAR(HIREDATE,'YY')AS �Ի�⵵ ,COUNT(*) AS �����
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YY')
;

/*
    5. ��� �̸��� ���ڼ��� 4,5 ���� ����� ���� ��ȸ�ϼ���
*/
SELECT COUNT(*) AS ����Ǽ�
FROM EMP
GROUP BY 
    ENAME
HAVING 
    LENGTH(ENAME) = 4 
    or LENGTH(ENAME) = 5
;
/*
    6. 81�⵵�� �Ի��� ����� ���� ��å���� ��ȸ�ϼ���
*/

SELECT
    JOB AS ����, COUNT(*) AS �����
FROM
    EMP
WHERE HIREDATE BETWEEN '1981/01/01' AND ' 1982/01/01'
GROUP BY
    JOB
;
SELECT JOB AS ��å , COUNT(*) AS �����
FROM EMP
GROUP BY
    JOB ,TO_CHAR(HIREDATE,'YY')
HAVING 
    TO_CHAR(HIREDATE,'YY')=81  

;

----------------------------------------------------------------

/*
    HAVING
    ==> GROUP BY ���� �׷�ȭ�� ��� ���� �׷��߿���
        ��ȸ����� ����� �׷��� �����ϴ� ���ǽ�
        
        **
        ���� ]
            WHERE ������ ��꿡 ����'��' �����͸� �����ϴ� ����
            HAVING ������ ����� ���� �� ��ȸ ����� �������� ���� �����ϴ� ������
*/

SELECT 
    JOB AS ����, COUNT(*) AS ������
FROM
    EMP
WHERE 
    DEPTNO = 10
GROUP BY
    JOB
;
-- �μ����� ��� �޿��� ����ϼ���.
-- ��, �� �μ��� ��� �޿��� 2000�̻��� �μ��� ��ȸ�ϼ���
SELECT
    DEPTNO �μ���ȣ, ROUND(AVG(SAL),2) AS �μ���ձ޿�
FROM
    EMP
GROUP BY
    DEPTNO
HAVING
    AVG(SAL) >=2000
;

-- ���޺��� ������� ��ȸ�ϼ���.
-- ��, ������� 1���� ������ �����ϰ� ��ȸ�ϼ���

SELECT JOB AS ����, COUNT(*) AS �����
FROM  EMP
GROUP BY JOB
HAVING COUNT(*) != 1
    
;
---------------------------------------------------------------------------------
/*
    7. ��� �̸��� ���̰� 4, 5������ ����� ���� �μ����� ��ȸ�ϼ���
        ��, ������� �ѻ�� �̸��� �μ��� ��¿��� �����ϰ����
*/

SELECT DEPTNO, COUNT(*) AS �����
FROM EMP
WHERE LENGTH(ENAME) IN (4,5)
GROUP BY DEPTNO
HAVING COUNT(*)>=1
;
SELECT DEPTNO, COUNT(*) AS �����
FROM EMP
WHERE
    LENGTH(ENAME) IN (4,5)
GROUP BY 
    DEPTNO
HAVING 
    DEPTNO != 1

;

/*
    8. 81�⵵�� �Ի��� ����� ��ü �޿��� ���޺��� ��ȸ�ϼ���.
        ��, ���޺� ��ձ޿��� 100�̸��� ������ ��ȸ�ؼ� �����ϼ���
*/ -- 81�⵵�� ��� ��� ������ �׷���
SELECT
    JOB AS ����, SUM(SAL)AS ��ü�޿� , AVG(SAL) AS ���
FROM
    EMP
WHERE
    TO_CHAR(HIREDATE,'YY')='81'
GROUP BY
    JOB
HAVING
    AVG(SAL) >= 1000
;
SELECT JOB, AVG(SAL), SUM(SAL)
FROM EMP
GROUP BY
    JOB,TO_CHAR(HIREDATE,'YY')
HAVING
    TO_CHAR(HIREDATE, 'YY')= '81'

;


/*
    9. 81�⵵�� �Ի��� ����� �� �޿��� ����� �̸� ���ڼ����� �׷�ȭ�ϼ���
        ��, �� �޿��� 2000�̸��� ���� �����ϰ�
        �� �޿��� ���� �������� ���� ������ ������������ �����ؼ� ��ȸ�ϼ���
*/
SELECT LENGTH(ENAME), SUM(SAL) AS ��ü�޿�, COUNT(*) AS �����
FROM EMP
WHERE TO_CHAR(HIREDATE,'YY')='81'
GROUP BY
    LENGTH(ENAME)
HAVING SUM(SAL) > 2000
ORDER BY
    SUM(SAL) DESC
;


SELECT 
   LENGTH(ENAME),  SUM(SAL) AS ��ü�޿�, COUNT(*) AS �����
FROM
    EMP
GROUP BY
    LENGTH(ENAME),TO_CHAR(HIREDATE, 'YY')
HAVING
    SUM(SAL) >2000
    AND TO_CHAR(HIREDATE, 'YY') =81

;
/*
    10. ����� �̸����ڼ��� 4,5�� ����� �μ��� ������� ��ȸ�ϼ���.
        ��, ������� 0�� ���� �����ϰ� �μ���ȣ ������������ �����ϼ���
*/
SELECT
    DEPTNO AS �μ���ȣ, COUNT(*) AS �����
FROM
    EMP
WHERE
    LENGTH(ENAME) IN (4,5)
GROUP BY
    DEPTNO
HAVING
    COUNT(*)<>0
;

/*
    EXTRA ]
        �μ����� �޿��� ��ȸ�ϴµ�
            10���μ��� ��ձ޿��� ��ȸ�ϰ�
                20���μ��� �޿��հ踦 �����ϰ�
                    30�� �μ��� �μ� �ְ�޿��� ��ȸ�ض�
*/

---------------------------------------------------------------------------
/*
    ��������
    ==> ���Ǹ�� �ȿ� �ٽ� ���� ����� ���Ե� ���� ��������(��������)�� �Ѵ�.
    ���� ]
        ���������� FROM���� ��ġ�ϴ� �������Ǹ�
            �ζ��κ�(INLINE VIEW)
        ��� �θ���
        �̶� �� �������Ǵ� ������ ����� ���̺�� ����ϰԵȴ�
*/

--'SMITH' ����� �Ҽ� �μ��� ������� ������ ��ȸ�ϼ���

SELECT
    EMPNO, ENAME, HIREDATE, DEPTNO
FROM
    EMP
WHERE
    DEPTNO =( SELECT
                DEPTNO       
                FROM 
                    EMP
                WHERE
                    ENAME = 'SMITH')
                    ;
                    
                    

SELECT
    DNO, MAX, MIN, AVG,CNT
FROM(

        SELECT
            
            DEPTNO DNO, MAX(SAL)AS MAX, MIN(SAL)AS MIN, AVG(SAL)AS AVG ,COUNT(*) AS CNT
        FROM
            EMP
        GROUP BY
            DEPTNO
            
    )
WHERE
   MAX = (
            SELECT
                MAX(SAL)   
            FROM EMP
        )
;
----------------------------------------------------------------------------
/*
    ���������� ����� ���� ����
    
    ***
    1. ���������� ��ȸ����� ���� �Ѱ��� �������� ���
        ==>�ϳ��� �����ͷ� ���� �����͸� ����� �� �ִ� ��쿡�� ��� ����Ѵ�.
        
        1) SELECT ��¿� ����� �� �ִ�.
            �̶� ���������� ��ȸ����� �ݵ�� ������ �����ʵ�� ��ȸ�Ǿ�� �ȴ�.
            
        2) �������� ����� �� �ִ�. 
*/

-- 10�� �μ� ����� ������ ��ȸ�ϴµ�
-- �����ȣ, ����̸�, �޿�, �μ���ȣ, �μ� �ְ�޿��� ��ȸ�ϼ���
                                 -- �ְ�޿��� �׷��� �ؾ��ϴ� �Լ��� ���� ����Ѵ�.
                                 

SELECT
    EMPNO, ENAME, SAL, DEPTNO,
    (
        SELECT
            MAX(SAL)        --�ְ�޿���������
        FROM
            EMP
        WHERE
            DEPTNO IN(  --���̽������ �μ��� ������
                        SELECT
                            DEPTNO
                        FROM
                            EMP
                        WHERE
                            DEPTNO=20
                             
                             )
                      
    )AS �ְ�޿�
FROM 
    EMP
    
WHERE
   DEPTNO=20
    
;



SELECT
    EMPNO, ENAME, 100*3
FROM
    EMP
;


/*
    2. ���������� ����� ���� �̻� ������ ���
            ==> �� ���� ������������ ��� �����ϴ�.
                �̶�, IN, ANY, ALL, EXIST �����ڸ� ����ؼ� ���������� ó���Ѵ�.
                
        ���� ]
            IN
                �������� �������� �Ѱ��� ��ġ�ϸ� �Ǵ� ���
                
            ANY
                �������� �������� �Ѱ��� ������ �Ǵ� ���
            
            ALL
                �������� �������� ��� �¾ƾ� �Ǵ� ���
            EXIST
                �������� �������� �ϳ��� ������ �Ǵ� ���
                �񱳴���� ���� ����Ѵ�.
                ���������� ����� �ִ��� �����ķ� �Ǵ��ϴ� ������
*/

-- ������ 'MANAGER'�� ����� ���� �μ��� ���� ����� ������ ��ȸ�ϼ���

--������ 'MANAGER'�� ����� �ҼӺμ� ��ȸ

SELECT
    EMPNO, ENAME, DEPTNO, JOB
FROM
    EMP
WHERE
    DEPTNO IN(
        SELECT
            DEPTNO
        FROM 
            EMP
        WHERE
            JOB = 'CLERK'
            AND ENAME<>'JAMES')
;


-- ����� ������ ��ȸ�ϴµ� ,
-- ��� �μ��� ��ձ޿����� ���� �޴� ����� ������ ��ȸ�ϼ���

SELECT
*
FROM
    EMP
WHERE
/*
 SAL> ALL(
            SELECT
                AVG(SAL)
            FROM
                EMP
            GROUP BY
                DEPTNO
        ) -- >(???,???,???)
*/
    SAL > ALL(
                SELECT 
                MAX(AVG)
                FROM(
                     SELECT
                        AVG(SAL) AS AVG
                     FROM
                         EMP
                     GROUP BY
                        DEPTNO
                )
                
            );

-- �� �μ��� ��ձ޿��� �ϳ��� ���� �޴� ����� ������ ��ȸ�ϼ���.



-- ALL

SELECT
    *
FROM
    EMP
WHERE
    EXISTS( --�񱳴�� ���� ����Ѵ�.
            SELECT
                *
                
            FROM
                EMP
            WHERE
                DEPTNO <> 40
            )
            
;

---------------------------------------------------------------------------

UPDATE
    EMP
SET
    SAL = (SELECT SAL FROM EMP WHERE ENAME = 'KING')
WHERE
    ENAME = 'SMITH'
    --SMITH ����� �޴� �޿��� KING����� �޴� �޿��δٰ�   
;

ROLLBACK;