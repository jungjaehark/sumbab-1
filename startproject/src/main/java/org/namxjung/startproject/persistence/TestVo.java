package org.namxjung.startproject.persistence;

public class TestVo {
	private int store_num;
	private String address;

	public TestVo(int store_num, String address) {
		this.store_num= store_num;
		this.address = address;
	}

	public TestVo() {}



	public int getStore_num() {
		return store_num;
	}

	public void setStore_num(int storenum) {
		this.store_num = storenum;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}


	

}
