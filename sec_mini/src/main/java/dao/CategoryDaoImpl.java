package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.CategoryVo;

public class CategoryDaoImpl implements CategoryDao {
	
	SqlSession sqlSession;
	
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}


	@Override
	public List<CategoryVo> selectList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("category.category_list");
	}

}
