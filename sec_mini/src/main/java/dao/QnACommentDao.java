package dao;

import java.util.List;

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
	public List<QnACommentVo> qnacList() {
		return sqlSession.selectList("qnac.select_list");
	}//end:boardList()
	
}
