package org.namxjung.startproject.persistence;

import java.util.List;

public interface TestDao {
	
	//테스트 첫페이지에 사용 전체 게시물 출력 번호와 이름만
	public List<TestVo> selectAll();
	
	public TestVo selectOne(int store_num);
	
	//==================================================================================================================
	//리뷰 테이블에서 가져올것들
	public ReviewVo selectReview(int store_num);

	
	
	//==================================================================================================================


}
