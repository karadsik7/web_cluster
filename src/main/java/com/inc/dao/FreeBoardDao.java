package com.inc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.inc.vo.BoardVo;

public class FreeBoardDao {

	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<BoardVo> list(Map<String, Object> searchMap) {
		return sqlSession.selectList("freeBoard.list", searchMap);
	}

	public void add(BoardVo boardVo) {
		sqlSession.insert("freeBoard.add", boardVo);
	}

	public BoardVo findOne(int id) {
		return sqlSession.selectOne("freeBoard.selectOne", id);
	}

	public void hitUp(int id) {
		sqlSession.update("freeBoard.hit", id);
	}

	public void update(BoardVo boardVo) {
		sqlSession.update("freeBoard.update", boardVo);
	}

	public void delete(int id) {
		sqlSession.delete("freeBoard.delete", id);
	}

	public void updateStep(BoardVo boardVo) {
		sqlSession.update("freeBoard.updateStep", boardVo);
	}

	public void addReply(BoardVo boardVo) {
		sqlSession.insert("freeBoard.addReply", boardVo);
	}

	public int getTotalCount(Map<String, Object> searchMap) {
		return sqlSession.selectOne("freeBoard.totalCount", searchMap);
	}
	
	

	
	
	
	
	
}
