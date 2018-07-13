package com.inc.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.inc.service.CommentService;
import com.inc.service.BoardService;
import com.inc.vo.CommentVo;
import com.inc.vo.MemberVo;

@Controller
public class CommentController {
	private CommentService commentService;
	private BoardService freeBoardService;
	private static final Logger logger = LoggerFactory.getLogger(CommentController.class);
	
	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}
	
	public void setFreeBoardService(BoardService freeBoardService) {
		this.freeBoardService = freeBoardService;
	}

	@RequestMapping(value="/comment/add", method=RequestMethod.POST)
	public String add(@ModelAttribute @Valid CommentVo commentVo, BindingResult result, Model model, HttpSession session,
				     RedirectAttributes redirectAttributes) {
		if(result.hasErrors()) {
			redirectAttributes.addFlashAttribute("errors", result.getAllErrors());
			return "redirect:/board/view?id="+commentVo.getB_id();
		}
		MemberVo loginMember = (MemberVo)session.getAttribute("member");
		commentVo.setM_id(loginMember.getId());
		commentService.add(commentVo);
		return "redirect:/board/view?id="+commentVo.getB_id();
	}
	
	@RequestMapping(value="/comment/del", method=RequestMethod.POST)
	@ResponseBody
	public String del(@RequestParam int id, HttpSession session, Model model) {
		CommentVo originVo = commentService.findOne(id);
		//보안상 세션비교
		if(!((MemberVo)session.getAttribute("member")).getId().equals(originVo.getM_id())
				&& !freeBoardService.checkAdmin(session)){
			model.addAttribute("msg", "타인의 게시물은 삭제가 불가능합니다.");
			model.addAttribute("url", "/board/list");
			return "/error.jsp";
		}else {
			commentService.delete(id);
			return "y";
		}
	}
	
	@RequestMapping(value="/comment/love", method=RequestMethod.POST)
	@ResponseBody
	public String love(@RequestParam int id, HttpSession session) {
		MemberVo loginMember = (MemberVo)session.getAttribute("member");
		String loginMemberId = loginMember.getId();
		boolean isCommentDual = commentService.commentDual(loginMemberId, id);
		if(isCommentDual) {
			return "dual";
		}else {
			try {
				commentService.addLove(loginMemberId, id);
				return "done";
			} catch (RuntimeException e) {
				logger.error("error by love", e.getMessage());
				return "error";
			}
		}
	}
	
	@RequestMapping(value="/comment/hate", method=RequestMethod.POST)
	@ResponseBody
	public String hate(@RequestParam int id, HttpSession session) {
		MemberVo loginMember = (MemberVo)session.getAttribute("member");
		String loginMemberId = loginMember.getId();
		boolean isCommentDual = commentService.commentDual(loginMemberId, id);
		if(isCommentDual) {
			return "dual";
		}else {
			try {
				commentService.addHate(loginMemberId, id);
				return "done";
			} catch (RuntimeException e) {
				logger.error("error by hate", e.getMessage());
				return "error";
			}
		}
	}
	
	
	
}
