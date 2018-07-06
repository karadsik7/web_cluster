package com.inc.vo;

import javax.validation.constraints.Pattern;

public class MemberVo {
	@Pattern(regexp="[A-Za-z]{1}[A-Za-z0-9]{3,9}", message="영대소문자(+숫자)의 조합만 가능합니다.")
	private String id;
	@Pattern(regexp="[A-Za-z0-9]{3,10}", message="알파벳 혹은 숫자의 조합으로 3글자 이상 입력해주세요.")
	private String password;
	private String passwordConfirm;
	@Pattern(regexp="[가-힣]{2,6}", message="이름은 한글 2~6글자로 입력하세요.")
	private String name;
	@Pattern(regexp="[A-Za-z0-9]+@[A-Za-z0-9]+.[A-Za-z]{2,10}", message="이메일 주소를 올바르게 입력하세요")
	private String email;
	@Pattern(regexp="[mf]{1}", message="올바르지 않은 데이터 접근입니다.")
	private String gender;
	private String emailCode;
	private int admin;
	
	
	public int getAdmin() {
		return admin;
	}
	public void setAdmin(int admin) {
		this.admin = admin;
	}
	public String getEmailCode() {
		return emailCode;
	}
	public void setEmailCode(String emailCode) {
		this.emailCode = emailCode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPasswordConfirm() {
		return passwordConfirm;
	}
	public void setPasswordConfirm(String passwordConfirm) {
		this.passwordConfirm = passwordConfirm;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
}
