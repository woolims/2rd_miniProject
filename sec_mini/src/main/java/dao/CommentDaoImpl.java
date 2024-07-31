package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.CommentVo;

@Repository
public class CommentDaoImpl implements CommentDao {

	@Autowired
    private SqlSession sqlSession;

    @Override
    public List<CommentVo> selectList(int boardNo) {
        return sqlSession.selectList("comment.comment_list", boardNo);
    }

    @Override
    public List<CommentVo> selectList(Map<String, Object> map) {
        return sqlSession.selectList("comment.comment_page_list", map);
    }

    @Override
    public int insert(CommentVo vo) {
        return sqlSession.insert("comment.comment_insert", vo);
    }

    @Override
    public int delete(int cmt_idx) {
        return sqlSession.delete("comment.comment_delete", cmt_idx);
    }

    @Override
    public int selectRowTotal(int boardNo) {
        return sqlSession.selectOne("comment.comment_row_total", boardNo);
    }

    @Override
    public int update(CommentVo vo) {
        return sqlSession.update("comment.update", vo);
    }
    
    private static final String NAMESPACE = "comment";
    
    
    @Override
    public CommentVo selectByIdx(int cmt_idx) {
        return sqlSession.selectOne(NAMESPACE + ".selectByIdx", cmt_idx);
    }
    
    @Override
    public int markCommentAsDeleted(int cmt_idx) {
        return sqlSession.update(NAMESPACE + ".markCommentAsDeleted", cmt_idx);
    }
}
