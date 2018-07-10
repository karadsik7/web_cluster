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
<style>
	.commentTime{
		font-size: 11px;
	    color: #999;
	    font-family: tahoma;
	    white-space: nowrap;
	    text-align: right;
	}
	.table{
		width: 100%;
	}
	.commentName{
		position: relative;
	    padding-right: 10px;
	    top: 5px;
	    padding-bottom: 10px;
	}
	.commentWrite {
    height: auto;
    overflow: hidden;
    overflow-y: scroll;
    width: 100%;
    border: 0;
    border-bottom: 1px solid #c2c2c2;
    vertical-align: top;
    padding: 0;
    resize: vertical;
    background: 0 0;
    font: 12px/1.5 '돋움',dotum,sans-serif;
    co
	
</style>
<script>
	function del(id){
		if(confirm("정말로 삭제하시겠습니까?")){
			$.ajax({
				"url" : "/board/del",
				"type" : "post",
				"data" : {"id" : id},
				"success" : function(data){
					alert("삭제가 완료됐습니다. 메인페이지로 이동합니다.");
					location.href = '${pageContext.request.contextPath}/board/list';
				}
			})
		}
	}
	
	function mod(id){
		if(confirm("수정하시겠습니까?")){
			location.href = '${pageContext.request.contextPath}/board/update?id='+id;
		}
	}
	
	function notice(id){
		if(confirm("이 글을 공지로 등록하시겠습니까?")){
			$.ajax({
				url : '/board/notice',
				type : 'post',
				data : {id : id},
				success : function(data){
					if(data == 'notAdmin'){
						alert("비정상적 접근입니다.");
						return;
					}else if(data == 'error'){
						alert("에러가 발생했습니다. 잠시 후 다시 시도해주세요.");
						return;
					}else if(data == 'success'){
						alert("공지로 등록했습니다.");
						location.href='/board/view?id='+id;
					}
				}
			});
		}
	}
	
	function delNotice(id){
		if(confirm("공지에서 해제하시겠습니까?")){
			$.ajax({
				url : '/board/delNotice',
				type : 'post',
				data : {id : id},
				success : function(data){
					if(data == 'notAdmin'){
						alert("비정상적 접근입니다.");
						return;
					}else if(data == 'error'){
						alert("에러가 발생했습니다. 잠시 후 다시 시도해주세요.");
						return;
					}else if(data == 'success'){
						alert("일반글로 전환하였습니다.");
						location.href='/board/view?id='+id;
					}
				}
			});
		}
	}
</script>
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
				<td>${board.name }</td>
			</tr>
			<tr class="warning">
				<th>내용</th>
				<td colspan="2" class="content">${board.content }</td>
			</tr>
		</table>
		<div class="buttons">
			<button type="button" style="text-align: right" class="btn btn-lg btn-info" 
			onclick="location.href='${pageContext.request.contextPath}/board/list'">목록</button>
			<button type="button" class="btn btn-lg btn-primary" 
			onclick="location.href='${pageContext.request.contextPath}/board/reply?id=${board.id }'">답글</button>
			<c:if test="${board.mvo.id == loginMemberId}">
			<button type="button" style="text-align: right;" class="btn btn-lg btn-success"
			onclick="mod(${board.id});">수정</button>
			</c:if>
			<c:if test="${board.mvo.id == loginMemberId || isAdmin}">
			<button type="button" style="text-align: right" class="btn btn-lg btn-danger"
			onclick="del(${board.id});">삭제</button>
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
			<table class="table table-bordered table-sm">
			<c:if test="${empty commentList}">
				<tr>
					<th colspan="2">
						댓글이 존재하지 않습니다.
					</th>				
				</tr>
			</c:if>
			<c:forEach var="comment" items="${commentList}">
				<tr>
					<th width="15%" class="commentName">${comment.name} <br /> (${comment.m_id})</th>
					<td width="75%" class="commentContent">${comment.content}</td>
					<td width="10%">
						<button class="btn btn-sm">
							<span class="glyphicon glyphicon-thumbs-up" style="color:blue;"></span>조와요
						</button>
						<button class="btn btn-sm" >
							<span class="glyphicon glyphicon-thumbs-down" style="color:blue;"></span>시러요
						</button>
						<f:parseDate var="date" value="${comment.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/>
						<span class="commentTime"><f:formatDate value="${date }" pattern="yy.MM.dd HH:mm:ss"/></span>
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