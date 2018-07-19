package com.inc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inc.service.BoardService;
import com.inc.service.MemberService;
import com.inc.vo.BoardTypeVo;
import com.inc.vo.MemberVo;

@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	private BoardService boardService;
	private MemberService memberService;
	
	
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}

	@RequestMapping(value="/admin", method=RequestMethod.GET)
	public String adminForm(Model model, HttpSession session) {
		List<MemberVo> adminList = memberService.getAdminList();
		Map<String, Object> memberMap = new HashMap<>();
		memberMap.put("id", "");
		memberMap.put("page", 1);
		Map<String, Object> resultMap = memberService.memberSearchPageList(memberMap);
		List<BoardTypeVo> boardStasisList = boardService.getboardStasisList();
		MemberVo loginAdmin = (MemberVo)session.getAttribute("member");
		model.addAttribute("boardStasisList", boardStasisList);
		model.addAttribute("myId", loginAdmin.getId());
		model.addAttribute("memberMap", memberMap);
		model.addAttribute("adminList", adminList);
		return "/member/admin.jsp";
	}
	
	@RequestMapping(value="/admin/add", method=RequestMethod.POST)
	@ResponseBody
	public String addAdmin(@RequestParam String id, HttpSession session, HttpServletRequest request) {
		if(!memberService.checkAdmin(session)) {
			return "hack";
		}else {
			try {
				memberService.addAdmin(id);
				return "done";
			} catch (RuntimeException e) {
				logger.error("error by addAdmin " + ((MemberVo)session.getAttribute("member")).getId() 
						+ " " + request.getRemoteAddr() + e.getMessage());
				return "error";
			}
		}
	}
	
	@RequestMapping(value="/admin/del", method=RequestMethod.POST)
	@ResponseBody
	public String delAdmin(@RequestParam String id, HttpSession session, HttpServletRequest request) {
		if(!memberService.checkAdmin(session)) {
			return "hack";
		}else {
			try {
				memberService.delAdmin(id);
				return "done";
			} catch (RuntimeException e) {
				logger.error("error by delAdmin " + ((MemberVo)session.getAttribute("member")).getId() 
						+ " " + request.getRemoteAddr() + e.getMessage());
				return "error";
			}
		}
	}
	
	@RequestMapping(value="/admin/boardAdd", method=RequestMethod.POST)
	@ResponseBody
	public String boardAdd(@RequestParam String name) {
		//제목의 유효성 검사, 중복 체크
		if(!boardService.validateBoardName(name)) {
			return "failVal";
		}else {
			try {
				boardService.boardAdd(name);
				return "done";
			} catch (RuntimeException e) {
				logger.error("error by boardAdd as Admin : " + e.getMessage());
				return "error";
			}
		}
	}
	
	@RequestMapping(value="/admin/delBoard", method=RequestMethod.POST)
	@ResponseBody
	public String delBoard(@RequestParam int id) {
		try {
			boardService.delBoard(id);
			return "done";
		} catch (RuntimeException e) {
			logger.error("error by delBoard as Admin : " + e.getMessage());
			return "error";
		}
	}
	
	@RequestMapping(value="/admin/modBoard", method=RequestMethod.POST)
	@ResponseBody
	public String modBoard(@RequestParam int id, @RequestParam String name) {
		if(!boardService.validateBoardName(name)) {
			return "failVal";
		}else {
			try {
				boardService.modBoard(id, name);
				return "done";
			} catch (RuntimeException e) {
				logger.error("error by modBoard as Admin : " + e.getMessage());
				return "error";
			}
		}
	}
	
	@RequestMapping(value="/admin/adminSearch", method=RequestMethod.POST)
	@ResponseBody
	public List<MemberVo> adminSearch(@RequestParam String id){
		List<MemberVo> adminList = memberService.adminSearchList(id);
		return adminList;
	}
	
	@RequestMapping(value="/admin/boardStasisSearch", method=RequestMethod.POST)
	@ResponseBody
	public List<BoardTypeVo> boardStasisSearch(@RequestParam String name){
		List<BoardTypeVo> boardStasisList = boardService.boardStasisSearchList(name);
		return boardStasisList;
	}
	
	@RequestMapping(value="/admin/memberPaging", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> memberPaging(@RequestParam String id, @RequestParam int page){
		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("id", id);
		searchMap.put("page", page);
		Map<String, Object> resultMap = memberService.memberSearchPageList(searchMap);
		return resultMap;
	}
	
	
	
}
