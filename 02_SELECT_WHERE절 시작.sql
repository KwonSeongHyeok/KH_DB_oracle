/*
SELECT WHERE 절
WHERE의 경우 조건을 걸어 선택한 조건에 해당하는 행만 볼 수 있도록 설정
WHERE 원하는 컬럼 = 원하는 컬럼에서 해당하는 조건;

만약 아무것도 없는 NULL 값을 조회하길 원한다면
WHERE 원하는 컬럼 IS NULL;

만약 NULL이 아닌 값만 조회하길 원한다면
WHERE 원하는 컬럼 IS NOT NULL;

~ 이상이거나 ~ 이하일때는 >= <= > < 사용(미만, 초과 포함)
WHERE 원하는 컬럼 >= 원하는 값;

사이 과 00 사이를 조회하길 원한다면 BETWEEN 00 AND 00 ;
예 WHERE BETWEEN 사당 AND 의정부;

-- WHERE 절 사용 X
ORDER BY
오름차순 ASC
내림차순 DESC

*/




-- 모든 직원 정보 조회
SELECT * FROM employee;

-- 모든 부서 정보 조회
SELECT * FROM department;

-- 모든 직업 정보 조회
SELECT * FROM JOB;

-- EMPLOYEE 테이블에서 이름, 입사일 조회
SELECT EMP_NAME, hire_date FROM employee;

/*
컬럼값 산술 연산
-- 컬럼값 : 행과 열이 교차되는 테이블 한 칸에 작성된 값

-- SELECT문 작성 시 컬러명에 산술 연산을 직접 작성하면
    조회결과(RESULT SET)에 연산 결과가 반영되어 조회된다.
*/

-- EMPLOYEE 테이블에서 모든 사원의 이름, 급여, 급여+100만 조회
-- 급여 우리회사 직원들의 급여를 100만원씩 + 하면 어떻게 될 것인가?
SELECT EMP_NAME, SALARY, SALARY+1000000 FROM employee;

-- 급여 + 100에 AS 사용해서 100만원 인상 추가
-- AS의 경우 큰 따옴표를 사용해서 표기
SELECT EMP_NAME, SALARY, SALARY+1000000  AS "급여_100만원_인상" FROM employee;

-- EMPLOYEE 테이블에서 모든 사원의 사번, 이름, 연봉(급여 * 12) 조회
SELECT EMP_ID, EMP_NAME, SALARY*12  AS "연봉" FROM employee;

-- EMPLOYEE 테이블에서 모든 사원의 사번, 이름, 상반기급여(급여*6) 조회
SELECT EMP_ID, EMP_NAME, SALARY*6  AS "상반기급여" FROM employee;

-- 특정 부서에서 속한 사원의 이름과 이메일 조회
-- 특정 부서 D9
SELECT DEPT_CODE, EMP_NAME, EMAIL
FROM employee
WHERE DEPT_CODE = 'D9';

-- 특정 부서 D1에서 속한 사원의 이름과 이메일 조회
SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE DEPT_CODE = 'D1';

-- 특정 부서 D4에서 속한 사원의 이름과 전화번호 이메일 조회
SELECT EMP_NAME, PHONE, EMAIL FROM EMPLOYEE WHERE DEPT_CODE = 'D4';

-- WHERE에서 조회한 조건에 부합하는 사람이 없으면 값이 나오지 않음 = 0
-- IS NULL을 사용하면 없는 사람을 조회할 수 있음
SELECT DEPT_CODE, EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE
WHERE DEPT_CODE is NULL;

-- dept_code 가  모두 is NULL인 사람의 모든 정보를 조회
SELECT * FROM EMPLOYEE WHERE DEPT_CODE is NULL;

-- 보너스가 없는 사원의 이름과 보너스를 조회
SELECT EMP_NAME, BONUS FROM employee WHERE BONUS is NULL;

-- 급여 등급이 S5인 사원의 이름과 급여 조회
SELECT EMP_NAME, SALARY FROM employee WHERE sal_level = 'S5';

-- 사원 번호가 210인 사원의 모든 정보 조회
SELECT * FROM EMPLOYEE WHERE EMP_ID = '210';

-- 이메일 주소가 null 이 아닌 사원의 이름과 이메일 조회
SELECT EMP_NAME, EMAIL FROM employee WHERE EMAIL IS NOT NULL;

-- 보너스가 0.2 이상인 사원의 이름과 보너스를 조회
SELECT EMP_NAME, BONUS FROM employee WHERE BONUS >= 0.2;

-- 급여가 3000000 에서 4000000 사이인 사원의 이름과 급여 조회
SELECT EMP_NAME, SALARY FROM employee WHERE SALARY BETWEEN 3000000 AND 4000000;

-- 급여가 높은 순서대로 사원의 이름과 급여 조회
-- 숫자체계 오름차순 1부터 시작
-- 숫자체계 내림차순 9부터 시작
SELECT EMP_NAME, SALARY FROM employee ORDER BY SALARY DESC;

-- 사원의 이름을 오름차순을 정렬해서 조회
-- 글자체계 오름차순 ㄱ부터 ㅎ까지 작성하기 A-Z
-- 글자체계 내림차순 ㅎ부터 ㄱ까지 작성하기 Z-A
SELECT EMP_NAME FROM EMPLOYEE ORDER BY EMP_NAME ASC;

