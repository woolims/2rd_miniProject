package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import vo.QnACommentVo;

public class QnACommentDao {

	@Autowired
	SqlSession sqlSession;	//SqlSessionTemplate의 interface
	
	//Setter Injection
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//게시글에 대한 답글 조회
	public List<QnACommentVo> qnacList(int qnaNo) {
		return sqlSession.selectList("qnac.select_list", qnaNo);
	}

	//게시글에 대한 페이지 답글 조회
	public List<QnACommentVo> selectList(Map<String, Object> map) {
		return sqlSession.selectList("qnac.qnac_page_list", map);
	}

	//게시글에 대한 답글수
	public int selectRowTotal(int qnaNo) {
		return sqlSession.selectOne("qnac.qnac_row_total", qnaNo);
	}

	//답글 작성
	public int insert(QnACommentVo vo) {
		return sqlSession.insert("qnac.qnac_insert", vo);
	}

	//답글 하나 선택
	public QnACommentVo selectOneQCN(int qnaCommentNo) {
		return sqlSession.selectOne("qnac.selectOneQCN", qnaCommentNo);
	}

	//답글 삭제
	public int delete(int qnaCommentNo) {
		return sqlSession.delete("qnac.qnac_delete", qnaCommentNo);
	}

	//답글 수정
	public int update(QnACommentVo vo) {
        return sqlSession.update("qnac.qnac_update", vo);
	}
	
}
