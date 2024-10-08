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
DROP SEQUENCE qna_no_seq;
DROP SEQUENCE qnac_no_seq;
DROP SEQUENCE seq_Comments_idx;
DROP SEQUENCE seq_Comment_Likes_c_likeNo;

-- 테이블 삭제
DROP TABLE QnAComment;
DROP TABLE QnA;
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
CREATE SEQUENCE qna_no_seq;
CREATE SEQUENCE qnac_no_seq;

-- 댓글 일련번호
CREATE SEQUENCE seq_Comments_idx
START WITH 1
INCREMENT BY 1
NOCACHE;

-- 댓글 좋아요 시퀀스 생성
CREATE SEQUENCE seq_Comment_Likes_c_likeNo
START WITH 1
INCREMENT BY 1
NOCACHE;

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
	nowBid NUMBER NOT NULL,
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
	cancelAt char(1) DEFAULT 'N' CHECK(cancelAt IN ('Y','N')),
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
	boardNo NUMBER PRIMARY KEY,
	nickName  VARCHAR2(200) NOT NULL UNIQUE,
	userNo NUMBER NOT NULL,
	title VARCHAR2(200) NOT NULL,
	boardContent VARCHAR2(2000) NOT NULL,
	createAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	b_readhit	number(38),
	updateAt TIMESTAMP,
	isPinned NUMBER(1) DEFAULT 0,
	CONSTRAINT fk_board_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE,
	CONSTRAINT fk_board_nickName FOREIGN KEY (nickName)
	REFERENCES Users(nickName) ON DELETE CASCADE
);

-- Comments 테이블 생성
CREATE TABLE Comments (
    cmt_idx      int PRIMARY KEY,        -- 일련번호
    cmt_content  VARCHAR2(2000),         -- 내용
    cmt_ip       VARCHAR2(200),          -- 아이피
    cmt_regdate  TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 등록일자
    cmt_update   TIMESTAMP,              -- 수정일자
    boardNo      int,                    -- 게시물번호
    userNo       int,                    -- 회원번호
    nickName     VARCHAR2(200),          -- 회원 닉네임
    is_deleted 	 NUMBER(1)	DEFAULT 0,
    CONSTRAINT fk_comments_boardNo FOREIGN KEY (boardNo)
    REFERENCES Board(boardNo) ON DELETE CASCADE,
    CONSTRAINT fk_comments_userNo FOREIGN KEY (userNo)
    REFERENCES Users(userNo) ON DELETE CASCADE,
    CONSTRAINT fk_comments_nickName FOREIGN KEY (nickName)
    REFERENCES Users(nickName) ON DELETE CASCADE
);

-- 댓글 좋아요 테이블 생성
CREATE TABLE Comment_Likes (
   c_likeNo      int PRIMARY KEY,        -- 일련번호
   cmt_idx       int UNIQUE,             -- 댓글 일련번호 (foreign key)
   userNo        int UNIQUE,             -- 회원번호 (foreign key)
   like_date     TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 좋아요 등록일자
   CONSTRAINT fk_comment_likes_cmt_idx FOREIGN KEY (cmt_idx)
   REFERENCES Comments(cmt_idx) ON DELETE CASCADE,
   CONSTRAINT fk_comment_likes_userNo FOREIGN KEY (userNo)
   REFERENCES Users(userNo) ON DELETE CASCADE
);

-- QnA 테이블 생성
CREATE TABLE QnA (
	qnaNo NUMBER PRIMARY KEY,
	userNo NUMBER NOT NULL,
	qnaTitle VARCHAR2(200) NOT NULL,
	qnaContent clob NOT NULL,
	qnaCreateAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_qna_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE
);

-- QnAComment 테이블 생성
CREATE TABLE QnAComment (
	qnaCommentNo NUMBER PRIMARY KEY,
	qnaNo NUMBER NOT NULL,
	userNo NUMBER NOT NULL,
	commentContent VARCHAR2(2000) NOT NULL,
	createAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_qnacomment_qnaNo FOREIGN KEY (qnaNo)
	REFERENCES QnA(qnaNo) ON DELETE CASCADE,
	CONSTRAINT fk_qnacomments_userNo FOREIGN KEY (userNo)
	REFERENCES Users(userNo) ON DELETE CASCADE
);

