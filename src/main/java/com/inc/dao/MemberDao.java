package com.inc.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.inc.vo.MemberVo;

public class MemberDao {

	private SqlSession session;
	
	public void setSqlSession(SqlSession session) {
		this.session = session;
	}
	
	public void add(MemberVo mvo) {
		session.insert("member.add", mvo);
	}

	public MemberVo findOne(MemberVo mvo) {
		return session.selectOne("member.findOne", mvo);
	}

	public int dualCheck(String id) {
		return session.selectOne("member.dualCheck", id);
	}

	public int emailDualCheck(String email) {
		return session.selectOne("member.emailCheck", email);
	}

	public void modify(MemberVo memberVo) {
		session.update("member.modify", memberVo);
	}

	public String findId(String email) {
		return session.selectOne("member.findId", email);
	}

	public void tempPass(Map<String, String> tempMap) {
		session.update("member.tempPass", tempMap);
	}
	
	
	
	
}
