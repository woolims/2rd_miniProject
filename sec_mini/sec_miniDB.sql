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
DROP SEQUENCE bid_no_seq;
DROP SEQUENCE bidP_no_seq;
DROP SEQUENCE sb_no_seq;
DROP SEQUENCE p_no_seq;
DROP SEQUENCE user_no_seq;
DROP SEQUENCE board_no_seq;
DROP SEQUENCE comment_no_seq;
DROP SEQUENCE c_like_no_seq;
DROP SEQUENCE pay_no_seq;
DROP SEQUENCE charge_no_seq;
DROP SEQUENCE category_no_seq;
DROP SEQUENCE d_category_no_seq;

-- 테이블 삭제
DROP TABLE Comment_Likes;
DROP TABLE Comments;
DROP TABLE Board;
DROP TABLE Cash;
DROP TABLE Scrap;
DROP TABLE Aboard;
DROP TABLE Sb;
DROP TABLE BidPlayer;
DROP TABLE Bid;
DROP TABLE Product;
DROP TABLE D_Category;
DROP TABLE Category;
DROP TABLE Charge;
DROP TABLE Users;


-- 시퀀스 생성
CREATE SEQUENCE aboard_no_seq;
CREATE SEQUENCE scrap_no_seq;
CREATE SEQUENCE bid_no_seq;
CREATE SEQUENCE bidP_no_seq;
CREATE SEQUENCE sb_no_seq;
CREATE SEQUENCE p_no_seq;
CREATE SEQUENCE user_no_seq;
CREATE SEQUENCE board_no_seq;
CREATE SEQUENCE comment_no_seq;
CREATE SEQUENCE c_like_no_seq;
CREATE SEQUENCE pay_no_seq;
CREATE SEQUENCE charge_no_seq;
CREATE SEQUENCE category_no_seq;
CREATE SEQUENCE d_category_no_seq;

-- Users 테이블 생성
CREATE TABLE Users (
	userNo NUMBER PRIMARY KEY,
	userName VARCHAR2(200) NOT NULL,
	userId VARCHAR2(200) NOT NULL UNIQUE,
	userPwd  VARCHAR2(200) NOT NULL,
	userAddr  VARCHAR2(200) NOT NULL,
	phone  VARCHAR2(200) NOT NULL UNIQUE,
	nickName  VARCHAR2(200) NOT NULL UNIQUE,
	createAt TIMESTAMP default CURRENT_TIMESTAMP,
	myCash NUMBER DEFAULT 100
);

-- Charge 테이블 생성
CREATE TABLE Charge (
	chargeNo NUMBER PRIMARY KEY,
	userNo NUMBER NOT NULL,
	chargeAmt NUMBER NOT NULL,
	chargeCard VARCHAR2(200) NOT NULL,
	yesCh char(1) default 'N' check(yesCh IN ('Y','N')),
	CONSTRAINT fk_charge_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE
);

-- Category 테이블 생성
CREATE TABLE Category (
	categoryNo NUMBER PRIMARY KEY,
	categoryName VARCHAR2(200) DEFAULT '부동산 및 기타' UNIQUE
);

-- D_Category 테이블 생성
CREATE TABLE D_Category (
	d_categoryNo NUMBER PRIMARY KEY,
	d_categoryName VARCHAR2(200) DEFAULT '기타' UNIQUE,
	categoryNo NUMBER NOT NULL,
	CONSTRAINT fk_category_categoryNo FOREIGN KEY (categoryNo)
	REFERENCES Category(categoryNo) ON DELETE CASCADE
);

