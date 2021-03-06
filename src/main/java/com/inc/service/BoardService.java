package com.inc.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.inc.vo.BoardTypeVo;
import com.inc.vo.BoardVo;
import com.inc.vo.TagVo;

public interface BoardService {

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

	BoardTypeVo getBoardType(int convertType);

	List<BoardTypeVo> boardTypeList();

	List<BoardTypeVo> getboardStasisList();

	boolean validateBoardName(String name);

	void boardAdd(String name);

	void delBoard(int id);

	void modBoard(int id, String name);

	List<BoardTypeVo> boardStasisSearchList(String name);

	List<BoardVo> boardNoticeList(int type);

	List<TagVo> tagList();

	boolean tagVerifier(List<TagVo> tagList, int t_id);

	boolean favoriteDual(String loginMemberId, int id);

	void addFavorite(String loginMemberId, int id);
	
	
}
