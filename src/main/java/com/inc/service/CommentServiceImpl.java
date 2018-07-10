package com.inc.service;

import java.util.List;

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
	
	
	
	
	
}
