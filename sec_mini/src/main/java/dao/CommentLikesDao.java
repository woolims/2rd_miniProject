package dao;

import vo.CommentLikesVo;

public interface CommentLikesDao {
    int insert(CommentLikesVo vo);
    int delete(CommentLikesVo vo);
    int count(int cmt_idx);
    boolean isLikedByUser(int cmt_idx, int userNo);
    int deleteByComment(int cmt_idx); // 댓글의 모든 좋아요 삭제
    int deleteLike(CommentLikesVo vo); // 특정 좋아요 삭제
}
