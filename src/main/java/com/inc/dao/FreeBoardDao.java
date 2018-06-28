package com.inc.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.inc.vo.BoardVo;

public class FreeBoardDao {

	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<BoardVo> list() {
		return sqlSession.selectList("freeBoard.list");
	}

	
	
	
	
	
}
