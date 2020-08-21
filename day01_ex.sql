--1. emp 테이블에 있는 사원이름과 부서번호를 조회하세요
SELECT ename , dept FROM emp;
--2. emp테이블에 있는 부서번호를 조회하세요
--    단, 중복된 부서는 한번만 조회되게 하세요
SELECT DISTINCT dept FROM emp;
--3. emp 테이블에 있는 사원이름과 연봉(급여*12)를 조회하세요
--  단, 출력은 별칭으로 출력되게 하세요
SELECT ename as 사원이름, (sal*12) as 연봉 FROM emp;
--4. 사원이름, 직급 그리고 연수입(연봉+커미션)을 조회하세요
--      커미션이 없는 사원은 커미션을 0으로 해서 계산하세요
SELECT ename as 사원이름, (sal + NVL(comm,0) ) as 연수입 FROM emp;
--5. 사원의 이름,직급, 입사일을 조회하세요.
-- 단 출력은 별칭으로
SELECT ename as 사원이름, job as 직급, hiredate as 입사일 FROM emp;
--6. 사원이름, 직급, 급여를 조회하세요.
        --단, 급여는 현재 급여의 10% 인상된 급여로 조회하세요.
SELECT ename as 사원이름, job as 직급 , sal+(sal/10) as 급여 FROM emp;
--7. 사원번호, 사원이름을 조회하세요.
--      단, 사원은 이름앞에'Mr.'이 붙여져서 출력되게 하세요.
SELECT empno as 사원번호, 'Mr.'||ename as 사원이름 FROM emp;
--8. 직급, 부서번호를 조회하는데 중복데이터는 한번만 조회되게 하세요/
SELECT DISTINCT job, deptno FROM emp;
--9. 사원이름, 직급, 입사일, 커미션을 조회하세요,
-- 단, 커미션은 현재 커미션에 200을 더한 결과를 조회하세요
--  커미션이 없는 사원은 300이 조회되게 하세요
SELECT empno as 사원이름, job as 직급, hiredate as 입사일, 
NVL(comm+200,+300) as 커미션 FROM emp;

--10. 사원이름이 'SMITH'인 사원의 사원이름, 직급, 입사일을 조회하세요
SELECT ename as 사원이름, job as 직급, hiredate as 입사일 
FROM emp WHERE ename = 'SMITH';
--11. 직급이 MANAGER인 사원의 이름, 직급, 급여를 조회하세요
SELECT ename as 사원이름, job as 직급, sal as 급여 
FROM emp WHERE job = 'MANAGER';
--12, 입사일이 81년 11월 17일인 사원의 이름 , 직급, 입사일을 조회하세요.
SELECT ename as 사원이름 , job as 직급, hiredate as 입사일 FROM emp WHERE hiredate ='81/11/17';
--13. 직급이 MANAGER이거나 , SALESMAN 인 사원의 이름, 직급, 부서번호를 출력하세요
SELECT ename as 사원이름, job as 직급, deptno as 부서번호 
FROM emp WHERE  job = 'SALESMAN' OR job = 'MANAGER';
select * from emp;
--14. 급여가 1000이상 3000미만의 사원의 이름, 직급, 급여를 조회하세요
SELECT ename as 사원이름 , job as 직급 , sal as 급여 FROM emp WHERE sal >1000 AND sal<3000;
--15. 직급이 MANAGER이고 급여가 1000이상인 사원의 이름, 직급, 급여,입사일을 조회하세요
SELECT ename as 사원이름, job as 직급, sal as 급여, hiredate as 입사일 FROM emp WHERE job = 'MANAGER' AND sal >1000;