package org.namxjung.startproject.persistence;

import java.util.List;

public interface TestDao {
	public List<TestVo> selectAll();
	
	public TestVo select(int store_num);
}
