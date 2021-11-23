-- 07_DML_subquery.sql

-- 서브쿼리

-- 단일 행 서브쿼리 (=)
-- 고객 호날두의 주문수량 조회
-- 1. client 테이블에서 고객명 '호날두'의 clientNo를 찾아서
-- 2. bookSale 테이블에서 이 clientNo에 해당되는 주문에 대해
-- 주문일, 주문수량 출력
SELECT bsDate, bsQty
FROM bookSale
WHERE	clientNo	= (SELECT clientNo
					   FROM client
					   WHERE clientName = '호날두');


-- 고객 호날두가 주문한 총 주문수량 출력
-- 1. client 테이블에서 고객명 '호날두'의 clientNo를 찾아서
-- 2. bookSale 테이블에서 이 clientNo에 해당되는 주문에 대해 
-- 총 주문수량 구해서 출력
SELECT SUM(bsQty) AS "총 주문수량"
FROM bookSale
WHERE	clientNo	= (SELECT clientNo
					   FROM client
					   WHERE clientName = '호날두');

-- 가장 비싼 도서의 도서명과 가격 출력
-- 1. 가장 비싼 도서 찾아서
-- 2. 해당 도서의 도서명과 가격 출력
SELECT bookName, bookPrice
FROM book
WHERE bookPrice = (SELECT MAX(bookPrice)
				   FROM book);


-- 단일 행 서브 쿼리 예 : 비교 연산자 사용
-- 1. 도서의 평균 가격보다 비싼 도서에 대해 (가격이 더 큰)
-- 2. 도서명, 가격 출력
-- 서브 쿼리에서 '평균 도서 가격'(단일행) 반환
SELECT bookName, bookPrice
FROM book
WHERE bookPrice > (SELECT AVG(bookPrice)
				   FROM book);

-- 참고 평균 도서 가격
SELECT ROUND(AVG(bookPrice)) FROM book;

-- 다중 행 서브 쿼리 (IN, NOT IN)
-- 도서를 구매한 적이 있는 고객의 고객명 출력
-- 1. bookSale에 있는  clientNo는 모두 구매한 고객
-- 2. client 테이블에서 이 clientNo에 해당되는 고객을 찾아서
-- 고객번호, 고객명 출력
SELECT clientNo, clientName
FROM client
WHERE clientNo IN (SELECT clientNo
				   FROM bookSale);

-- 한 번도 주문한 적이 없는 고객의 고객번호, 고객명 출력
SELECT clientNo, clientName
FROM client
WHERE clientNo NOT IN (SELECT clientNo
				       FROM bookSale);

-- 도서명이 '안드로이드 프로그래밍'인 도서를 구매한 고객의 고객명 출력
-- 1. book 테이블에서 도서명이 '안드로이드 프로그래밍'인 도서의 bookNo를 찾아서
-- 2. bookSale 테이블에서 이 bookNo에 해당되는 도서를 구매한 clientNo를 찾고 
-- 3. client 테이블에서 이 clientNo에 해당되는 고객명을 찾아서 출력
SELECT clientName
FROM client
WHERE clientNo IN (SELECT clientNo
				   FROM bookSale
                   WHERE bookNo IN (SELECT bookNo
									FROM book
                                    WHERE bookName = '안드로이드 프로그래밍'));


-- IN : 다중 행 반환인 경우에 사용 (단일 행 반환 시 사용해도 오류 없음)
-- = : 단일행 반환인 경우에 사용 (결과가 여러 행인 경우에 사용 시 오류 발생)
-- 결과 행을 잘 모르겠으면 IN 사용

-- 고객명 기준으로 정렬
SELECT clientName
FROM client
WHERE clientNo IN (SELECT clientNo
				   FROM bookSale
                   WHERE bookNo IN (SELECT bookNo
									FROM book
                                    WHERE bookName = '안드로이드 프로그래밍'))
ORDER BY clientName;

-- ---------------------------------------------------

-- 다중 행 서브 쿼리 (EXIST, NOT EXISTS)
-- EXISTS : 서브 쿼리의 결과가 행을 반환하면 참이 되는 연산자
-- 도서를 구매한 적이 있는 고객
-- 1. bookSale에 조건에 해당되는 행이 존재하면 참 반환
-- 2. client 테이블에서 이 clientNo에 해당되는 고객의
-- 고객번호, 고객명 출력
SELECT clientNo, clientName
FROM client
WHERE EXISTS (SELECT clientNo
			  FROM bookSale
			  WHERE client.clientNo = bookSale.clientNo);

