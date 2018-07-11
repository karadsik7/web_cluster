package com.inc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.inc.dao.CommentDao;
import com.inc.vo.CommentVo;

public class CommentServiceImpl implements CommentService{

	private CommentDao commentDao;
	
	public void setCommentDao(CommentDao commentDao) {
		this.commentDao = commentDao;
	}

	@Override
	public List<CommentVo> list(int id) {
		return commentDao.list(id);
	}

	@Override
	public void add(CommentVo commentVo) {
		commentDao.add(commentVo);
	}

	@Override
	public CommentVo findOne(int id) {
		return commentDao.findOne(id);
	}

	@Override
	public void delete(int id) {
		commentDao.delete(id);
	}

	@Override
	public boolean commentDual(String loginMemberId, int id) {
		Map<String, Object> idMap = idMapCreate(loginMemberId, id);
		int result = commentDao.commentDualCheck(idMap);
		if(result != 0) {
			return true;
		}else {
			return false;
		}
	}
	
	@Override
	public void addLove(String loginMemberId, int id) {
		Map<String, Object> idMap = idMapCreate(loginMemberId, id);
		commentDao.addLove(idMap);
	}
	
	@Override
	public void addHate(String loginMemberId, int id) {
		Map<String, Object> idMap = idMapCreate(loginMemberId, id);
		commentDao.addHate(idMap);
	}

	private Map<String, Object> idMapCreate(String loginMemberId, int id) {
		Map<String, Object> idMap = new HashMap<>();
		idMap.put("m_id", loginMemberId);
		idMap.put("c_id", id);
		return idMap;
	}

	
	
	
	
	
	
	
	
	
	
}
