package org.namxjung.startproject.service;

import java.util.List;

import org.namxjung.startproject.persistence.ReviewVo;
import org.namxjung.startproject.persistence.TestVo;

public interface TestService {

	//전체조회 글과 이름만
	public List<TestVo> list();
	
	public TestVo readStore(int store_num);
	


}
