CREATE SCHEMA dbproject1;

use dbproject1;

CREATE TABLE book(
	bookNo char(10) NOT NULL PRIMARY KEY,
    bookTitle varchar(30),
    bookAuthor varchar(20),
    bookYear INT,
    bookPrice INT,
    bookPublisher char(10));
    
INSERT INTO book VALUES ('B001', '자바프로그래밍', '홍길동', 2021, 30000, '서울출판사'),
						('B002', '데이터베이스', '이몽룡', 2020, 25000, '멀티출판사'),
						('B003', 'HTML/CSS', '성춘향', 2021, 18000, '강남출판사');
                        
SELECT * FROM book;