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
<header class="masthead" style="background-image: url('/img/login.jpg') ">
	<div class="overlay"></div>
</header>

	<div class="container">
		<form action="/member/login" method="post" class="form-horizontal">
			<div class="form-group">
				<label for="id" class="control-label col-sm-2 col-sm-offset-1">아이디</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="id" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="password" class="control-label col-sm-2 col-sm-offset-1">비밀번호</label>
				<div class="col-sm-6">
					<input type="password" name="password" class="form-control" />
				</div>
			</div>
			<br />
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-3">
					<button class="btn btn-success btn-block" type="button" onclick="location.href='/member/search'">아이디/비밀번호 찾기</button>
				</div>
				<div class="col-sm-3">
					<button class="btn btn-primary btn-block">로그인</button>
				</div>
			</div>
		</form>
	</div>



<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>
</html>