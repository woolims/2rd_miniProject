package dao;

import java.util.List;
import java.util.Map;

import vo.BoardVo;

public interface BoardDao {
    List<BoardVo> selectList();
    int insert(BoardVo vo);
    BoardVo selectOne(int boardNo);
    int update_readhit(int boardNo);
    int update_readhit2(int boardNo);
    int update(BoardVo vo);
    int delete(int boardNo);
    	
    //검색기능..페이지네이션..
    List<BoardVo> selectList(Map<String, Object> map);
    int selectRowTotal(Map<String, Object> map);
    
    // 게시글 핀 상태 업데이트
    int updatePinStatus(int boardNo, int isPinned);
    
    // 상위 3개의 최신 게시글을 가져오는 메서드
    List<BoardVo> selectTopThreeRecentPosts();
    
}

