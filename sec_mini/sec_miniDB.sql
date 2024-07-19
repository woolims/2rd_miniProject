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
DROP SEQUENCE user_no_seq_seq;
DROP SEQUENCE board_no_seq;
DROP SEQUENCE comment_no_seq;
DROP SEQUENCE c_like_no_seq;
DROP SEQUENCE ac_no_seq;
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
DROP TABLE Account;
DROP TABLE Users;

-- 시퀀스 생성
CREATE SEQUENCE aboard_no_seq;
CREATE SEQUENCE scrap_no_seq;
CREATE SEQUENCE view_no_seq;
CREATE SEQUENCE bid_no_seq;
CREATE SEQUENCE sb_no_seq;
CREATE SEQUENCE p_no_seq;
CREATE SEQUENCE user_no_seq_seq;
CREATE SEQUENCE board_no_seq;
CREATE SEQUENCE comment_no_seq;
CREATE SEQUENCE c_like_no_seq;
CREATE SEQUENCE ac_no_seq;
CREATE SEQUENCE pay_no_seq;
CREATE SEQUENCE charge_no_seq;
CREATE SEQUENCE category_no_seq;

-- Users 테이블 생성
CREATE TABLE Users (
	userNo NUMBER PRIMARY KEY,
	userName VARCHAR2(200) NOT NULL,
	userId VARCHAR2(200) NOT NULL UNIQUE,
	userPwd  VARCHAR2(200) NOT NULL,
	userAddr  VARCHAR2(200) NOT NULL,
	phone  VARCHAR2(200) NOT NULL UNIQUE,
	nickName  VARCHAR2(200) NOT NULL UNIQUE,
	createAt TIMESTAMP default CURRENT_TIMESTAMP
);

-- Account 테이블 생성
CREATE TABLE Account (
	acNo NUMBER PRIMARY KEY,
	userNo NUMBER NOT NULL,
	myCash NUMBER DEFAULT 100,
	CONSTRAINT fk_account_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE
);

-- Charge 테이블 생성
CREATE TABLE Charge (
	chargeNo NUMBER PRIMARY KEY,
	acNo NUMBER NOT NULL,
	chargeAmt NUMBER NOT NULL,
	chargeCard VARCHAR2(200) NOT NULL,
	yesCh char(1) default 'N' check(yesCh IN ('Y','N')),
	CONSTRAINT fk_charge_acNo FOREIGN KEY (acNo)
	REFERENCES Account(acNo) ON DELETE CASCADE
);

-- Category 테이블 생성
CREATE TABLE Category (
	categoryNo NUMBER PRIMARY KEY,
	categoryName VARCHAR2(200) DEFAULT '기타' UNIQUE
);

-- Product 테이블 생성
CREATE TABLE Product (
	pNo NUMBER PRIMARY KEY,
	pName VARCHAR2(200) NOT NULL,
	categoryNo NUMBER NOT NULL,
	pImage varchar2(200) DEFAULT 'none.png',
	pDesc VARCHAR2(200),
	useAt INTEGER DEFAULT 5 CHECK(useAt IN (1,2,3,4,5)),
	startPrice NUMBER NOT NULL,
	pPieces NUMBER DEFAULT 1,
	CONSTRAINT fk_product_categoryNo FOREIGN KEY (categoryNo)
	REFERENCES Category(categoryNo) ON DELETE CASCADE
);

-- Bid 테이블 생성
CREATE TABLE Bid (
	bidNo NUMBER PRIMARY KEY,
	pNo NUMBER NOT NULL,
	userNo NUMBER NOT NULL,
	entryBidPrice NUMBER DEFAULT 0,
	remaningTime TIMESTAMP  DEFAULT CURRENT_TIMESTAMP + INTERVAL '1' DAY,
	registrationTime TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
	autoExtension char(1) DEFAULT 'N' CHECK(autoExtension IN ('Y','N')),
	earlyTermination char(1) DEFAULT 'N' CHECK(earlyTermination IN ('Y','N')),
	minBidUnit NUMBER DEFAULT 1,
	endDate TIMESTAMP  DEFAULT CURRENT_TIMESTAMP + INTERVAL '1' DAY,
	CONSTRAINT fk_bid_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE,
	CONSTRAINT fk_bid_pNo FOREIGN KEY (pNo)
	REFERENCES Product(pNo) ON DELETE CASCADE
);

