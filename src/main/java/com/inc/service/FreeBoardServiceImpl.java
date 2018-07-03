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
	
	
	
	
	
	
	
	
	
}
