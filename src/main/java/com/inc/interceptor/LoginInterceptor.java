package com.inc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		if(request.getSession().getAttribute("member") == null) {
			request.setAttribute("msg", "로그인 후 이용 가능합니다.");
			request.setAttribute("url", "/member/login");
			request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
			return false;
		}
		return true;
	}

	
	
}
