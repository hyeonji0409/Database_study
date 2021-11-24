use sqldb3;

use mysql;
-- 사용자 계정 조회

SELECT * FROM user;

-- 사용자 계정 생성
-- CREATE USER 계정@호스트 identified by
CREATE USER newuser1@'%' identified by '1111';

-- newuser1으로 Connection 생성해서 서버에 연결되는지 확인
-- 스키마 접근 불가

-- 비밀번호 변경
SET PASSWORD  for 'newuser1'@'%' = '1234';
 
-- 계정삭제
DROP USER 'newuser1'@'%';

-- 권한
-- 권한 조회: SHOW GRANTS FOR 사용자계정;
SHOW GRANTS FOR dbuser;

-- 계정생성
CREATE USER newuser1@'%' identified by '1111';

-- newuser1의 권한조회
SHOW GRANTS FOR newuser1;

-- 권한 부여
-- 모든 권한 부여
GRANT ALL PRIVILEGES ON *.* TO newuser1@'%';

-- newuser1의 SELECT 권한 삭제
REVOKE select ON *.* FROM newuser1@'%';

-- newuser1 권한 조회
SHOW GRANTS FOR newuser1;

-- sqldb3의 모든 테이블에 select 권한 부여
GRANT select ON sqldb3.* TO newuser1@'%';



