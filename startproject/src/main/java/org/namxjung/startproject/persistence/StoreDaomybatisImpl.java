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
		//기본페이징기법....게시물수 조정하고 싶으면 이부분을 건드리도록.....
		//결론적으로 1페이지당 5개의 개시물 만약 추가 게시물이 6개면 페이지넘은2가되는....
		int startNum = (page_num - 1) * 5 + 1;
		int endNum = page_num * 5;
			//추후에 결정될 page_num에따라 달라지는 startNum과 endNum
		//store_num, starNum, endNum......다 map에 떄려박고,,,,parameterType이 map인 sql문...
		
		map.put("store_num", store_num);
		map.put("startNum", startNum);
		map.put("endNum", endNum);

		return sqlSession.selectList("selectReviews", map);
	}

	// 컨틀롤러에서 사용될 selectReviewPaging.............mapper도 존나 짜증난다...
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

	@Override
	public List<StoreVo> selectAllAddress() {
		return sqlSession.selectList("selectAllAddress");
	}

}
