package com.inc.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.inc.vo.BoardVo;

public interface FreeBoardService {

	List<BoardVo> list(Map<String, Object> searchMap);

	void add(BoardVo boardVo);

	BoardVo findOne(int id);

	void hitUp(int id);

	void update(BoardVo boardVo);

	void delete(int id);

	void updateStep(BoardVo boardVo);

	void addReply(BoardVo boardVo);

	int getTotalCount(Map<String, Object> searchMap);

	boolean checkAdmin(HttpSession session);

	void notice(int id);

	boolean checkNotice(int id);

	void delNotice(int id);

	
	
	
}
