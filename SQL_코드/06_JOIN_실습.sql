SELECT e.EMP_NAME, e.SALARY, s.SAL_LEVEL
FROM EMPLOYEE e, SAL_GRADE s
WHERE s.SAL_LEVEL IN ('S4', 'S5', 'S6') AND e.SAL_LEVEL = s.SAL_LEVEL;
/*****  JOIN 실습 *****/

-- 1. EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서
-- 각 직원의 이름과 그 직원이 속한 부서명 조회
-- ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ORACLE
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- 2. EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서
-- 각 직원의 이름과 그 직원이 속한 부서명, 급여 조회
-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ORACLE
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;


-- 3. EMPLOYEE 테이블과 SAL_GRADE 테이블을 조인해서
-- 각 직원의 이름과 급여 등급 조회
-- ANSI
SELECT EMP_NAME, SAL_GRADE.SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (EMPLOYEE.SAL_LEVEL = SAL_GRADE.SAL_LEVEL);
/*
다른 테이블에서 컬럼명은 다르지만 서로 의미하는 바가 같은 컬럼끼리는
컬럼명1 = 컬럼명A 사용할 수 있음

다른 테이블에서 컬럼명이 같을 때는 참조하는 테이블이 무엇인지 작성해줘야함
테이블명.컬러명1 = 테이블명.컬럼명2
SELECT로 참조할 때도 테이블명 작성해서 어디서 어느컬럼을 가지고 오는지 작성

테이블명도 별칭 가능(AS안쓰고, 소문자로 사용)
*/

-- ORACLE
SELECT EMP_NAME, s.SAL_LEVEL
FROM EMPLOYEE e, SAL_GRADE s
WHERE e.SAL_LEVEL = s.SAL_LEVEL;


-- 각 직원의 이름과 그 직원이 속한 부서의 부서명 및 직급 조회
-- 테이블 EMPLOYEE, DEPARTMENT, JOB

-- ANSI
SELECT e.EMP_NAME, d.DEPT_TITLE, j.JOB_NAME
FROM EMPLOYEE e
JOIN DEPARTMENT d ON (e.DEPT_CODE = d.DEPT_ID)
JOIN JOB j ON (e.JOB_CODE = j.JOB_CODE);
/*
e.DEPT_CODE = d.DEPT_ID
e.JOB_CODE = j.JOB_CODE

EMPLOYEE      DEPARTMENT    JOB
EMP_NAME    DEPT_TITLE      JOB_NAME
전지연	        인사관리부	      대리
차태연	        인사관리부	      대리
방명수	        인사관리부	      사원
*/
-- ORACLE
SELECT e.EMP_NAME, d.DEPT_TITLE, j.JOB_NAME
FROM EMPLOYEE e,  DEPARTMENT d, JOB j
WHERE e.DEPT_CODE = d.DEPT_ID AND e.JOB_CODE = j.JOB_CODE;


-- 1. 직원의 이메일 주소화 해당 부서의 부서명 조회
-- TABLE : EMPLOYEE DEPARTMENT
-- SELECT EMAIL DEPT_TITLE
SELECT EMP_NAME, e.EMAIL, d.DEPT_TITLE
FROM EMPLOYEE e, DEPARTMENT d
WHERE e.DEPT_CODE = d.DEPT_ID;

-- 2. 급여가 300만원 이상인 직원들의 이름과 그 직원이 속한 부서명 조회
-- TABLE : EMPLOYEE DEPARTMENT
-- SELECT EMP_NAME, DEPT_TITLE
-- WHERE
SELECT e.EMP_NAME, d.DEPT_TITLE
FROM employee e, department d
WHERE e.salary >= 3000000 AND e.dept_code = d.dept_id;

-- 3. 각 직원의 이름과 그 직원이 속한 부서명의 부서명, 급여 등급명 조회
-- TABLE : EMPLOYEE DEPARTMENT SAL_GRADE
-- SELECT EMP_NAME, DEPT_TITLE, SAL_LEVEL
SELECT e.EMP_NAME, d.DEPT_TITLE, s.SAL_LEVEL
FROM employee e, department d, sal_grade s
WHERE e.dept_code= d.dept_id AND e.sal_level = s.sal_level;


-- 4. 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번 이름 직급명 부서명 근무지역명 급여를 조회
-- TABLE : EMPLOYEE JOB DEPARTMENT, LOCATION
SELECT  e.EMP_ID,  e.EMP_NAME, j.JOB_NAME, d.DEPT_TITLE, l.LOCAL_NAME, e.SALARY
FROM employee e, department d, job j, location l
WHERE e.dept_code = d.dept_id AND e.job_code = j.job_code AND d.location_id = l.local_code
AND l.local_name LIKE 'ASIA%' AND j.job_name = '대리';


-- 1. D5 부서에 속한 직원들의 이름과 직급명 조회
SELECT e.EMP_NAME, j.JOB_NAME
FROM EMPLOYEE e, JOB j
WHERE e.DEPT_CODE = 'D5' AND e.JOB_CODE = j.JOB_CODE;

-- 2. 각 부서의 부서명과 해당 부서에 속한 직원의 평균급여 조회
SELECT d.DEPT_TITLE, FLOOR(AVG(e.SALARY)), d.DEPT_ID
FROM EMPLOYEE e, DEPARTMENT d
WHERE e.DEPT_CODE = d.DEPT_ID
GROUP BY d.DEPT_TITLE, d.DEPT_ID;
--> 평균에서 정수로 변경하길 원한다면 CEIL ROUND FLOOR

-- 3. 급여 등급이 S4 이상인 직원의 이름, 급여, 급여 등급 조회
SELECT * FROM SAL_GRADE;
SELECT e.EMP_NAME, e.SALARY, s.SAL_LEVEL
FROM EMPLOYEE e, SAL_GRADE s
WHERE s.SAL_LEVEL IN ('S4', 'S5', 'S6') AND e.SAL_LEVEL = s.SAL_LEVEL;






-- 매니저 찾기
SELECT E1.EMP_ID, E1.EMP_NAME, E2.EMP_NAME "부하직원"
FROM EMPLOYEE E1
JOIN EMPLOYEE E2 ON (E1.EMP_ID = E2.MANAGER_ID);