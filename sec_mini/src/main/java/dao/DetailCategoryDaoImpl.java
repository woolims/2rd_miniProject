package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.DetailCategoryVo;

public class DetailCategoryDaoImpl implements DetailCategoryDao {

	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	@Override
	public List<DetailCategoryVo> selectList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("category.d_category_list");
	}
	


}
