package org.namxjung.startproject.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<Map<String, Object>> selectReviews(int store_num) {
		System.out.println("리뷰 셀렉 실행확인");
		System.out.println(store_num);
		
		return sqlSession.selectList("selectReviews", store_num);
	}

	
}
