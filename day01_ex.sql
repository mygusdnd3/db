--1. emp ���̺� �ִ� ����̸��� �μ���ȣ�� ��ȸ�ϼ���
SELECT ename , dept FROM emp;
--2. emp���̺� �ִ� �μ���ȣ�� ��ȸ�ϼ���
--    ��, �ߺ��� �μ��� �ѹ��� ��ȸ�ǰ� �ϼ���
SELECT DISTINCT dept FROM emp;
--3. emp ���̺� �ִ� ����̸��� ����(�޿�*12)�� ��ȸ�ϼ���
--  ��, ����� ��Ī���� ��µǰ� �ϼ���
SELECT ename as ����̸�, (sal*12) as ���� FROM emp;
--4. ����̸�, ���� �׸��� ������(����+Ŀ�̼�)�� ��ȸ�ϼ���
--      Ŀ�̼��� ���� ����� Ŀ�̼��� 0���� �ؼ� ����ϼ���
SELECT ename as ����̸�, (sal + NVL(comm,0) ) as ������ FROM emp;
--5. ����� �̸�,����, �Ի����� ��ȸ�ϼ���.
-- �� ����� ��Ī����
SELECT ename as ����̸�, job as ����, hiredate as �Ի��� FROM emp;
--6. ����̸�, ����, �޿��� ��ȸ�ϼ���.
        --��, �޿��� ���� �޿��� 10% �λ�� �޿��� ��ȸ�ϼ���.
SELECT ename as ����̸�, job as ���� , sal+(sal/10) as �޿� FROM emp;
--7. �����ȣ, ����̸��� ��ȸ�ϼ���.
--      ��, ����� �̸��տ�'Mr.'�� �ٿ����� ��µǰ� �ϼ���.
SELECT empno as �����ȣ, 'Mr.'||ename as ����̸� FROM emp;
--8. ����, �μ���ȣ�� ��ȸ�ϴµ� �ߺ������ʹ� �ѹ��� ��ȸ�ǰ� �ϼ���/
SELECT DISTINCT job, deptno FROM emp;
--9. ����̸�, ����, �Ի���, Ŀ�̼��� ��ȸ�ϼ���,
-- ��, Ŀ�̼��� ���� Ŀ�̼ǿ� 200�� ���� ����� ��ȸ�ϼ���
--  Ŀ�̼��� ���� ����� 300�� ��ȸ�ǰ� �ϼ���
SELECT empno as ����̸�, job as ����, hiredate as �Ի���, 
NVL(comm+200,+300) as Ŀ�̼� FROM emp;

--10. ����̸��� 'SMITH'�� ����� ����̸�, ����, �Ի����� ��ȸ�ϼ���
SELECT ename as ����̸�, job as ����, hiredate as �Ի��� 
FROM emp WHERE ename = 'SMITH';
--11. ������ MANAGER�� ����� �̸�, ����, �޿��� ��ȸ�ϼ���
SELECT ename as ����̸�, job as ����, sal as �޿� 
FROM emp WHERE job = 'MANAGER';
--12, �Ի����� 81�� 11�� 17���� ����� �̸� , ����, �Ի����� ��ȸ�ϼ���.
SELECT ename as ����̸� , job as ����, hiredate as �Ի��� FROM emp WHERE hiredate ='81/11/17';
--13. ������ MANAGER�̰ų� , SALESMAN �� ����� �̸�, ����, �μ���ȣ�� ����ϼ���
SELECT ename as ����̸�, job as ����, deptno as �μ���ȣ 
FROM emp WHERE  job = 'SALESMAN' OR job = 'MANAGER';
select * from emp;
--14. �޿��� 1000�̻� 3000�̸��� ����� �̸�, ����, �޿��� ��ȸ�ϼ���
SELECT ename as ����̸� , job as ���� , sal as �޿� FROM emp WHERE sal >1000 AND sal<3000;
--15. ������ MANAGER�̰� �޿��� 1000�̻��� ����� �̸�, ����, �޿�,�Ի����� ��ȸ�ϼ���
SELECT ename as ����̸�, job as ����, sal as �޿�, hiredate as �Ի��� FROM emp WHERE job = 'MANAGER' AND sal >1000;