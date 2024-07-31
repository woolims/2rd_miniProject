package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.DetailCategoryVo;

public class DetailCategoryDaoImpl implements DetailCategoryDao {

    private SqlSession sqlSession;

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public List<DetailCategoryVo> selectList() {
        return sqlSession.selectList("category.d_category_list");
    }

	@Override
	public List<DetailCategoryVo> selectList(int categoryNo) {
		// TODO Auto-generated method stub
		 return sqlSession.selectList("category.d_category_list_from_categoryno", categoryNo);
	}

}
