-- day04 ����

/*
    1. SMITH ����� ������ ������ ���� ����� ������ ��ȸ�ϼ���
*/
SELECT ENAME AS ����̸�, JOB AS ����, SAL AS ����, HIREDATE AS �Ի���
FROM EMP
WHERE
    JOB IN (
            SELECT
               JOB
            FROM
                EMP
            WHERE 
                ENAME = 'SMITH'
                
            )
    
;
/*
    2. ������� ��ձ޿����� ���Թ޴� ����� ������ ����ϼ���
*/
SELECT ENAME AS ����̸�, JOB AS ����, SAL AS ����, HIREDATE AS �Ի���
FROM EMP
WHERE
   SAL< ( 
                SELECT
                    AVG(SAL)
                FROM
                    EMP
        
                    
                )
;
/*
    3. �ְ� �޿����� ������ ��ȸ�ϼ���.
*/

SELECT ENAME AS ����̸�, JOB AS ����, SAL AS ����, HIREDATE AS �Ի���
FROM EMP
WHERE
    SAL IN(
            SELECT 
                MAX(SAL)
            FROM
                EMP
            )

;
/*
    4. KING ������� �ʰ� �Ի��� ����� ������ ��ȸ�ϼ���    
*/

SELECT ENAME AS ����̸�, JOB AS ����, SAL AS ����, HIREDATE AS �Ի���
FROM EMP
WHERE
    HIREDATE >(
                SELECT HIREDATE FROM EMP WHERE ENAME = 'KING'
                )
;

/*
    5. �� ����� �޿��� ��ձ޿��� ���̸� ��ȸ�ϼ���,   
*/

SELECT ENAME AS ����̸�, JOB AS ����, SAL AS ���� 
      ,SAL-(    
            SELECT
                MAX(SAL)
            FROM 
                EMP
        ) AS �޿�����
FROM EMP
;

------------------Ǯ��
SELECT
    EMPNO, ENAME,
    SAL -(SELECT
        AVG(SAL)
    FROM
        EMP)
    
FROM EMP
;

SELECT (10  - (SELECT 9/3 FROM DUAL)) FROM DUAL;
/*
    6. �μ��� �޿��հ谡 ���� ���� �μ��� ������� ������ ��ȸ�ϼ���  
*/
SELECT *
FROM EMP
WHERE
     DEPTNO IN (
                SELECT MAX(SUM(SAL))
                FROM EMP
                GROUP BY
                    DEPTNO
                     
                    )

            
;

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE
    DEPTNO = (
                SELECT
                    DEPTNO
                FROM
                    EMP
                GROUP BY
                    DEPTNO
                HAVING
                    SUM(SAL) = (
                                    SELECT
                                        MAX(SUM(SAL))
                                    FROM
                                        EMP
                                    GROUP BY
                                        DEPTNO
                                    )
            )
;
/*
    7. Ŀ�̼��� �޴� ������ �ѻ���̶� �ִ� �μ��� �Ҽ� ������ ������ ��ȸ�ϼ���  
*/
SELECT  ENAME AS ����̸�, JOB AS ����, SAL AS ����, COMM,HIREDATE AS �Ի���, DEPTNO
FROM EMP
WHERE
    COMM IS NULL
    
    
;
---Ǯ��
SELECT
    *
FROM
    EMP
WHERE
    DEPTNO IN (
                SELECT
                    DISTINCT DEPTNO
                FROM
                    EMP
                WHERE
                    COMM IS NOT NULL
               )
;
/*
    8. ��� �޿����� �޿��� ����, �̸��� 4���� �Ǵ� 5������ ����� ������ ��ȸ�ϼ���.
*/
SELECT ENAME AS ����̸�, JOB AS ����, SAL AS ����, COMM,HIREDATE AS �Ի���, DEPTNO
FROM EMP
WHERE
    SAL > (SELECT AVG(SAL) FROM EMP)
    AND LENGTH(ENAME) IN (4,5)
    
;


------------------Ǯ��
SELECT
ENAME AS ����̸�, JOB AS ����, SAL AS ����, COMM,HIREDATE AS �Ի���, DEPTNO 
, ROUND((SELECT AVG(SAL) FROM EMP),2) AS �������
FROM
    EMP
WHERE
     SAL > (SELECT AVG(SAL) FROM EMP )
           AND LENGTH(ENAME) IN(4,5)
;
/*
    9. ����� �̸��� 4���ڷε� ����� ���� ������ ������� ������ ��ȸ�ϼ���  
*/
SELECT ENAME AS ����̸�, JOB AS ����, SAL AS ����, COMM,HIREDATE AS �Ի���
FROM EMP
WHERE
    ENAME IN ( SELECT ENAME FROM EMP WHERE LENGTH(ENAME) =4)

    
;

/*
    10. �Ի�⵵�� 81���� �ƴ� ����� ���� �μ��� �ִ� ����� ������ ��ȸ�ϼ���  
*/

SELECT
    *
FROM
    EMP
WHERE 
    DEPTNO IN (
SELECT 
    DISTINCT DEPTNO
FROM
    EMP
WHERE
    HIREDATE NOT BETWEEN '1981/01/01' AND '1982/01/01')
  --  TO_CHAR(HIREDATE, 'YY') != '81')
    /*
        ����������
            <>
            !=
            ^=
            NOT
    */
;

/*
    11. ���޺� ��� �޿����� �����̶� ���� �޴� ����� ������ ��ȸ�ϼ��� --ANY
*/

/*
    12. ��� �Ի�⵵ ��ձ޿����� ���� �޴� ����� ������ ��ȸ�ϼ���.--ALL
*/

/*
    13. �ְ� �޿����� �̸� ���̿� ���� �̸� ���̸� ���� ����� �����ϸ� 
        ��� ����� ������ ��ȸ�ϰ�, 
        �ƴϸ� ��ȸ���� ������.   ---EXISTS
*/
SELECT
*
FROM
EMP
WHERE
     EXISTS( SELECT
            *
            FROM
            EMP
            WHERE
                LENGTH(ENAME) = ( 
                                    SELECT
                                    LENGTH(ENAME)
                                  FROM
                                    EMP
                                    WHERE
                                        SAL = (
                                                SELECT
                                                    MAX(SAL)
                                                    FROM
                                                        EMP
                                                   
                                                    )
                                    )
                                                    
                 )