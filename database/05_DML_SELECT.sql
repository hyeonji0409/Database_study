/* SELECT */

CREATE DATABASE sqldb3;

use sqldb3;

-- 데이터 타입 변경하기
ALTER TABLE publisher MODIFY pubNo VARCHAR(10),
					  MODIFY pubName VARCHAR(20);
                      
 ALTER TABLE book MODIFY bookNo VARCHAR(10),
				  MODIFY bookName VARCHAR(20),                    
				  MODIFY bookAuthor VARCHAR(10),                     
				  MODIFY bookPrice INT,                     
				  MODIFY bookDate Date,                     
				  MODIFY bookStock VARCHAR(20);   
                      
 ALTER TABLE client MODIFY clientNo VARCHAR(10),
					  MODIFY clientName VARCHAR(10),                    
					  MODIFY clientPhone VARCHAR(13),                     
					  MODIFY clientAddress VARCHAR(50),                     
					  MODIFY clientBirth Date,                     
					  MODIFY clientHobby VARCHAR(20),                     
					  MODIFY clientGender VARCHAR(10);       
                      
 ALTER TABLE bookSale MODIFY bsNo VARCHAR(10),                    
					  MODIFY bsDate Date,                     
					  MODIFY bsQty INT;
                      
-- 기본키 / 외래키 설정
-- 기본키
ALTER TABLE publisher ADD CONSTRAINT PK_publisher_pubNo PRIMARY KEY (pubNo);
ALTER TABLE book ADD CONSTRAINT PK_book_bookNo PRIMARY KEY (bookNo);
ALTER TABLE client ADD CONSTRAINT PK_client_clientNo PRIMARY KEY (clientNo);
ALTER TABLE bookSale ADD CONSTRAINT PK_bookSale_bsNo PRIMARY KEY (bsNo);

-- 외래키
ALTER TABLE book ADD CONSTRAINT FK_book_publisher FOREIGN KEY(pubNo) REFERENCES publisher(pubNo);
ALTER TABLE bookSale ADD CONSTRAINT FK_bookSale_client FOREIGN KEY (clientNo) REFERENCES client(clientNo);
ALTER TABLE bookSale ADD CONSTRAINT FK_bookSale_book FOREIGN KEY (bookNo) REFERENCES book(bookNo);

DESC book;


/* SELECT 실습 */

-- 저자가 '홍길동'인 도서의 도서명, 저자 출력하기
SELECT bookName, bookAuthor
From book
WHERE bookAuthor = '홍길동';

-- 가격이 30000원 이상인 도서의 도서명, 가격, 재고 출력
SELECT bookName, bookPrice, bookStock
FROM book
WHERE bookPrice >= 30000;

-- 재고가 3~5 사이인 도서의 도서명, 재고 출력
SELECT bookName, bookStock
FROM book
WHERE bookStock >=3 AND bookStock <=5;

-- BETWEEN 조건 사용
-- BETWEEN A AND B
SELECT bookName, bookStock
FROM book
WHERE bookStock BETWEEN 3 AND 5;

-- 리스트에 포함(IN, NOT IN)
-- 출판사명이 서울출판사(pubNo=1)와 도서출판 강남(pubNo=2)인 도서의 도서명, 출판사번호 출력
SELECT bookName, pubNo
FROM book
WHERE pubNo IN ('1','2');

SELECT bookName, pubNo
FROM book
WHERE pubNo NOT IN ('2');

select * from client;

-- NULL 실습을 위해 NULL로 설정하기 -- 
UPDATE client SET clientHobby = null WHERE clientName = '호날두'; 
UPDATE client SET clientHobby = null WHERE clientName = '샤라포바'; 

SELECT clientName, clientHobby From client;

SELECT clientName, clientHobby
FROM client
WHERE clientHobby IS NULL;

-- 취미에 공백 있는 행
SELECT clientName, clientHobby
FROM client
WHERE clientHobby= '';

-- ''와 ' '는 동일 (스페이스 개수 상관 없이 공백으로 인식)

-- 논리 (AND. OR)
-- 저자가 '홍길동'이면서 재고가 3권 이상인 모든 도서 출력
SELECT *
FROM book
WHERE bookAuthor = '홍길동' AND bookStock >= 3;

