package com.inc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.inc.service.FreeBoardService;

@Controller
public class FreeBoardController {
	
	private FreeBoardService freeBoardService;

	public void setFreeBoardService(FreeBoardService freeBoardService) {
		this.freeBoardService = freeBoardService;
	}
	
	@RequestMapping(value="/fboard/list", method=RequestMethod.GET)
	public String list() {
		return "/board/list.jsp";
	}
	
	
	
	
	
}
