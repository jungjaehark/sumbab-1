package org.namxjung.startproject.service;

import java.util.List;
import java.util.Map;

import org.namxjung.startproject.persistence.ReviewVo;
import org.namxjung.startproject.persistence.StoreVo;

public interface StoreViewService {

	//전체조회 글과 이름만
	public List<StoreVo> list();
	
	public StoreVo readStore(int store_num);
	

	


}
