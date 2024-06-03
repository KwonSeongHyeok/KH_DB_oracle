CREATE TABLE EMPLOYEE2 AS SELECT * FROM EMPLOYEE;

-- 1.
INSERT INTO EMPLOYEE2
VALUES('223', '김영수', '850101-1234567', 'kim_ys@or.kr', '01012345678', 'D1', 'J4', 'S2', 3500000, 0.1, '200', '15/06/20', '', 'N');

-- 2.
INSERT INTO DEPARTMENT2
VALUES('D10', '연구개발부', 'L6');
/*
컬럼의 최대 크기가 2BYTE로 영어나 숫자로 2글자까지만 가능하지만
3글자를 작성하려 했기 때문에 에러 발생
-> department2 테이블에서 "DEPT_ID" 에 해당하는 컬럼의 크기를
    2에서 3으로 늘려주거나
    VARCHAR2로 변경해서 255까지 늘려주는 방법이 존재 -> VARCHAR2 알아서 공간크기를 조정
    CHAR의 경우 공간 크기를 조정하지 못하기 때문에 처음부터 크기를 잘 선택
*/

-- 3.
INSERT INTO EMPLOYEE2
VALUES('224', '이수진', '900101-2345678', 'lee_sj@or.kr', '01098765432', 'D2', 'J2', 'S3',  3000000, 0.15, '201', '16/07/01', '', 'N');

-- 4.
INSERT INTO DEPARTMENT2
VALUES('D11', '품질관리부', 'L7');

-- 5.
INSERT INTO EMPLOYEE2
VALUES('225', '박민수', '750303-3456789', 'park_ms@or.kr', '01123456789', 'D3', 'J5', 'S1', 2800000, 0.05, '202', '17/08/15', '', 'N');

-- 6.
INSERT INTO DEPARTMENT2
VALUES('D12', '재무부', 'L8');

-- 7.
INSERT INTO EMPLOYEE2
VALUES('226', '최은지', '860404-4567890', 'choi_ej@or.kr', '01056789012', 'D4', 'J3', 'S4', 4200000, 0.2, '203', '18/09/25', '', 'N');

-- 8.
INSERT INTO DEPARTMENT2
VALUES('D13', '홍보부', 'L9');

-- 9.
INSERT INTO EMPLOYEE2
VALUES('227', '장영호', '950505-5678901', 'jang_yh@or.kr', '01067890123', 'D5', 'J1', 'S5', 5000000, 0.25, '204', '19/10/30', '', 'N');

-- 10.
INSERT INTO DEPARTMENT2
VALUES('D14', '전략기획부', 'L10');

-- 11.
INSERT INTO EMPLOYEE2
VALUES('228', '윤지혜', '760606-6789012', 'yoon_jh@or.kr', '01734567890', 'D6', 'J2', 'S2', 3200000, 0.1, '205', '20/11/05', '', 'N');

-- 12.
INSERT INTO DEPARTMENT2
VALUES('D15', '법무부', 'L11');

-- 14.
INSERT INTO DEPARTMENT2
VALUES('D16', '고객지원부', 'L12');

-- 16.
INSERT INTO DEPARTMENT2
VALUES('D17', '기술혁신부', 'L13');


-- 18.
INSERT INTO DEPARTMENT2
VALUES('D18', '경영지원부', 'L14');


-- 20.
INSERT INTO DEPARTMENT2
VALUES('D19', '정보기술부', 'L15');






-- UPDATE
-- 1. 
UPDATE EMPLOYEE
SET EMAIL = 'sun_di__updated@or.kr', PHONE = '01012345678'
WHERE EMP_ID = 200;

-- 2.
SELECT * FROM EMPLOYEE2
WHERE DEPT_CODE = 'D1';

UPDATE EMPLOYEE
SET SALARY = SALARY * 1.1, BONUS = BONUS + 0.05
WHERE DEPT_CODE = 'D1';

-- 3.









