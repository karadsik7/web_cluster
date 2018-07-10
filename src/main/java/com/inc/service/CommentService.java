package com.inc.service;

import java.util.List;

import javax.validation.Valid;

import com.inc.vo.CommentVo;

public interface CommentService {

	List<CommentVo> list(int id);

	void add(CommentVo commentVo);

	
	
}
