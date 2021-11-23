-- 06_DML_join.sql

use sqldb3;

-- 다양한 조인 문 표기 형식

-- (1) WHERE 조건 사용
SELECT client.clientNo, clientName, bsQty
FROM client, bookSale
WHERE client.clientNo = bookSale.clientNo;
-- 양쪽 테이블에 공통되는 열 이름 앞에 테이블명 표기 : 모호성을 없애기 위해
-- 테이블명 오류 발생
-- client.clientNo

-- (2) 양쪽 테이블에 공통되지 않지만 모든 열 이름에 테이블명 붙임
-- 서버에서 찾고자 하는 열의 정확한 위치를 알려주므로 성능이 향상
SELECT client.clientNo, client.clientName, bookSale.bsQty
FROM client, bookSale
WHERE client.clientNo = bookSale.clientNo;

-- (3) 테이블명 대신 별칭(Alias) 사용
SELECT C.clientNo, C.clientName, BS.bsQty
FROM client C, bookSale BS
WHERE C.clientNo = BS.clientNo;

-- (4) JOIN ON 명시
SELECT C.clientNo, C.clientName, BS.bsQty
FROM bookSale BS
	JOIN client C
	ON C.clientNo = BS.clientNo;
    
-- (5) INNER JOIN ON 명시
-- 가장 많이 사용되는 방법으로 우리는 이 방법 사용
SELECT C.clientNo, C.clientName, BS.bsQty
FROM bookSale BS
	INNER JOIN client C
	ON C.clientNo = BS.clientNo;
    
-- --------------------------------------------
-- client 테이블과 bookSale 테이블 조인
-- clientNo 기준 : client (모든 고객) > bookSale (주문한 고객)
-- 두 테이블에 공통으로 들어 있는 값(clientNo)의 의미
-- 한 번이라도 도서를 주문한 적이 있는 고객
-- 출력 열 선택 안 하면 2개 테이블의 모든 열 표시
-- 공통되는 clientNo 열이 중복되서 출력
SELECT *
FROM client
	INNER JOIN booksale
    ON client.clientNo = bookSale.clientNo;

-- 필요한 열만 추출
-- 테이블명 대신 별칭(Alias) 사용
-- 한 번이라도 도서를 주문한 적이 있는 고객의 고객번호와 고객명 출력
SELECT C.clientNo, C.clientName
FROM client C
	INNER JOIN bookSale BS
    ON C.clientNo = BS.clientNo;

-- 한 번이라도 도서를 주문한 적이 있는 고객의 고객번호와 고객명 출력
-- 중복되는 행은 한 번만 출력
-- 고객번호 오름차순/내림차순 정렬
SELECT DISTINCT C.clientNo, C.clientName
FROM client C
	INNER JOIN bookSale BS
    ON C.clientNo = BS.clientNo
ORDER BY C.clientNo DESC;

-- client 테이블과 bookSale 테이블 위치 상관 없음
SELECT DISTINCT C.clientNo, C.clientName
FROM bookSale BS
	INNER JOIN client C
    ON C.clientNo = BS.clientNo
ORDER BY C.clientNo DESC;

-- 3개 테이블 결합
-- 테이블 3개 / 조인 조건 2개
-- 주문된 도서에 대하여 고객명과 도서명 출력
-- 주문된 도서 : bookSale 테이블 필요
-- 고객명 : client 테이블 필요
-- 도서명 : book 테이블 필요
SELECT C.clientName, B.bookName
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
    INNER JOIN book B ON B.bookNo = BS.bookNo;

-- 도서를 주문한 고객의 고객 정보, 주문 정보, 도서 정보 출력
-- 주문번호, 주문일, 고객번호, 고객명, 도서명, 주문수량
SELECT BS.bsNo, BS.bsDate, C.clientNo,  C.clientName, B.bookName, BS.bsQty
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
    INNER JOIN book B ON B.bookNo = BS.bookNo;
-- 기본 : bsNo로 오름차순 정렬

-- 최근 주문이 먼저 출력되도록 날짜 기준 정렬
SELECT BS.bsNo, BS.bsDate, C.clientNo,  C.clientName, B.bookName, BS.bsQty
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
    INNER JOIN book B ON B.bookNo = BS.bookNo
ORDER BY BS.bsDate DESC;

-- 고객별로 총 주문 수량 계산하여
-- 고객번호, 고객명, 총 주문수량 출력
-- 총 주문 수량 기준 내림차순 정렬
SELECT C.clientNo, C.clientName, SUM(bsQty) AS 총주문수량
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
GROUP BY C.clientNo
ORDER BY 총주문수량 DESC;
-- 고객별로 : GROUP BY
-- 고객번호 : client 테이블 필요
-- 총 주문수량 : bookSale 테이블 필요
-- 2개 테이블 사용 --> 조인 (공통된 값 존재하므로 INNER JOIN)
-- 내림차순 정렬 : ORDER BY 

