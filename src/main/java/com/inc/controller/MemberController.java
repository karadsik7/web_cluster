package com.inc.controller;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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

import com.inc.encryptor.SHA256Encryptor;
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
	public String signup(@ModelAttribute @Valid MemberVo memberVo, BindingResult result, Model model, HttpSession session) {
		//유효성 검사
		if(memberService.dualCheck(memberVo.getId()) == "denied") {
			FieldError error = new FieldError("idDual", "id", "중복된 아이디입니다. 중복 확인을 하시기 바랍니다.");
			result.addError(error);
		}else if(!memberVo.getPassword().equals(memberVo.getPasswordConfirm())) {
			FieldError error = new FieldError("passwordNotEqual", "password", "패스워드가 일치하지 않습니다.");
			result.addError(error);
		}else if(!memberVo.getEmail().equals(session.getAttribute("email"))) {
			FieldError error = new FieldError("emailCorruption", "email", "인증 메일을 발송한 메일 계정으로 가입하세요.");
			result.addError(error);
		}else if(!memberVo.getEmailCode().equals(session.getAttribute("emailCode"))){
			FieldError error = new FieldError("emailCodeError", "emailCode", "인증 번호가 일치하지 않습니다. 메일을 확인하세요");
			result.addError(error);
		}
		if(result.hasErrors()) {
			return "/member/signup.jsp";
		}
		//암호화
		String encryptedPassword = SHA256Encryptor.shaEncrypt(memberVo.getPassword()); 
		memberVo.setPassword(encryptedPassword);
		memberService.add(memberVo);
		return "redirect:/";
	}
	
	@RequestMapping(value="/member/login", method=RequestMethod.GET)
	public String loginForm() {
		return "/member/login.jsp";
	}
	
	@RequestMapping(value="/member/login", method=RequestMethod.POST)
	public String login(HttpServletRequest request, @ModelAttribute MemberVo mvo, Model model) {
		//암호화
		String encryptedPassword = SHA256Encryptor.shaEncrypt(mvo.getPassword()); 
		mvo.setPassword(encryptedPassword);
		
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
	
	@RequestMapping(value="/member/mailSend", method=RequestMethod.POST)
	@ResponseBody
	public String mailSend(@RequestParam String email, HttpSession session) {
		//유효성 검사
		if(email.length() == 0) {
			return "null";
		}else if(!emailValidator(email)) {
			return "inconsistence";
		//중복 체크
		}else if(!memberService.emailDualCheck(email)) {
			return "dual";
		//데이터에 이상 없을 시 메일 전송 및 코드 세션 저장
		}else {
			String emailCode;
			try {
				emailCode = memberService.mailSend(email);
				session.setAttribute("email", email);
				session.setAttribute("emailCode", emailCode);
				return "done";
			}
			 catch (RuntimeException e) {
				return "error";
			}
		}
	}
	
	private boolean emailValidator(String email) {
		return Pattern.compile("[A-Za-z0-9]+@[A-Za-z0-9]+.[A-Za-z]{2,10}").matcher(email).matches();
	}
	
	
}
