DROP DATABASE IF EXISTS board;
CREATE DATABASE board;
SHOW DATABASES;
USE board;

# 게시물 테이블(`article`)을 만듭니다. 게시물은 제목과 내용으로 이루어져 있습니다.
CREATE TABLE article (
	title CHAR(255),
	content TEXT
);

# 잘 추가되었는지 확인
SHOW TABLES;

# article 테이블의 구조 확인
DESC article;

# 제목은 '제목1', 내용은 '내용1'인 데이터 하나 추가 
INSERT INTO article SET title = "제목1", content = "내용1";

# 제목 조회
SELECT title FROM article;

# 내용 조회
SELECT content FROM article;

# 제목, 내용 칼럼 데이터 조회
SELECT title, content FROM article;

# 내용, 제목 칼럼 데이터 조회
SELECT content, title FROM article;

# 모든 데이터 조회
SELECT * FROM article;

# 테이블의 모든 데이터 지우기
DELETE FROM article;

# 제목1, 내용1 데이터 추가
INSERT INTO article SET title = "제목1", content = "내용1";

# 제목2, 내용2 데이터 추가
INSERT INTO article SET title = "제목2", content = "내용2";

# 데이터 조회
SELECT title FROM article;
SELECT content FROM article;
SELECT content, title FROM article;
SELECT * FROM article;

# 제목 데이터 aaa로 수정(모두 수정됨..)
UPDATE article SET title = "aaa";

# `body`가 내용2인 것만 조회
SELECT * FROM article WHERE content = "내용2";

# 내용2만 새로운내용2 로 수정
UPDATE article SET content = "새로운내용2" WHERE content = "내용2";

# 데이터 조회
SELECT * FROM article;

# 데이터 삭제 (모든 데이터가 삭제...)
DELETE FROM article;

# 제목1, 내용1 데이터 추가
INSERT INTO article SET title = "제목1", content = "내용1";

# 제목2, 내용2 데이터 추가
INSERT INTO article SET title = "제목2", content = "내용2";

# 제목이 제목1인 것만 삭제
DELETE FROM article WHERE title = "제목1";