-- 고객번호 출력하지 않고 고객명만 출력 가능
SELECT C.clientName, SUM(bsQty) AS 총주문수량
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
GROUP BY C.clientNo
ORDER BY 총주문수량 DESC;


-- 주문일, 고객명, 도서명, 도서 가격, 주문수량, 주문액 계산하여 출력
-- 주문일 오름차순 정렬
SELECT BS.bsDate, C.clientName, B.bookName, B.bookPrice, BS.bsQty,
	   B.bookPrice * BS.bsQty AS 주문액
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
    INNER JOIN book B ON B.bookNo = BS.bookNo
ORDER BY BS.bsDate;

-- WHERE 절 추가
-- 2019년 ~ 현재까지 판매된 내용만 출력
SELECT BS.bsDate, C.clientName, B.bookName, B.bookPrice, BS.bsQty,
	   B.bookPrice * BS.bsQty AS 주문액
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
    INNER JOIN book B ON B.bookNo = BS.bookNo
WHERE BS.bsDate >= '2019-01-01'
ORDER BY BS.bsDate;


-- -----------------------------------------------------------------

-- 연습문제

-- 1. 모든 도서에 대하여 도서의 도서번호, 도서명, 출판사명 출력
SELECT B.bookNo, B.bookName, b.bookauthor, P.pubName
FROM book B 
	INNER JOIN publisher P ON  B.pubNo = P.pubNo ;


-- 2. '서울 출판사'에서 출간한 도서의 도서명, 저자명, 출판사명 출력 
-- (조건에 출판사명 사용)
SELECT B.bookName, B.bookAuthor, P.pubName
FROM book B
	INNER JOIN publisher P ON  B.pubNo = P.pubNo
WHERE P.pubName = '서울 출판사';


-- 3. '종로출판사'에서 출간한 도서 중 판매된 도서의 도서명 출력
-- 중복된 경우 한 번만 출력 (조건에 출판사명 사용)
SELECT DISTINCT B.bookName, P.pubName
FROM book B
	INNER JOIN publisher P ON  B.pubNo = P.pubNo
	INNER JOIN bookSale BS ON  B.bookNo = BS.bookNo
WHERE  P.pubName = '종로출판사';


-- 4. 도서가격이 30,000원 이상인 도서를 주문한 고객의 
-- 고객명, 도서명, 도서가격, 주문수량 출력
SELECT C.clientName,  B.bookName, B.bookPrice, BS.bsQty
FROM bookSale BS 
	INNER JOIN client C ON C.clientNo = BS.clientNo
	INNER JOIN book B ON B.bookNo = BS.bookNo
WHERE B.bookPrice >= 30000;		


-- 5. '안드로이드 프로그래밍' 도서를 구매한 고객에 대하여
-- 도서명, 고객명, 성별, 주소 출력 (고객명으로 오름차순 정렬)
SELECT b.bookName, c.clientName, c.clientGender, c.clientAddress
FROM bookSale BS 
	INNER JOIN client C ON C.clientNo = BS.clientNo
	INNER JOIN book B ON B.bookNo = BS.bookNo
WHERE bookName = '안드로이드 프로그래밍'
ORDER BY clientName;


SELECT * FROM bookSale;
SELECT * FROM client;
SELECT * FROM book;

-- 6. '도서출판 강남'에서 출간된 도서 중 판매된 도서에 대하여
-- '총 매출액' 출력
SELECT SUM(B.bookPrice * BS.bsQty) AS "총 매출액"
FROM book B
	INNER JOIN bookSale BS ON B.bookNo = BS.bookNo        
	INNER JOIN publisher P ON B.pubNo = P.pubNo
WHERE P.pubName = '도서출판 강남';     

-- 집계 함수 앞에 열을 출력할 경우
SELECT P.pubName, SUM(B.bookPrice * BS.bsQty) AS "총 매출액"
FROM book B
	INNER JOIN bookSale BS ON B.bookNo = BS.bookNo        
	INNER JOIN publisher P ON B.pubNo = P.pubNo
WHERE P.pubName = '도서출판 강남'
GROUP BY P.pubNo;

-- 각 매출 건수 출력
SELECT P.pubName, B.bookPrice * BS.bsQty AS "매출액"
FROM book B
	INNER JOIN bookSale BS ON B.bookNo = BS.bookNo        
	INNER JOIN publisher P ON B.pubNo = P.pubNo
WHERE P.pubName = '도서출판 강남';        



-- 7. '서울 출판사'에서 출간된 도서에 대하여
-- 판매일, 출판사명, 도서명, 도서가격, 주문수량, 주문액 출력
SELECT BS.bsDate, P.pubName, B.bookName, B.bookPrice, 
		   BS.bsQty, B.bookPrice * BS.bsQty AS "판매액"