-- NOT EXISTS
-- 한 번도 주문적이 없는 고객의 고객번호, 고객명 출력
-- 서브 쿼리에 조건에 해당되는 행이 없으면 TRUE 반환
SELECT clientNo, clientName
FROM client
WHERE NOT EXISTS (SELECT clientNo
			     FROM bookSale
			     WHERE client.clientNo = bookSale.clientNo);


-- NULL인 경우 IN과 EXISTS 차이
-- clientHobby에 null 값 포함
 SELECT clientHobby FROM client;
 -- null 2개

-- EXISTS : 서브 쿼리 결과에 NULL 값 포함
-- NULL 값 포함하여 모든 clientNo 출력
SELECT clientHobby
FROM client
WHERE EXISTS (SELECT clientHobby
			  FROM client);
-- NULL과 공백 다 출력 : 9개


-- IN : 서브 쿼리 결과에 NULL 값 포함되지 않음
-- NULL 값을 갖지 않는 clientHobby만 출력
SELECT clientHobby
FROM client
WHERE clientHobby IN (SELECT clientHobby
			          FROM client);
-- NULL 제외, 공백 포함해서 7개

-- ALL : 검색 조건이 서브 쿼리 결과의 모든 값에 만족하면 참이 되는 연산자
-- 2번 고객이 주문한 도서의 최고 주문수량 보다 더 많은 도서를 구매한 고객의
-- 고객번호, 주문번호, 주문수량 출력
-- (2번 고객이 주문한 모든 주문에서 발생한 주문수량 보다 더 크면 됨)
SELECT clientNo, bsNo, bsQty
FROM bookSale
WHERE bsQty > ALL (SELECT bsQty
				   FROM bookSale
                   WHERE clientNo = '2');

-- 5, 2, 2
SELECT bsQty
FROM bookSale
WHERE clientNo = '2';

SELECT bsQty
FROM bookSale;


-- ANY 연산자
-- 2번 고객보다 한 번이라도 더 많은 주문을 한 적이 있는 고객의
-- 고객번호, 주문번호, 주문수량 출력
-- (최소 한 번이라도 크면 됨)
-- 5, 2, 2 세 번 중에한 한 번이라도 크면 (2보다 크게 주문한 것에 해당)
SELECT clientNo, bsNo, bsQty
FROM bookSale
WHERE bsQty > ANY (SELECT bsQty
				   FROM bookSale
				   WHERE clientNo = '2');
-- 2번 고객 자신도 포함

-- 2번 고객 자신을 빼고 출력
SELECT clientNo, bsNo, bsQty
FROM bookSale
WHERE bsQty > ANY (SELECT bsQty
			   FROM bookSale
			   WHERE clientNo = '2')
	 AND clientNo != '2';

-- -------------------------------------------------------------
/*
	연습문제
	1. 호날두(고객명)가 주문한 도서의 총 구매량 출력
	2. ‘종로출판사’에서 출간한 도서를 구매한 적이 있는 고객명 출력
	3. 베컴이 주문한 도서의 최고 주문수량보다 더 많은 도서를 구매한 고객명 출력
	4. 서울에 거주하는 고객에게 판매한 도서의 총 판매량 출력
*/

--  서브 쿼리 연습문제

-- 1. 호날두(고객명)가 주문한 도서의 총 구매량 출력
SELECT SUM(bsQty) "총 구매량"
FROM bookSale
WHERE clientNo = (SELECT clientNo 
				 FROM client
				 WHERE clientName = '호날두');


-- 서브 쿼리 결과가 단일 행인 경우에는 =과 IN 둘 다 사용 가능
SELECT SUM(bsQty) "총 구매량"
FROM bookSale
WHERE clientNo IN (SELECT clientNo 
				  FROM client
				  WHERE clientName = '호날두');


-- 2. '종로출판사'에서 출간한 도서를 구매한 적이 있는 고객명 출력
SELECT clientName
FROM  client
WHERE clientNo IN (SELECT clientNo
				   FROM bookSale
				   WHERE bookNo IN (SELECT bookNo
									FROM book
									WHERE pubNo IN (SELECT pubNo
													FROM publisher
													WHERE pubName = '종로출판사')));

