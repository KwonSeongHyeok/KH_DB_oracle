-- 1번
-- 학생이름과 주소지를 조회하시오
-- 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 정렬
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS "주소지"
FROM TB_STUDENT
ORDER BY 1;

-- 2번
-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서 조회하시오.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY SUBSTR(student_ssn,1,6) DESC, STUDENT_NAME;

-- 3번
-- 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 
-- 이름과 학번, 주소를 이름 오름차순으로 조회하시오.
-- 단, 출력헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.
SELECT STUDENT_NAME AS "학생이름", STUDENT_NO AS "학번", STUDENT_ADDRESS AS "주소지"
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_ADDRESS,1,3) IN ('경기도', '강원도')
AND entrance_date < TO_DATE('2000-01-01', 'YYYY-MM-DD');

-- 4번
-- 현재 법학과 교수의 이름, 주민등록 번호를 나이가 많은 순서부터 조회하시오.
-- ANSI
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR p
JOIN TB_DEPARTMENT d ON (p.DEPARTMENT_NO = d.DEPARTMENT_NO)
WHERE d.DEPARTMENT_NAME = '법학과'
ORDER BY 2 ASC;

-- ORACLE
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR p, TB_DEPARTMENT d
WHERE p.DEPARTMENT_NO = d.DEPARTMENT_NO AND d.DEPARTMENT_NAME = '법학과'
ORDER BY 2 ASC;

-- 5번
-- 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다. 
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 조회하시오.
-- (참고) 소수점 아래 2자리까지 0으로 표현 : TO_CHAR(NUMBER, 'FM9.00')
-- (FM : 조회 결과 양쪽 공백 제거)
SELECT TO_CHAR(POINT, 'FM9.00') AS "학점", STUDENT_NO AS "학번"
FROM TB_GRADE
WHERE SUBSTR(TERM_NO,1,6) = '200402' AND CLASS_NO = 'C3118100'
ORDER BY 1 DESC, 2 DESC;


-- 6번
-- 학생 번호, 학생 이름, 학과 이름을 학생 이름 오름차순으로 조회하시오.

-- ANSI
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM tb_student s
JOIN tb_department d ON (d.DEPARTMENT_NO = s.DEPARTMENT_NO)
ORDER BY 2;

-- ORACLE
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME 
FROM TB_STUDENT s, tb_department d
WHERE d.DEPARTMENT_NO = s.DEPARTMENT_NO
ORDER BY 2;

-- 7번
-- 춘 기술대학교의 과목 이름, 해당 과목을 수업하는 학과 이름을 조회하시오.

-- ANSI
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS c
JOIN TB_DEPARTMENT d ON (c.DEPARTMENT_NO = d.DEPARTMENT_NO);
-- ORACLE
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS c, TB_DEPARTMENT d
WHERE c.DEPARTMENT_NO = d.DEPARTMENT_NO;

-- 8번
-- 과목, 해당 과목 교수 이름을 조회하시오.
-- TB_CLASS_PROFESSOR : 과목별 교수의 정보를 저장한 테이블(과목 코드, 학과 코드)

-- ANSI
-- TB_CLASS와  TB_PROFESSOR 테이블이 공통으로
-- DEPARTMENT_NO 컬럼을 가지고 있다 해서 이를 이용해서 JOIN을 하면 안됨!
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS c
JOIN TB_CLASS_PROFESSOR cp ON (c.CLASS_NO = cp.CLASS_NO)
JOIN TB_PROFESSOR p ON (cp.PROFESSOR_NO = p.PROFESSOR_NO);

-- ORACLE
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS c, TB_CLASS_PROFESSOR cp, TB_PROFESSOR p
WHERE c.CLASS_NO = cp.CLASS_NO AND cp.PROFESSOR_NO = p.PROFESSOR_NO;


-- 9번
-- 8번의 결과 중 '인문 사회' 계열에 속한 과목명, 교수이름을 과목명 오름차순으로 조회하시오.

-- ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS c
JOIN TB_CLASS_PROFESSOR cp ON (c.CLASS_NO = cp.CLASS_NO)
JOIN TB_PROFESSOR p ON (cp.PROFESSOR_NO = p.PROFESSOR_NO)
JOIN TB_DEPARTMENT d ON (c.DEPARTMENT_NO = d.DEPARTMENT_NO)
WHERE d.CATEGORY = '인문사회'
ORDER BY 1;

-- ORACLE
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS c, TB_CLASS_PROFESSOR cp, TB_PROFESSOR p, TB_DEPARTMENT d
WHERE c.CLASS_NO = cp.CLASS_NO
AND cp.PROFESSOR_NO = p.PROFESSOR_NO
AND c.DEPARTMENT_NO = d.DEPARTMENT_NO
AND d.CATEGORY = '인문사회'
ORDER BY 1;
                        
-- 10번
-- 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 조회하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)

-- ANSI
SELECT s.STUDENT_NO AS "학번", STUDENT_NAME AS "학생 이름", AVG(POINT) AS "전체 평점"
FROM TB_STUDENT s
JOIN TB_GRADE g ON (s.STUDENT_NO = g.STUDENT_NO)
JOIN TB_DEPARTMENT d ON(s.DEPARTMENT_NO = d.DEPARTMENT_NO)
WHERE d.DEPARTMENT_NAME LIKE '%음악%'
GROUP BY s.STUDENT_NO, STUDENT_NAME;
-- ORACLE
SELECT s.STUDENT_NO AS "학번", STUDENT_NAME AS "학생 이름", AVG(POINT) AS "전체 평점"
FROM TB_STUDENT s, TB_GRADE g ,TB_DEPARTMENT d
WHERE s.STUDENT_NO = g.STUDENT_NO
AND s.DEPARTMENT_NO = d.DEPARTMENT_NO
AND d.DEPARTMENT_NAME LIKE '%음악%'
GROUP BY s.STUDENT_NO, STUDENT_NAME;

-- 11번
-- 학번이 A313047인 학생의 학과이름, 학생이름, 지도교수 이름을 조회하시오.

-- ANSI
-- ORACLE


-- 12번
-- 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아 
-- 학생이름과 수강학기를 조회하는 SQL을 작성하시오.

-- ANSI
-- ORACLE


-- 13번
-- 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아 
-- 과목 이름, 학과 이름을 조회하시오.

-- ANSI
SELECT class_name, department_name
FROM tb_class c
JOIN tb_department d ON (c.department_no = d.department_no)
WHERE d.category = '예체능';

-- ORACLE

-- 14번
-- 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 
-- 학생이름, 지도교수이름 학번이 높은 순서로 조회하는 SQL을 작성하시오.
-- 단, 지도교수가 없을 경우 "지도교수 미지정"으로 표시

-- ANSI
-- ORACLE


-- 15번
-- 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 
-- 학생의 학번, 이름, 학과, 이름, 평점을 조회하시오.

-- ANSI
-- ORACLE



-- 16번
-- 환경조경학과 전공과목들의 과목 별 평점을 조회하시오.
-- (평점은 TRUNC를 이용해 소수점 아래 둘째 자리까지 표시)
-- ANSI

-- ORACLE


-- 17번
-- 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 조회하시오.
       
  
-- 18번
-- 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 조회하시오


-- 19번
-- 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 
-- 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL문을 작성하시오
-- 단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 
-- 평점은 소수점 첫째자리까지만 반올림하여 표시

-- ANSI
-- ORACLE
