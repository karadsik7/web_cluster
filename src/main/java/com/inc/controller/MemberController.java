package com.inc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inc.service.MemberService;
import com.inc.vo.MemberVo;

@Controller
public class MemberController {

	private MemberService memberService;
	
	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}
	
	
	@RequestMapping(value="/member/signup", method=RequestMethod.GET)
	public String signupForm(Model model) {
		model.addAttribute("memberVo", new MemberVo());
		return "/member/signup.jsp";
	}
	
	@RequestMapping(value="/member/signup", method=RequestMethod.POST)
	public String signup(@ModelAttribute @Valid MemberVo memberVo, BindingResult result, Model model) {
		if(!memberVo.getPassword().equals(memberVo.getPasswordConfirm())) {
			FieldError error = new FieldError("passwordNotEqual", "password", "패스워드가 일치하지 않습니다.");
			result.addError(error);
		}//이후에 이메일 인증번호 대조해서 불일치시 에러 던질것
		if(result.hasErrors()) {
			return "/member/signup.jsp";
		}
		memberService.add(memberVo);
		return "redirect:/";
	}
	
	@RequestMapping(value="/member/login", method=RequestMethod.GET)
	public String loginForm() {
		return "/member/login.jsp";
	}
	
	@RequestMapping(value="/member/login", method=RequestMethod.POST)
	public String login(HttpServletRequest request, @ModelAttribute MemberVo mvo, Model model) {
		MemberVo findMember = memberService.findOne(mvo);
		if(findMember == null) {
			model.addAttribute("msg", "아이디 혹은 비밀번호가 틀렸습니다.");
			model.addAttribute("url", "/member/login");
			return "/error.jsp";
			
		}else {
			request.getSession().invalidate();
			request.getSession().setAttribute("member", findMember);
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="/member/logout", method=RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="/member/dualCheck", method=RequestMethod.POST)
	@ResponseBody
	public String dualCheck(@RequestParam String id) {
		if(id == "") {
			FieldError error = new FieldError("noValueId", "id", "아이디를 입력하세요.");
			return "denied";
		}
		String result = memberService.dualCheck(id);
		return result;
	}
	
	
}
