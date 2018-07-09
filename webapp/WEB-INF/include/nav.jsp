<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
	<div class="container">
		<a class="navbar-brand" href="/">Web Cluster</a>
		<button class="navbar-toggler navbar-toggler-right" type="button"
			data-toggle="collapse" data-target="#navbarResponsive"
			aria-controls="navbarResponsive" aria-expanded="true"
			aria-label="Toggle navigation">
			Menu<i class="fa fa-bars"></i>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
				<c:if test="${sessionScope.member != null}">
					<li class="nav-item"><a class="nav-link" href="/fboard/list">Board</a></li>
					<li class="nav-item"><a class="nav-link" href="/member/modify">MyPage</a></li>
					<li class="nav-item"><a class="nav-link" href="/member/logout">Logout</a></li>
				</c:if>
				<c:if test="${sessionScope.member == null }">
					<li class="nav-item"><a class="nav-link" href="/member/signup">Register</a></li>
					<li class="nav-item"><a class="nav-link" href="/member/login">Login</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</nav>