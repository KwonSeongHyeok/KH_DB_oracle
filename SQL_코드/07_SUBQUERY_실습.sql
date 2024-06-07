/***** SUBQUERY 실습 *****/
-- 1. 각 직원의 급여가 부서 평균 급여보다 높은 직원들의 이름과 급여 조회하기
-- 1) 부서 평균급여 구하기
SELECT AVG(SALARY)
FROM EMPLOYEE e
WHERE DEPT_CODE = e.DEPT_CODE; -- 의미가 없는 코드, 없어도 됨

-- 2) 직원들의 이름과 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 3089820;

-- 3) 서브쿼리 이용해서 한 번에 쿼리 작성하기
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                         FROM EMPLOYEE e
                         WHERE DEPT_CODE = e.DEPT_CODE);

-- 1. 각 직원의 급여가 부서 평균 급여보다 높은 직원들의 이름과 급여 조회하기
SELECT EMP_NAME, SALARY,DEPT_CODE
FROM EMPLOYEE E1
WHERE E1.SALARY >= (SELECT AVG (SALARY)
                                FROM EMPLOYEE E2
                                WHERE E2.DEPT_CODE = E1.DEPT_CODE
                                GROUP BY DEPT_CODE);


-- 2. 최대 급여를 받는 직원의 이름과 급여 조회하기
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);

-- 3. D5 부서의 평균 급여보다 높은 급여를 받는 직원들의 이름 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5');

SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5';

-- 4. 급여가 300만원 이상인 직원 중에서 가장 낮은 급여를 받는 직원의 이름과 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE WHERE SALARY > 3000000);
--> 서브 쿼리를 통해서 특정 조건을 만족하는 최저 급여를 찾고
----> 조건에 맞는 급여를 받는 직원을 외부 쿼리에서 조회

/*
서브쿼리
SELECT MIN(SALARY) --> 컬럼 최솟값 선택
FROM EMPLOYEE      --> 찾을 데이터 테이블 선택
WHERE SALARY > 3000000 --> 급여가 300만원 이상인 행들만 최소값을 계산

외부쿼리 = 메인쿼리
SELECT EMP_NAME, SALARY --> 최종으로 눈으로 볼 컬럼 선택
FROM EMPLOYEE  --> 테이블 섡택
WHERE SALARY = (서브쿼리); --> 급여가 서브쿼리에서 반환된 최소 급여와 같은 행들만 가져오는 것
*/



/* SELECT를 활용한 서브쿼리 실습 */
-- 1. 부서별로 보너스 율이 0.2 이상인 직원 수 조회
SELECT DEPT_TITLE,
            (SELECT COUNT(*) FROM EMPLOYEE E
            WHERE E.DEPT_CODE = D.DEPT_ID
            AND E.BONUS >= 0.2) AS "BONUS COUNT"
FROM DEPARTMENT D;


-- 2. 부서별로 최고 급여와 최저 급여를 조회
SELECT DEPT_TITLE,
            /*최고 급여 서브쿼리*/
            (SELECT MAX(SALARY) FROM EMPLOYEE E WHERE E.DEPT_CODE = D.DEPT_ID) AS "최고급여",
            /*최고 급여 서브쿼리*/
            (SELECT MIN(SALARY) FROM EMPLOYEE E WHERE E.DEPT_CODE = D.DEPT_ID) AS "최저급여"
FROM DEPARTMENT D;


-- 1. 부서별 직원수 조회 SELECT
-- 외부 쿼리 DEPT_CODE
SELECT DEPT_TITLE,
         (SELECT COUNT(*) FROM EMPLOYEE E WHERE E.DEPT_CODE = D.DEPT_ID) AS "직원수"
FROM DEPARTMENT D;

-- 2. 부서별로 직원수가 5명 이상인 부서의 부서명과 직원수 조회
---- SELECT 서브쿼리
---- WHERE 서브쿼리
---- 회부

SELECT DEPT_TITLE,
        (SELECT COUNT(*) FROM EMPLOYEE E WHERE E.DEPT_CODE = D.DEPT_ID) AS "직원수"
FROM DEPARTMENT D
WHERE (SELECT COUNT(*) FROM EMPLOYEE E WHERE E.DEPT_CODE = D.DEPT_ID) >= 5;


-- 6. 부서별 입사일이 가장 빠른 사원의
-- 사번, 이름, 부서명(NULL이면 '소속없음'), 직급명, 입사일을 조회하고
-- 입사일이 빠른 순으로 조회하시오
-- 단, 퇴사한 직원은 제외하고 조회..

SELECT DEPT_CODE, MIN(HIRE_DATE) FROM EMPLOYEE GROUP BY DEPT_CODE;


SELECT EMP_NO, EMP_NAME, NVL(DEPT_TITLE, '소속없음') "부서명" ,E.HIRE_DATE "입사일", JOB_NAME "직급명"
FROM EMPLOYEE E , (
SELECT DEPT_CODE,MIN(HIRE_DATE)AS HIRE_DATE
FROM EMPLOYEE
GROUP BY DEPT_CODE
) E2, DEPARTMENT D, JOB J
WHERE e.hire_date = E2.hire_date
AND D.DEPT_ID = E.DEPT_CODE
AND E.JOB_CODE = J.JOB_CODE
ORDER BY 입사일;

SELECT DISTINCT EMP_NO, EMP_NAME, NVL2(E.DEPT_CODE,D.DEPT_TITLE,'소속없음') "부서명" ,E.HIRE_DATE "입사일", JOB_NAME "직급명"
FROM EMPLOYEE E , (
SELECT DEPT_CODE,MIN(HIRE_DATE)AS HIRE_DATE
FROM EMPLOYEE
GROUP BY DEPT_CODE
) E2, DEPARTMENT D, JOB J
WHERE e.hire_date = E2.hire_date
AND (D.DEPT_ID = E.DEPT_CODE OR E.DEPT_CODE IS NULL)
AND E.JOB_CODE = J.JOB_CODE;


















