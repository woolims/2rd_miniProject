package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import vo.AboardVo;
import vo.BidVo;

public class AboardDao {

	@Autowired
	SqlSession sqlSession;	//SqlSessionTemplate의 interface
	
	//Setter Injection
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//전체목록
	public List<AboardVo> selectList() {
		return sqlSession.selectList("aboard.select_list");
	}
	
	public AboardVo selectOne(int auctionBoardNo) {
		return sqlSession.selectOne("aboard.select_auctionBoardNo", auctionBoardNo);
	}
	
	public int insertAboard(AboardVo vo) {
		return sqlSession.insert("aboard.aboard_insert", vo);
	}
	
	public int deleteAboard(int auctionBoardNo) {
		return sqlSession.delete("aboard.aboard_delete", auctionBoardNo);
	}
	
}
