<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/include/header.jsp" />
<link href="/css/board.css?ver=1" rel="stylesheet">
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
	.vertical-menu {
		margin-left: 10%;
		margin-top : 30%;
		display:inline-block;
  			width: 200px;
	}

	.vertical-menu a {
	    background-color: #eee;
	    color: black;
	    display: block;
	    padding: 12px;
	    text-decoration: none;
	}
	
	.vertical-menu a:hover {
	    background-color: #ccc;
	}
	
	.vertical-menu a.active {
	    background-color: #007bff;
	    color: white;
	}
	
	.btn-group button {
    background-color: #333; 
    border: 1px solid black;
    color: white; 
    padding: 10px 24px;
    cursor: pointer;
    float: left;
	}
	
	.btn-group:after {
	    content: "";
	    clear: both;
	    display: table;
	}
	
	.btn-group button:not(:last-child) {
	    border-right: none;
	}
	
	.btn-group button:hover {
	    background-color: red;
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
	
	function search(type){
		var option = $('#search_option').val();
		var text = $('#search_text').val();
		if(text == "" && option == 'all'){
			alert("검색어를 입력하세요.");
			$('#search_text').focus();
			return;
		}else{
			location.href = '/board/list/'+type+'?option='+option+'&text='+text;
		}
	}
	
	
</script>
<body>
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<header class="masthead" style="background-image: url('/img/board.png') ">
      <div class="overlay"></div>
    </header>
    <div class="col-sm-2">
    	<h2 class="text-center">커뮤니티</h2>
		<div class="vertical-menu">
			<c:forEach var="bt" items="${boardTypeList}">
				<a href="/board/list/${bt.id}" <c:if test="${bt.id == boardType.id}">class="active"</c:if>>${bt.name}</a>
			</c:forEach>
		</div>
	</div>
	<div class="container-fluid">
		<div class="col-sm-8">
		<div class="header" style="margin-top:0">
			<h2 class="text-left">${boardType.name}</h2>
			<div class="btn-group" style="width:100%">
			  <button style="width:25%">정보/TIP</button>
			  <button style="width:25%">추천글</button>
			  <button style="width:25%">질문</button>
			  <button style="width:25%">스크린샷</button>	
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
						<a href="/board/view?id=${bvo.id}">${bvo.title }</a>
					<td>${bvo.name } (${bvo.m_id})</td>
					<td>
						${bvo.regdate }
					</td>
					<td>${bvo.hit }</td>
				</tr>
				</c:forEach>
			</table>
			<div>
				<div class="search">
					<select id="search_option" onchange="lock();">
						<option value="all">전체</option>
						<option value="title">제목</option>
						<option value="name">이름</option>
						<option value="content">내용</option>
						<option value="title_content">제목+내용</option>
					</select>
					<input type="text" id="search_text" value="${param.text }" />
					<button type="button" onclick="search(${boardType.id});" class="btn btn-success">찾기</button>
				</div>
				<button type="button" onclick="location.href='/board/add/${boardType.id}'" class="btn btn-primary btn-lg" style="float:right; padding-top: 10px;">글쓰기</button>
			</div>
		</div>
			<div class="center">
				<ul class="pagination">
					${paging}
				</ul>
			</div>
		</div>
	</div>
<!-- script library -->
	<div>
		<jsp:include page="/WEB-INF/include/footer.jsp" />
	</div>
</body>
</html>