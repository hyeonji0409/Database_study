-- 스키마 (데이터베이스) 생성 및 삭제 --
-- SCHEMA / DATABASE 동일 의미
CREATE SCHEMA sqldb DEFAULT CHARACTER SET utf8;
CREATE DATABASE sqldb2 DEFAULT CHARACTER SET utf8mb4;

-- 스키마(데이터베이스)  --
DROP SCHEMA sqldb;
DROP DATABASE sqldb2;

CREATE SCHEMA sqldb DEFAULT CHARACTER SET utf8;

-- 테이블 생성
-- CREATE TABLE
-- 속성(열)과 속성에 관한 제약 정의
-- 기본키(PRIMARY KEY), 외래키(FOREIGN KEY) 정의

-- 사용할 데이터베이스 지정
use sqldb;

-- 상품 테이블 생성
-- 제약 조건
	-- 기본기: prdNo NOT NULL
    -- prdName NOT NULL
    
CREATE TABLE product(
	prdNo VARCHAR(10) NOT NULL PRIMARY KEY,
    prdName VARCHAR(30) NOT NULL,
    prdPrice INT,
    prdCompany VARCHAR(30)
);

-- 상세 정보 출력
DESCRIBE product;

-- 기본키 제약조건 설정 방법2
CREATE TABLE product2(
	prdNo VARCHAR(10) NOT NULL,
    prdName VARCHAR(30) NOT NULL,
    prdPrice INT,
    prdCompany VARCHAR(30),
    PRIMARY KEY(prdNo)
);

--  기본키 제약조건 설정방법3
CREATE TABLE product3(
	prdNo VARCHAR(10) NOT NULL,
    prdName VARCHAR(30) NOT NULL,
    prdPrice INT,
    prdCompany VARCHAR(30),
    CONSTRAINT PK_product_prdNo PRIMARY KEY(prdNo)
);

DESCRIBE product2;
DESCRIBE product3;

/*
출판사 테이블 생성(출판사 번호, 출판사명)
제약조건 설정
- 기본키로 pubNo NOT NULL
- pubName NOT NULL

*/
CREATE TABLE publisher(
	pubNo VARCHAR(10) NOT NULL PRIMARY KEY,
    pubName VARCHAR(30) NOT NULL
);

-- #### 도서 테이블 설정
-- 외래키(출판사 번호 pubNo) 제약조건 설정
-- 기타 제약조건 설정
	-- 기본키: bookNo NOT NULL
    -- 외래키: pubNo (참조 테이블의 기본키와 동일하게 설정)

CREATE TABLE book(
	bookNo VARCHAR(10) NOT NULL PRIMARY KEY,
    bookName VARCHAR(30) NOT NULL,
    bookPrice INT DEFAULT 10000 CHECK(bookPrice > 1000),
    pubNo VARCHAR(10) NOT NULL,
    bookDate date,
    CONSTRAINT FK_book_publisher FOREIGN KEY(pubNo) REFERENCES publisher(pubNo)
);

DESCRIBE book;


ALTER TABLE book add bookDate date;

-- 학과 테이블
CREATE TABLE department(
	dNo VARCHAR(30) NOT NULL PRIMARY KEY,
    dName VARCHAR(10) NOT NULL,
	dTel VARCHAR(13) 
);

-- 학생 테이블
CREATE TABLE student(
	stdNo VARCHAR(10) NOT NULL PRIMARY KEY,
	stdName VARCHAR(30) NOT NULL,
    stdGrade INT DEFAULT 4 CHECK(stdGrade >= 1 AND stdGrade <=4),
    stdAddress VARCHAR(50),
    stdBirth DATE,
    dNo VARCHAR(10) NOT NULL,
    CONSTRAINT FK_studentt_department FOREIGN KEY(dNo) REFERENCES department(dNo)
);


-- 교수 테이블 생성
CREATE TABLE professor(
	proNo VARCHAR(10) NOT NULL PRIMARY KEY,
    proName VARCHAR(30) NOT NULL,
    proPosition VARCHAR(20),
    proTel VARCHAR(13),
    dNo VARCHAR(10) NOT NULL,
    CONSTRAINT FK_professor_department FOREIGN KEY(dNo) REFERENCES department(dNo)
);

-- 과목 테이블 생성
CREATE TABLE subjects(
	subNo VARCHAR(10) NOT NULL PRIMARY KEY,
    subName VARCHAR(30) NOT NULL,
    subCnt INT,
    proNo VARCHAR(10) NOT NULL,
    CONSTRAINT FK_subject_professor FOREIGN KEY(proNo) REFERENCES professor(proNo)
);

-- 성적 테이블
CREATE TABLE score (
	stdNo VARCHAR(10) NOT NULL,
    subNo VARCHAR(10) NOT NULL,
    scScore INT,
    scGrade VARCHAR(2),
    CONSTRAINT FK_score_stdNo_subNo PRIMARY KEY(stdNo, subNo),
    CONSTRAINT FK_score_student FOREIGN KEY(stdNo) REFERENCES student(stdNo),    
    CONSTRAINT FK_score_subjects FOREIGN KEY(subNo) REFERENCES subjects(subNo)    
);


-- 키 값 자동 증가 (AUTO_INCREMENT)

CREATE TABLE board(
	boardNo INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    boardTitle VARCHAR(30) NOT NULL,
    boardWriter VARCHAR(20),
    boardContent VARCHAR(100) NOT NULL
);

-- 초기값 100으로 설정하고 3씩 증가
CREATE TABLE board2(
	boardNo INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    boardTitle VARCHAR(30) NOT NULL,
    boardWriter VARCHAR(20),
    boardContent VARCHAR(100) NOT NULL
);

ALTER TABLE board2 AUTO_INCREMENT = 100;
SET @@AUTO_INCREMENT_INCREMENT=3;

-- 100부터 시작해서 3씩 증가하는 것을 
-- 1부터 1씩 증가하는 것으로 변경

SET @COUNT = 0;
UPDATE board2 SET boardNo = @COUNT:=@COUNT+1;

-- 중간에 있는 값 삭제하고 전체를 다시 1부터 1씩 증가하도록 재정렬
ALTER TABLE board2 AUTO_INCREMENT = 1;




