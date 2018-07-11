<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<link href="/css/board.css" rel="stylesheet">
	<style>
		.center{
			text-align:center;
		}
		.pagination{
			display:inline-block;
		}
		.notice{
			background-color: #FFFF99 !important;
		}
	</style>
</head>
<script>
	window.onload = function(){
		for(var option of $('#search_option').children()){
			if($(option).val() == '${param.option}'){
				$(option).attr('selected', 'selected');
			}
		}
		$('#search_text').val('${param.text}');
		lock();
	}
	
	function lock(){
		if($('#search_option').val() == 'all'){
			$('#search_text').attr('disabled', 'disabled');
		}else{
			$('#search_text').removeAttr('disabled');
		}
	}
	
	function search(){
		var option = $('#search_option').val();
		var text = $('#search_text').val();
		if(text == "" && option == 'all'){
			alert("검색어를 입력하세요.");
			$('#search_text').focus();
			return;
		}else{
			location.href = '/board/list?option='+option+'&text='+text;
		}
	}
</script>
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
			<button type="button" onclick="search();" class="btn btn-success btn-lg">찾기</button>
		</div>
	</div>
	<div class="body">
		<table class="board table table-striped table-hover">
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
			<tr <c:if test="${bvo.notice == 1}">class="notice"</c:if>>
				<td>${bvo.id }</td>
				<td style="text-align: left;" >
					<c:if test="${bvo.notice == 1}">
						<span class="label label-danger">공지</span>
					</c:if>
					<c:forEach var="i" begin="1" end="${bvo.depth }">
						<c:if test="${i != bvo.depth}">
						&nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${i == bvo.depth }">
						└▶
						</c:if>
					</c:forEach>
					<a href="${pageContext.request.contextPath}/board/view?id=${bvo.id}">${bvo.title }</a>
				<td>${bvo.name } (${bvo.m_id})</td>
				<td>
					<f:parseDate var="date" value="${bvo.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/>
					<f:formatDate value="${date }" pattern="yyyy/MM/dd HH:mm:ss" />
				</td>
				<td>${bvo.hit }</td>
			</tr>
			</c:forEach>
		</table>
		<div class="buttons">
			<button type="button" onclick="location.href='/board/add'" class="btn btn-primary btn-lg">글쓰기</button>
		</div>
	</div>
	<div class="center">
		<ul class="pagination">
			${paging}
		</ul>
	</div>
</div>
<!-- script library -->
	<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>
</html>