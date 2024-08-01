package dao;

import org.apache.ibatis.session.SqlSession;

import vo.BidVo;
import vo.SBVo;

public class SBDao {
		

	SqlSession sqlSession; // SqlSessionTemplate의 interface

	// Setter Injection
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int insert_user_sb(SBVo sb_vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("sb.insert_user_sb",sb_vo);
	}

	public int end_at_update(int pNo) {
		// TODO Auto-generated method stub
		
		return sqlSession.update("sb.end_at_update",pNo);
		
	}

	
	
	

}
