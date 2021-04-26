package org.namxjung.startproject.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StoreDaomybatisImpl implements StoreDao {

	private SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<StoreVo> selectAll() {
		return sqlSession.selectList("selectAll");
	}

	@Override
	public StoreVo selectOne(int store_num) {
		return sqlSession.selectOne("selectOne", store_num);
	}

	@Override
	public List<Map<String, Object>> nearbyCafe(int store_num) {
		return sqlSession.selectList("nearbycafe", store_num);
	}

	@Override
	public List<Map<String, Object>> nearbyRestaurant(int store_num) {
		return sqlSession.selectList("nearbyrestaurant", store_num);
	}

//==============================================================================

	@Override
	public List<Map<String, Object>> selectReviews(int store_num, int page_num) {
		System.out.println("리뷰 셀렉 실행확인");
		System.out.println(store_num);

		Map<String, Integer> map = new HashMap<>();

		/*
		 * 기본 페이징 기법 -- PAGE_NO가 1일 때 1 ~ 5, 2일 때 6 ~ 10 -- 1 - 1 * 5 + 1을 하면 1일때는 1이
		 * 나오고 2일때는 2 - 1 * 5 + 1이니까 1 * 5 + 1이면 6 구글링으로,,,,,
		 */
		// 예를들어 게시물의
		int startNum = (page_num - 1) * 5 + 1;
		int endNum = page_num * 5;

		map.put("store_num", store_num);
		map.put("startNum", startNum);
		map.put("endNum", endNum);

		return sqlSession.selectList("selectReviews", map);
	}

	// 위와 같이
	@Override
	public List<Map<String, Object>> selectReviewsPaging(int store_num, int page_num) {
		System.out.println("리뷰 셀렉 실행확인");
		System.out.println(store_num);
		Map<String, Integer> map = new HashMap<>();
		int startNum = (page_num - 1) * 5 + 1;
		int endNum = page_num * 5;
		System.out.printf("startNum=%d, endNum=%d\n", startNum, endNum);
		map.put("store_num", store_num);
		map.put("startNum", startNum);
		map.put("endNum", endNum);

		return sqlSession.selectList("selectReviewsPaging", map);
	}

	@Override
	public int getReviewCount(int storeNum) {
		return sqlSession.selectOne("reviewCount", storeNum);
	}

}
