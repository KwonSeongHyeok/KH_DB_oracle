/*
함수
컬럼값이나 지정된 값을 읽어 연산한 결과를 반환하는 것

단일 행 함수 : N개의 행의 컬럼 값을 전달하여 N개의 결과가 반환

그룹 함수 : N개의 행의 컬럼 값을 전달하여 1개의 결과가 반환
               (그룹의 수가 늘어나면 그룹의 수만큼 결과를 반환)
               
함수는 SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절에서 사용 가능

SELECT절 : 찾는 기준이 아닌, 눈으로 표기되는 총합, 계산 결과 등에 대한 것을 눈으로  봤을 때
              정리해놓은 컬럼
              -> 정리해서 보여주자!

WHERE절 : 찾는 조건이 되는 행을 작성해줌
              길이, 크기, 결과가 조건에 부합하는 결과만 볼 수 있도록 설정
              -> 내가 원하는 조건만 보여줘!
              
*/

/************* 단일행 함수 ****************/

-- 문자열 관련 함수

-- LENGTH (문자열 | 컬럼명) : 문자열의 길이 반환
SELECT 'HELLO WORLD', LENGTH('HELLO WORLD')
FROM DUAL;


-- EMPLOYEE 테이블에서
-- 사원명, 이메일 , 이메일 길이 조회
-- 이메일 길이 오름차순 조회

SELECT EMP_NAME, EMAIL, LENGTH(EMAIL) AS "이메일 길이"
FROM EMPLOYEE
WHERE LENGTH(EMAIL) <=12
ORDER BY "이메일 길이" ASC;


-- INSTR(문자열 | 컬럼명, '찾을 문자열' [, 찾는 것을 시작할 위치 [, 순번] ] )

-- 찾을 시작 위치부터 지정된 순번째 찾은 문자열의 시작 위치를 반환

-- LIKE와 INSTR 차이점
-- LIKE같은 경우 @ 들어갔는지 검색
-- INSTR @ 몇번째에 있습니까?

-- 문자열에서 맨 앞에 있는 'B'의 위치를 조회
SELECT 'AAB AAC AA BB AA', INSTR('AAB AAC AA BB AA', 'B')
FROM DUAL; -- DUAL 존재하지 않는 테이블로 어떤 값을 테스트할 때 사용
-- ↑B가 처음부터 쭉 글자를 봤을 때 몇 번째에 위치해 있는가? 처음 B가 나타나는 위치는?

-- 문자열에서 5번째 부터 검색해서 처음 찾은 'B'의 위치 조회
SELECT 'AAB AAC AA BB AA', INSTR('AAB AAC AA BB AA', 'B' ,5)
FROM DUAL;
-- AAB A 5번째부터 B를 찾기 시작
-- AAB AAC AA B12번째 자리에서 B가 처음 나타났기 때문에 B는 12번째 자리에 위치한다 표시된 것

-- 문자열에서 5번 부터 검색 시작해서 2번째로 찾은 'B'의 위치 조회
SELECT 'AAB AAC AA BB AA', INSTR('AAB AAC AA BB AA', 'B' ,5, 2)
FROM DUAL;
-- AAB A 5번째부터 B를 찾기 시작
-- AAB AAC AA BB 13번째 자리에서 B가 두번째로 나타났기 때문에 B는 13번째 자리에 위치한다 표시된 것


-- SUBSTR(문자열 | 컬러명, 시작위치 [,길이])
-- 문자열을 시작 위치부터 지정된 길이만큼 잘라내서 반환
-- 길이를 작성하지 않은 경우 시작 위치부터 끝까지 잘라내서 반환

-- 시작 위치, 자를 길이 지정
SELECT SUBSTR('ABCDE', 2, 3)
FROM DUAL;
--> 2번째 자리에 존재하는 B부터 시작해서
---> 총 3가지를 가지고 오겠다
----> B C D를 가지고 오는 것


-- 시작위치만 지정 하고 자를 길이는 미지정
SELECT SUBSTR('ABCDE', 4)
FROM DUAL;
--> ABCDE 에서 4번째 자리에 위치한 D부터 시작해서
---> 마지막까지 모두 가지고 오겠다는 것
----> D 다음에 있는 E까지 모두 가지고 온 것
-----> DE


