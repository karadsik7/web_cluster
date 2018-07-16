package com.inc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.inc.service.BoardService;
import com.inc.vo.BoardVo;

@Controller
public class MainController {

	private BoardService boardService;
	
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}


	@RequestMapping("/")
	public String main(Model model) {
		Map<String, Object> defaultMap = new HashMap<>();
		defaultMap.put("page", 1);
		defaultMap.put("type", 1);
		List<BoardVo> boardList = boardService.list(defaultMap);
		model.addAttribute("boardList", boardList);
		return "/home.jsp";
	}
	
}
