package com.briup.entity;


public class CombinationProduct {
	private String ids;
	private String names;
	public CombinationProduct() {
	}
	public CombinationProduct(String ids, String names) {
		this.ids = ids;
		this.names = names;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getNames() {
		return names;
	}
	public void setNames(String names) {
		this.names = names;
	}
	@Override
	public String toString() {
		return "CombinationProduct [ids=" + ids + ", names=" + names + "]";
	}
	
}
