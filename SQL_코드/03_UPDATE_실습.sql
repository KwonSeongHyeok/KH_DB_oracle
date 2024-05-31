/*** UPDATE 실습 ***/

-- D1 인사관리부 -> 인사팀으로변경
UPDATE DEPARTMENT2
SET DEPT_TITLE = '인사팀'
WHERE DEPT_ID = 'D1';

SELECT * FROM DEPARTMENT2
WHERE DEPT_ID = 'D1';

-- D3 마케팅부 -> 마케팅팀 변경
UPDATE DEPARTMENT2
SET DEPT_TITLE = '마케팅팀'
WHERE DEPT_ID = 'D3';

SELECT * FROM DEPARTMENT2
WHERE DEPT_ID = 'D3';

-- D8 기술지원부 -> 기술지원팀 변경
UPDATE DEPARTMENT2
SET DEPT_TITLE = '기술지원팀'
WHERE DEPT_ID = 'D8';

SELECT * FROM DEPARTMENT2
WHERE DEPT_ID = 'D8';

-- 수정된 내용을 저장하길 원한다면 COMMIT
-- 저장하지 않길 원한다면 ROLLBACK;
COMMIT;

-- EMPLOYEE2 테이블에서 BONUS를 받지 않은 사원의
-- BONUS를 0.1로 변경
UPDATE EMPLOYEE2
SET BONUS = 0.1
WHERE BONUS IS NULL;

-- 변경후 EMP_NAME, BONUS 모두 조회
SELECT EMP_NAME, BONUS FROM EMPLOYEE2;

ROLLBACK;

-- 모든 직원의 기본 급여 인상 EMPLOYEE2
UPDATE EMPLOYEE2
SET SALARY = SALARY+1000000;

SELECT EMP_NAME, SALARY
FROM EMPLOYEE2;

-- D9 부서의 모든 직원의 보너스율 0.4로 수정 EMPLOYEE2
UPDATE EMPLOYEE2
SET BONUS = 0.4
WHERE DEPT_CODE = 'D9';

SELECT DEPT_CODE, BONUS
FROM EMPLOYEE2;

-- DEPT_CODE가 NULL인 직원은 D3부서로 이동
UPDATE EMPLOYEE2
SET DEPT_CODE = 'D3'
WHERE DEPT_CODE IS NULL;

SELECT DEPT_CODE FROM EMPLOYEE2;
-- 특정 입사일 (2000-01-01) 이후 입사한 직원의 급여 수정
-- HRIE_DATE
UPDATE EMPLOYEE2
SET SALARY = SALARY*1.5
WHERE HIRE_DATE > TO_DATE('2000-01-01', 'YYYY-MM-DD');


-- 1997-09-12 에 입사한 직원 퇴사처리
-- ENT_YN
UPDATE EMPLOYEE2
SET ENT_YN = 'Y'
WHERE HIRE_DATE = TO_DATE('1997-09-12', 'YYYY-MM-DD');

ROLLBACK; -- UPDATE 모두 취소

SELECT EMP_NAME, EMAIL FROM EMPLOYEE2;

-- 특정 도메인 주소 변경
UPDATE EMPLOYEE2
SET EMAIL = REPLACE(EMAIL, 'or.kr', 'kh.kh');

SELECT EMP_NAME, EMAIL FROM EMPLOYEE2;

-- 핸드폰 번호 EMPLOYEE2 에서 010 뒤에 - 붙여서 변경
UPDATE EMPLOYEE2
SET PHONE = REPLACE(PHONE, '010', '010-');

SELECT * FROM EMPLOYEE2;

-- LIKE -> 무조건 맨 앞이 010 이어야 하고 중간에 오는 010 변경 x

UPDATE EMPLOYEE2
SET PHONE = REPLACE(PHONE, '010', '010-')
WHERE PHONE LIKE '010%';
/*
"EMPLOYEE2"."PHONE"(actual: 13, maximum:12)
--> 행 최대 크기 12자리로 설정해줬기 때문에 나중에 발생하는 에러
--> 행 최대 크기를 늘리거나 다시 돌아가기 rollback 설정
*/
ROLLBACK;
SELECT * FROM EMPLOYEE2;

-- 특정 입사일을 가진 직원의 입사일 변경
-- 1999-09-09 입사한 직원 -> 2000-01-02
UPDATE EMPLOYEE2
SET HIRE_DATE = TO_DATE('2000-01-02', 'YYYY_MM_DD')
WHERE HIRE_DATE = TO_DATE('1999-09-09', 'YYYY-MM-DD');

COMMIT;

SELECT * FROM DEPARTMENT2;

UPDATE DEPARTMENT2
SET DEPT_TITLE = '인사팀';

SELECT * FROM DEPARTMENT2;

ROLLBACK;


















