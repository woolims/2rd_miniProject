package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import vo.CommentLikesVo;

@Repository
public class CommentLikesDaoImpl implements CommentLikesDao {

    private static final String NAMESPACE = "commentLikes";

    @Autowired
    SqlSession sqlSession;

    public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public SqlSession getSqlSession() {
        return sqlSession;
    }
    
    @Override
    public int insert(CommentLikesVo vo) {
        int c_likeNo = sqlSession.selectOne(NAMESPACE + ".getNextVal");
        vo.setC_likeNo(c_likeNo);
        return sqlSession.insert(NAMESPACE + ".insert", vo);
    }

    @Override
    public int delete(CommentLikesVo vo) {
        return sqlSession.delete(NAMESPACE + ".delete", vo);
    }

    @Override
    public int count(int cmt_idx) {
        return sqlSession.selectOne(NAMESPACE + ".count", cmt_idx);
    }

    @Override
    public boolean isLikedByUser(int cmt_idx, int userNo) {
        Integer count = sqlSession.selectOne(NAMESPACE + ".isLikedByUser", new CommentLikesVo(cmt_idx, userNo));
        return count != null && count > 0;
    }

    @Override
    public int deleteByComment(int cmt_idx) {
        return sqlSession.delete(NAMESPACE + ".deleteByComment", cmt_idx);
    }

    @Override
    public int deleteLike(CommentLikesVo vo) {
        return sqlSession.delete(NAMESPACE + ".deleteLike", vo);
    }
}
