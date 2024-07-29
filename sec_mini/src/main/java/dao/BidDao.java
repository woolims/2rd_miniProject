package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import vo.AboardVo;
import vo.BidVo;

public class BidDao {

	@Autowired
	SqlSession sqlSession;	//SqlSessionTemplate의 interface
	
	//Setter Injection
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public BidVo selectOne(int bidNo) {
		return sqlSession.selectOne("bid.select_bidNo", bidNo);
	}
	
	public int insertBid(AboardVo vo) {
		System.out.println(vo.getpNo());
		System.out.println(vo.getStartPrice());
		System.out.println(vo.getRemaningTime());
		System.out.println(vo.getAutoExtension());
		
		return sqlSession.insert("bid.bid_insert", vo);
	}
	
	public int updateBid(BidVo vo) {
		return sqlSession.update("bid.bid_update", vo);
	}
	
	public int deleteBid(int bidNo) {
		return sqlSession.delete("bid.bid_delete", bidNo);
	}
	
}
