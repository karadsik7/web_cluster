package com.inc.service;

import java.util.List;

import javax.validation.Valid;

import com.inc.vo.CommentVo;

public interface CommentService {

	List<CommentVo> list(int id);

	void add(CommentVo commentVo);

	CommentVo findOne(int id);

	void delete(int id);

	boolean commentDual(String loginMemberId, int id);

	void addLove(String loginMemberId, int id);

	void addHate(String loginMemberId, int id);


	
	
}