-- 유저 데이터
insert into Users values(user_no_seq.nextval, '관리자', 'admin', 'admin', '비공개', '비공개', '관리자', default, default);
insert into Users values(user_no_seq.nextval, '직원', 'one12', 'one12', '비공개', '010-123-123', '직원', default, 1000000);
insert into Users values(user_no_seq.nextval, '직원2', 'one13', 'one13', '비공개', '010-124-124', '직원2', default, 100000000);

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
INSERT INTO Bid (bidNo, pNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate,nowBid)
VALUES (bid_no_seq.nextVal, 1, 8000, CURRENT_TIMESTAMP + INTERVAL '3' DAY, CURRENT_TIMESTAMP, 'Y', 'N', 500, CURRENT_TIMESTAMP + INTERVAL '3' DAY,0);
INSERT INTO Bid (bidNo, pNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate,nowBid)
VALUES (bid_no_seq.nextVal, 2, 12000, CURRENT_TIMESTAMP + INTERVAL '2' DAY, CURRENT_TIMESTAMP, 'N', 'Y', 1000, CURRENT_TIMESTAMP + INTERVAL '2' DAY,0);
INSERT INTO Bid (bidNo, pNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate,nowBid)
VALUES (bid_no_seq.nextVal, 3, 9000, CURRENT_TIMESTAMP + INTERVAL '4' DAY, CURRENT_TIMESTAMP, 'N', 'N', 700, CURRENT_TIMESTAMP + INTERVAL '4' DAY,0);
INSERT INTO Bid (bidNo, pNo, entryBidPrice, remaningTime, registrationTime, autoExtension, earlyTermination, minBidUnit, endDate,nowBid)
VALUES (bid_no_seq.nextVal, 4, 15000, CURRENT_TIMESTAMP + INTERVAL '1' DAY, CURRENT_TIMESTAMP, 'Y', 'Y', 2000, CURRENT_TIMESTAMP + INTERVAL '1' DAY,0);


-- 입찰자 테이블의 더미 데이터 이제 없어

-- 경매 테이블의 더미 데이터
INSERT INTO Aboard (auctionBoardNo, pNo, userNo, createAt, deleteAt, endAt, viewCount)
VALUES (aboard_no_seq.nextVal, 1, 1, CURRENT_TIMESTAMP, 'N', 'N', 100);
INSERT INTO Aboard (auctionBoardNo, pNo, userNo, createAt, deleteAt, endAt, viewCount)
VALUES (aboard_no_seq.nextVal, 2, 1, CURRENT_TIMESTAMP, 'N', 'Y', 50);
INSERT INTO Aboard (auctionBoardNo, pNo, userNo, createAt, deleteAt, endAt, viewCount)
VALUES (aboard_no_seq.nextVal, 3, 2, CURRENT_TIMESTAMP, 'N', 'N', 80);
INSERT INTO Aboard (auctionBoardNo, pNo, userNo, createAt, deleteAt, endAt, viewCount)
VALUES (aboard_no_seq.nextVal, 4, 1, CURRENT_TIMESTAMP, 'N', 'Y', 120);

-- QnA 테이블의 더미 데이터
INSERT INTO QnA (qnaNo, userNo, qnaTitle, qnaContent, qnaCreateAt)
VALUES (qna_no_seq.nextVal, 2, 'QnA를 진행합니다.', 'QnA가 뭔가요?', default);
INSERT INTO QnA (qnaNo, userNo, qnaTitle, qnaContent, qnaCreateAt)
VALUES (qna_no_seq.nextVal, 2, '제 상품 좀 환불 가능할까요?', '샀는데 하자가 너무 많아요. 환불해주세요.', default);
INSERT INTO QnA (qnaNo, userNo, qnaTitle, qnaContent, qnaCreateAt)
VALUES (qna_no_seq.nextVal, 2, '포인트 충전이 안 되네요.', '충전을 시도했는데 충전이 안 된다고 떠요.', default);



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

