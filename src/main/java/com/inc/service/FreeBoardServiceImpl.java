package com.inc.service;

import java.util.List;

import com.inc.dao.FreeBoardDao;
import com.inc.vo.BoardVo;

import oracle.net.aso.b;

public class FreeBoardServiceImpl implements FreeBoardService{

	private FreeBoardDao freeBoardDao;

	public void setFreeBoardDao(FreeBoardDao freeBoardDao) {
		this.freeBoardDao = freeBoardDao;
	}

	@Override
	public List<BoardVo> list() {
		return freeBoardDao.list();
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
	
	
	
	
	
	
	
	
	
}
