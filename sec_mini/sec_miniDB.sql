/*

-- 1. system 계정으로 접속 후 mini2 계정 생성
CREATE USER mini2 IDENTIFIED BY mini2;

-- 2. 권한 부여
GRANT CONNECT, RESOURCE, CREATE SESSION TO mini2;

-- 3. 추가 권한 부여
GRANT CREATE TABLE TO mini2;
GRANT CREATE VIEW TO mini2;
GRANT CREATE PROCEDURE TO mini2;
GRANT CREATE SEQUENCE TO mini2;



-- 시퀀스 삭제
DROP SEQUENCE aboard_no_seq;
DROP SEQUENCE scrap_no_seq;
DROP SEQUENCE view_no_seq;
DROP SEQUENCE bid_no_seq;
DROP SEQUENCE sb_no_seq;
DROP SEQUENCE p_no_seq;
DROP SEQUENCE user_no_seq;
DROP SEQUENCE board_no_seq;
DROP SEQUENCE comment_no_seq;
DROP SEQUENCE c_like_no_seq;
DROP SEQUENCE pay_no_seq;
DROP SEQUENCE charge_no_seq;
DROP SEQUENCE category_no_seq;

-- 테이블 삭제
DROP TABLE Comment_Likes;
DROP TABLE Comments;
DROP TABLE Board;
DROP TABLE Cash;
DROP TABLE Views;
DROP TABLE Scrap;
DROP TABLE Aboard;
DROP TABLE Sb;
DROP TABLE Bid;
DROP TABLE Product;
DROP TABLE Category;
DROP TABLE Charge;
DROP TABLE Users;

-- 시퀀스 생성
CREATE SEQUENCE aboard_no_seq;
CREATE SEQUENCE scrap_no_seq;
CREATE SEQUENCE view_no_seq;
CREATE SEQUENCE bid_no_seq;
CREATE SEQUENCE sb_no_seq;
CREATE SEQUENCE p_no_seq;
CREATE SEQUENCE user_no_seq;
CREATE SEQUENCE board_no_seq;
CREATE SEQUENCE comment_no_seq;
CREATE SEQUENCE c_like_no_seq;
CREATE SEQUENCE pay_no_seq;
CREATE SEQUENCE charge_no_seq;
CREATE SEQUENCE category_no_seq;

-- Users 테이블 생성
CREATE TABLE Users (
	userNo   NUMBER 	   	PRIMARY KEY,
	userName VARCHAR2(200) 	NOT NULL,
	userId   VARCHAR2(200) 	NOT NULL UNIQUE,
	userPwd  VARCHAR2(200) 	NOT NULL,
	userAddr VARCHAR2(200) 	NOT NULL,
	phone    VARCHAR2(200) 	NOT NULL UNIQUE,
	nickName VARCHAR2(200) 	NOT NULL UNIQUE,
	point	 NUMBER			default 0,
	createAt TIMESTAMP 	   	default CURRENT_TIMESTAMP
);

select * from users
update users set point=0 where userNo=2

-- Account 테이블 생성 (사용 xxxxxxxxx)
CREATE TABLE Account (
	acNo   	NUMBER	PRIMARY KEY
	userNo 	NUMBER	NOT NULL
	myCash 	NUMBER	DEFAULT 100
	CONSTRAINT fk_account_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) 	 ON DELETE CASCADE
);

-- Charge 테이블 생성
CREATE TABLE Charge (
	chargeNo   	NUMBER 			PRIMARY KEY,
	chargeAmt  	NUMBER 		 	NOT NULL,
	chargeCard 	VARCHAR2(200) 	NOT NULL
);
	
	--- API 기능 추가 못 했을 때 사용
	yesCh char(1) default 'N' check(yesCh IN ('Y','N')),

-- Category 테이블 생성
CREATE TABLE Category (
	categoryNo 		NUMBER 			PRIMARY KEY,
	categoryName 	VARCHAR2(200) 	DEFAULT '기타' UNIQUE
);

-- Product 테이블 생성
CREATE TABLE Product (
	pNo 		NUMBER 			PRIMARY KEY,
	pName 		VARCHAR2(200) 	NOT NULL,
	categoryNo 	NUMBER 			NOT NULL,
	pImage 		varchar2(200) 	DEFAULT 'none.png',
	pDesc 		VARCHAR2(200),
	useAt 		NUMBER 			DEFAULT 5 CHECK(useAt IN (1,2,3,4,5)),
	startPrice 	NUMBER 			NOT NULL,
	pPieces		NUMBER 			DEFAULT 1,
	CONSTRAINT fk_product_categoryNo 	FOREIGN KEY (categoryNo)
	REFERENCES Category(categoryNo) 	ON DELETE CASCADE
);

-- Bid 테이블 생성
CREATE TABLE Bid (
	bidNo 				NUMBER 		PRIMARY KEY,
	pNo 				NUMBER 		NOT NULL,
	userNo 				NUMBER 		NOT NULL,
	entryBidPrice 		NUMBER 		DEFAULT 0,
	remaningTime 		TIMESTAMP  	DEFAULT CURRENT_TIMESTAMP + INTERVAL '1' DAY,
	registrationTime 	TIMESTAMP  	DEFAULT CURRENT_TIMESTAMP,
	autoExtension 		char(1) 	DEFAULT 'N' CHECK(autoExtension IN ('Y','N')),
	earlyTermination 	char(1) 	DEFAULT 'N' CHECK(earlyTermination IN ('Y','N')),
	minBidUnit 			NUMBER 		DEFAULT 1,
	endDate 			TIMESTAMP  	DEFAULT CURRENT_TIMESTAMP + INTERVAL '1' DAY,
	CONSTRAINT 			fk_bid_userNo 	FOREIGN KEY (userNo)
	REFERENCES 			Users(userNo) 	ON DELETE CASCADE,
	CONSTRAINT 			fk_bid_pNo 		FOREIGN KEY (pNo)
	REFERENCES 			Product(pNo) 	ON DELETE CASCADE
);

-- Sb 테이블 생성
CREATE TABLE Sb (
	sbNo 		NUMBER PRIMARY KEY,
	userNo 		NUMBER NOT NULL,
	bidNo 		NUMBER NOT NULL,
	CONSTRAINT 	fk_sb_userNo 	FOREIGN KEY (userNo)
	REFERENCES 	Users(userNo) 	ON DELETE CASCADE,
	CONSTRAINT 	fk_sb_bidNo	 	FOREIGN KEY (bidNo)
	REFERENCES 	Bid(bidNo) 		ON DELETE CASCADE
);

-- Aboard 테이블 생성
CREATE TABLE Aboard (
	auctionBoardNo 	NUMBER 		PRIMARY KEY,
	bidNo 			NUMBER 		NOT NULL,
	createAt 		TIMESTAMP  	DEFAULT CURRENT_TIMESTAMP,
	deleteAt 		char(1) 	DEFAULT 'N' CHECK(deleteAt IN ('Y','N')),
	endAt 			char(1) 	DEFAULT 'N' CHECK(endAt IN ('Y','N')),
	viewCount 		NUMBER 		DEFAULT 0,
	CONSTRAINT 		fk_aboard_bidNo FOREIGN KEY (bidNo)
	REFERENCES		Bid(bidNo) 		ON DELETE CASCADE
);

-- Scrap 테이블 생성
CREATE TABLE Scrap (
	scrapNo 		NUMBER PRIMARY KEY,
	auctionBoardNo	NUMBER NOT NULL,
	userNo 			NUMBER NOT NULL,
	CONSTRAINT fk_scrap_userNo 			FOREIGN KEY (userNo)
	REFERENCES Users(userNo) 			ON DELETE CASCADE,
	CONSTRAINT fk_scrap_auctionBoardNo 	FOREIGN KEY (auctionBoardNo)
	REFERENCES Aboard(auctionBoardNo)	ON DELETE CASCADE
);

-- Views 테이블 생성
CREATE TABLE Views (
	viewNo 			NUMBER PRIMARY KEY,
	auctionBoardNo 	NUMBER NOT NULL,
	userNo 			NUMBER NOT NULL,
	CONSTRAINT fk_views_userNo 			FOREIGN KEY (userNo)
	REFERENCES Users(userNo) 			ON DELETE CASCADE,
	CONSTRAINT fk_views_auctionBoardNo 	FOREIGN KEY (auctionBoardNo)
	REFERENCES Aboard(auctionBoardNo) 	ON DELETE CASCADE
);

-- Cash 테이블 생성
CREATE TABLE Cash (
	payNo 		NUMBER 		PRIMARY KEY,
	acNo 		NUMBER 		NOT NULL,
	bidNo 		NUMBER 		NOT NULL,
	payDate 	TIMESTAMP 	DEFAULT CURRENT_TIMESTAMP,
	backPay 	char(1) 	DEFAULT 'N' CHECK(backPay IN ('Y','N')),
	CONSTRAINT 	fk_cash_acNo 	FOREIGN KEY (acNo)
	REFERENCES 	Account(acNo) 	ON DELETE CASCADE,
	CONSTRAINT 	fk_cash_bidNo 	FOREIGN KEY (bidNo)
	REFERENCES 	Bid(bidNo) 		ON DELETE CASCADE
);

-- Board 테이블 생성
CREATE TABLE Board (
	boardNo 		NUMBER 			PRIMARY KEY,
	userNo 			NUMBER 			NOT NULL,
	title 			VARCHAR2(200) 	NOT NULL,
	boardContent 	VARCHAR2(2000) 	NOT NULL,
	createAt 		TIMESTAMP 		DEFAULT CURRENT_TIMESTAMP,
	updateAt 		TIMESTAMP,
	CONSTRAINT fk_board_userNo 	FOREIGN KEY (userNo)
	REFERENCES Users(userNo) 	ON DELETE CASCADE
);

-- Comments 테이블 생성
CREATE TABLE Comments (
	commentNo 		NUMBER 			PRIMARY KEY,
	boardNo 		NUMBER 			NOT NULL,
	userNo 			NUMBER 			NOT NULL,
	commentContent 	VARCHAR2(2000) 	NOT NULL,
	createAt 		TIMESTAMP 		DEFAULT CURRENT_TIMESTAMP,
	updateAt 		TIMESTAMP,
	CONSTRAINT fk_comments_userNo 	FOREIGN KEY (userNo)
	REFERENCES Users(userNo) 		ON DELETE CASCADE,
	CONSTRAINT fk_comments_boardNo 	FOREIGN KEY (boardNo)
	REFERENCES Board(boardNo) 		ON DELETE CASCADE
);

-- Comment_Likes 테이블 생성
CREATE TABLE Comment_Likes (
	c_likeNo 	NUMBER 		PRIMARY KEY,
	commentNo 	NUMBER 		NOT NULL,
	userNo 		NUMBER 		NOT NULL,
	CONSTRAINT fk_commentlike_userNo 	FOREIGN KEY (userNo)
	REFERENCES Users(userNo) 			ON DELETE CASCADE,
	CONSTRAINT fk_commentlike_commentNo FOREIGN KEY (commentNo)
	REFERENCES Comments(commentNo) 		ON DELETE CASCADE
);

delete from users where userNo=2
insert into Users values(1, '관리자', 'admin', 'admin', '비공개', '비공개', '관리자', default, default);
insert into Users values(2, '직원', 'one12', 'one12', '비공개', '010-123-123', '직원', default, default);

select * from users where userId = 'admin';

-- 카테고리 테이블의 더미 데이터
insert into Category values(category_no_seq.nextVal, '자동차|중고차·신차|오토바이');
insert into Category values(category_no_seq.nextVal, '패션');
insert into Category values(category_no_seq.nextVal, '액세서리|시계');
insert into Category values(category_no_seq.nextVal, '스포츠|레저');
insert into Category values(category_no_seq.nextVal, '가전');
insert into Category values(category_no_seq.nextVal, '카메라');
insert into Category values(category_no_seq.nextVal, '컴퓨터');
insert into Category values(category_no_seq.nextVal, '장난감');
insert into Category values(category_no_seq.nextVal, '게임');
insert into Category values(category_no_seq.nextVal, '문화·취미');
insert into Category values(category_no_seq.nextVal, '골동품|컬렉션');
insert into Category values(category_no_seq.nextVal, '책|잡지|만화');
insert into Category values(category_no_seq.nextVal, '음악');
insert into Category values(category_no_seq.nextVal, '영화|드라마|애니메이션');
insert into Category values(category_no_seq.nextVal, '인테리어|DIY');
insert into Category values(category_no_seq.nextVal, '사무 용품');
insert into Category values(category_no_seq.nextVal, '꽃|원예|농업');
insert into Category values(category_no_seq.nextVal, '뷰티·건강');
insert into Category values(category_no_seq.nextVal, '아기 용품');
insert into Category values(category_no_seq.nextVal, '음식·음료');
insert into Category values(category_no_seq.nextVal, '애완동물·생물');
insert into Category values(category_no_seq.nextVal, '티켓|숙박');
insert into Category values(category_no_seq.nextVal, '부동산');
insert into Category values(category_no_seq.nextVal, '기타');

-- 상품 테이블의 더미 데이터
INSERT INTO Product (pNo, pName, categoryNo, pImage, pDesc, useAt, startPrice, pPieces)
VALUES (1, 'Product A', 1, 'product_a.png', 'Description of Product A', 3, 10000, 10);
INSERT INTO Product (pNo, pName, categoryNo, pImage, pDesc, useAt, startPrice, pPieces)
VALUES (2, 'Product B', 2, 'product_b.png', 'Description of Product B', 2, 15000, 5);
INSERT INTO Product (pNo, pName, categoryNo, pImage, pDesc, useAt, startPrice, pPieces)
VALUES (3, 'Product C', 1, 'product_c.png', 'Description of Product C', 4, 12000, 8);
INSERT INTO Product (pNo, pName, categoryNo, pImage, pDesc, useAt, startPrice, pPieces)
VALUES (4, 'Product D', 3, 'product_d.png', 'Description of Product D', 5, 18000, 3);

-- 입찰 테이블의 더미 데이터
INSERT INTO Bid (bidNo, pNo, userNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate)
VALUES (1, 1, 1, 8000, CURRENT_TIMESTAMP + INTERVAL '3' DAY, CURRENT_TIMESTAMP, 'Y', 'N', 500, CURRENT_TIMESTAMP + INTERVAL '3' DAY);
INSERT INTO Bid (bidNo, pNo, userNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate)
VALUES (2, 2, 1, 12000, CURRENT_TIMESTAMP + INTERVAL '2' DAY, CURRENT_TIMESTAMP, 'N', 'Y', 1000, CURRENT_TIMESTAMP + INTERVAL '2' DAY);
INSERT INTO Bid (bidNo, pNo, userNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate)
VALUES (3, 3, 1, 9000, CURRENT_TIMESTAMP + INTERVAL '4' DAY, CURRENT_TIMESTAMP, 'N', 'N', 700, CURRENT_TIMESTAMP + INTERVAL '4' DAY);
INSERT INTO Bid (bidNo, pNo, userNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate)
VALUES (4, 4, 1, 15000, CURRENT_TIMESTAMP + INTERVAL '1' DAY, CURRENT_TIMESTAMP, 'Y', 'Y', 2000, CURRENT_TIMESTAMP + INTERVAL '1' DAY);

-- 경매 테이블의 더미 데이터
INSERT INTO Aboard (auctionBoardNo, bidNo, createAt, deleteAt, endAt, viewCount)
VALUES (1, 1, CURRENT_TIMESTAMP, 'N', 'N', 100);
INSERT INTO Aboard (auctionBoardNo, bidNo, createAt, deleteAt, endAt, viewCount)
VALUES (2, 2, CURRENT_TIMESTAMP, 'N', 'Y', 50);
INSERT INTO Aboard (auctionBoardNo, bidNo, createAt, deleteAt, endAt, viewCount)
VALUES (3, 3, CURRENT_TIMESTAMP, 'N', 'N', 80);
INSERT INTO Aboard (auctionBoardNo, bidNo, createAt, deleteAt, endAt, viewCount)
VALUES (4, 4, CURRENT_TIMESTAMP, 'N', 'Y', 120);

select * from category

CREATE VIEW AuctionView AS
SELECT DISTINCT
    a.auctionBoardNo,
    a.bidNo,
    b.entryBidPrice,
    b.remaningTime,
    b.registrationTime,
    b.autoExtension,
    b.earlyTermination,
    b.minBidUnit,
    b.endDate,
    p.pNo,
    p.pName,
    p.categoryNo,
    p.pImage,
    p.pDesc,
    p.useAt,
    p.startPrice,
    p.pPieces,
    c.categoryName
FROM Aboard a
INNER JOIN Bid b ON a.bidNo = b.bidNo
INNER JOIN Product p ON b.pNo = p.pNo
INNER JOIN Category c ON p.categoryNo = c.categoryNo;

select * from AuctionView

CREATE VIEW Product_Total AS 
	SELECT *
	FROM Product p
	INNER JOIN Category c ON p.categoryNo = c.categoryNo;

*/