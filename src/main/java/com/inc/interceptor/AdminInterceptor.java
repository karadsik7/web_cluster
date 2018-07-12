package com.inc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.inc.vo.MemberVo;

public class AdminInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		MemberVo member = (MemberVo)request.getSession().getAttribute("member");
		if(member == null || member.getAdmin() == 0) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/");
			request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
			return false;
		}
		return true;
	}

	
	
}