-- 서브 쿼리 결과가 단일 행인 경우에는 = 사용 가능
-- 결과가 다중 행인 SELECT 절에만 IN 사용 가능
SELECT clientName
FROM  client
WHERE clientNo IN (SELECT clientNo
				   FROM bookSale
				   WHERE bookNo IN (SELECT bookNo
									FROM book
									WHERE pubNo = (SELECT pubNo
												   FROM publisher
												   WHERE pubName = '종로출판사')));


-- 서브 쿼리 결과가 다중 행인 경우에는 = 사용할 경우 오류 발생
SELECT clientName
FROM  client
WHERE clientNo = (SELECT clientNo
				  FROM bookSale
				  WHERE bookNo = (SELECT bookNo
								  FROM book
								  WHERE pubNo = (SELECT pubNo
												FROM publisher
												WHERE pubName = '종로출판사')));


-- 3. 베컴이 주문한 도서의 최고 주문수량 보다 더 많은 도서를 구매한 고객명 출력
SELECT clientName
FROM client
WHERE  clientNo IN (SELECT clientNo
					FROM bookSale
					WHERE  bsQty > ALL (SELECT bsQty
										FROM bookSale
										WHERE  clientNo IN (SELECT clientNo
															FROM client
															WHERE clientName = '베컴')));	
-- 또는
SELECT clientName
FROM client
WHERE  clientNo IN (SELECT clientNo
							   FROM bookSale
							   WHERE  bsQty > ALL (SELECT bsQty
												  FROM bookSale
												  WHERE  clientNo = (SELECT clientNo
																	FROM client
																	WHERE  clientName = '베컴')));

-- 또는 MAX() 사용
SELECT clientName
FROM client
WHERE  clientNo IN (SELECT clientNo
							   FROM bookSale
							   WHERE  bsQty >	(SELECT MAX(bsQty)
												FROM bookSale
												WHERE  clientNo IN (SELECT clientNo
																	FROM client
																	WHERE clientName = '베컴')));	

SELECT * FROM bookSale;

-- 참고 : 주문 내역
SELECT bsNo, clientName, bsQty
FROM bookSale, client 
WHERE client.clientNo = bookSale.clientNo;


-- 4. 서울에 거주하는 고객에게 판매한 도서의 총 판매량 출력
-- 1. 서울에 거주하는 고객의 clientNo 찾아서
-- 2. 이 clientNo가 구매한 bsQty 총합
-- IN 사용 
SELECT SUM(bsQty) AS "총 판매량"
FROM bookSale
WHERE clientNo IN (SELECT clientNo
				  FROM client
				  WHERE clientAddress LIKE '%서울%');

-- EXISTS 사용 (결과 동일)
SELECT SUM(bsQty) AS "총 판매량"
FROM bookSale
WHERE EXISTS (SELECT clientNo   
			  FROM client
			  WHERE clientAddress LIKE '%서울%'
					AND client.clientNo = bookSale.clientNo);
								   
--  서울에 거주하는 고객에게 판매한 도서의 판매량
-- JOIN으로 확인
SELECT C.clientNo, C.clientAddress, BS.bsQty
FROM client C
	INNER JOIN bookSale BS ON C.clientNo = BS.clientNo
WHERE C.clientAddress LIKE '%서울%';


-- ------------------------------------------------------------------

-- 스칼라 서브 쿼리
-- 고객별로 고객번호, 고객명,  총 주문수량 출력
SELECT clientNo, (SELECT clientName
				  FROM client
                  WHERE client.clientNo = bookSale.clientNo), SUM(bsQty)
FROM bookSale
GROUP BY clientNo;

-- 스칼라 서브 쿼리 결과 열에 이름 지정
SELECT clientNo, (SELECT clientName
				  FROM client
                  WHERE client.clientNo = bookSale.clientNo) AS "고객명", SUM(bsQty) AS "총 주문수량"
FROM bookSale
GROUP BY clientNo;

-- 인라인 뷰 서브 쿼리 
-- 도서 가격이 25,000원 이상인 도서에 대하여
-- 도서별로 도서명, 도서가격, 총 판매 수량, 총 판매액 출력
-- 총 판매액으로 내림차순 정렬
SELECT bookName, bookPrice, SUM(bsQty) AS 총판매량, SUM(bookPrice * bsQty) AS "총판매액"
FROM (SELECT bookNo, bookName, bookPrice
	  FROM book
      WHERE bookPrice >= 25000) book, bookSale
WHERE book.bookNo = bookSale.bookNo
GROUP BY book.bookNo
ORDER BY 총판매량 DESC;




