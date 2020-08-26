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
/*
    6. �μ��� �޿��հ谡 ���� ���� �μ��� ������� ������ ��ȸ�ϼ���  
*/
SELECT ENAME AS ����̸�, JOB AS ����, SAL AS ����, HIREDATE AS �Ի���, DEPTNO
FROM EMP
WHERE
     ENAME IN (
                SELECT ENAME
                FROM EMP
                WHERE ENAME EXISTS( SELECT MAX(SUM(SAL)) FROM EMP GROUP BY DEPTNO)               
                     
                     
                       
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

/*
    8. ��� �޿����� �޿��� ����, �̸��� 4���� �Ǵ� 5������ ����� ������ ��ȸ�ϼ���.
*/
SELECT ENAME AS ����̸�, JOB AS ����, SAL AS ����, COMM,HIREDATE AS �Ի���, DEPTNO
FROM EMP
WHERE
    SAL > (SELECT AVG(SAL) FROM EMP)
    AND LENGTH(ENAME) IN (4,5)
    
;

/*
    9. ����� �̸��� 4���ڷε� ����� ���� ������ ������� ������ ��ȸ�ϼ���  
*/
SELECT ENAME AS ����̸�, JOB AS ����, SAL AS ����, COMM,HIREDATE AS �Ի���
FROM EMP
WHERE
    ENAME IN ( SELECT ENAME FROM EMP WHERE LENGTH(ENAME) =4)

    


/*
    10. �Ի�⵵�� 81���� �ƴ� ����� ���� �μ��� �ִ� ����� ������ ��ȸ�ϼ���  
*/

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