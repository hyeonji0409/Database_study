-- ALTER문

-- 열 추가: ALTER TABLE 테이블명 ADD

use sqldb;

-- student 테이블에 stdTel 열 추가alter

ALTER TABLE student ADD stdTel VARCHAR(13);

DESCRIBE student;

-- 여러 개의 열 추가: stdAge, stdAddress
ALTER TABLE student ADD (stdAge VARCHAR(2), stdAddress2 VARCHAR(50));

-- 열의 데이터 형식 변경: stdAge 열의 데이터 타입을 INT로 변경
ALTER TABLE student MODIFY stdAge INT;

-- 열의 제약조건 변경: stdName을 NULL 허용으로 변경
ALTER TABLE student MODIFY stdName VARCHAR(2) NULL;

-- 열 이름 변경: stdTel을 stdHP로 변경
ALTER TABLE student RENAME COLUMN stdTel TO stdHP;

-- 열 이름과 데이터 타입 변경
ALTER TABLE student CHANGE stdAddress stdAddress1 VARCHAR(30);

-- 열 삭제: stdHP 열 삭제
ALTER TABLE student DROP COLUMN stdHP;

-- 여러 개의 열 삭제
ALTER TABLE student DROP stdAge, DROP stdAddress2;

/* 
연습문제
1. product 테이블에 숫자 값을 갖는 prdStock과 제조일을 나타내는 prdDate 열 추가
2. product 테이블의 prdCompany 열을 NOT NULL로 변경
3. publisher 테이블에 pubPhone, pubAddress 열 추가
4. publisher 테이블에서 pubPhone 열 삭제
*/

ALTER TABLE product ADD (prdStock INT, prdDate DATE);
ALTER TABLE product MODIFY prdCompany VARCHAR(30) NULL;

ALTER TABLE publisher ADD(pubPhone VARCHAR(13), pubAddress VARCHAR(30));
ALTER TABLE publisher DROP COLUMN pubPhone;

-- 외래키 제약조건이 설정된 경우 기본키 테이블의 기본키 삭제 시 오류 발생
ALTER TABLE department DROP PRIMARY KEY;

-- 외래키 제약조건 먼저 삭제하기
ALTER TABLE student DROP CONSTRAINT FK_studentt_department;
ALTER TABLE professor DROP CONSTRAINT FK_professor_department;


-- 기본키 삭제하기
ALTER TABLE department DROP PRIMARY KEY;

-- 기본키 / 외래키 추가
-- 기본키 제약조건 추가: department
ALTER TABLE department ADD CONSTRAINT PK_department_dNo PRIMARY KEY(dNo);

-- 외래키 제약조건 추가: student와 professor 테이블
ALTER TABLE student ADD CONSTRAINT FK_student_department FOREIGN KEY(dNo) REFERENCES department(dNo);
ALTER TABLE professor ADD CONSTRAINT FK_professor_department FOREIGN KEY(dNo) REFERENCES department(dNo);

-- ON DELETE CASCADE
-- student 테이블의 기존 외래키 삭제하고 다시 설정
ALTER TABLE student DROP CONSTRAINT FK_student_department;

ALTER TABLE student ADD CONSTRAINT FK_student_department 
FOREIGN KEY(dNo) REFERENCES department(dNo) ON DELETE CASCADE;