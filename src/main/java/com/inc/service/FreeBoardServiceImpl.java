package com.inc.service;

import java.util.List;

import com.inc.dao.FreeBoardDao;
import com.inc.vo.BoardVo;

public class FreeBoardServiceImpl implements FreeBoardService{

	private FreeBoardDao freeBoardDao;

	public void setFreeBoardDao(FreeBoardDao freeBoardDao) {
		this.freeBoardDao = freeBoardDao;
	}

	@Override
	public List<BoardVo> list() {
		return freeBoardDao.list();
	}
	
	
	
	
	
	
	
}
