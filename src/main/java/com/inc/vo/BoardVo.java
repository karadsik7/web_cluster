package com.inc.vo;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class BoardVo {
/*
	ID      NOT NULL NUMBER       
	NAME    NOT NULL VARCHAR2(30) 
	TITLE   NOT NULL VARCHAR2(60) 
	CONTENT NOT NULL CLOB         
	IP               VARCHAR2(20) 
	REGDATE          DATE         
	HIT              NUMBER       
	REF              NUMBER       
	STEP             NUMBER       
	DEPTH            NUMBER       
	M_ID             VARCHAR2(10) 
	NOTICE           NUMBER(1)    
	TYPE             NUMBER       
	T_ID             NUMBER 
	*/
	
	private int id;
	@Pattern(regexp="[A-Za-z가-힣]{1,10}", message="이름은 1~10글자 이내로 작성해주세요")
	private String name;
	@Size(min=1, max=20, message="제목은 1글자부터 20글자 이내로 작성해주세요.")
	private String title;
	@Size(min=1, message="본문을 입력해주세요.")
	private String content;
	private String ip;
	private String regdate;
	private int hit;
	private int ref;
	private int step;
	private int depth;
	private String m_id;
	private MemberVo mvo;
	private int notice;
	private int type;
	private int commentCount;
	private int t_id;
	private TagVo tvo;
	private int favoriteCount;
	
	
	
	
	public int getFavoriteCount() {
		return favoriteCount;
	}
	public void setFavoriteCount(int favoriteCount) {
		this.favoriteCount = favoriteCount;
	}
	public TagVo getTvo() {
		return tvo;
	}
	public void setTvo(TagVo tvo) {
		this.tvo = tvo;
	}
	public int getT_id() {
		return t_id;
	}
	public void setT_id(int t_id) {
		this.t_id = t_id;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getNotice() {
		return notice;
	}
	public void setNotice(int notice) {
		this.notice = notice;
	}
	public MemberVo getMvo() {
		return mvo;
	}
	public void setMvo(MemberVo mvo) {
		this.mvo = mvo;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	
	
	
	
}