-- 마이옥션 입찰 조회
CREATE OR REPLACE VIEW MyAuctionBidView AS
SELECT DISTINCT
    a.auctionBoardNo,
    a.pNo,
    p.pName,
	p.pImage,
	b.bidNo,
    b.entryBidPrice,
	b.endDate,
	bp.userNo
FROM Aboard a
INNER JOIN Product p ON a.pNo = p.pNo
INNER JOIN Bid b ON p.pNo = b.pNo
INNER JOIN BidPlayer bp ON b.bidNo = bp.bidNo;

-- 마이옥션 낙찰 조회
CREATE OR REPLACE VIEW MyAuctionSbView AS
SELECT DISTINCT
    a.auctionBoardNo,
    a.pNo,
    p.pName,
	p.pImage,
	b.bidNo,
    b.entryBidPrice,
	b.endDate,
	sb.userNo
FROM Aboard a
INNER JOIN Product p ON a.pNo = p.pNo
INNER JOIN Bid b ON p.pNo = b.pNo
INNER JOIN Sb sb ON b.bidNo = sb.bidNo;

-- QnA 전체 조회
CREATE OR REPLACE VIEW QnAView AS
SELECT
    q.qnaNo,
	q.userNo,
	q.qnaTitle,
	q.qnaContent,
	q.qnaCreateAt,
	u.userName
FROM QnA q
INNER JOIN Users u ON q.userNo = u.userNo;

-- QnA 답글 조회
CREATE OR REPLACE VIEW QnACommentView AS
SELECT DISTINCT
	qc.qnaCommentNo,
    qc.qnaNo,
	qc.userNo,
	qc.commentContent,
	qc.CreateAt,
	u.userName
FROM QnAComment qc
INNER JOIN Users u ON qc.userNo = u.userNo;


create or replace view Bid_view as
select
	b.entryBidPrice,
	b.remaningTime,
	b.registrationTime,
	b.autoExtension,
	b.earlyTermination,
	b.minBidUnit,
	b.endDate,
	b.pNo,
	b.nowBid,
	bp.bidNo,
	bp.bidPNo,
	bp.userNo,
	bp.playPrice,
	u.myCash,
	p.pName,
	p.pDesc,
	p.useAt,
	p.startPrice
FROM Bid b
INNER JOIN BidPlayer bp ON b.bidNo = bp.bidNo
INNER JOIN Users u ON bp.userNo = u.userNo
INNER JOIN product p ON b.pNo = p.pNo;

update users set mycash=9900 where userNo=2


========================================================================================================================================================================

-- 상품 조회
select * from Product
-- 입찰 조회
select * from Bid
select * from Sb
-- 경매 조회
select * from Aboard
-- 경매 조회
select * from Users
-- 입찰자 조회
select * from BidPlayer
-- 경매 게시판 뷰 조회
select * from AuctionView
select * from category

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

		select * from
		(
			select
				rownum as no,
				q.*
			from
			(
				select * from QnACommentView where qnaNo = 5 order by qnaCommentNo desc
			) q
		)
		where no between 1 and 5

		select nvl(count(*),0) from QnACommentView where qnaNo = 5

update Product set pImage='야스오.jsp' where pNo=1;
update Product set pImage='드레이븐11.jsp' where pNo=2;
update Product set pImage='따봉도치.jsp' where pNo=3;
update Product set pImage='징크스.jsp' where pNo=4;

select * from Product

    	SELECT * FROM (
		    SELECT * FROM AuctionView ORDER BY viewCount DESC
		) WHERE ROWNUM <= 5

    	SELECT * FROM (
		    SELECT * FROM AuctionView where deleteAt='N' and endAt='N' ORDER BY viewCount DESC
		) WHERE ROWNUM <= 5

*/






