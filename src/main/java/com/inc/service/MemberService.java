package com.inc.service;

import com.inc.vo.MemberVo;

public interface MemberService {

	public void add(MemberVo mvo);

	public MemberVo findOne(MemberVo mvo);

	public String dualCheck(String id);
	
}
