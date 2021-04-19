package org.namxjung.startproject.service;

import java.util.List;

import org.namxjung.startproject.persistence.TestVo;

public interface TestService {

	public List<TestVo> list();
	
	public  TestVo read(int store_num);

}
