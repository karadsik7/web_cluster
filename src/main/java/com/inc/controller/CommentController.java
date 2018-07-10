package com.inc.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.inc.service.CommentService;
import com.inc.service.FreeBoardService;
import com.inc.vo.CommentVo;
import com.inc.vo.MemberVo;

@Controller
public class CommentController {

	private CommentService commentService;
	private FreeBoardService freeBoardService;
	
	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}
	
	public void setFreeBoardService(FreeBoardService freeBoardService) {
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
	
	
	
}
