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
	public List<BidVo> select_bid() {
		return sqlSession.selectList("bid.select_bid");
	}
	
//	입찰자 전체 조회
	public BidVo select_bid_player() {

		return sqlSession.selectOne("bid.select_bid_player");
	}
	

//	입찰페이지 번호만 조회
	public BidVo selectOne_bidNo() {

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
	
//	유저마다 처음으로 입찰성공시 작동할 sql문
	public int bid_success1(BidVo vo) {
		
		return sqlSession.insert("bid.bid_success1", vo);
	}
	
//	유저마다 재입찰성공시 작동할 sql문
	public int bid_success2(BidVo vo) {
		
		return sqlSession.update("bid.bid_success2", vo);
	}

	
//	특정 경매에 참여하는 유저를 구별하기위한 sql문
	public List<BidVo> bid_check(BidVo  vo){

		return sqlSession.selectList("bid.bid_check", vo);
	}
	
//	재입찰하는 유저번호를 체크하는 sql문
	public BidVo re_user_check(BidVo vo) {
		
		return sqlSession.selectOne("bid.re_user_check",vo);
	}

	public int entry_bid_update(BidVo vo) {
		// TODO Auto-generated method stub
		
		return sqlSession.update("bid.entry_bid_update",vo);
	}

	public int now_bid_update(BidVo vo) {

		return sqlSession.update("bid.now_bid_update",vo);
	}

	public String p_name_select(int pNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("bid.p_name_select",pNo);
	}

	public int now_bid_select(int bidNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("bid.now_bid_select",bidNo);
	}

	public int bid_count_select() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("bid.bid_count_select");
	}

	public int user_playPrice(int bidNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("bid.user_playPrice",bidNo);
	}
	
	public BidVo user_sb(int user_playPrice) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("bid.user_sb",user_playPrice);
	}

	public int p_no_select_one(int bidNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("bid.p_no_select_one",bidNo);
	}

	


	

}