-- EMPLOYEE 테이블에서 급여가 300만원을 초과하는 사원의 사번 이름 급여 부서코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE FROM EMPLOYEE WHERE SALARY > 3000000;

-- EMPLOYEE 테이블에서 연봉이 5000만원을 이하인 사원의 사번 이름 연봉 조회 연봉은 연봉으로 표기
SELECT EMP_ID, EMP_NAME, SALARY*12 AS "연봉" FROM EMPLOYEE WHERE SALARY*12 <= 50000000;

-- EMPLOYEE 테이블에서 부서코드가 'D9'가 아닌 사원들의 이름 부서코드 전화번호 조회
SELECT EMP_NAME, DEPT_CODE, PHONE FROM EMPLOYEE WHERE DEPT_CODE != 'D9';

-- EMPLOYEE 테이블에서 부서코드가 'D6'사원 중 급여가 300만원을 초과하는 사원의 이름 부서코드 급여 조회
SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE = 'D6'  AND SALARY > 3000000;

-- 부서코드가 D6이고 직급코드가 J3인 사원의 이름과 급여
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE DEPT_CODE = 'D6' AND JOB_CODE ='J3';

-- 날짜 범위 비교
-- EMPLOYEE 테이블에서 입사일이 2000-01-01부터 2000-12-31 사이인
-- 사원의 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE AS "입사일" FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN TO_DATE('2000-01-01', 'YYYY-MM-DD')
AND
TO_DATE('2000-12-31', 'YYYY-MM-DD');

-- 입사일이 2000년 이후 입사한 사원의 이름과 입사일 조회
SELECT EMP_NAME, HIRE_DATE AS "입사일" FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('2000-01-01', 'YYYY-MM-DD');



-- 이메일의 아이디 글자 수가 5글자인 사원의 이름 이메일 조회 5글자@
SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '_____@%';

-- 이메일의 아이디 중 _앞 쪾의 글자수가 3글자인 사원의 이름 이메일 조회
SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '___%';

-- ESCAPE 옵션 : LIKE 의미를 벗어나 단순 문자열로 인식
--> 적용범위 : 특수문자 뒤 한 글자

SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '___#_%' ESCAPE '#';
/*
___ 세글자 의미 

ESCAPE '#' 구분을 지을 것이다.
___LIKE 사용하는 3글자만 찾으라는 의미로 구분짓는 것
_% -> -로된 글자 찾기

___#_%   ___@%
_를 @처럼 사용하길 원했기 때문에 중간 #을 넣어준 것

__#_%   __돈%
_를 돈처럼 사용하길 원했기 때문에 중간 #을 넣어준 것

*/

-- EMPLOYEE  테이블

-- 1. EMP_NAME을 "이름", SALARY를 "급여"로 표시하여 선택
SELECT EMP_NAME AS "이름", SALARY AS "급여" FROM EMPLOYEE;

--2. DEPT_CODE를 "부서코드", JOB_CODE를 "직무코드"로 표시하여 선택
SELECT DEPT_CODE AS "부서코드", JOB_CODE AS "직무코드" FROM EMPLOYEE;

-- 3. EMAIL을 "이메일", PHONE를 "전화번호"로 표시하여 선택
SELECT EMAIL AS "이메일", PHONE AS "전화번호" FROM EMPLOYEE;

--4. EMP_ID을 "사원ID", HIRE_DATE를 "입사일"로 표시하여 선택
SELECT EMP_ID AS "사원ID", HIRE_DATE AS "입사일" FROM EMPLOYEE;

--5. EMP_NAME, DEPT_CODE, SALARY를 각각 "이름", "부서", "급여"로 표시하여 선택
SELECT EMP_NAME AS "이름", DEPT_CODE AS "부서", SALARY AS "급여" FROM EMPLOYEE;

--6. 중복되지 않은 DEPT_CODE를 선택
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

--7. 중복되지 않은 JOB_CODE를 선택
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

--8. 중복되지 않은 SAL_LEVEL을 선택
SELECT DISTINCT SAL_LEVEL FROM EMPLOYEE;

--9. 중복되지 않은 MANAGER_ID를 선택
SELECT DISTINCT MANAGER_ID FROM EMPLOYEE;

--10. 중복되지 않은 EMP_NAME을 선택
SELECT DISTINCT EMP_NAME FROM EMPLOYEE;


-- OR

-- DEPT_CODE가 D5이거나 SALARY가 2000000 보다 큰 사원의 이름과 급여 선택
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE DEPT_CODE = 'D5' OR SALARY > 2000000;


-- DEPT_CODE가 D6이거나 JOB_CODE가 J3인 사원의 이름과 급여를 선택
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE DEPT_CODE = 'D6' OR JOB_CODE = 'J3';

-- SAL_LEVEL이 S5 이거나 BONUS가 0.2인 사원의 이름과 급여수준 선택
SELECT EMP_NAME, SAL_LEVEL FROM EMPLOYEE WHERE SAL_LEVEL = 'S5' OR BONUS = '0.2';

-- ENT_YN이 N이거나 HIRE_DATE가 2000년 이후인 사원의 이름과 입사일 선택
SELECT EMP_NAME, HIRE_DATE FROM EMPLOYEE
WHERE ENT_YN = 'N' OR HIRE_DATE > TO_DATE('2000-01-01', 'YYYY-MM-DD')
ORDER BY HIRE_DATE ASC ;









