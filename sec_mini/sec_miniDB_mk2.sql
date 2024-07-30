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
CREATE TABLE Comments (
    cmt_idx      int PRIMARY KEY,        -- 일련번호
    cmt_content  VARCHAR2(2000),         -- 내용
    cmt_ip       VARCHAR2(200),          -- 아이피
    cmt_regdate  TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 등록일자
    cmt_update   TIMESTAMP,              -- 수정일자
    boardNo      int,                    -- 게시물번호
    userNo       int,                    -- 회원번호
    nickName     VARCHAR2(200),          -- 회원 닉네임
    CONSTRAINT FK_COMMENTS_BOARDNO FOREIGN KEY (boardNo) REFERENCES Board(boardNo) ON DELETE CASCADE
);

-- 외래키
alter table Comments
   add constraint fk_comments_boardNo foreign key(boardNo)
                                      references Board(boardNo);

alter table Comments
   add constraint fk_comments_userNo foreign key(userNo)
                                        references Users(userNo); 
alter table Comments
   add constraint fk_comments_nickName foreign key(nickName)
                                        references Users(nickName); 
                                        
--댓글 삭제여부( 관리자인지, 아닌지) 
ALTER TABLE Comments ADD is_deleted NUMBER(1) DEFAULT 0;




INSERT INTO Board VALUES (board_no_seq.NEXTVAL, '관리자', 1, '제목입니다.', '내용입니다.', DEFAULT, 0, TO_TIMESTAMP('2024-07-24', 'YYYY-MM-DD'));

INSERT INTO Board VALUES (board_no_seq.NEXTVAL, '관리자', 1, '2제목.', '2내용입니다.', DEFAULT, 0, TO_TIMESTAMP('2024-07-24', 'YYYY-MM-DD'));

INSERT INTO Board VALUES (board_no_seq.NEXTVAL, '관리자', 1, '3제목.', '3내용입니다.', DEFAULT, 0, TO_TIMESTAMP('2024-07-24', 'YYYY-MM-DD'));


delete from users where userNo=2
insert into Users values(1, '관리자', 'admin', 'admin', '비공개', '비공개', '관리자', default);
insert into Users values(2, '직원', 'one12', 'one12', '비공개', '010-123-123', '직원', default);

select * from users where userId = 'admin';


SELECT * FROM Board ORDER BY boardNo DESC
*/


/*

drop table Comments
drop sequence  seq_Comments_idx




-- 일련번호
CREATE SEQUENCE seq_Comments_idx
START WITH 1
INCREMENT BY 1
NOCACHE;




CREATE TABLE Comments (
    cmt_idx      int PRIMARY KEY,        -- 일련번호
    cmt_content  VARCHAR2(2000),         -- 내용
    cmt_ip       VARCHAR2(200),          -- 아이피
    cmt_regdate  TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 등록일자
    cmt_update   TIMESTAMP,              -- 수정일자
    boardNo      int,                    -- 게시물번호
    userNo       int,                    -- 회원번호
    nickName     VARCHAR2(200),          -- 회원 닉네임
    CONSTRAINT FK_COMMENTS_BOARDNO FOREIGN KEY (boardNo) REFERENCES Board(boardNo) ON DELETE CASCADE
);


--- 외래키 설정
ALTER TABLE Comment_Likes
   ADD CONSTRAINT fk_comment_likes_cmt_idx FOREIGN KEY(cmt_idx)
                                      REFERENCES Comments(cmt_idx) ON DELETE CASCADE;

ALTER TABLE Comment_Likes
   ADD CONSTRAINT fk_comment_likes_userNo FOREIGN KEY(userNo)
                                      REFERENCES Users(userNo) ON DELETE CASCADE;

-- 유니크 제약 조건 추가
ALTER TABLE Comment_Likes
ADD CONSTRAINT unique_user_comment_likes UNIQUE (cmt_idx, userNo);

select * from
(
	select
		rank() over(order by cmt_idx desc) as no,
		c.*
	from 
	(
	  select * from Comments where boardNo=20
	) c
)
where no between 1 and 5

-- 조회
   select id="comment_list"  parameterType="int"  resultType="vo.CommentVo">
      select * from Comments where boardNo = 3
      order by cmt_idx desc






--paging menu
	select
	rank() over(order by b_ref desc) as no, -- 변경 필요
	b.*
	from 
	(select * from Board) b

-- 2 inline view 형태로 사용
select * from
(
		select
		rank() over(order by b_ref desc) as no, -- 변경 필요
		b.*,
		(select nvl(count(*),0) from Comments where b_idx=b.boardNo)as cmt_count
		from 
		(select * from Board) b
)
where no between 1 and 5



--해당 게시글에 연결된 댓글의 갯수
select count(*) from Comments where boardNo = 3

*/



/*
drop SEQUENCE seq_Comment_Likes_c_likeNo
drop table Comment_Likes 
   
-- 시퀀스 생성
CREATE SEQUENCE seq_Comment_Likes_c_likeNo
START WITH 1
INCREMENT BY 1
NOCACHE;

-- 댓글 좋아요 테이블 생성
CREATE TABLE Comment_Likes (
   c_likeNo      int PRIMARY KEY,        -- 일련번호
   cmt_idx       int,                    -- 댓글 일련번호 (foreign key)
   userNo        int,                    -- 회원번호 (foreign key)
   like_date     TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 좋아요 등록일자
);

-- 외래키 설정
ALTER TABLE Comment_Likes
   ADD CONSTRAINT fk_comment_likes_cmt_idx FOREIGN KEY(cmt_idx)
                                      REFERENCES Comments(cmt_idx) ON DELETE CASCADE;

ALTER TABLE Comment_Likes
   ADD CONSTRAINT fk_comment_likes_userNo FOREIGN KEY(userNo)
                                      REFERENCES Users(userNo) ON DELETE CASCADE;

-- 유니크 제약 조건 추가
ALTER TABLE Comment_Likes
ADD CONSTRAINT unique_user_comment_likes UNIQUE (cmt_idx, userNo);


 */

