package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.AboardVo;
import vo.BidVo;

public class BidDao {

	SqlSession sqlSession; // SqlSessionTemplate의 interface

	// Setter Injection
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

//	입찰페이지 정보 전체조회
	public List<AboardVo> select_bid() {

		return sqlSession.selectList("bid.select_bid");
	}

//	입찰페이지 번호만 조회
	public int selectOne_bidNo() {

		return sqlSession.selectOne("bid.selectOne_bidNo");
	}

	
//	 유저 번호만 조회 
//	 public BidVo selectOne_userNo() {
//	  
//	 return sqlSession.selectOne("bid.selectOne_userNo"); }
	 
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
	
	public int updateBid(AboardVo vo) {
		return sqlSession.update("bid.bid_update", vo);
	}
	
	public int deleteBid(int bidNo) {
		return sqlSession.delete("bid.bid_delete", bidNo);
	}
	
	
//  아무도 입찰을 안 했을 때 경매최저가
	public int new_bid_price_select(int pNo) {

		return sqlSession.selectOne("bid.new_bid_price_select",pNo);
	}

//	경매에 참가한 사람의 정보
	public int users_bid_insert(AboardVo vo) {

		return sqlSession.selectOne("bid.users_bid_insert", vo);
	}

//	경매페이지에 띄울 최고입찰금액
	public int entry_bid_select(int bidNo) {

		return sqlSession.selectOne("bid.entry_bid_select", bidNo);
	}

//	경매에 참여한 개인이 입력한 최고값 개인열람용
	public int entry_bid_person_update(AboardVo vo) {

		return sqlSession.selectOne("entry_bid_person_update", vo);
	}

//	입장시 캐시보유량 체크
	public int cashCheck(int userNo) {

		return sqlSession.selectOne("bid.cashCheck", userNo);
	}
	
//	유저마다 처음으로 입찰성공시 작동할 sql문
	public int bid_success1(AboardVo vo) {
		
		return sqlSession.insert("bid.bid_success1", vo);
	}
	
//	유저마다 재입찰성공시 작동할 sql문
	public int bid_success2(AboardVo vo) {
		
		return sqlSession.update("bid.bid_success2", vo);
	}

}
