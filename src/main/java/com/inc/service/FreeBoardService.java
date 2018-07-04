package com.inc.service;

import java.util.List;

import javax.validation.Valid;

import com.inc.vo.BoardVo;

public interface FreeBoardService {

	List<BoardVo> list();

	void add(BoardVo boardVo);

	BoardVo findOne(int id);

	void hitUp(int id);

	void update(BoardVo boardVo);

	void delete(int id);

	void updateStep(BoardVo boardVo);

	void addReply(BoardVo boardVo);

	
	
	
}
