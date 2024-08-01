package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import vo.BoardVo;

@Repository("board_dao")
public class BoardDaoImpl implements BoardDao {

    public BoardDaoImpl() {
        System.out.println("--BoardDaoImpl()--");
    }

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<BoardVo> selectList() {
        return sqlSession.selectList("board.board_list");
    }

    @Override
    public List<BoardVo> selectList(Map<String, Object> map) {
        return sqlSession.selectList("board.board_list_condition", map);
    }

    @Override
    public int insert(BoardVo vo) {
        return sqlSession.insert("board.board_insert", vo);
    }

    @Override
    public BoardVo selectOne(int boardNo) {
        return sqlSession.selectOne("board.board_one", boardNo);
    }

    @Override
    public int update_readhit(int boardNo) {
        return sqlSession.update("board.board_update_readhit", boardNo);
    }

    @Override
    public int update(BoardVo vo) {
        return sqlSession.update("board.board_update", vo);
    }

    @Override
    public int delete(int boardNo) {
        return sqlSession.delete("board.board_delete", boardNo);
    }

    @Override
    public int selectRowTotal(Map<String, Object> map) {
        return sqlSession.selectOne("board.board_row_total", map);
    }

    @Override
    public int updatePinStatus(int boardNo, int isPinned) {
        Map<String, Object> params = new HashMap<>();
        params.put("boardNo", boardNo);
        params.put("isPinned", isPinned);
        return sqlSession.update("board.updatePinStatus", params);
    }
}
