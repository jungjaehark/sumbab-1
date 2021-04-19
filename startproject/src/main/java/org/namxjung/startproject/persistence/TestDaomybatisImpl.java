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
	public TestVo select(int store_num) {
		TestVo vo = (TestVo) sqlSession.selectOne("select", store_num);
		return vo;
	}

}
