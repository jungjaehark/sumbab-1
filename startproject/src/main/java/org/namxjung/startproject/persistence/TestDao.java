package org.namxjung.startproject.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface TestDao {
	
	//테스트 첫페이지에 사용 전체 게시물 출력 번호와 이름만
	public List<TestVo> selectAll();
	
	public TestVo selectOne(int store_num);
	
	//==================================================================================================================
	//리뷰 테이블에서 가져올것들
	List<Map<String, Object>> selectReviews(int store_num, int page_num);
	
	List<Map<String, Object>> selectReviewsPaging(int store_num, int page_num);	
	
	int getReviewCount(int storeNum);
	
	//==================================================================================================================


}
