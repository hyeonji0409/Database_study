CREATE SCHEMA sqldb2;

use sqldb2;

-- 출판사 테이블 생성alter
CREATE TABLE publisher (
    pubNo VARCHAR(10) NOT NULL PRIMARY KEY,
    pubName VARCHAR(30) NOT NULL
)   
CREATE TABLE book (
	bookNo VARCHAR(10) NOT NULL PRIMARY KEY,
	bookname VARCHAR(30) NOT NULL,
	bookPrice INT DEFAULT 10000 CHECK(bookPrice > 1000),
	bookDate DATE,
	pubNo VARCHAR(10) NOT NULL,	
	CONSTRAINT FK_book_publisher FOREIGN KEY (pubNo) REFERENCES publisher (pubNo)
);

-- publisher 테이블에 데이터 입력
INSERT INTO publisher (pubNo, pubName) VALUES ('1','서울 출판사');
INSERT INTO publisher (pubNo, pubName) VALUES ('2','강남 출판사');
INSERT INTO publisher (pubNo, pubName) VALUES ('3','종로 출판사');

-- publisher 테이블 내용 조회
SELECT * FROM publisher;

-- 도서 테이블에 데이터 입력
INSERT INTO book (bookNo, bookName, bookPrice, bookDate, pubNo) VALUES('1', '자바', 20000, '2021-05-17', '1');

-- 모든 열에 데이터를 입력할 경우 열이름 생략 가능
INSERT INTO book VALUES('2', '자바스크립트', 23000, '2021-05-17', '3');

-- 여러 개의 데이터를 한 번에 INSERT
INSERT INTO book(bookNo, bookName,bookPrice,bookDate,pubNo)
	VALUES('3', '데이터베이스', 35000, '2021-07-11', '2'),
	('4', '알고리즘', 18000, '2021-05-22', '3'),
	('5', '웹프로그래밍', 22000, '2021-09-10', '2');

-- 모든 열에 데이터를 입력할 경우 열이름 생략 가능
INSERT INTO book(bookNo, bookName,bookPrice,bookDate,pubNo)
	VALUES('3', '데이터베이스', 35000, '2021-07-11', '2'),
	('4', '알고리즘', 18000, '2021-05-22', '3'),
	('5', '웹프로그래밍', 22000, '2021-09-10', '2');
    
SELECT * FROM book;

-- 학과 테이블 생성
CREATE TABLE department(
	dptNo VARCHAR(10) NOT NULL PRIMARY KEY,
	dptName VARCHAR(30) NOT NULL,
	dptTel VARCHAR(13)
);

-- 학생 테이블 생성 
CREATE TABLE student (
	stdNo VARCHAR(10) NOT NULL PRIMARY KEY,
	stdName VARCHAR(30) NOT NULL,
	stdYear INT DEFAULT 4 CHECK(stdYear >= 1 AND stdYear <= 4),
	stdAddress VARCHAR(50), 
	stdBirthDay DATE,
	dptNo VARCHAR(10) NOT NULL,
	CONSTRAINT FK_student_department FOREIGN KEY (dptNo) REFERENCES department (dptNo)
);

INSERT INTO department (dptNo, dptName, dptTel) 
		VALUES ('1', '컴퓨터학과','02-1111-1111'),
		('2', '경영학과','02-2222-2222'),
		('3', '수학과','02-3333-3333');
        
INSERT INTO student (stdNo, stdName, stdYear, stdAddress, stdBirthday, dptNo)
	VALUES ('2018002' ,'이몽룡', 4, '서울시 강남구', '1998-05-07', '1'),
    ('2019003' ,'홍길동', 3, '경기도 안양시', '1999-11-11', '2'),
    ('20211003' ,'성춘향', 1, '전라북도 남원시', '2002-01-02', '3'),
    ('2021004' ,'변학도', 1, '서울시 종로구', '2000-03-26', '2');

select * from student;


-- product..csv 파일 import 해서 product 테이블 생성
DESCRIBE product;
DESC product;

-- 파일 임포트 하면 제약조건 없어짐 -> 기본키 추가 필요
-- 기본키 추가 전에 text를 VARCHAR( )로 변경 (안하면 오류)

-- 기본키인 prdNo를 VARCHAR(10)로 변경
ALTER TABLE product MODIFY prdNo VARCHAR(10) NOT NULL;

SELECT * FROM sqldb2;

-- 기본키 제약조건 추가
ALTER TABLE product ADD CONSTRAINT PK_product_prdNo PRIMARY KEY (prdNo);

-- 모든 text 타입을 VARCHAR로 변경
ALTER TABLE product MODIFY prdName VARCHAR(20), 
					MODIFY prdMaker VARCHAR(30), 
					MODIFY prdColor VARCHAR(10), 
					MODIFY ctgNo VARCHAR(10);
                    
/* UPDATE */

SELECT * FROM product;

-- 상품번호가 1005인 상품의 상품명을 UHD TV로 변경
UPDATE product SET prdName = 'UHD TV' WHERE prdNO = '1005';


/* DELETE */

-- 상품명이 '그늘막 텐트'인 상품 삭제
DELETE FROM product WHERE prdName = '그늘막 텐트';

-- 연습문제

SELECT * FROM book;

INSERT INTO book(bookNo, bookName,bookPrice,bookDate,pubNo)
	VALUES('9', 'JAVA 프로그래밍', 30000, '2021-03-10','1'),
		('10','파이썬 데이터 과학',24000,'2018-02-05','2');
        
UPDATE book SET bookPrice = 22000 WHERE bookName = '자바';

DELETE FROM book WHERE bookDate >= '2018-01-01' AND bookDate <= '2018-12-31';


/* 종합 연습문제 */ 
/*
1. 고객 테이블 (customer) 생성 
2. 고객 테이블의 전화번호 열을 NOT NULL로 변경
3. 고객 테이블에 ‘성별’, ‘나이’ 열 추가
4. 고객 테이블에 데이터 삽입 (3개)
5. 고객명이 홍길동인 고객의 전화번호 값 수정 (값은 임의로)
6. 나이가 20살 미만인 고객 삭제
*/

-- 고객 테이블 생성
CREATE TABLE customer(
	custNo VARCHAR(10) NOT NULL PRIMARY KEY,
	custName VARCHAR(30),
	custPhone VARCHAR(13),
	custAddress VARCHAR(50)
);

-- 고객 테이블 전화번호 not null 변경
ALTER TABLE customer MODIFY custPhone VARCHAR(13) NOT NULL;

-- 성별, 나이 열 추가
ALTER TABLE customer ADD (custSex VARCHAR(10), custAge int);

-- 고객 테이블 데이터 삽입
INSERT INTO customer(custNo, custName, custPhone, custAddress, custSex, custAge)
VALUES('1','김준면','010-1234-5678','서울시 영등포구','남',32), 
('2','김민석','010-2345-6789','경기도 구리시','남',32), 
('3','변백현','010-1992-0506','경기도 부천시','남',30);

-- 고객명이 김민석인 고객의 전화번호 값 수정 (값은 임의로)
UPDATE customer SET custPhone = '010-1990-0326' WHERE custName = '김민석';

-- 나이가 31살 미만인 고객 삭제
DELETE FROM customer WHERE custAge < 31;

SELECT * FROM customer;




