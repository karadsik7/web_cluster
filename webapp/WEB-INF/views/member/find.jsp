<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/include/header.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/include/nav.jsp" />
<header class="masthead" style="background-image: url('/img/search.jpg') ">
	<div class="overlay"></div>
</header>

	<div class="container">
		<div class="header">
		
		</div>
		<div class="bod">
				<div class="panel panel-success text-center">
					<div class="panel-heading">아이디 찾기</div>
					<div class="panel-body"><a href="/member/idFind">이메일로 인증</a></div>
				</div>
				<div class="panel panel-danger text-center">
					<div class="panel-heading">비밀번호 찾기</div>
					<div class="panel-body"><a href="/member/passFind">이메일로 인증</a></div>
				</div>
		</div>
	</div>



<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>
</html>