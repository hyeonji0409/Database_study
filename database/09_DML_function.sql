use sqldb3;

SELECT clientNo, ROUND(AVG(bookPrice * bsQty)) AS "평균 주문액",
				 ROUND(AVG(bookPrice * bsQty),0) AS "1의 자리까지 출력",
				 ROUND(AVG(bookPrice * bsQty),-1) AS "10의 자리까지 출력",
				 ROUND(AVG(bookPrice * bsQty),-2) AS "100의 자리까지 출력",
				 ROUND(AVG(bookPrice * bsQty),-3) AS "1000의 자리까지 출력"
FROM book, bookSale
WHERE book.bookNo = bookSale.bookNo
GROUP BY clientNo;


-- 고객별 평균 주문액을 출력
SELECT clientNo, ROUND(AVG(bookPrice * bsQty)) AS "평균 주문액",
				 ROUND(AVG(bookPrice * bsQty), 0) AS "1의 자리까지 출력", 
                 ROUND(AVG(bookPrice * bsQty), -1) AS "10의 자리까지 출력", 
                 ROUND(AVG(bookPrice * bsQty), -2) AS "100의 자리까지 출력", 
                 ROUND(AVG(bookPrice * bsQty), -3) AS "1000의 자리까지 출력"
FROM book, bookSale
WHERE book.bookNo = bookSale.bookNo
GROUP BY clientNo;

SELECT bookPrice,
	RANK() OVER (ORDER BY bookPrice DESC) "RANK",
    DENSE_RANK() OVER (ORDER BY bookPrice DESC) "DENSE_RANK",
    ROW_NUMBER() OVER (ORDER BY bookPrice DESC) "ROW_NUMBER"
FROM book;

-- CHAR_LENGTH() : 문자열 길이(글자 수)를 반환하는 함수
-- LENGTH() : 바이트 수
-- '서울 출판사'에서 출간한 도서의 도서명과 바이트 수, 문자열 길이, 출판사명 출력
SELECT B.bookName AS "도서명",
	   LENGTH(B.bookName) AS "바이트 수",
       CHAR_LENGTH(B.bookName) AS "길이",
       P.pubName AS "출판사"
FROM book B
	INNER JOIN publisher P ON B.pubNo = P.pubNo
WHERE P.pubName = '서울 출판사';


-- SUBSTR()

-- 도서 테이블의 '저자' 열에서 성만 출력
SELECT SUBSTR(bookAuthor, 1, 1) AS "성"
FROM book;

-- 도서 테이블의 '저자' 열에서 이름만 출력
SELECT SUBSTR(bookAuthor, 2, 2) AS "이름"
FROM book;


-- 현재 날짜와 시간 출력
SELECT DATE(NOW()), TIME(NOW());

-- 날짜에서 연, 월, 일 추출
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE());

-- 시간에서 시, 분, 초, microsecond 출력
SELECT HOUR(CURTIME()), MINUTE(CURTIME()), SECOND(CURTIME()), MICROSECOND(CURTIME());

CREATE TABLE movie (
	movieId VARCHAR(10) NOT NULL PRIMARY KEY,
    movieTitle VARCHAR(30),
	movieDirector VARCHAR(20),
    movieStar VARCHAR(20),
    movieScript LONGTEXT,
    movieFilm LONGBLOB
);

INSERT INTO movie 
	   VALUES ('1', '쉰드러 리스트', '스필버그', '리암 니슨',
			   LOAD_FILE('D:/Full_Stackc_Study/dbWorkspace/database/movies/Schindler.txt'),
               LOAD_FILE('D:/Full_Stackc_Study/dbWorkspace/database/movies/Schindler.mp4'));

SHOW variables LIKE 'max_allowed_packet';

SHOW variables LIKE 'secure_file_priv';

SELECT * FROM sqldb3.movie;


-- LONGTEXT 타입의 영화 대본 데이터를 텍스트 파일로 내보내기
SELECT movieScript 
FROM movie 
WHERE movieId = '1'
INTO OUTFILE 'D:/Full_Stackc_Study/dbWorkspace/database/movies/Schindler_out.txt'
LINES TERMINATED BY '\\n';

-- 동영상 파일(바이너리 파일)로 내보내기
SELECT movieFilm FROM movie WHERE movieId = '1'
INTO OUTFILE 'D:/Full_Stackc_Study/dbWorkspace/database/movies/Schindler_out.mp4';

-- 도서 테이블의 모든 데이터를 텍스트 파일로 내보내기
SELECT * FROM book
INTO OUTFILE 'D:/Full_Stackc_Study/dbWorkspace/database/movies/book_out.txt';
