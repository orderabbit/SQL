# ==== DB 초기화 ====
DROP DATABASE IF EXISTS board;

CREATE DATABASE board;

USE board;

CREATE TABLE article(
  title VARCHAR(200),
  content TEXT
);

# ======================================================

# board DB 선택
USE board;

# 게시물 조회
SELECT * FROM article;

# article 테이블 데이터 삭제
DELETE FROM article;

# 제목3, 내용3 데이터 두개 추가
INSERT INTO article SET title = "제목3", content = "내용3";
INSERT INTO article SET title = "제목3", content = "내용3";

# 제목3인 게시물 중 두번째 것만 제목을 새제목3으로 수정 (게시물 구분 안됨)
UPDATE article SET title = "새제목3" WHERE title = "제목3";

# 테이블 구조 확인
DESC article;


## key -> 중복 X(Unique), 반드시 데이터가 있어야 함.(비어 있음 X -> not NULL)
## 후보키 -> 여러 속성 중에서 키가 될 수 있는 속성
### 주민번호, 일련번호, 사번, 학번 .....
#### 전화번호 -> 후보키???, 주민번호 -> 후보키??? 호적 등록 안된 사람
### 쉬운 방법 -> 키를 직접 만들면 된다.(문자 조합, 숫자) 숫자가 편함. 1씩 증가시키면 중복 X


# 테이블 구조 수정 - 칼럼 추가(ADD), 기존 칼럼 삭제(DROP), 기존 칼럼 내용 변경(MODIFY)
# 식별용 데이터를 저장할 id 컬럼 추가
ALTER TABLE article ADD id INT;

# 데이터 조회(새로 생긴 id 칼럼의 값은 NULL)
SELECT * FROM article;

# 기존 데이터 중 1개만 id를 2로 변경 -> 방법 X

# 가장 위에 있는 데이터만 조회
SELECT * FROM article LIMIT 1;

# 가장 위에 있는 데이터의 id를 2로 수정
UPDATE article SET id = 2 LIMIT 1;
 
# 데이터 조회
SELECT * FROM article;

# 2번 게시물만 조회
SELECT * FROM article WHERE id = 2;

# 2번 게시물이 아닌 게시물 조회 (안나옴.. 값이 null인 것은 필터 대상이 안됨)
SELECT * FROM article WHERE id = NULL;
SELECT * FROM article WHERE id != 2;

# NULL인 데이터를 필터 검색
SELECT * FROM article WHERE id IS NULL; # NULL인 것을 찾을 때
SELECT * FROM article WHERE id IS NOT NULL; # NULL이 아닌 것을 찾을 때

# id가 null인 행 찾아서 id값을 1로 수정.
UPDATE article SET id = 1 WHERE id IS NULL;

# 데이터 조회
SELECT * FROM article;


#==============================================================================================


# id가 2, 제목은 제목4, 내용은 내용4인  게시물데이터 추가 (id 2인 값이 존재하지만 중복등록 됨.)
INSERT INTO article SET id = 2, title = "제목4", content = "내용4";

# 데이터 조회
SELECT * FROM article;

# id 컬럼에 unique, not null 제약 걸기(이미 중복되는 데이터가 있기 때문에 제약이 걸리지 않음)
## not null -> null 허용 X
## unique -> 중복 허용 X
## auto_increment -> 자동 증가
## default -> 기본값 설정

ALTER TABLE article MODIFY id INT UNIQUE NOT NULL;

# 2번 게시물, 데이터 삭제 => DELETE
DELETE FROM article WHERE id = 2 AND title = "제목4";

# 다시 id 컬럼에 unique, not null 제약 걸기
ALTER TABLE article MODIFY id INT UNIQUE NOT NULL;

# 구조 확인
DESC article;

# id 없이 게시물 하나 추가. 제목1, 내용1 (id가 not null이라 0으로 바뀌어서 들어감)
INSERT INTO article SET title = "제목1", content = "내용2";

# id 없이 게시물 하나 추가. 제목2, 내용2 (0이 이미 존재하므로 등록이 안됨)
INSERT INTO article SET title = "제목2", content = "내용2";

# id 컬럼에 자동증가제약 추가
ALTER TABLE article MODIFY id INT AUTO_INCREMENT;

# 구조 확인
DESC article;

# 데이터 삭제
DELETE FROM article;

# id 컬럼에 자동증가제약 다시 시도
ALTER TABLE article MODIFY id INT AUTO_INCREMENT;

# id 없이 게시물 하나 추가. 제목1, 내용1
INSERT INTO article SET title = "제목1", content = "내용1";

# id 없이 게시물 하나 추가. 제목2, 내용2
INSERT INTO article SET title = "제목2", content = "내용2";

# 데이터 확인
SELECT * FROM article;

#==========================================================

## 제약은 테이블 생성할 때 미리 설계해놓고 반영하는 것이 일반적.

## 기존의 article 테이블 삭제
DROP TABLE article;

## article 테이블 생성 -> id(primarykey), title, content. id는 자동증가
CREATE TABLE article(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title CHAR(200) NOT NULL,
	content TEXT NOT NULL
);

DESC article;