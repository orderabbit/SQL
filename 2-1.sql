## 인덱스(색인)

DROP DATABASE IF EXISTS t1;
## 새로운 데이터 베이스 생성

CREATE DATABASE t1;

## t1데이터 베이스 선택

USE t1;

## 테이블 생성

CREATE TABLE t_member (
id INT PRIMARY KEY AUTO_INCREMENT,
loginId CHAR(50) NOT NULL,
loginPw CHAR(200) NOT NULL,
nickname CHAR(50) NOT NULL
);

## 회원 생성

INSERT INTO t_member
SET loginId = 'user1',
loginPw = 'pass1',
nickname = '홍길동';

INSERT INTO t_member
SET loginId = 'user2',
loginPw = 'pass2',
nickname = '이순신';

## 회원을 많이 만들것.

SELECT \*
FROM t_member;

## insert values로 회원 생성

INSERT INTO t_member (loginId, loginPw, nickname)
VALUES ('user3', 'pass3', '황진이');

## 랜덤 회원 생성

SELECT SUBSTR(UUID(), 1, 7), 'pass4', '아무나'; FROM t_member;

## insert와 select로 회원 생성

INSERT INTO t_member (loginId, loginPw, nickname)
SELECT SUBSTR(UUID(), 1, 7), 'pass4', '아무나' FROM t_member;

SELECT COUNT(\*)
FROM t_member;

# user1 검색. 2초 조금 넘게 걸림

SELECT SQL_NO_CACHE \*
FROM t_member
WHERE loginId = 'user1';

# loginId에 인덱스 생성

CREATE INDEX loginId_idx ON t_member(loginId);

# 인덱스 생성 되었는지 확인

DESC t_member;

# 인덱스가 걸린 컬럼으로 검색, 인덱스가 걸려있지 않은 컬럼으로 검색

SELECT SQL_NO_CACHE \*
FROM t_member
WHERE loginId = 'user1'; # 0.002초

SELECT SQL_NO_CACHE \*
FROM t_member
WHERE nickname = '홍길동'; # 1.15초

# 검색할 때 자주 사용되는 컬럼에 인덱스를 건다.

# 검색 -> 조인 = 비슷한 메커니즘. 인덱스 컬럼으로 조인하면 조인이 빠름.

# 인덱스 -> 테이블 복사(2개가 생김). 생성, 수정, 삭제가 2배 일어남.

# sql 실행 계획 확인

EXPLAIN SELECT SQL_NO_CACHE \*
FROM t_member
WHERE nickname = '홍길동'; # 1.15초

EXPLAIN SELECT SQL_NO_CACHE \*
FROM t_member
WHERE loginId = 'user1'; # 0.002초

## 중복 데이터가 많은 컬럼에는 인덱스는 적절하지 않다.
## 인덱스를 사용하면 빠르긴 하지만 그만큼 추가적인 저장 용량이 필요하고 삽입, 수정, 삭제 연산이 늘어난다.
## pk(primarykey)는 인덱스가 만들어짐.
