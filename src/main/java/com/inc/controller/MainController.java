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
		Map<String, Object> freeboardMap = new HashMap<>();
		freeboardMap.put("page", 1);
		freeboardMap.put("type", 1);
		Map<String, Object> humorboardMap = new HashMap<>();
		humorboardMap.put("page", 1);
		humorboardMap.put("type", 2);
		Map<String, Object> lolboardMap = new HashMap<>();
		lolboardMap.put("page", 1);
		lolboardMap.put("type", 3);
		/*Map<String, Object> bgboardMap = new HashMap<>();
		freeboardMap.put("page", 1);
		freeboardMap.put("type", 4);
		Map<String, Object> owboardMap = new HashMap<>();
		freeboardMap.put("page", 1);
		freeboardMap.put("type", 5);
		Map<String, Object> dfboardMap = new HashMap<>();
		freeboardMap.put("page", 1);
		freeboardMap.put("type", 6);*/
		
		
		
		List<BoardVo> freeboardList = boardService.list(freeboardMap);
		List<BoardVo> humorboardList = boardService.list(humorboardMap);
		List<BoardVo> lolboardList = boardService.list(lolboardMap);
	/*	List<BoardVo> bgboardList = boardService.list(bgboardMap);
		List<BoardVo> owboardList = boardService.list(owboardMap);
		List<BoardVo> dfboardList = boardService.list(dfboardMap);
		*/
		
		model.addAttribute("freeboardList", freeboardList);
		model.addAttribute("humorboardList", humorboardList);
		model.addAttribute("lolboardList", lolboardList);
	/*	model.addAttribute("bgboardList", bgboardList);
		model.addAttribute("dfboardList", dfboardList);
		model.addAttribute("owboardList", owboardList);*/
		return "/home.jsp";
	}
	
}
