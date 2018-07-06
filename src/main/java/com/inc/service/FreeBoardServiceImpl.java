package com.inc.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.inc.dao.FreeBoardDao;
import com.inc.vo.BoardVo;
import com.inc.vo.MemberVo;


public class FreeBoardServiceImpl implements FreeBoardService{

	private FreeBoardDao freeBoardDao;
	
	public static final int maxCountOfOneList = 10;
	public static final int maxCountOfOnePage = 10;

	public void setFreeBoardDao(FreeBoardDao freeBoardDao) {
		this.freeBoardDao = freeBoardDao;
	}

	@Override
	public List<BoardVo> list(Map<String, Object> searchMap) {
		int page = (int)searchMap.get("page");
		int startRownum = (page - 1) * maxCountOfOneList + 1;
		int endRownum = startRownum + (maxCountOfOneList - 1);
		
		searchMap.put("start", startRownum);
		searchMap.put("end", endRownum);
		return freeBoardDao.list(searchMap);
	}

	@Override
	public void add(BoardVo boardVo) {
		
		freeBoardDao.add(boardVo);
	}

	@Override
	public BoardVo findOne(int id) {
		return freeBoardDao.findOne(id);
	}

	@Override
	public void hitUp(int id) {
		freeBoardDao.hitUp(id);
	}

	@Override
	public void update(BoardVo boardVo) {
		freeBoardDao.update(boardVo);
	}

	@Override
	public void delete(int id) {
		freeBoardDao.delete(id);
	}

	@Override
	public void updateStep(BoardVo boardVo) {
		//답글을 쓰는 원본글의 ref depth step 정보를 가져옴
		BoardVo originVo = freeBoardDao.findOne(boardVo.getId());
		//ref depth step 설정
		boardVo.setRef(originVo.getRef());
		boardVo.setDepth(originVo.getDepth() + 1);
		boardVo.setStep(originVo.getStep() + 1);
		freeBoardDao.updateStep(boardVo);
	}

	@Override
	public void addReply(BoardVo boardVo) {
		freeBoardDao.addReply(boardVo);
	}

	@Override
	public int getTotalCount(Map<String, Object> searchMap) {
		return freeBoardDao.getTotalCount(searchMap);
	}

	@Override
	public boolean checkAdmin(HttpSession session) {
		MemberVo enterMember = (MemberVo)session.getAttribute("member");
		if(enterMember.getAdmin() == 1) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public void notice(int id) {
		freeBoardDao.notice(id);
	}
	
	@Override
	public void delNotice(int id) {
		freeBoardDao.delNotice(id);
	}

	@Override
	public boolean checkNotice(int id) {
		BoardVo bvo = freeBoardDao.findOne(id);
		if(bvo.getNotice() == 1) {
			return true;
		}else {
			return false;
		}
	}
	
	
	
	
	
	
	
	
	
	
	
}
