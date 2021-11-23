use sqldb3;

-- 테이블 복사 
-- 제약조건 복사 안 됨
-- 복사 후 제약조건 설정 필요

-- (1) 테이블 복사 : 새 테이블로 전체 복사
CREATE TABLE new_book1 AS
SELECT * FROM book;

SELECT * FROM new_book1;
DESC new_book1;

-- 기본키 제약조건 추가
ALTER TABLE new_book1
	ADD CONSTRAINT PK_new_book1_bookNo
    PRIMARY KEY (bookNo);

-- (2) 테이블 복사 : 새 테이블로 일부만 복사
CREATE TABLE new_book2 AS
SELECT * FROM book WHERE bookDate LIKE '2020%';

-- 기본키 제약조건 추가
ALTER TABLE new_book2
	ADD CONSTRAINT PK_new_book2_bookNo
    PRIMARY KEY (bookNo);
    
SELECT * FROM new_book2;
DESC new_book2;

-- (3) 기존 테이블로 데이터만 복사
-- 테이블 구조가 동일한 경우에만 가능

-- new_book2 테이블의 전체 데이터 삭제
DELETE FROM new_book2;

-- new_book2 테이블에 데이터 복사
INSERT INTO new_book2 
SELECT * FROM book;

SELECT * FROM new_book2;
DESC new_book2;

-- (4) 다른 데이터베이스이 테이블 복사
-- 데이터베이스명.테이블명
-- 새 테이블로 일부 복사
CREATE TABLE product2 AS
SELECT * FROM sqldb2.product WHERE prdPrice >= 1000000;

-- 기본키 제약조건 추가
ALTER TABLE product2
	ADD CONSTRAINT PK_product2_prdNo
    PRIMARY KEY (prdNo);

SELECT * FROM product2;
DESC product2;








