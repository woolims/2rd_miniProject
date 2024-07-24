package dao;

import java.util.List;
import vo.BoardVo;

public interface BoardDao {
	
	List<BoardVo> selectList();

	int insert(BoardVo vo);

	BoardVo selectOne(int boardNo);

	int update_readhit(int boardNo);

	 int update(BoardVo vo);

	int delete(int boardNo);

	
}
