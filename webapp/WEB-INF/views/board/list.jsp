<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<link href="/css/board.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<header class="masthead" style="background-image: url('/img/board.png') ">
      <div class="overlay"></div>
    </header>
	<div class="container">
	<div class="header">
		<div class="search">
			<select id="search_option" onchange="lock();">
				<option value="all">전체</option>
				<option value="title">제목</option>
				<option value="name">이름</option>
				<option value="content">내용</option>
				<option value="title_content">제목+내용</option>
			</select>
			<input type="text" id="search_text" value="${param.text }" />
			<button type="button" onclick="search();" class="btn btn-success">검색</button>
		</div>
	</div>
	<div class="body">
		<table class="board">
			<tr>
				<th style="width:10%">번호</th>
				<th style="width:55%">제목</th>
				<th style="width:15%">이름</th>
				<th style="width:10%">날짜</th>
				<th style="width:10%">조회</th>
			</tr>
			<c:if test="${empty boardList }">
			<tr>
				<td colspan="5">게시물이 존재하지 않습니다.</td>
			</tr>
			</c:if>
			<c:forEach var="bvo" items="${boardList }">
			<tr>
				<td>${bvo.id }</td>
				<td style="text-align: left;">
					<c:forEach var="i" begin="1" end="${bvo.depth }">
						<c:if test="${i != bvo.depth}">
						&nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${i == bvo.depth }">
						└▶
						</c:if>
					</c:forEach>
					<a href="${pageContext.request.contextPath}/board/view?id=${bvo.id}&page=${param.page}">${bvo.title }</a></td>
				<td>${bvo.name }</td>
				<td>
					<f:parseDate var="date" value="${bvo.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/>
					<f:formatDate value="${date }" pattern="yyyy/MM/dd" />
				</td>
				<td>${bvo.hit }</td>
			</tr>
			</c:forEach>
		</table>
		<div class="buttons">
			<button type="button" onclick="location.href='${pageContext.request.contextPath}/board/add'" class="btn btn-primary">글쓰기</button>
		</div>
	</div>
	<div class="footer">
		<div class="paging text_center">
			${paging }
		</div>
	</div>
</div>
<!-- script library -->
	<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>
</html>