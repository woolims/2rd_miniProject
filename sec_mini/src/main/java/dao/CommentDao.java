package dao;

import java.util.List;
import java.util.Map;

import vo.CommentVo;

public interface CommentDao {
    List<CommentVo> selectList(int boardNo);
    int insert(CommentVo vo);
    int delete(int cmt_idx);
    int update(CommentVo vo);  // 수정 메서드 추가
    
    CommentVo selectByIdx(int cmt_idx); // 댓글을 조회하는 메서드 추가
    int markCommentAsDeleted(int cmt_idx); // 댓글 관리자가 삭제하는지 알 수 있는 메서드 추가

    List<CommentVo> selectList(Map<String, Object> map);  // 페이징된 댓글 목록 조회 메서드 추가
    int selectRowTotal(int boardNo);  // 댓글 총 개수 조회 메서드 추가
}