package dao;

import java.util.List;

import vo.DetailCategoryVo;

public interface DetailCategoryDao {

	List<DetailCategoryVo> selectList();

	List<DetailCategoryVo> selectList(int categoryNo);
}
