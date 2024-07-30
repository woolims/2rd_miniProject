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
select count(*) from Comments where boardNo = 23

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


select * from Comment_Likes where cmt_idx = 7

select * from Comments where boardNo = 41

 */