FROM book B
	INNER JOIN bookSale BS ON B.bookNo = BS.bookNo        
	INNER JOIN publisher P ON B.pubNo = P.pubNo
WHERE P.pubName = '서울 출판사';


-- 8. 판매된 도서에 대하여 
-- 도서별로 도서번호, 도서명, '총 주문 수량' 출력
SELECT B.bookNo, B.bookName, SUM(BS.bsQty) AS "총 주문 수량"
FROM book B
	INNER JOIN bookSale BS ON B.bookNo = BS.bookNo       		
GROUP BY B.bookNo;

SELECT * FROM bookSale;


-- 9. 판매된 도서에 대하여 
-- 고객별로 고객명, 총구매액 출력
-- 총구매액이 100,000원 이상인 경우만 해당   
SELECT C.clientName, SUM(B.bookPrice * BS.bsQty) AS "총구매액"
FROM bookSale BS 
	INNER JOIN client C ON C.clientNo = BS.clientNo
	INNER JOIN book B ON B.bookNo = BS.bookNo
GROUP BY C.clientNo
HAVING SUM(B.bookPrice * BS.bsQty) >= 100000;

-- HAVING 조건 없는 경우 고객별 총구매 내역 
SELECT C.clientName, SUM(B.bookPrice * BS.bsQty) AS "총구매액"
FROM bookSale BS 
	INNER JOIN client C ON C.clientNo = BS.clientNo
	INNER JOIN book B ON B.bookNo = BS.bookNo
GROUP BY C.clientNo;

SELECT * FROM bookSale;

-- 10. 판매된 도서 중 '도서출판 강남'에서 출간한 도서에 대하여
-- 고객명, 주문일, 도서명, 주문수량, 출판사명 출력
-- 고객명으로 오름차순 정렬
-- 4개 테이블 : 외래키 제약조건 3개
SELECT C.clientName, BS.bsDate, B.bookName, BS.bsQty, P.pubName    
FROM bookSale BS 
	INNER JOIN client C ON C.clientNo = BS.clientNo
	INNER JOIN book B  ON B.bookNo = BS.bookNo       
	INNER JOIN publisher P ON B.pubNo = P.pubNo
WHERE P.pubName = '도서출판 강남'
ORDER BY C.clientName;
         
-- -------------------------------------------------------------------

-- 외부 조인

-- (1) 왼쪽 (LEFT) 테이블 기준
-- client : bookSale 
-- 왼쪽 테이블(client) 데이터 모두 출력
-- 오른쪽 테이블 : 해당 값 없으면  null 출력
-- client 테이블에는 존재하지만 bookSale에 없는 값은 null로 출력
-- 의미 : 고객 중 한 번도 구매한 적이 없은 고객은 null로 출력

SELECT *
FROM client C
	LEFT OUTER JOIN bookSale BS
    ON C.clientNo = BS.clientNo
ORDER BY C.clientNo;

-- 고객 중에서 한 번도 구매한 적이 없는 고객의 
-- 고객번호, 고객명 출력
SELECT C.clientNo, C.clientName
FROM client C
	LEFT OUTER JOIN bookSale BS
    ON C.clientNo = BS.clientNo
WHERE BS.clientNo IS NULL
ORDER BY C.clientNo;

-- 도서 중에서 한 번도 판매된 적이 없는 도서의
-- 도서번호, 도서명 출력
SELECT B.bookNo, B.bookName
FROM book B
	LEFT OUTER JOIN bookSale BS
    ON B.bookNo = BS.bookNo
WHERE BS.bookNo IS NULL
ORDER BY B.bookNo;
    

-- 오른쪽 테이블 기준
-- 오른쪽  bookSale 데이터 모두 출력
-- 왼쪽 테이블 (client)에는 주문한 적이 있는 고객 정보만 출력
SELECT *
FROM client C
	RIGHT OUTER JOIN bookSale BS
    ON C.clientNo = BS.clientNo
ORDER BY C.clientNo;

-- 한 번이라도 주문한 적이 있는 고객의 
-- 고객번호, 고객명 출력
-- 중복된 경우 한 번만 출력
SELECT DISTINCT C.clientNo, C.clientName
FROM client C
	RIGHT OUTER JOIN bookSale BS
    ON C.clientNo = BS.clientNo
ORDER BY C.clientNo;

-- 완전 외부 조인 (FULL OUTER JOIN)
-- MySQL에서는 FULL OUTER JOIN 지원하지 않음
-- LEFT JOIN과 RIGHT JOIN을 UNION해서 사용

SELECT *
FROM client C
	LEFT JOIN bookSale BS
    ON C.clientNo = BS.clientNo

UNION

SELECT *
FROM client C
	RIGHT JOIN bookSale BS
    ON C.clientNo = BS.clientNo;







