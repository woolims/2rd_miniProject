package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.UserVo;


public class UserDao {

	SqlSession sqlSession;	//SqlSessionTemplate의 interface
	
	//Setter Injection
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//전체조회
	public List<UserVo> selectList(){
		return sqlSession.selectList("user.select_list");
	}
	
	public int insert(UserVo vo) {
		return sqlSession.insert("user.user_insert", vo);
	}



	public UserVo login(UserVo vo) {
		return sqlSession.selectOne("user.login", vo);
	}
	
	public UserVo selectOne(String userId) {
		return sqlSession.selectOne("user.select_userId", userId);
	}
	
	public UserVo selectOne(int userNo) {
		return sqlSession.selectOne("user.select_userNo", userNo);
	}
	
	public int update(UserVo vo) {
		return sqlSession.update("user.user_update", vo);
	}//end:update()
	
	public int update_myCash(UserVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.update("user.user_update_myCash", vo);
	}//end:update_point()
	
	public int deleteUser(int userNo) {
		return sqlSession.delete("user.user_delete", userNo);
	
	}//end:delete()

	
}