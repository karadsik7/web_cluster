package com.inc.service;

import java.util.List;

import javax.servlet.http.HttpSession;

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

	public List<MemberVo> getAdminList();

	public List<MemberVo> getNormalList();
	
	public boolean checkAdmin(HttpSession session);

	public void addAdmin(String id);

	public void delAdmin(String id);

	public List<MemberVo> adminSearchList(String id);

	public List<MemberVo> memberSearchList(String id);
	
}
