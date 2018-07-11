package com.inc.dao;

import java.util.List;
import java.util.Map;

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

	public CommentVo findOne(int id) {
		return session.selectOne("comments.findOne", id);
	}

	public void delete(int id) {
		session.delete("comments.delete", id);
	}

	public int commentDualCheck(Map<String, Object> idMap) {
		return session.selectOne("comments.dualCheck", idMap);
	}

	public void addLove(Map<String, Object> idMap) {
		session.insert("comments.addLove", idMap);
	}

	public void addHate(Map<String, Object> idMap) {
		session.insert("comments.addHate", idMap);
	}
	
}
