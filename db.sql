# 데이터베이스 생성
DROP DATABASE IF EXISTS myshop;
CREATE DATABASE myshop;
USE myshop;

# ============================================== product

# 제품 테이블 생성
CREATE TABLE product (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    productName CHAR(100) NOT NULL,
    `body` TEXT NOT NULL,
    color TEXT NOT NULL,
    size TEXT NOT NULL,
    price INT(10) NOT NULL,
    fee INT(10) NOT NULL,
    blindStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '블라인드여부',
    blindDate DATETIME COMMENT '블라인드날짜',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부',
    delDate DATETIME COMMENT '삭제날짜'
);

# 제품 테이블에 boardId 칼럼 추가
ALTER TABLE product ADD COLUMN categoryId INT(10) UNSIGNED NOT NULL AFTER updateDate;

# 제품 테이블에 회원번호 칼럼 추가
ALTER TABLE product ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

INSERT INTO product
SET regDate = NOW(),
updateDate = NOW(),
categoryId = 1,
memberId = 1,
productName = "조끼_10",
color = "악세사리",
price = 10000,
`body` = "악세사리",
 fee = 2500;

# ============================================== article

# 게시물 테이블 생성
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL,
    blindStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '블라인드여부',
    blindDate DATETIME COMMENT '블라인드날짜',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부',
    delDate DATETIME COMMENT '삭제날짜'
);

# 게시물, 테스트 데이터 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 1,
memberId = 1,
title = "제목1 입니다.",
`body` = "내용1 입니다.";

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = "제목2 입니다.",
`body` = "내용2 입니다.";

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = "제목3 입니다.",
`body` = "내용3 입니다.";

# 게시물 테이블에 boardId 칼럼 추가
ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER updateDate;

# 게시물 테이블에 회원번호 칼럼 추가
ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

# 기존 게시물의 작성자를 회원1로 지정
UPDATE article
SET memberId = 1
WHERE memberId = 0;

# 테스트 게시물 생성, memberId = 2, 제목, 내용 랜덤
INSERT INTO article
(regDate, updateDate, memberId, title, `body`, boardId)
SELECT NOW(), NOW(), 1, CONCAT('제목_', FLOOR(RAND() * 1000) + 1), CONCAT('내용_', FLOOR(RAND() * 1000) + 1), 2
FROM article;

# 게시물 테이블에 boardId  랜덤 번호 생성
UPDATE article
SET boardId = FLOOR(RAND() * 2) + 1
WHERE boardId = 0;
# ============================================== `member`

# 회원 테이블 생성
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    loginId CHAR(30) NOT NULL,
    loginPw VARCHAR(100) NOT NULL,
    `name` CHAR(30) NOT NULL,
    `email` CHAR(100) NOT NULL,
    `cellphoneNo` CHAR(20) NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴여부',
    delDate DATETIME COMMENT '탈퇴날짜'
);

# 로그인 ID로 검색했을 때
ALTER TABLE `member` ADD UNIQUE INDEX (`loginId`);

# 회원, 테스트 데이터 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = "adm001",
loginPw = "adm001",
`name` = "adm001",
cellphoneNo = "01012341234",
email = "bhbh89900@gmail.com";

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = "user001",
loginPw = "user001",
`name` = "user001",
cellphoneNo = "01077778888",
email = "bhbh89900@gmail.com";

# 멤버 테이블에 authKey 칼럼 추가
ALTER TABLE `member` ADD COLUMN authKey CHAR(80) NOT NULL AFTER loginPw;

# 기존 회원의 authKey 데이터 채우기
UPDATE `member`
SET authKey = 'authKey1__1'
WHERE id = 1;

UPDATE `member`
SET authKey = 'authKey1__2'
WHERE id = 2;

# authKey 칼럼에 유니크 인덱스 추가
ALTER TABLE `member` ADD UNIQUE INDEX (`authKey`);

# 로그인비번 칼럼의 길이를 100으로 늘림
ALTER TABLE `member` MODIFY COLUMN loginPw VARCHAR(100) NOT NULL;

# 기존 회원의 비밀번호를 암호화 해서 저장
UPDATE `member`
SET loginPw = SHA2(loginPw, 256);

# 회원 테이블에 권한레벨 필드 추가
ALTER TABLE `member`
ADD COLUMN `authLevel` SMALLINT(2) UNSIGNED
DEFAULT 3 NOT NULL COMMENT '(3=일반,7=관리자)' AFTER `loginPw`; 

# 1번 회원을 관리자로 지정한다.
UPDATE `member`
SET authLevel = 7
WHERE id = 1;

# 1번 회원을 관리자로 지정한다.
UPDATE `member`
SET authLevel = 7
WHERE id = 2;

# ============================================== board

