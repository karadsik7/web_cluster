package com.inc.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.inc.dao.MemberDao;
import com.inc.encryptor.SHA256Encryptor;
import com.inc.vo.MemberVo;

public class MemberServiceImpl implements MemberService{

	private MemberDao memberDao;
	private JavaMailSender javaMailSender;
	
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	
	public void setJavaMailSender(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}



	@Override
	public void add(MemberVo mvo) {
		memberDao.add(mvo);
	}


	@Override
	public MemberVo findOne(MemberVo mvo) {
		mvo.setPassword(SHA256Encryptor.shaEncrypt(mvo.getPassword()));
		return memberDao.findOne(mvo);
	}

	@Override
	public String dualCheck(String id) {
		int result = memberDao.dualCheck(id);
		if(result == 0) {
			return "allowed";
		}else {
			return "denied";
		}
	}

	@Override
	public boolean emailDualCheck(String email) {
		int count = memberDao.emailDualCheck(email);
		if(count == 0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public String mailSend(String email) {
		String mailCode = getRandomCode();
		MimeMessage msg = javaMailSender.createMimeMessage();
		MimeMessageHelper helper;
		try {
			helper = new MimeMessageHelper(msg, true, "UTF-8");
			helper.setFrom("mktprogramtester@gmail.com");
			helper.setTo(email);
			helper.setSubject("Web Cluster 인증메일입니다.");
			helper.setText("Web Cluster 회원가입 요청에 감사드립니다! Web Cluster에 회원가입을 하시기 위해선 이하의 인증번호를 입력해주세요.\n\t\t인증번호 : " + mailCode);
			javaMailSender.send(msg);
		} catch (MessagingException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		return mailCode;
	}
	
	@Override
	public void modify(MemberVo memberVo) {
		memberVo.setPassword(SHA256Encryptor.shaEncrypt(memberVo.getPassword()));
		memberDao.modify(memberVo);
		
	}
	
	@Override
	public String findId(String email) {
		return memberDao.findId(email);
	}

	private String getRandomCode() {
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < 4; i++) {
			sb.append((int)(Math.random()*10));
		}
		return sb.toString();
	}
	
	
	

	
	
	
	
	
	
}
