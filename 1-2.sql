DROP DATABASE mall;

CREATE DATABASE mall;

USE mall;

CREATE TABLE t_order(
id INT(5) PRIMARY KEY AUTO_INCREMENT, # 주문번호
userNo INT(5) NOT NULL, # 회원번호
productNo INT(5) NOT NULL # 상품번호
);

CREATE TABLE t_user(
id INT(5) PRIMARY KEY AUTO_INCREMENT, # 회원번호
userId CHAR(200) NOT NULL, # 회원아이디
userPw CHAR(200) NOT NULL, # 회원 비밀번호
userName CHAR(50) NOT NULL, # 회원 이름
addr CHAR(200) NOT NULL # 주소
);

CREATE TABLE t_product(
id INT(5) PRIMARY KEY AUTO_INCREMENT, # 상품 번호
pname CHAR(100) NOT NULL, # 상품 이름
price INT(10) NOT NULL # 상품 가격
);

INSERT INTO t_product
SET pname = '운동화',
price = 1000000;

INSERT INTO t_product
SET pname = '코트',
price = 100000;

INSERT INTO t_product
SET pname = '반바지',
price = 30000;

INSERT INTO t_product
SET pname = '스커트',
price = 15000;

INSERT INTO t_product
SET pname = '코트',
price = 100000;

INSERT INTO t_product
SET pname = '티셔츠',
price = 9000;

INSERT INTO t_product
SET pname = '운동화',
price = 200000;

INSERT INTO t_product
SET pname = '모자',
price = 30000;



INSERT INTO t_user
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
addr = '런던';

INSERT INTO t_user
SET userId = 'user2',
userPw = 'pass2',
userName = '설현',
addr = '서울';

INSERT INTO t_user
SET userId = 'user3',
userPw = 'pass3',
userName = '원빈',
addr = '대전';

INSERT INTO t_user
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
addr = '대구';

INSERT INTO t_user
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
addr = '부산';

INSERT INTO t_user
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
addr = '울산';


INSERT INTO t_order
SET userNo = 1,
productNo = 1;

INSERT INTO t_order
SET userNo = 2,
productNo = 2;

INSERT INTO t_order
SET userNo = 3,
productNo = 3;

INSERT INTO t_order
SET userNo = 4,
productNo = 4;

INSERT INTO t_order
SET userNo = 5,
productNo = 5;

INSERT INTO t_order
SET userNo = 6,
productNo = 6;

INSERT INTO t_order
SET userNo = 6,
productNo = 7;

INSERT INTO t_order
SET userNo = 1,
productNo = 5;

INSERT INTO t_order
SET userNo = 4,
productNo = 4;

INSERT INTO t_order
SET userNo = 1,
productNo = 1;

INSERT INTO t_order
SET userNo = 5,
productNo = 8;


SELECT * 
FROM t_user;

SELECT * 
FROM t_product;

SELECT * 
FROM t_order;


# 1. 손흥민의 주문 개수는? ???
SELECT id
FROM t_user
WHERE userName = "손흥민";

SELECT COUNT(id) 
FROM t_order 
WHERE userNo = "1";


# 2. 손흥민이 산 상품은? ???
SELECT productNo
FROM t_order
WHERE userNo = 1;

SELECT *
FROM t_product
WHERE id IN (1, 5);


# 3. 스커트를 산 사람은? ???
SELECT id
FROM t_product
WHERE pname = "스커트";

SELECT userNo
FROM t_order
WHERE productNo = 4;


SELECT userName
FROM t_user
WHERE id = 4;


# 4. 가장 많이 주문한 사람의 아이디와 이름, 주문개수는? ???
SELECT userNo, COUNT(userNo) AS cnt
FROM t_order
GROUP BY userNo
ORDER BY cnt DESC;

SELECT userName
FROM t_user
WHERE id = 1;


# 5. 소지섭이 사용한 총 금액은? ???
SELECT id
FROM t_user 
WHERE userName = "소지섭";

SELECT productNo
FROM t_order
WHERE userNo = 5;

SELECT SUM(price)
FROM t_product
WHERE id IN (5, 8);

### 데이터 조회를 편하게 하려면 테이블 한개가 좋음 -> 데이터 관리가 X
### 데이터를 효율적으로 관리하기 위해 테이블 분리 -> 데이터 조회가 불편

### join 제공 -> 실제 물리적으로는 분리되어있는 테이블을 논리적으로 이어 붙이는 것


SELECT * 
FROM t_order;
 
SELECT * 
FROM t_user;
               
SELECT *
FROM t_order
INNER JOIN t_user 
ON t_order.userNo = t_user.id;

SELECT *
FROM t_order
INNER JOIN t_product
ON t_order.productNo = t_product.id;


## 테이블 3개도 join 가능? (먼저 나오는 테이블이 왼쪽, 그 다음 나오는 테이블이 오른쪽)
## join 결과를 하나의 테이블로 볼 수 있다.
## join 결과 실제 테이블 X. 가상의 테이블(View) -> update, delete, insert X
SELECT *
FROM t_order
INNER JOIN t_user
ON t_order.userNo = t_user.id
INNER JOIN t_product
ON t_order.productNo = t_product.id;


### join을 해서 문제풀기
# 1. 손흥민의 주문 개수는? ???
SELECT COUNT(pname)
FROM t_order
INNER JOIN t_user
ON t_order.userNo = t_user.id
INNER JOIN t_product
ON t_order.productNo = t_product.id
WHERE userName = "손흥민";


# 2. 손흥민이 산 상품은? ???
SELECT pname, COUNT(pname)
FROM t_order
INNER JOIN t_user
ON t_order.userNo = t_user.id
INNER JOIN t_product
ON t_order.productNo = t_product.id
WHERE userName = "손흥민"
GROUP BY pname;


# 3. 스커트를 산 사람은? ???
SELECT DISTINCT userName
FROM t_order
INNER JOIN t_user
ON t_order.userNo = t_user.id
INNER JOIN t_product
ON t_order.productNo = t_product.id
WHERE pname = "스커트";


# 4. 가장 많이 주문한 사람의 아이디와 이름, 주문개수는? ???
SELECT userId, userName, COUNT(userId) AS cnt
FROM t_order
INNER JOIN t_user
ON t_order.userNo = t_user.id
INNER JOIN t_product
ON t_order.productNo = t_product.id
GROUP BY userName
ORDER BY cnt DESC;


# 5. 소지섭이 사용한 총 금액은? ???
SELECT SUM(price)
FROM t_order
INNER JOIN t_user
ON t_order.userNo = t_user.id
INNER JOIN t_product
ON t_order.productNo = t_product.id
WHERE userName = "소지섭";
