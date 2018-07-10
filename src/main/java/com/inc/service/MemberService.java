package com.inc.service;

import com.inc.vo.MemberVo;

public interface MemberService {

	public void add(MemberVo mvo);

	public MemberVo findOne(MemberVo mvo);

	public String dualCheck(String id);

	public boolean emailDualCheck(String email);

	public String mailSend(String email);

	public void modify(MemberVo memberVo);

	public String findId(String email);
	
	public void passMailSend(String email, String id);
	
}
