package com.inc.vo;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class CommentVo {
/*	
	ID      NOT NULL NUMBER        
	B_ID             NUMBER        
	M_ID             VARCHAR2(10)  
	NAME    NOT NULL VARCHAR2(30)  
	CONTENT NOT NULL VARCHAR2(300) 
	REGDATE NOT NULL DATE*/ 
	
	
	private int id;
	private int b_id;
	private String m_id;
	@Pattern(regexp="[A-Za-z0-9가-힣ㄱ-ㅎ]{2,10}", message="이름은 10글자 이내로만 작성해주세요.")
	private String name;
	@Size(min=2, max=100, message="내용은 100자 이내로만 작성 가능합니다.")
	private String content;
	private String regdate;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
	
}
