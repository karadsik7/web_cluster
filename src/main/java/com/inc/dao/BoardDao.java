package com.inc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.inc.vo.BoardTypeVo;
import com.inc.vo.BoardVo;
import com.inc.vo.MemberVo;
import com.inc.vo.TagVo;

public class BoardDao {

	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<BoardVo> list(Map<String, Object> searchMap) {
		return sqlSession.selectList("board.list", searchMap);
	}

	public void add(BoardVo boardVo) {
		sqlSession.insert("board.add", boardVo);
	}

	public BoardVo findOne(int id) {
		return sqlSession.selectOne("board.selectOne", id);
	}

	public void hitUp(int id) {
		sqlSession.update("board.hit", id);
	}

	public void update(BoardVo boardVo) {
		sqlSession.update("board.update", boardVo);
	}

	public void delete(int id) {
		sqlSession.delete("board.delete", id);
	}

	public void updateStep(BoardVo boardVo) {
		sqlSession.update("board.updateStep", boardVo);
	}

	public void addReply(BoardVo boardVo) {
		sqlSession.insert("board.addReply", boardVo);
	}

	public int getTotalCount(Map<String, Object> searchMap) {
		return sqlSession.selectOne("board.totalCount", searchMap);
	}

	public void notice(int id) {
		sqlSession.update("board.notice", id);
	}

	public void delNotice(int id) {
		sqlSession.update("board.delNotice", id);
	}

	public BoardTypeVo boardType(int convertType) {
		return sqlSession.selectOne("board.boardType", convertType);
	}

	public List<BoardTypeVo> boardTypeList() {
		return sqlSession.selectList("board.boardTypeList");
	}

	public List<BoardTypeVo> boardStasisList() {
		return sqlSession.selectList("board.boardStasisList");
	}

	public int boardDualCheck(String name) {
		return sqlSession.selectOne("board.boardCheck", name);
	}

	public void boardAdd(String name) {
		sqlSession.insert("board.boardAdd", name);
	}

	public void delBoard(int id) {
		sqlSession.delete("board.delBoard", id);
	}

	public void modBoard(Map<String, Object> modMap) {
		sqlSession.update("board.modBoard", modMap);
	}

	public List<BoardTypeVo> boardStasisSearchList(String name) {
		return sqlSession.selectList("board.boardStasisSearchList", name);
	}

	public List<BoardVo> boardNoticeList(int type) {
		return sqlSession.selectList("board.boardNoticeList", type);
	}

	public List<TagVo> tagList() {
		return sqlSession.selectList("tags.list");
	}

	public int favoriteDualCheck(Map<String, Object> idMap) {
		return sqlSession.selectOne("board.favoriteDualCheck", idMap);
	}

	public void addFavorite(Map<String, Object> idMap) {
		sqlSession.insert("board.addFavorite", idMap);
	}

	
	

	
	
	
	
	
}