-- Product 테이블 생성
CREATE TABLE Product (
	pNo NUMBER PRIMARY KEY,
	pName VARCHAR2(200) NOT NULL,
	categoryNo NUMBER NOT NULL,
	d_categoryNo NUMBER NOT NULL,
	pImage varchar2(200) DEFAULT 'none.png',
	pDesc VARCHAR2(200),
	useAt NUMBER DEFAULT 5 CHECK(useAt IN (1,2,3,4,5)),
	startPrice NUMBER NOT NULL,
	pPieces NUMBER DEFAULT 1,
	CONSTRAINT fk_product_categoryNo FOREIGN KEY (categoryNo)
	REFERENCES Category(categoryNo) ON DELETE CASCADE,
	CONSTRAINT fk_product_d_categoryNo FOREIGN KEY (d_categoryNo)
	REFERENCES D_Category(d_categoryNo) ON DELETE CASCADE
);

-- Bid 테이블 생성
CREATE TABLE Bid (
	bidNo NUMBER PRIMARY KEY,
	pNo NUMBER NOT NULL,
	entryBidPrice NUMBER DEFAULT 0,
	remaningTime TIMESTAMP  DEFAULT CURRENT_TIMESTAMP + INTERVAL '1' DAY,
	registrationTime TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
	autoExtension char(1) DEFAULT 'N' CHECK(autoExtension IN ('Y','N')),
	earlyTermination char(1) DEFAULT 'N' CHECK(earlyTermination IN ('Y','N')),
	minBidUnit NUMBER DEFAULT 1,
	endDate TIMESTAMP  DEFAULT CURRENT_TIMESTAMP + INTERVAL '1' DAY,
	CONSTRAINT fk_bid_pNo FOREIGN KEY (pNo)
	REFERENCES Product(pNo) ON DELETE CASCADE
);

