package org.namxjung.startproject.service;

import java.util.List;

import org.namxjung.startproject.persistence.TestDao;
import org.namxjung.startproject.persistence.TestVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TestServiceImpl implements TestService {
	@Autowired
	private TestDao myTestDao;

	public void setMyBoardDao(TestDao myTestDao) {
		this.myTestDao = myTestDao;
	}

	public List<TestVo> list() {
		System.out.println("과욘?");
		return myTestDao.selectAll();
	}

	@Override
	public TestVo read(int store_num) {
		return myTestDao.select(store_num);
	}
	

}
