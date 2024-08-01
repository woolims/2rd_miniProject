package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import vo.AboardVo;
import vo.BidVo;
import vo.ScrapVo;

public class AboardDao {

	@Autowired
	SqlSession sqlSession; // SqlSessionTemplate의 interface

	// Setter Injection
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 전체목록
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
		return sqlSession.update("aboard.aboard_delete", auctionBoardNo);
	}

	public int update_readhit(int auctionBoardNo) {
		return sqlSession.update("aboard.aboard_update_readhit", auctionBoardNo);
	}
	
	public int update_filename(AboardVo vo) {

		return sqlSession.update("aboard.aboard_update_filename", vo);
	}//end:update() 

	public List<AboardVo> selectDCate(int d_categoryNo) {
		return sqlSession.selectList("aboard.select_d_categoryNo", d_categoryNo);
	}

	public List<AboardVo> selectCate(int categoryNo) {
		return sqlSession.selectList("aboard.select_categoryNo", categoryNo);
	}

	public List<AboardVo> selectListMyBid(int userNo) {
		return sqlSession.selectList("aboard.select_my_bid", userNo);
	}

	public List<AboardVo> selectListMySb(int userNo) {
		return sqlSession.selectList("aboard.select_my_sb", userNo);
	}

	public List<AboardVo> selectListMyAuc(int userNo) {
		return sqlSession.selectList("aboard.select_my_auc", userNo);
	}

	public List<AboardVo> selectListMySc(int userNo) {
		return sqlSession.selectList("aboard.select_my_sc", userNo);
	}
	
	//즐겨찾기 결과 불러오기
	public ScrapVo selectOne(Map<String, Object> map) {
		return sqlSession.selectOne("aboard.select_scrap", map);
	}

	public int update_cancelAt(ScrapVo vo) {
		return sqlSession.update("aboard.updateCancelAt", vo);
	}
	
	//즐겨찾기 추가
	public int insertScrap(Map<String, Object> map) {
		return sqlSession.insert("aboard.insertScrap", map);
	}

	public ScrapVo selectOne(ScrapVo vo) {
		return sqlSession.selectOne("aboard.select_scrapvo", vo);
	}


}
