package dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import vo.BoardVo;

@Repository("board_dao") // 앞으로 참조하는 참조변수 이름은 board_dao이다 참조받은건 BoardDao라는 뜻
public class BoardDaoImpl implements BoardDao {
	
	public BoardDaoImpl() {
		// TODO Auto-generated constructor stub
		System.out.println("--BoardDaoImpl()--");
	}
	
    @Autowired
    private SqlSession sqlSession;

	@Override
	public List<BoardVo> selectList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.board_list");
	}

	@Override
	public int insert(BoardVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.board_insert", vo);
	}

	@Override
	public BoardVo selectOne(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.board_one",boardNo); //sqlSession에 넣었으니 mapper에 작성해야한다
	}

	@Override
	public int update_readhit(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.board_update_readhit", boardNo); // 이 게시글의 조회수를 증가시키는 놈.. mapper에 등록해야한다.
	}

    @Override
    public int update(BoardVo vo) {
        return sqlSession.update("board.board_update", vo);
    }

    @Override
    public int delete(int boardNo) {
        return sqlSession.delete("board.board_delete", boardNo);
    }

}

