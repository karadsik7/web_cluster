package com.inc.vo;

public class BoardTypeVo {

	private int id;
	private String name;
	private int b_total_count;
	private int b_yesterday_count;
	

	public int getB_total_count() {
		return b_total_count;
	}

	public void setB_total_count(int b_total_count) {
		this.b_total_count = b_total_count;
	}

	public int getB_yesterday_count() {
		return b_yesterday_count;
	}

	public void setB_yesterday_count(int b_yesterday_count) {
		this.b_yesterday_count = b_yesterday_count;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
	
	
}
