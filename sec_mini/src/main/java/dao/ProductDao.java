package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import vo.ProductVo;

public class ProductDao {

	@Autowired
	SqlSession sqlSession;	//SqlSessionTemplate의 interface
	
	//Setter Injection
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public ProductVo selectOne(int pNo) {
		return sqlSession.selectOne("product.select_pNo", pNo);
	}
	
	public int insertProduct(ProductVo vo) {
		return sqlSession.insert("product.product_insert", vo);
	}
	
	public int updateProduct(ProductVo vo) {
		return sqlSession.update("product.product_update", vo);
	}
	
	public int deleteProduct(int pNo) {
		return sqlSession.delete("product.product_delete", pNo);
	}
	
}
