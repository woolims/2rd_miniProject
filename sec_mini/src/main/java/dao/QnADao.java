package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import vo.QnACommentVo;
import vo.QnAVo;

public class QnADao {

	@Autowired
	SqlSession sqlSession;	//SqlSessionTemplate의 interface
	
	//Setter Injection
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//전체 조회
	public List<QnAVo> qnaList() {
		return sqlSession.selectList("qna.select_list");
	}//end:boardList()
	
	//전체 조회
	public List<QnAVo> qnaList(Map<String, Object> map) {
		return sqlSession.selectList("qna.select_list_paging", map);
	}//end:boardList()

	//상세 조회
	public QnAVo selectOne(int qnaNo) {
		return sqlSession.selectOne("qna.selectOne_qnaNo", qnaNo);
	}//end:selectOne()
	
	//QnA 작성
	public int write(QnAVo vo) {
		return sqlSession.insert("qna.qna_insert", vo);
	}//end: write()

	//QnA 삭제
	public int delete(int qnaNo) {
		return sqlSession.delete("qna.qna_delete", qnaNo);
	}//end: delete()

	//QnA 수정
	public int update(QnAVo vo) {
		return sqlSession.update("qna.qna_update", vo);
	}//end: update()

	public int selectRowTotal(Map<String, Object> map) {
		return sqlSession.selectOne("qna.qna_row_total", map);
	}

	public List<QnACommentVo> qnaCList() {
		return sqlSession.selectList("qna.qna_comment_list");
	}
	
}
