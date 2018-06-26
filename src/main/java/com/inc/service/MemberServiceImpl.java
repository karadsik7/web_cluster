package com.inc.service;

import com.inc.dao.MemberDao;
import com.inc.vo.MemberVo;

public class MemberServiceImpl implements MemberService{

	private MemberDao memberDao;
	
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	
	@Override
	public void add(MemberVo mvo) {
		memberDao.add(mvo);
	}


	@Override
	public MemberVo findOne(MemberVo mvo) {
		return memberDao.findOne(mvo);
	}

	@Override
	public String dualCheck(String id) {
		int result = memberDao.dualCheck(id);
		if(result == 0) {
			return "allowed";
		}else {
			return "denied";
		}
	}
	
	
	
}