-- BidPlayer 테이블 생성
CREATE TABLE BidPlayer (
	bidPNo NUMBER PRIMARY KEY,
	bidNo NUMBER NOT NULL,
	userNo NUMBER NOT NULL,
	playPrice NUMBER DEFAULT 0,
	CONSTRAINT fk_bidP_bidNo FOREIGN KEY (bidNo)
	REFERENCES Bid(bidNo) ON DELETE CASCADE,
	CONSTRAINT fk_bidP_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE
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
	pNo NUMBER NOT NULL,
	userNo NUMBER NOT NULL,
	createAt TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
	deleteAt char(1) DEFAULT 'N' CHECK(deleteAt IN ('Y','N')),
	endAt char(1) DEFAULT 'N' CHECK(endAt IN ('Y','N')),
	viewCount NUMBER DEFAULT 0,
	CONSTRAINT fk_aboard_pNo FOREIGN KEY (pNo)
	REFERENCES Product(pNo) ON DELETE CASCADE,
	CONSTRAINT fk_aboard_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE
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

-- Cash 테이블 생성
CREATE TABLE Cash (
	payNo NUMBER PRIMARY KEY,
	userNo NUMBER NOT NULL,
	bidNo NUMBER NOT NULL,
	payDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	backPay char(1) DEFAULT 'N' CHECK(backPay IN ('Y','N')),
	CONSTRAINT fk_cash_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE,
	CONSTRAINT fk_cash_bidNo FOREIGN KEY (bidNo)
	REFERENCES Bid(bidNo) ON DELETE CASCADE
);

-- Board 테이블 생성
CREATE TABLE Board (
    boardNo NUMBER PRIMARY KEY, -- 게시글 번호
    nickName  VARCHAR2(200) NOT NULL, -- 회원의 닉네임
    userNo NUMBER NOT NULL, -- 회원 번호
    title VARCHAR2(200) NOT NULL, -- 제목
    boardContent VARCHAR2(2000) NOT NULL, -- 내용
    createAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 작성일
    b_readhit INT DEFAULT 0, -- 조회수
    updateAt TIMESTAMP, -- 수정일
    CONSTRAINT fk_board_userNo FOREIGN KEY (userNo)
        REFERENCES Users(userNo) ON DELETE CASCADE,
    CONSTRAINT fk_board_nickName FOREIGN KEY (nickName)
        REFERENCES Users(nickName) ON DELETE CASCADE
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
insert into Users values(user_no_seq.nextval, '관리자', 'admin', 'admin', '비공개', '비공개', '관리자', default, default);
insert into Users values(user_no_seq.nextval, '직원', 'one12', 'one12', '비공개', '010-123-123', '직원', default, 1000000);

select *from Users
INSERT INTO Category VALUES (category_no_seq.nextVal, '자동차 및 차량');
INSERT INTO Category VALUES (category_no_seq.nextVal, '패션 및 액세서리');
INSERT INTO Category VALUES (category_no_seq.nextVal, '스포츠 및 레저');
INSERT INTO Category VALUES (category_no_seq.nextVal, '전자기기 및 가전');
INSERT INTO Category VALUES (category_no_seq.nextVal, '게임 및 장난감');
INSERT INTO Category VALUES (category_no_seq.nextVal, '문화 및 취미');
INSERT INTO Category VALUES (category_no_seq.nextVal, '가정용품 및 인테리어');
INSERT INTO Category VALUES (category_no_seq.nextVal, '뷰티 및 건강');
INSERT INTO Category VALUES (category_no_seq.nextVal, '식음료');
INSERT INTO Category VALUES (category_no_seq.nextVal, '애완동물');
INSERT INTO Category VALUES (category_no_seq.nextVal, '부동산 및 기타');

-- 상세 카테고리 테이블 더미 데이터
-- '자동차 및 차량' 카테고리 (categoryNo: 1)
INSERT INTO D_Category VALUES (1, '중고차', 1);
INSERT INTO D_Category VALUES (2, '신차', 1);
INSERT INTO D_Category VALUES (3, '전기차', 1);
INSERT INTO D_Category VALUES (4, '오토바이', 1);
INSERT INTO D_Category VALUES (5, '자동차 용품', 1);
-- '패션 및 액세서리' 카테고리 (categoryNo: 2)
INSERT INTO D_Category VALUES (6, '남성 의류', 2);
INSERT INTO D_Category VALUES (7, '여성 의류', 2);
INSERT INTO D_Category VALUES (8, '어린이 의류', 2);
INSERT INTO D_Category VALUES (9, '액세서리', 2);
INSERT INTO D_Category VALUES (10, '시계', 2);
INSERT INTO D_Category VALUES (11, '가방', 2);
INSERT INTO D_Category VALUES (12, '신발', 2);
INSERT INTO D_Category VALUES (13, '보석류', 2);
-- '스포츠 및 레저' 카테고리 (categoryNo: 3)
INSERT INTO D_Category VALUES (14, '레저 용품', 3);
INSERT INTO D_Category VALUES (15, '캠핑 용품', 3);
INSERT INTO D_Category VALUES (16, '낚시 용품', 3);
INSERT INTO D_Category VALUES (17, '자전거', 3);
INSERT INTO D_Category VALUES (18, '스포츠 의류', 3);
INSERT INTO D_Category VALUES (19, '등산 용품', 3);
INSERT INTO D_Category VALUES (20, '수영 용품', 3);
INSERT INTO D_Category VALUES (21, '스케이트보드', 3);
-- '전자기기' 카테고리 (categoryNo: 4)
INSERT INTO D_Category VALUES (22, '텔레비전', 4);
INSERT INTO D_Category VALUES (23, '스피커', 4);
INSERT INTO D_Category VALUES (24, '카메라', 4);
INSERT INTO D_Category VALUES (25, '컴퓨터', 4);
INSERT INTO D_Category VALUES (26, '노트북', 4);
INSERT INTO D_Category VALUES (27, '태블릿', 4);
-- '게임 및 장난감' 카테고리 (categoryNo: 5)
INSERT INTO D_Category VALUES (28, '장난감', 5);
INSERT INTO D_Category VALUES (29, '보드게임', 5);
INSERT INTO D_Category VALUES (30, '퍼즐', 5);
INSERT INTO D_Category VALUES (31, '비디오 게임', 5);
INSERT INTO D_Category VALUES (32, '게임 콘솔', 5);
-- '문화 및 취미' 카테고리 (categoryNo: 6)
INSERT INTO D_Category VALUES (33, '책', 6);
INSERT INTO D_Category VALUES (34, '잡지', 6);
INSERT INTO D_Category VALUES (35, '만화책', 6);
INSERT INTO D_Category VALUES (36, '앨범', 6);
INSERT INTO D_Category VALUES (37, '음반', 6);
INSERT INTO D_Category VALUES (38, '미술품', 6);
-- '가정 및 인테리어' 카테고리 (categoryNo: 7)
INSERT INTO D_Category VALUES (39, 'DIY', 7);
INSERT INTO D_Category VALUES (40, '사무 용품', 7);
INSERT INTO D_Category VALUES (41, '가구', 7);
INSERT INTO D_Category VALUES (42, '조명', 7);
INSERT INTO D_Category VALUES (43, '부엌 용품', 7);
INSERT INTO D_Category VALUES (44, '욕실 용품', 7);
INSERT INTO D_Category VALUES (45, '정원 용품', 7);
INSERT INTO D_Category VALUES (46, '꽃', 7);
-- '뷰티 및 건강' 카테고리 (categoryNo: 8)
INSERT INTO D_Category VALUES (47, '스킨케어', 8);
INSERT INTO D_Category VALUES (48, '헤어케어', 8);
INSERT INTO D_Category VALUES (49, '메이크업', 8);
INSERT INTO D_Category VALUES (50, '네일', 8);
INSERT INTO D_Category VALUES (51, '향수', 8);
INSERT INTO D_Category VALUES (52, '건강 보조제', 8);
INSERT INTO D_Category VALUES (53, '운동용품', 8);
INSERT INTO D_Category VALUES (54, '아기 용품', 8);
-- '식음료' 카테고리 (categoryNo: 9)
INSERT INTO D_Category VALUES (55, '음식', 9);
INSERT INTO D_Category VALUES (56, '음료', 9);
INSERT INTO D_Category VALUES (57, '스낵', 9);
INSERT INTO D_Category VALUES (58, '건강식품', 9);
-- '애완동물' 카테고리 (categoryNo: 10)
INSERT INTO D_Category VALUES (59, '애완동물 사료', 10);
INSERT INTO D_Category VALUES (60, '애완동물 장난감', 10);
INSERT INTO D_Category VALUES (61, '애완동물 용품', 10);
-- '부동산 및 기타' 카테고리 (categoryNo: 11)
INSERT INTO D_Category VALUES (62, '부동산', 11);
INSERT INTO D_Category VALUES (63, '토지', 11);
INSERT INTO D_Category VALUES (64, '기타', 11);
delete from Product
delete from Bid
delete from BidPlayer
delete from Aboard
-- 상품 테이블의 더미 데이터
INSERT INTO Product (pNo, pName, categoryNo, d_categoryNo, pImage, pDesc, useAt, startPrice, pPieces)
VALUES (p_no_seq.nextVal, 'Product A', 1, 1, 'product_a.png', 'Description of Product A', 3, 10000, 10);
INSERT INTO Product (pNo, pName, categoryNo, d_categoryNo, pImage, pDesc, useAt, startPrice, pPieces)
VALUES (p_no_seq.nextVal, 'Product B', 1, 2, 'product_b.png', 'Description of Product B', 2, 15000, 5);
INSERT INTO Product (pNo, pName, categoryNo, d_categoryNo, pImage, pDesc, useAt, startPrice, pPieces)
VALUES (p_no_seq.nextVal, 'Product C', 1, 2, 'product_c.png', 'Description of Product C', 4, 12000, 8);
INSERT INTO Product (pNo, pName, categoryNo, d_categoryNo, pImage, pDesc, useAt, startPrice, pPieces)
VALUES (p_no_seq.nextVal, 'Product D', 2, 6, 'product_d.png', 'Description of Product D', 5, 18000, 3);

-- 입찰 테이블의 더미 데이터
INSERT INTO Bid (bidNo, pNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate)
VALUES (bid_no_seq.nextVal, 1, 8000, CURRENT_TIMESTAMP + INTERVAL '3' DAY, CURRENT_TIMESTAMP, 'Y', 'N', 500, CURRENT_TIMESTAMP + INTERVAL '3' DAY);
INSERT INTO Bid (bidNo, pNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate)
VALUES (bid_no_seq.nextVal, 2, 12000, CURRENT_TIMESTAMP + INTERVAL '2' DAY, CURRENT_TIMESTAMP, 'N', 'Y', 1000, CURRENT_TIMESTAMP + INTERVAL '2' DAY);
INSERT INTO Bid (bidNo, pNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate)
VALUES (bid_no_seq.nextVal, 3, 9000, CURRENT_TIMESTAMP + INTERVAL '4' DAY, CURRENT_TIMESTAMP, 'N', 'N', 700, CURRENT_TIMESTAMP + INTERVAL '4' DAY);
INSERT INTO Bid (bidNo, pNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate)
VALUES (bid_no_seq.nextVal, 4, 15000, CURRENT_TIMESTAMP + INTERVAL '1' DAY, CURRENT_TIMESTAMP, 'Y', 'Y', 2000, CURRENT_TIMESTAMP + INTERVAL '1' DAY);


-- 입찰자 테이블의 더미 데이터
INSERT INTO BidPlayer (bidPNo, bidNo, userNo, playPrice)
VALUES (bidP_no_seq.nextval, 1, 1, 1000);
INSERT INTO BidPlayer (bidPNo, bidNo, userNo, playPrice)
VALUES (bidP_no_seq.nextval, 1, 2, 2200);
INSERT INTO BidPlayer (bidPNo, bidNo, userNo, playPrice)
VALUES (bidP_no_seq.nextval, 2, 1, 3000);
INSERT INTO BidPlayer (bidPNo, bidNo, userNo, playPrice)
VALUES (bidP_no_seq.nextval, 2, 2, 1000);
INSERT INTO BidPlayer (bidPNo, bidNo, userNo, playPrice)
VALUES (bidP_no_seq.nextval, 3, 1, 10000);
INSERT INTO BidPlayer (bidPNo, bidNo, userNo, playPrice)
VALUES (bidP_no_seq.nextval, 4, 1, 321000);

-- 경매 테이블의 더미 데이터
INSERT INTO Aboard (auctionBoardNo, pNo, userNo, createAt, deleteAt, endAt, viewCount)
VALUES (aboard_no_seq.nextVal, 1, 1, CURRENT_TIMESTAMP, 'N', 'N', 100);
INSERT INTO Aboard (auctionBoardNo, pNo, userNo, createAt, deleteAt, endAt, viewCount)
VALUES (aboard_no_seq.nextVal, 2, 1, CURRENT_TIMESTAMP, 'N', 'Y', 50);
INSERT INTO Aboard (auctionBoardNo, pNo, userNo, createAt, deleteAt, endAt, viewCount)
VALUES (aboard_no_seq.nextVal, 3, 2, CURRENT_TIMESTAMP, 'N', 'N', 80);
INSERT INTO Aboard (auctionBoardNo, pNo, userNo, createAt, deleteAt, endAt, viewCount)
VALUES (aboard_no_seq.nextVal, 4, 1, CURRENT_TIMESTAMP, 'N', 'Y', 120);

-- 상품 조회
select * from Product
-- 입찰 조회
select * from Bid
-- 경매 조회
select * from Aboard
-- 경매 조회
select * from Users

select * from category
-- 전체 조회
CREATE OR REPLACE VIEW AuctionView AS
SELECT DISTINCT
    a.auctionBoardNo,
    a.pNo,
    a.userNo,
    a.createAt,
    a.deleteAt,
    a.endAt,
    a.viewCount,
    b.bidNo,
    b.entryBidPrice,
    b.remaningTime,
    b.registrationTime,
    b.autoExtension,
    b.earlyTermination,
    b.minBidUnit,
    b.endDate,
    p.pName,
    p.categoryNo,
    p.d_categoryNo,
    p.pImage,
    p.pDesc,
    p.useAt,
    p.startPrice,
    p.pPieces,
    c.categoryName,
    dc.d_categoryName
FROM Aboard a
INNER JOIN Product p ON a.pNo = p.pNo
INNER JOIN Bid b ON p.pNo = b.pNo
INNER JOIN Category c ON p.categoryNo = c.categoryNo
INNER JOIN D_Category dc ON p.d_categoryNo = dc.d_categoryNo;


CREATE OR REPLACE VIEW Bid_Player_User_PView AS
SELECT DISTINCT
    b.entryBidPrice,
    b.remaningTime,
    b.registrationTime,
    b.autoExtension,
    b.earlyTermination,
    b.minBidUnit,
    b.endDate,
    bp.userNo,
    bp.bidNo,
    bp.playPrice,
    u.myCash,
    p.pNo,
    p.pName,
    p.pDesc,
    p.useAt,
    p.startPrice,
    p.pPieces
FROM Bid b
INNER JOIN BidPlayer bp ON b.bidNo = bp.bidNo
INNER JOIN Users u ON bp.userNo = u.userNo
INNER JOIN Product p ON b.pNo = p.pNo;


========================================================================================================================================================================
select * from Aboard a, Product p, Bid b, Category c where a.pNo = p.pNo and p.pNo = b.pNo and p.categoryNo = c.categoryNo and c.ca

--입찰 정보 조회
CREATE OR REPLACE VIEW BidView AS
SELECT DISTINCT
    a.auctionBoardNo,
    a.pNo,
    a.createAt,
    a.deleteAt,
    a.endAt,
    a.viewCount,
    p.pName,
    p.categoryNo,
    p.pImage,
    p.pDesc,
    p.useAt,
    p.startPrice,
    p.pPieces,
    b.endDate,
    c.categoryName,
    dc.d_categoryNo,
    dc.d_categoryName
FROM Aboard a
INNER JOIN Product p ON a.pNo = p.pNo
INNER JOIN Bid b ON p.pNo = b.pNo
INNER JOIN Category c ON p.categoryNo = c.categoryNo
INNER JOIN D_Category dc ON p.d_categoryNo = dc.d_categoryNo;



SELECT DISTINCT
    b.bidNo,
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
    c.categoryName,
    p.d_categoryNo,
    dc.d_categoryName
FROM Product p
INNER JOIN Bid b ON p.pNo = b.pNo
INNER JOIN Category c ON p.categoryNo = c.categoryNo
INNER JOIN D_Category dc ON p.d_categoryNo = dc.d_categoryNo;






select * from Product p, D_Category dc where p.d_categoryNo = dc.d_categoryNo
select * from Product p, Category c, D_Category dc where p.d_categoryNo = dc.d_categoryNo and c.categoryNo = dc.categoryNo order by pNo

CREATE VIEW Product_Total AS 
	SELECT 
		p.pName,
		c.categoryName
	FROM Product p
	INNER JOIN Category c ON p.categoryNo = c.categoryNo;

select * from AuctionView where deleteAt='N';

select (endDate - sysdate)as times from AuctionView

select max(entryBidPrice) from bid  where pNo=2

SELECT p_no_seq.NEXTVAL FROM dual;
SELECT aboard_no_seq.NEXTVAL FROM dual;

SELECT * from Product
insert into aboard values(
			aboard_no_seq.nextVal,
			7, 
			default,
			default,
			default,
			default
		)

*/







