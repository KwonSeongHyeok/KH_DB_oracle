-- DDL(Data Definition Language)
-- 데이터 정의 언어로 객체를 만들고(create) 수정하고(alter) 삭제(drop) 구문

-- ALTER(바꾸다, 수정하다)
-- 수정가능한 것 컬럼(추가/수정/삭제) 제약조건(추가/삭제) 이름변경(테이블, 컬럼, 제약조건)

--[작성법]
-- 테이블을 수정하는 경우
-- ALTER TABLE 테이블명 ADD / MODIFY/ DROP 수정할 내용;

-- 1. 제약조건 추가 / 삭제

-- 작성하는 방법 중 [] 대괄호 : 생략 가능(선택_
-- 제약조건 추가 : ALTER TABLE 테이블명
--                     ADD [CONSTRAINT 제약조건명] 제약조건 (컬럼명) [REFERENCES 테이블명(컬럼명)]];

-- DEPARTMENT 테이블을 복사해서 예제 진행

CREATE TABLE DEPT_COPY AS SELECT * FROM DEPARTMENT;

-- DEPT_COPY 테이블에 PK PRIMARY KET 추가
ALTER TABLE DEPT_COPY ADD CONSTRAINT DEPT_COPY_PK PRIMARY KEY (DEPT_ID);
--> ALTER TABLE DEPT_COPY : DEPT_COPY 테이블을 수정하겠다
--> ADD CONSTRAINT : 새로운 제약조건을 추가하는 값
--> DEPT_COPY_PK 새로운 제약조건의 이름
--> PRIMARY KEY(DEPT_ID) : DEPT_ID를 기본키로 설정

-- DEPT_COPY 테이블에서 DEPT_TITLE 컬럼에 UNIQUE 제약조건 추가
-- CONSTRAINT 제약조건 이름 DEPT_COPY_UNI
ALTER TABLE DEPT_COPY ADD CONSTRAINT DEPT_COPY_UNI UNIQUE(DEPT_TITLE);


-- 2. 컬럼 추가 / 수정 / 삭제

-- 컬럼 추가 : ALTER TABLE 테이블명 ADD(컬럼명 데이터타입 [DEFAULT] '값']);

-- 컬럼 수정 : ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입; (데이터 타입 변경)
-->              ALTER TABLE 테이블명 MODIFY DEFAULT '값'; (기본값 변경)

---> 데이터 타입 수정할 경우 컬럼에 저장된 크기 미만으로는 변경할 수 없음
-----> 데이터탕비 VATCHAR2(100) -> VARCHER2(10)  데이터 타입이 10 초과되는건 불가


-- 컬럼 삭제 : ALTER TABLE 테이블명 DROP (삭제할 컬럼명);
-->              ALTER TABLE 테이블명 DROP COLUMN 삭제할 컬럼명;

--> 테이블에는 최소 1개 이상의 컬럼이 존재해야하기 때문에 모든 컬럼 삭제 X

-- DEPT_COPY 컬럼에 CNAME VARCHAR2(20) 컬럼 추가

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY ADD (CNAME VARCHAR2(20));

--DEPT_COPY 테이블에 LNAME VARCHAR2(30) 기본값은 한국으로 추가
ALTER TABLE DEPT_COPY ADD (LNAME VARCHAR2(30) DEFAULT '한국');

SELECT * FROM DEPT_COPY;

-- (수정)
-- DEPT_COPY 테이블의 DEPT_ID 컬럼의 데이터 타입을 CHAR2() -> VARCHAR(3) 변경
-- ALTER TABLE 테이블명 MODIFY 컬럼명 테이터타입;

ALTER TABLE DEPT_COPY MODIFY DEPT_ID VARCHAR2(3);
--> 주의할 점 기존에 저장된 컬럼값이 3보다 크면 변경 불가
---> 컬럼값을 조절할 때 ( 큰 값 -> 작은 값) 이미 저장된 데이터값이 변경할 값보다 크지 않은지 확인하고 조절


-- (삭제)
-- DEPT_COPY 테이블에서 CNAME, LNAME 삭제
--> ALTER TABLE 테이블명 DROP (삭제할컬럼명);

ALTER TABLE DEPT_COPY DROP (CNAME);

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY DROP COLUMN LNAME;

SELECT * FROM DEPT_COPY;

--> DEPT_TITLE 컬럼 1번 방법 삭제
ALTER TABLE DEPT_COPY DROP (DEPT_TITLE);
SELECT * FROM DEPT_COPY;

--> LOCATION_ID 컬럼 2번 방법 삭제
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;


-- 3. 테이블 삭제
-- [작성법]
-- DROP TABLE 테이블명 [CASCADE CONSTRAINT];

-- 삭제할 테이블 TB1 생성
CREATE TABLE TB1(
    TB1_PK NUMBER PRIMARY KEY,
    TB1_COL NUMBER
    );
    
CREATE TABLE TB2(
    TB2_PK NUMBER PRIMARY KEY,
    TB2_COL NUMBER REFERENCES TB1 -- TB1 테이블의 PK값을 참조
    );

-- 일반 삭제 (DEPT_COPY)
DROP TABLE DEPT_COPY;

SELECT * FROM DEPT_COPY; -- ORA-00942: table or view does not exist

DROP TABLE TB1;
-- ORA-02449: unique/primary keys in table referenced by foreign keys
-- 외래 키에 의해 잠조되는 고유 / 기본키가 존재하기 때문에 삭제할 수 없음
-- 삭제하고 싶은데 어떻게 삭제를 하는가?

-- 해결방법 1 : 자식테이블(TB2) 삭제 후 부모테이블 (TB1) 삭제
DROP TABLE TB2;
DROP TABLE TB1;

-- 해결방법2 : CASCADE CONSTRAINTS 옵션 사용
--> 제약조건까지 모두 삭제 조건을 없애버려서 부모 자식 끊음
DROP TABLE TB1 CASCADE CONSTRAINTS;
DROP TABLE TB2;
SELECT * FROM TB2;

-- 4. 제약조건 컬럼 테이블 이름 변경(RENAME)
-- ALTER TABLE 테이블명 RENAME TO 새로운테이블명;

-- 테이블 복사
CREATE TABLE DEPT_COPY AS SELECT * FROM department;

ALTER TABLE DEPT_COPY RENAME TO DCOPY;

SELECT * FROM DCOPY;
SELECT * FROM DEPT_COPY;
















