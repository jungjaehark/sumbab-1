package org.namxjung.startproject.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class TestDaomybatisImpl implements TestDao {
	
	private SqlSession sqlSession;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
		
	@Override
	public List<TestVo> selectAll() {
		return sqlSession.selectList("selectAll");
	}

	@Override
	public TestVo selectOne(int store_num) {
		return sqlSession.selectOne("selectOne", store_num);
	}


//==============================================================================

	@Override
	public ReviewVo selectReview(int store_num) {
		return sqlSession.selectOne("selectReview", store_num);
	}




}