# 게시판 별 리스팅(board) 테이블 생성
CREATE TABLE board (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(20) UNIQUE NOT NULL,
    `name` CHAR(20) UNIQUE NOT NULL,
    blindStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '블라인드여부',
    blindDate DATETIME COMMENT '블라인드날짜',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부',
    delDate DATETIME COMMENT '삭제날짜'
);

# 게시판 별 리스팅 테스트 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = "notice",
`name` = "공지사항";

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = "free",
`name` = "자유";

# 게시판 테이블에 회원번호 칼럼 추가
ALTER TABLE board ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

# 게시판 memberId 1로 하기
UPDATE `board`
SET memberId = 1
WHERE memberId = 0;

# ============================================== reply

# 댓글 테이블 생성
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    relId INT(10) UNSIGNED NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    `body` TEXT NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부',
    delDate DATETIME COMMENT '삭제날짜',
    blindStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '블라인드여부',
    blindDate DATETIME COMMENT '블라인드날짜'
);

# 댓글 테스트 데이터 생성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
articleId = 1,
memberId= 1,
`body` = "댓글1 입니다.";

INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
articleId = 2,
memberId= 1,
`body` = "댓글1 입니다.";

UPDATE reply
SET `body` = "새로운 댓글입니다."
WHERE articleId = 1;

# 게시물 전용 댓글에서 범용 댓글로 바꾸기 위해 relTypeCode 추가
ALTER TABLE reply ADD COLUMN `relTypeCode` CHAR(20) NOT NULL AFTER updateDate;

# 고속 검색을 위해서 인덱스 걸기
ALTER TABLE reply ADD KEY (relTypeCode, relId); 

# 현재는 게시물 댓글 밖에 없기 때문에 모든 행의 relTypeCode 값을 article 로 지정
UPDATE reply
SET relTypeCode = 'article'
WHERE relTypeCode = '';

# ============================================== getFile

# 파일 테이블 추가
CREATE TABLE genFile (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, # 번호
  regDate DATETIME DEFAULT NULL, # 작성날짜
  updateDate DATETIME DEFAULT NULL, # 갱신날짜
  delDate DATETIME DEFAULT NULL, # 삭제날짜
  delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0, # 삭제상태(0:미삭제,1:삭제)
  relTypeCode CHAR(50) NOT NULL, # 관련 데이터 타입(article, member)
  relId INT(10) UNSIGNED NOT NULL, # 관련 데이터 번호
  originFileName VARCHAR(100) NOT NULL, # 업로드 당시의 파일이름
  fileExt CHAR(10) NOT NULL, # 확장자
  typeCode CHAR(20) NOT NULL, # 종류코드 (common)
  type2Code CHAR(20) NOT NULL, # 종류2코드 (attatchment)
  fileSize INT(10) UNSIGNED NOT NULL, # 파일의 사이즈
  fileExtTypeCode CHAR(10) NOT NULL, # 파일규격코드(img, video)
  fileExtType2Code CHAR(10) NOT NULL, # 파일규격2코드(jpg, mp4)
  fileNo SMALLINT(2) UNSIGNED NOT NULL, # 파일번호 (1)
  fileDir CHAR(20) NOT NULL, # 파일이 저장되는 폴더명
  PRIMARY KEY (id),
  KEY relId (relId,relTypeCode,typeCode,type2Code,fileNo)
);

# ============================================== like

# 좋아요 테이블 생성
CREATE TABLE `like` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME DEFAULT NULL, # 삭제날짜
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0, # 삭제상태(0:미삭제,1:삭제)
    relTypeCode CHAR(20) NOT NULL,
    relId INT(10) UNSIGNED NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL
);

# 고속 검색을 위해서 인덱스 걸기
ALTER TABLE `like` ADD KEY (relTypeCode, relId);

# 좋아요 테이블에 `like` 칼럼 추가
ALTER TABLE `like` ADD COLUMN `like` CHAR(20) NOT NULL AFTER memberId;

# ============================================== category

# 카테고리 별 리스팅(category) 테이블 생성
CREATE TABLE category (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(20) UNIQUE NOT NULL,
    categoryName CHAR(20) UNIQUE NOT NULL,
    blindStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '블라인드여부',
    blindDate DATETIME COMMENT '블라인드날짜',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부',
    delDate DATETIME COMMENT '삭제날짜'
);

# 카테고리 테이블에 회원번호 칼럼 추가
ALTER TABLE category ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

# 게시판 별 리스팅 테스트 생성
INSERT INTO category
SET regDate = NOW(),
updateDate = NOW(),
`code` = "101",
categoryName = "상의";

INSERT INTO category
SET regDate = NOW(),
updateDate = NOW(),
`code` = "102",
categoryName = "하의";

