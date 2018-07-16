<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/include/header.jsp" />
<link href="/css/board.css" rel="stylesheet">
<link href="/css/boardView.css" rel="stylesheet">
<script src="/js/boardView.js" type="text/javascript"></script>
	
</head>
<body>
<jsp:include page="/WEB-INF/include/nav.jsp" />
<header class="masthead" style="background-image: url('/img/board.png') ">
      <div class="overlay"></div>
</header>
<div class="container">
	<div class="header">
		<c:if test="${isAdmin && !isNotice}">
			<button type="button" class="btn btn-lg btn-warning" 
			onclick="notice(${board.id});">이 글을 공지사항으로</button>
		</c:if>
		<c:if test="${isAdmin && isNotice}">
			<button type="button" class="btn btn-lg btn-warning" 
			onclick="delNotice(${board.id});">공지사항 해제</button>
		</c:if>
	</div>
	<div class="body">
		<table class="board-view table table-bordered table-hover">
			<tr class="info">
				<th width="30%">제목</th>
				<td>${board.title }</td>
			</tr>
			<tr class="active">
				<th>이름</th>
				<td>${board.name } (${board.m_id})</td>
			</tr>
			<tr class="warning">
				<th>내용</th>
				<td colspan="2" class="content">${board.content }</td>
			</tr>
		</table>
		<div class="buttons">
			<button type="button" style="text-align: right" class="btn btn-lg btn-info" 
			onclick="location.href='/board/list/${board.type}'">목록</button>
			<button type="button" class="btn btn-lg btn-primary" 
			onclick="location.href='/board/reply?id=${board.id }'">답글</button>
			<c:if test="${board.mvo.id == loginMemberId}">
			<button type="button" style="text-align: right;" class="btn btn-lg btn-success"
			onclick="mod(${board.id});">수정</button>
			</c:if>
			<c:if test="${board.mvo.id == loginMemberId || isAdmin}">
			<button type="button" style="text-align: right" class="btn btn-lg btn-danger"
			onclick="del(${board.id}, ${board.type});">삭제</button>
			</c:if>
		</div>
	</div>
	
	 <div class="footer">
		<div class="comments">
			<form:form action="/comment/add" modelAttribute="commentVo" method="post">
				<form:input type="hidden" path="b_id" value="${board.id }"/>
				<table class="table table-bordered">
					<tr>
						<th width="15%">이름</th>
						<td>
							<form:input type="text" path="name" class="form-control"/>
						</td>
						<td></td>
					</tr>
					<tr>
						<th width="15%">내용</th>
						<td><form:textarea path="content" class="commentWrite form-control" cols="60" rows="3"></form:textarea>
							<c:forEach var="error" items="${errors}">
								<p class="errors">${error.defaultMessage }</p>
							</c:forEach>	
						</td>
						<td rowspan="2"><button style="width:100%; height:100%;" 
						class="btn btn-lg btn-primary">댓글 등록</button></td>
					</tr>
				</table>
				
			</form:form>
			<table class="table table-bordered table-sm comment_table">
			<c:if test="${empty commentList}">
				<tr>
					<th colspan="2">
						댓글이 존재하지 않습니다.
					</th>				
				</tr>
			</c:if>
			<c:forEach var="comment" items="${commentList}">
				<c:if test="${comment.loveCount - comment.hateCount >= 2}">
					<tr class="comment_best_tr">
					<th width="15%" class="commentName bestTh text-right">${comment.name} <br /> (${comment.m_id})</th>
					<td width="75%" class="commentContent bestTd"><span class="label label-danger">best</span><br />${comment.content}</td>
					<td width="10%" class="bestTd">
						<button class="btn btn-sm thumb_up_btn" type="button" onclick="love(${comment.id}, ${board.id});">
							<span class="glyphicon glyphicon-thumbs-up thumb"></span>좋아요 <span class="count">${comment.loveCount}</span>
						</button>
						<button class="btn btn-sm thumb_down_btn" type="button" onclick="hate(${comment.id}, ${board.id});">
							<span class="glyphicon glyphicon-thumbs-down thumb"></span>싫어요 <span class="count">${comment.hateCount}</span>
						</button>
						<f:parseDate var="date" value="${comment.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/>
						<span class="commentTime"><f:formatDate value="${date }" pattern="yy.MM.dd HH:mm:ss"/></span>
						<c:if test="${isAdmin || loginMemberId == comment.m_id}">
							<span class="label label-danger glyphicon glyphicon-remove" onclick="delComment(${comment.id}, ${board.id});">삭제</span>
						</c:if>
				</c:if>
			</c:forEach>
			<c:forEach var="comment" items="${commentList}">
				<tr class="comment_all_tr">
					<th width="15%" class="commentName comment_all_th text-right">${comment.name} <br /> (${comment.m_id})</th>
					<td width="75%" class="commentContent"><c:if test="${comment.loveCount - comment.hateCount >= 2}"><span class="label label-danger">best</span><br /></c:if>${comment.content}</td>
					<td width="10%">
						<button class="btn btn-sm thumb_up_btn" type="button" onclick="love(${comment.id}, ${board.id});">
							<span class="glyphicon glyphicon-thumbs-up thumb"></span>좋아요 <span class="count">${comment.loveCount}</span>
						</button>
						<button class="btn btn-sm thumb_down_btn" type="button" onclick="hate(${comment.id}, ${board.id});">
							<span class="glyphicon glyphicon-thumbs-down thumb"></span>싫어요 <span class="count">${comment.hateCount}</span>
						</button>
						<f:parseDate var="date" value="${comment.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/>
						<span class="commentTime"><f:formatDate value="${date }" pattern="yy.MM.dd HH:mm:ss"/></span>
						<c:if test="${isAdmin || loginMemberId == comment.m_id}">
							<span class="label label-danger glyphicon glyphicon-remove" onclick="delComment(${comment.id}, ${board.id});">삭제</span>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</table>
			
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>
</html>