-- 저자가 홍길동이거나 성춘향인 모든 도서 출력
SELECT * FROM book
WHERE bookAuthor = '홍길동' OR bookAuthor = '성춘향';

-- 출판사 테이블에서 출판사 명에 '출판사'가 포함된 모든 행 출력
SELECT *
FROM publisher
WHERE pubName LIKE '%출판사%';

-- 고객 중 출생년도가 1990년대인 모든 고객 출력
SELECT *
FROM client
WHERE clientBirth LIKE '%199%';

-- 고객 테이블에서 고객이 4글자인 모든 고객 정보 출력
SELECT *
FROM client
WHERE clientName LIKE '____';

-- 도서 테이블에서 도서명에 안드로이드가 들어있지 않은 도서의 도서명 출력
SELECT *
FROM book
WHERE bookName NOT LIKE '%안드로이드%';

-- 고객 테이블에서 주소만 검색하여 출력(중복되는 주소는 한번만 출력)
SELECT DISTINCT clientAddress
FROM client;

-- 고객 테이블에서 취미가 축구이거나 등산인 고객의 고객명, 취미 출력
SELECT clientName, clientHobby
FROM client
WHERE clientHobby = '축구' OR clientHobby = '등산';

-- 도서 테이블에서 저자의 두 번째 위치에 '길'이 들어 있는 저자명 출력 (중복되는 저자명은 한번
SELECT DISTINCT bookAuthor
FROM book
WHERE bookAuthor LIKE'%_길%';

-- 도서 테이블에서 발행일이 2019년인 도서의 도서명, 저자, 발행일 출력
SELECT bookName, bookAuthor, bookDate
FROM book
WHERE bookDate LIKE'%2019%';

-- 도서판매 테이블에서 고객번호1, 2를 제외한 모든 판매 데이터 출력
SELECT *
FROM bookSale
WHERE clientNo NOT IN('1', '2');

-- 고객 테이블에서 취미가 NULL이 아니면서 주소가 '서울'인 고객의 고객명, 주소, 취미 출력
SELECT clientName, clientAddress, clientHobby
FROM client
WHERE clientHobby IS NOT NULL AND clientAddress = '서울';

-- 도서 테이블에서 가격이 25,000원 이상이면서 저자 이름에 '길동'이 들어가는 도서의 도서명, 저자, 가격, 재고 출력
SELECT bookName, bookAuthor, bookPrice, bookStock
FROM book
WHERE bookPrice >= 25000 AND bookAuthor Like '%길동%';

-- 도서 테이블에서 가격이 20,000 ~ 25,000원인 모든 도서 출력 
SELECT bookName, bookAuthor, bookPrice, bookStock
FROM book
WHERE bookPrice >= 20000 AND bookPrice <= 25000;

-- 도서 테이블에서 저자명에 '길동'이 들어 있지 않는 도서의 도서명, 저자 출력
SELECT bookName, bookAuthor
FROM book
WHERE bookAuthor NOT Like '%길동%';

/* ORDER BY */ 

-- 도서명 순서대로 검색
SELECT *
FROM book
ORDER BY bookName ASC;


-- 도서명 내림차순 검색
SELECT *
FROM book
ORDER BY bookName DESC;

-- 한글 >> 영문 >> 숫자 순서로 출력
SELECT *
FROM book
ORDER BY (
	CASE WHEN ASCII(SUBSTRING(bookName, 1)) BETWEEN 48 AND 57 THEN 3
    	 WHEN ASCII(SUBSTRING(bookName, 1)) < 122 THEN 2 ELSE 1 END), bookName;

-- 영문 >> 한글 >> 숫자
SELECT *
FROM book
ORDER BY (
	CASE WHEN ASCII(SUBSTRING(bookName, 1)) BETWEEN 48 AND 57 THEN 3
    	 WHEN ASCII(SUBSTRING(bookName, 1)) < 122 THEN 1 ELSE 2 END), bookName;


-- 상위 n개 출력
SELECT *
FROM book
ORDER BY bookName
LIMIT 5; -- 첫 번째부터 상위 5개

SELECT *
FROM book
ORDER BY bookName
LIMIT 5 OFFSET 0;

SELECT *
FROM book
ORDER BY bookName
LIMIT 0, 5;


/* 정렬 계속 */

-- 도서 테이블에서 재고 수량을 기준으로 내림차순 정렬하여 도서명, 저자, 재고 출력
SELECT bookName, bookAuthor, bookStock
FROM book
ORDER BY bookName DESC;

SELECT bookName, bookAuthor, bookStock
FROM book
ORDER BY bookName DESC, bookAuthor ASC;


-- 도서 테이블에서 총 재고 수량 계산하여 출력
SELECT SUM(bookStock)
FROM book;

-- 열 이름 만들어주기
SELECT SUM(bookStock) As 'sum of bookStock'
FROM book;

-- 도서판매 테이블에서 고객번호 2인 호날두가 주문한 도서의 총 주문수량 계산하여 출력
SELECT SUM(bsQty) AS '총 주문수량'
FROM bookSale
WHERE clientNo = '2';

-- 도서판매 테이블에서 최대/최소 주문수량 확인
SELECT MAX(bsQty) AS '최대 주문량', MIN(bsQty) AS '최소 주문량'
FROM bookSale;

-- 도서 테이블에서 도서의 가격 총합, 평균 값, 최고가, 최저가 출력
SELECT SUM(bookPrice) AS '도서 가격 총합', AVG(bookPrice) AS '평균값',
MAX(bookPrice) AS '최고가', MIN(bookPrice) AS '최저가'
FROM book;

-- 도서 판매 테이블에서 도서 판매 건수 출력(모든 행의 수)
SELECT COUNT(*) AS "총 판매 건수"
FROM bookSale;

SELECT COUNT(clientHobby) AS 취미
FROM client;

-- 취미가 열에서 값이 들어 있는 행의 수


SELECT COUNT(clientHobby) AS 취미
FROM client
WHERE clientHobby NOT IN ('');


-- 도서 판매 테이블에서 도서별로 주문수량, 판매수량 합계 출력
SELECT bookNo, SUM(bsQty) AS '판매량 합계'
FROM bookSale
GROUP BY bookNo;

-- - 도서 테이블에서 가격이 25000원인 도서에 대해 출판사별로 도서 수 합계(출판사별: 그룹화)
-- 단, '도서 수 합계'가 2인 이상만 출력
SELECT pubNo, COUNT(*) AS "도서 수 합계"
FROM book
WHERE bookPrice >= 25000
GROUP BY pubNo
HAVING COUNT(*) >= 2;

-- 도서 테이블에서 가격 순으로 내림차순 정렬하여, 도서명, 저자, 가격 출력(가격이 같으면 저자 순으로 오름차순 정렬)
SELECT bookName, bookAuthor, bookPrice
FROM book
ORDER BY bookPrice DESC, bookAuthor ASC; 

-- 도서 테이블에서 저자에 '길동'이 들어가는 도서의 총 재고 수량 계산하여 출력
SELECT SUM(bookStock) AS "총 재고 수량"
FROM book
WHERE bookAuthor LIKE '%길동%';

-- 도서 테이블에서 ‘서울 출판사' 도서 중 최고가와 최저가 출력 
SELECT MAX(bookPrice) AS 최고가, MIN(bookPrice) AS 최저가
FROM book
WHERE pubNo = '1';

-- 도서 테이블에서 출판사별로 총 재고수량과 평균 재고 수량 계산하여 출력 (‘총 재고 수량’으로 내림차순 정렬)
SELECT SUM(bookStock) AS '총 재고수량', AVG(bookStock) AS '평균 재고수량'
FROM book
ORDER BY '총 재고수량' DESC;

-- 도서판매 테이블에서 고객별로 ‘총 주문 수량’과 ‘총 주문 건수’ 출력. 단 주문 건수가 2이상인 고객만 해당 
SELECT clientNo, COUNT(*) AS "총 주문 건수", SUM(bsQty) AS "총 주문 수량"
FROM bookSale
GROUP BY clientNo
HAVING COUNT(*) >= 2; 

