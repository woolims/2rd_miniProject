package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.BidVo;

public class BidDao {

	SqlSession sqlSession; // SqlSessionTemplate의 interface

	// Setter Injection
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

//	입찰페이지 정보 전체조회
	public List<BidVo> select_bid() {

		return sqlSession.selectList("bid.select_bid");
	}

//	입찰페이지 번호만 조회
	public int selectOne_bidNo() {

		return sqlSession.selectOne("bid.selectOne_bidNo");
	}
	
//  아무도 입찰을 안 했을 때 경매최저가
	public int new_bid_price_select(int pNo) {

		return sqlSession.selectOne("bid.new_bid_price_select");
	}
	
//	경매에 참가한 사람의 정보
	public int users_bid_insert(BidVo vo) {

		return sqlSession.selectOne("bid.users_bid_insert", vo);
	}

//	경매페이지에 띄울 최고입찰금액
	public int entry_bid_select(int bidNo) {

		return sqlSession.selectOne("bid.entry_bid_select", bidNo);
	}
	
//	경매에 참여한 개인이 입력한 최고값 개인열람용
	public int entry_bid_person_update(BidVo vo) {

		return sqlSession.selectOne("entry_bid_person_update", vo);
	}
	
//	입장시 캐시보유량 체크
	public int cashCheck(int userNo) {

		return sqlSession.selectOne("bid.cashCheck", userNo); 
	}

	

}