# 게시판 별 리스팅 테스트 생성
INSERT INTO category
SET regDate = NOW(),
updateDate = NOW(),
`code` = "103",
categoryName = "가방";

INSERT INTO category
SET regDate = NOW(),
updateDate = NOW(),
`code` = "104",
categoryName = "악세사리";


# 카테고리 memberId 1로 하기
UPDATE category
SET memberId = 1
WHERE memberId = 0;

# ============================================== order

# 주문 별 리스팅(order) 테이블 생성
CREATE TABLE `order` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    orderName CHAR(80) NOT NULL,
    cellphoneNo CHAR(20) NOT NULL,
    post TEXT NOT NULL,
    address TEXT NOT NULL,
    detailAddress TEXT NOT NULL,
    email CHAR(100) NOT NULL,
    totalPayment INT(10) NOT NULL,
    blindStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '블라인드여부',
    blindDate DATETIME COMMENT '블라인드날짜',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부',
    delDate DATETIME COMMENT '삭제날짜'
);

# 주문 테이블에 productId 칼럼 추가
ALTER TABLE `order` ADD COLUMN productId INT(10) UNSIGNED NOT NULL AFTER updateDate;

# 주문 테이블에 categoryId 칼럼 추가
ALTER TABLE `order` ADD COLUMN categoryId INT(10) UNSIGNED NOT NULL AFTER productId;

# 주문 테이블에 memberId 칼럼 추가
ALTER TABLE `order` ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER categoryId;

# 주문 테이블에 결제 권한레벨 필드 추가
ALTER TABLE `order`
ADD COLUMN payment TINYINT(1)  UNSIGNED
NOT NULL COMMENT '(1=무통장입금)' AFTER email; 

# 주문 테이블에  결제 상태 권한레벨 필드 추가
ALTER TABLE `order`
ADD COLUMN paymentStatus TINYINT(1)  UNSIGNED
COMMENT '(1=입금완료 2=결제완료)' AFTER totalPayment; 

# 주문 테이블에 categoryId 칼럼 추가
ALTER TABLE `order` ADD COLUMN paymentDate DATETIME AFTER paymentStatus;

INSERT INTO `order`
SET regDate = NOW(),
updateDate = NOW(),
productId=1,
categoryId=1,
memberId=1,
orderName ="김철수",
cellphoneNo="01012341234",
address="서울특별시 ㅇㅇ동 ㄷㄷ아파트",
email="sss@s22.com",
payment =1,
totalPayment =12000;

SELECT * FROM `order`;
# ============================================== Delivery

# 배송 리스팅(Delivery) 테이블 생성
CREATE TABLE delivery (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    company CHAR(20),
    waybillNum CHAR(80),
    blindStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '블라인드여부',
    blindDate DATETIME COMMENT '블라인드날짜',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부',
    delDate DATETIME COMMENT '삭제날짜'
);

# 배송 테이블에 productId 칼럼 추가
ALTER TABLE delivery ADD COLUMN orderId INT(10) UNSIGNED NOT NULL AFTER updateDate;

# 배송 테이블에 categoryId 칼럼 추가
ALTER TABLE delivery ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER orderId;

# 배송 테이블에 권한레벨 필드 추가
ALTER TABLE delivery
ADD COLUMN deliveryState  TINYINT(1) UNSIGNED
DEFAULT 1 NOT NULL COMMENT '(1=발송, 2=배송완료)' AFTER waybillNum; 

select * from delivery;

INSERT INTO
delivery
SET regDate = NOW(),
updateDate = NOW(),
orderId = 1,
memberId = 1,
company = "대한통운",
waybillNum = "1234123415";

# ============================================== Cart

# 장바구니 리스팅(Cart) 테이블 생성
CREATE TABLE cart (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME DEFAULT NULL, # 삭제날짜
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0, # 삭제상태(0:미삭제,1:삭제)
    relTypeCode CHAR(20) NOT NULL,
    relId INT(10) UNSIGNED NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL
);

# ============================================== attr

# 부가정보테이블
# 댓글 테이블 추가
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(20) NOT NULL,
    `relId` INT(10) UNSIGNED NOT NULL,
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(70) NOT NULL,
    `value` TEXT NOT NULL
);

# attr 유니크 인덱스 걸기
## 중복변수 생성금지
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`);

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`);

# attr에 만료날짜 추가
ALTER TABLE `attr` ADD COLUMN `expireDate` DATETIME NULL AFTER `value`;

# 임시로 만들어진 회원은, 비번변경할 필요가 없도록 설정
INSERT INTO attr (
    regDate,
	updateDate,
	relTypeCode,
	relId,
	typeCode,
	type2Code,
	`value`,
	expireDate
)

SELECT NOW(), NOW(), 'member', id, 'extra', 'needToChangePassword', 0, NULL
FROM `member`
