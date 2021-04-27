package org.namxjung.startproject.service;

import java.util.List;

import org.namxjung.startproject.persistence.StoreDao;
import org.namxjung.startproject.persistence.StoreVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StoreViewServiceImpl implements StoreViewService {
	@Autowired
	private StoreDao myTestDao;
//서비스는 비교적한산한 편인듯싶다...
	public void setMyBoardDao(StoreDao myTestDao) {
		this.myTestDao = myTestDao;
	}

	public List<StoreVo> list() {
		System.out.println("과욘?");
		return myTestDao.selectAll();
	}

	@Override
	public StoreVo readStore(int store_num) {
		return myTestDao.selectOne(store_num);
	}



}
