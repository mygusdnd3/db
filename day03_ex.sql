/*
    1. 1���� 365���̶�� �����ϰ�
        ����� �ٹ��� ���� �� ������ ǥ���ϰ�
        ��� �Ҽ� ���ϴ� ��������
        
        ǥ������ ]
            ����̸�    �Ի���     �ٹ����
            SMITH       80/00/00    40�� 
            
*/

SELECT ENAME AS ����̸�, TO_CHAR(HIREDATE,'YY/MM/DD') AS �Ի���, CONCAT(TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(HIREDATE,'YYYY'),'��') AS �ٹ����
FROM EMP;

SELECT ENAME AS ����̸�, HIREDATE AS �Ի���, TO_CHAR(SYSDATE, 'YYYY')- TO_CHAR(HIREDATE,'YYYY')||' ��' AS �ٹ����
FROM EMP
;
/*
    2. ����� �̸�, �Ի��� , �ٹ����� ��ȸ�ϼ���
        ��, �ٹ����� ��, �� ������ ǥ���ϼ���

*/
SELECT ENAME AS ����̸�, HIREDATE AS �Ի���, TO_CHAR(SYSDATE,'YYYY')-TO_CHAR(HIREDATE,'YYYY') AS ��
     , FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS �Ի簳��
FROM EMP
;
SELECT ENAME AS ����̸�, HIREDATE AS �Ի���, TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(HIREDATE,'YYYY') AS ��
     , FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS �Ի簳�� FROM EMP;
/*
    3. ����� ù �޿��� ���� �� ���� �ٹ��� ���� ��ȸ�ϼ���
*/
SELECT ENAME, LAST_DAY(HIREDATE)-HIREDATE AS "ù �޿��� �ٹ���"
FROM EMP
;
SELECT ENAME, LAST_DAY(HIREDATE)     FROM EMP;
/*
    4. ����� �Ի��� �����ϴ� ù ������� ��ȸ�ϼ���
*/
SELECT ENAME, HIREDATE, NEXT_DAY(HIREDATE,'��')AS ù��°�����
FROM EMP
;

/*
    5. �ٹ������ �Ի��� ���� 1���� �������� �����ؾ��Ѵ�.
        ����� �ٹ���� �������� ��ȸ�ϼ���.
        ��, 15�� �����Ի��ڴ� �ش� ���� �����Ϸ� �ϰ�
            16�� ���� �Ի��ڴ� �ش� ���� �������� �������� �Ѵ�.
*/
SELECT ENAME, ROUND(HIREDATE,'MM'),HIREDATE
FROM EMP
;


/*
    6. ����� �����Ͽ� �Ի��� ����� �̸�, �Ի���, �Ի� ������ ��ȸ�ϼ���
*/

SELECT TO_CHAR(HIREDATE, 'day') FROM EMP;
SELECT ENAME, HIREDATE FROM EMP
WHERE
 TO_CHAR(HIREDATE,'DAY') = '������'
 ;

/*
    7 ��� �޿��߿��� ������� 0�� ����� ����̸�, �޿��� ��ȸ�ϼ���
    
    ��Ʈ ]
        ���ڿ��� ��ȯ�� ó���Ѵ�.
*/
SELECT ENAME, SAL

FROM EMP

WHERE
 SUBSTR(TO_CHAR(SAL),-3,1) != 0;

 


/*
    8. ����� ����̸�, �޿�, Ŀ�̼��� ��ȸ�ϼ���.
        ��, Ŀ�̼��� ���� ����� NONE ���� ǥ�õǰ� �ϼ���.
        
        
*/     
SELECT ENAME, SAL, COMM,COALESCE(TO_CHAR(COMM),'NONE')

FROM EMP
;

SELECT 
    ENAME AS ����̸� , SAL ����޿�, COMM AS Ŀ�̼�
    ,DECODE(COMM,NULL,'NONE'
                ,TO_CHAR(COMM)
        )AS "Ŀ�̼� ����"
FROM EMP
;
    