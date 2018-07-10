package com.inc.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.inc.vo.CommentVo;

public class CommentDao {

	private SqlSession session;
	
	public void setSqlSession(SqlSession session) {
		this.session = session;
	}

	public List<CommentVo> list(int id) {
		return session.selectList("comments.list", id);
	}

	public void add(CommentVo commentVo) {
		session.insert("comments.add", commentVo);
	}
	
}
