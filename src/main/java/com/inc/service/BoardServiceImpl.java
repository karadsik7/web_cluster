package com.inc.service;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.inc.dao.BoardDao;
import com.inc.vo.BoardVo;
import com.inc.vo.MemberVo;


public class BoardServiceImpl implements BoardService{

	private BoardDao boardDao;
	
	public static final int maxCountOfOneList = 10;
	public static final int maxCountOfOnePage = 10;

	public void setBoardDao(BoardDao boardDao) {
		this.boardDao = boardDao;
	}

	@Override
	public List<BoardVo> list(Map<String, Object> searchMap) {
		int page = (int)searchMap.get("page");
		int startRownum = (page - 1) * maxCountOfOneList + 1;
		int endRownum = startRownum + (maxCountOfOneList - 1);
		
		searchMap.put("start", startRownum);
		searchMap.put("end", endRownum);
		List<BoardVo> boardList = boardDao.list(searchMap);
		boardList = compareDay(boardList);
		return boardList;
	}

	@Override
	public void add(BoardVo boardVo) {
		
		boardDao.add(boardVo);
	}

	@Override
	public BoardVo findOne(int id) {
		return boardDao.findOne(id);
	}

	@Override
	public void hitUp(int id) {
		boardDao.hitUp(id);
	}

	@Override
	public void update(BoardVo boardVo) {
		boardDao.update(boardVo);
	}

	@Override
	public void delete(int id) {
		boardDao.delete(id);
	}

	@Override
	public void updateStep(BoardVo boardVo) {
		//답글을 쓰는 원본글의 ref depth step 정보를 가져옴
		BoardVo originVo = boardDao.findOne(boardVo.getId());
		//ref depth step 설정
		boardVo.setRef(originVo.getRef());
		boardVo.setDepth(originVo.getDepth() + 1);
		boardVo.setStep(originVo.getStep() + 1);
		boardDao.updateStep(boardVo);
	}

	@Override
	public void addReply(BoardVo boardVo) {
		boardDao.addReply(boardVo);
	}

	@Override
	public int getTotalCount(Map<String, Object> searchMap) {
		return boardDao.getTotalCount(searchMap);
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
		boardDao.notice(id);
	}
	
	@Override
	public void delNotice(int id) {
		boardDao.delNotice(id);
	}

	@Override
	public boolean checkNotice(int id) {
		BoardVo bvo = boardDao.findOne(id);
		if(bvo.getNotice() == 1) {
			return true;
		}else {
			return false;
		}
	}
	
	
	private List<BoardVo> compareDay(List<BoardVo> boardList) {
		Calendar today = Calendar.getInstance();
		Integer todayYear = today.get(Calendar.YEAR);
		Integer todayMonth = today.get(Calendar.MONTH) + 1;
		Integer todayDate = today.get(Calendar.DATE);
		
		String strMonth = String.valueOf(todayMonth);
		if(todayMonth < 10) {
			strMonth = "0" +todayMonth;
		}
		String toDay = todayYear+"-"+strMonth+"-"+todayDate;
		
		for(int i = 0; i < boardList.size(); i++) {
			if(toDay.equals(boardList.get(i).getRegdate().substring(0, 10))) {
				boardList.get(i).setRegdate(boardList.get(i).getRegdate().substring(11, 16));
			}else {
				boardList.get(i).setRegdate(boardList.get(i).getRegdate().replaceAll("-", ".").substring(0, 10));
			}
		}
		return boardList;
	}
	
	
	
	
	
	
	
	
}