-- Sb 테이블 생성
CREATE TABLE Sb (
	sbNo NUMBER PRIMARY KEY,
	userNo NUMBER NOT NULL,
	bidNo NUMBER NOT NULL,
	CONSTRAINT fk_sb_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE,
	CONSTRAINT fk_sb_bidNo FOREIGN KEY (bidNo)
	REFERENCES Bid(bidNo) ON DELETE CASCADE
);

-- Aboard 테이블 생성
CREATE TABLE Aboard (
	auctionBoardNo NUMBER PRIMARY KEY,
	bidNo NUMBER NOT NULL,
	createAt TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
	deleteAt char(1) DEFAULT 'N' CHECK(deleteAt IN ('Y','N')),
	endAt char(1) DEFAULT 'N' CHECK(endAt IN ('Y','N')),
	viewCount NUMBER DEFAULT 0,
	CONSTRAINT fk_aboard_bidNo FOREIGN KEY (bidNo)
	REFERENCES Bid(bidNo) ON DELETE CASCADE
);

-- Scrap 테이블 생성
CREATE TABLE Scrap (
	scrapNo NUMBER PRIMARY KEY,
	auctionBoardNo NUMBER NOT NULL,
	userNo NUMBER NOT NULL,
	CONSTRAINT fk_scrap_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE,
	CONSTRAINT fk_scrap_auctionBoardNo FOREIGN KEY (auctionBoardNo)
	REFERENCES Aboard(auctionBoardNo) ON DELETE CASCADE
);

-- Views 테이블 생성
CREATE TABLE Views (
	viewNo NUMBER PRIMARY KEY,
	auctionBoardNo NUMBER NOT NULL,
	userNo NUMBER NOT NULL,
	CONSTRAINT fk_views_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE,
	CONSTRAINT fk_views_auctionBoardNo FOREIGN KEY (auctionBoardNo)
	REFERENCES Aboard(auctionBoardNo) ON DELETE CASCADE
);

-- Cash 테이블 생성
CREATE TABLE Cash (
	payNo NUMBER PRIMARY KEY,
	acNo NUMBER NOT NULL,
	bidNo NUMBER NOT NULL,
	payDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	backPay char(1) DEFAULT 'N' CHECK(backPay IN ('Y','N')),
	CONSTRAINT fk_cash_acNo FOREIGN KEY (acNo)
	REFERENCES Account(acNo) ON DELETE CASCADE,
	CONSTRAINT fk_cash_bidNo FOREIGN KEY (bidNo)
	REFERENCES Bid(bidNo) ON DELETE CASCADE
);

-- Board 테이블 생성
CREATE TABLE Board (
	boardNo NUMBER PRIMARY KEY,
	userNo NUMBER NOT NULL,
	title VARCHAR2(200) NOT NULL,
	boardContent VARCHAR2(2000) NOT NULL,
	createAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updateAt TIMESTAMP,
	CONSTRAINT fk_board_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE
);

-- Comments 테이블 생성
CREATE TABLE Comments (
	commentNo NUMBER PRIMARY KEY,
	boardNo NUMBER NOT NULL,
	userNo NUMBER NOT NULL,
	commentContent VARCHAR2(2000) NOT NULL,
	createAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updateAt TIMESTAMP,
	CONSTRAINT fk_comments_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE,
	CONSTRAINT fk_comments_boardNo FOREIGN KEY (boardNo)
	REFERENCES Board(boardNo) ON DELETE CASCADE
);

-- Comment_Likes 테이블 생성
CREATE TABLE Comment_Likes (
	c_likeNo NUMBER PRIMARY KEY,
	commentNo NUMBER NOT NULL,
	userNo NUMBER NOT NULL,
	CONSTRAINT fk_commentlike_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE,
	CONSTRAINT fk_commentlike_commentNo FOREIGN KEY (commentNo)
	REFERENCES Comments(commentNo) ON DELETE CASCADE
);


*/