-- EMPLOYEE 테이블에서
-- 사원명, 이메일 아이디에서 @ 앞에 있는 아이디만
-- 가지고 오고
-- 이메일 아이디를 오름차순 조회
-- -> 외우기 손으로 작성할 때 한글자도 틀리지 않고 작성
SELECT EMP_NAME, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1) AS "이메일 아이디"
FROM EMPLOYEE
ORDER BY "이메일 아이디" ASC;


-- INSTR(EMAIL, '@') 이메일 주소에서 @ 위치를 찾음
-- 찾은 다음에 @ 가 표시되면 안되기 때문에 -1 설정을 해서 @ 제거

SELECT EMP_NAME, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')) AS "이메일 아이디"
FROM EMPLOYEE
ORDER BY "이메일 아이디" ASC;


-- SUBSTR(EMAIL, 1) 을 작성하게 되면 나타나는 결과
SELECT EMP_NAME, SUBSTR(EMAIL, 1) AS "이메일 아이디"
FROM EMPLOYEE
ORDER BY "이메일 아이디" ASC;


-- 앞에서 부터 값을 가지고 올 때는 +를 작성해주지만
-- 뒤에서 부터 값을 가지고 오길 원할 때는 -를 작성
SELECT EMP_ID, PHONE, SUBSTR(PHONE, -4) AS "마지막_네자리" FROM EMPLOYEE;



/********** 그룹 관련 함수 **********/

-- COUNT 행의 총 갯수를 셀 때 사용하는 함수

/*
COUNT 사용 방법
COUNT(*) : 조회된 모든 행의 개수 반환
                -> 이름, 주소 와 같은 항목이 몇개 있는가?
COUNT(컬럼명) : 지정된 컬럼 값이 NULL이 아닌 행의 개수 반환
                      (NULL은 제외하고 개수를 작성하겠다는 의미)
                      -> 00개 조회되었습니다. 검색한 내역 총 몇개인가?
COUNT(DISTINCT 컬럼명) : 지정된 컬럼에서 중복값을 제외한 행의 개수 반환
*/

-- EMPLOYEE 테이블 전채 행의 개수
SELECT COUNT(*) FROM EMPLOYEE;

-- 전화번호가 있는 사원의 수
SELECT COUNT(*) FROM EMPLOYEE WHERE PHONE IS NOT NULL;

-- 좀더 가벼게 WHERE을 사용하지 않고
-- 전화번호가 있는 사원의 수
SELECT COUNT(PHONE) FROM EMPLOYEE;


/*** COUNT 실습 ***/
-- 1. 전체 직원 수 조회
--> AS 총 직원 수
SELECT COUNT(*) AS "총 직원 수" FROM EMPLOYEE;

-- 2. WHERE 사용해서 D9 부서 직원 수 조회
--> D9 부서 직원 수
SELECT COUNT(*) AS "D9 부서 직원 수" FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3. WHERE 활용해서 보너스 받은 직원 수
--> 보너스 받은 직원들
SELECT COUNT(*) AS "보너스 받은 직원들" FROM EMPLOYEE
WHERE BONUS IS NOT NULL;




-- AVG 평균
-- 모든 사원의 평균 급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- CEIL     올림
SELECT CEIL(AVG(SALARY))
FROM EMPLOYEE;

-- FLOOR    내림
SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE;

-- ROUND    반올림
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;


/********* AVG 평균 구하기 실습 **********/

-- 1. 전체 직원 평균 급여 조회
--> AS 평균급여
SELECT AVG(SALARY) AS "평균급여" FROM EMPLOYEE;

-- 2. 부서별 평균 급여 조회
--> AS 부서, AS 평균급여
SELECT  DEPT_CODE AS "부서", AVG(SALARY) AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;
/*
SELECT DEPT_CODE AS "부서", AVG(SALARY) AS "평균급여"
사용하려면 추후 GROUP BY 를 사용해야함
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
183행, 8열에서 오류 발생

*/

-- 3. D5 부서의 평균 급여 조회
--> AS D5부서 평균 급여
SELECT AVG(SALARY) AS "D5부서 평균 급여"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';













