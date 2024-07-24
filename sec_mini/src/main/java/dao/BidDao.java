package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class BidDao {
	
	@Autowired
	SqlSession sqlSession;

	public void setSqlsession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	

}
