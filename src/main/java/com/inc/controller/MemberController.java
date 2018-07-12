package com.inc.controller;

import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.inc.vo.BoardVo;
import com.inc.vo.MemberVo;

@Controller
public class MemberController {

	private MemberService memberService;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
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
	public String dualCheck(@RequestParam String id, BindingResult result) {
		if(id == "") {
			FieldError error = new FieldError("noValueId", "id", "아이디를 입력하세요.");
			result.addError(error);
			return "denied";
		}
		String dualResult = memberService.dualCheck(id);
		return dualResult;
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
				logger.error("error by mailSend", e.getMessage());
				return "error";
			}
		}
	}
	
	@RequestMapping(value="/member/modify", method=RequestMethod.GET)
	public String modifyForm(Model model, HttpSession session) {
		MemberVo member = (MemberVo)session.getAttribute("member");
		member.setPassword(null);
		model.addAttribute("memberVo", member);
		return "/member/modify.jsp";
	}
	
	@RequestMapping(value="/member/modify", method=RequestMethod.POST)
	public String modify(@ModelAttribute @Valid MemberVo memberVo, BindingResult result, Model model, 
			HttpSession session) {
		MemberVo originMember = (MemberVo)session.getAttribute("member");
		String sessionEmail = (String)session.getAttribute("email");
		
		//이메일 바꾸고 인증 안하는 경우 체크
		if(!originMember.getEmail().equals(memberVo.getEmail()) && sessionEmail == null) {
			FieldError error = new FieldError("emailValid", "email", "이메일 인증이 필요합니다.");
			result.addError(error);
		}
		if(result.hasErrors()) {
			memberVo.setId(originMember.getId());
			memberVo.setEmail(originMember.getEmail());
			model.addAttribute("memberVo", memberVo);
			return "/member/modify.jsp";
		}else {
			memberVo.setId(originMember.getId());
			memberService.modify(memberVo);
			session.invalidate();
			model.addAttribute("msg", "회원정보 수정이 완료됐습니다. 재로그인 해주세요.");
			model.addAttribute("url", "/member/login");
			return "/error.jsp";
		}
	}
	
	@RequestMapping(value="/member/find", method=RequestMethod.GET)
	public String findForm() {
		return "/member/find.jsp";
	}
	
	@RequestMapping(value="/member/idFind", method=RequestMethod.GET)
	public String idFindForm() {
		return "/member/idFind.jsp";
	}
	
	@RequestMapping(value="/member/idFind", method=RequestMethod.POST)
	@ResponseBody
	public String idFindForm(@RequestParam String email) {
		String result = memberService.findId(email);
		System.out.println(result);
		return result;
	}
	
	@RequestMapping(value="/member/passFind", method=RequestMethod.GET)
	public String passFindForm() {
		return "/member/passFind.jsp";
	}
	
	@RequestMapping(value="/member/passFind", method=RequestMethod.POST)
	@ResponseBody
	public String passFindForm(@RequestParam String email) {
		String id = memberService.findId(email);
		if(id == null) {
			return "notFind";
		}else {
			try {
				memberService.passMailSend(email, id);
				return "success";
			} catch (RuntimeException e) {
				logger.error("error by passFindMailSend", e.getMessage());
				return "error";
			}
		}
	}
	
	@RequestMapping(value="/member/admin", method=RequestMethod.GET)
	public String adminForm(Model model, HttpSession session) {
		List<MemberVo> adminList = memberService.getAdminList();
		List<MemberVo> memberList = memberService.getNormalList();
		MemberVo loginAdmin = (MemberVo)session.getAttribute("member");
		model.addAttribute("myId", loginAdmin.getId());
		model.addAttribute("memberList", memberList);
		model.addAttribute("adminList", adminList);
		return "/member/admin.jsp";
	}
	
	@RequestMapping(value="/member/addAdmin", method=RequestMethod.POST)
	@ResponseBody
	public String addAdmin(@RequestParam String id, HttpSession session) {
		if(!memberService.checkAdmin(session)) {
			return "hack";
		}else {
			try {
				memberService.addAdmin(id);
				return "done";
			} catch (RuntimeException e) {
				logger.error("error by addAdmin", e.getMessage());
				return "error";
			}
		}
	}
	
	@RequestMapping(value="/member/delAdmin", method=RequestMethod.POST)
	@ResponseBody
	public String delAdmin(@RequestParam String id, HttpSession session) {
		if(!memberService.checkAdmin(session)) {
			return "hack";
		}else {
			try {
				memberService.delAdmin(id);
				return "done";
			} catch (RuntimeException e) {
				logger.error("error by delAdmin", e.getMessage());
				return "error";
			}
		}
	}
	
	
	private boolean emailValidator(String email) {
		return Pattern.compile("[A-Za-z0-9]+@[A-Za-z0-9]+.[A-Za-z]{2,10}").matcher(email).matches();
	}
	
	
	
}
