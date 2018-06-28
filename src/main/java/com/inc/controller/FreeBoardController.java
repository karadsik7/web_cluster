package com.inc.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.inc.service.FreeBoardService;
import com.inc.vo.BoardVo;

@Controller
public class FreeBoardController {
	
	private FreeBoardService freeBoardService;

	public void setFreeBoardService(FreeBoardService freeBoardService) {
		this.freeBoardService = freeBoardService;
	}
	
	@RequestMapping(value="/fboard/list", method=RequestMethod.GET)
	public String list(Model model) {
		List<BoardVo> boardList = freeBoardService.list();
		model.addAttribute("boardList", boardList);
		return "/board/list.jsp";
	}
	
	@RequestMapping(value="/fboard/add", method=RequestMethod.GET)
	public String addForm(Model model) {
		model.addAttribute("boardVo", new BoardVo());
		return "/board/add.jsp";
	}
	
	@RequestMapping(value="/fboard/add", method=RequestMethod.POST)
	public String add(@ModelAttribute BoardVo boardVo, BindingResult result, HttpSession session) {
		//입력값 검증 및 필드에러 포워드
		if(result.hasErrors()) {
			return "/board/add.jsp";
		}
		//성공시 데이터베이스 입력후 리다이렉트
		
		return "redirect:/";
	}
	
	
	
	
	
}
