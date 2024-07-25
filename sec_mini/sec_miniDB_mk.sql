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
CREATE SEQUENCE user_no_seq;
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

INSERT INTO Board VALUES (board_no_seq.NEXTVAL, '관리자', 1, '제목입니다.', '내용입니다.', DEFAULT, 0, TO_TIMESTAMP('2024-07-24', 'YYYY-MM-DD'));

INSERT INTO Board VALUES (board_no_seq.NEXTVAL, '관리자', 1, '2제목.', '2내용입니다.', DEFAULT, 0, TO_TIMESTAMP('2024-07-24', 'YYYY-MM-DD'));

INSERT INTO Board VALUES (board_no_seq.NEXTVAL, '관리자', 1, '3제목.', '3내용입니다.', DEFAULT, 0, TO_TIMESTAMP('2024-07-24', 'YYYY-MM-DD'));


delete from users where userNo=2
insert into Users values(1, '관리자', 'admin', 'admin', '비공개', '비공개', '관리자', default);
insert into Users values(2, '직원', 'one12', 'one12', '비공개', '010-123-123', '직원', default);

select * from users where userId = 'admin';


SELECT * FROM Board ORDER BY boardNo DESC
*/