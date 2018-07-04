<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/include/header.jsp" />
<link href="/css/board.css" rel="stylesheet">
<script>
	function del(id){
		if(confirm("정말로 삭제하시겠습니까?")){
			$.ajax({
				"url" : "/fboard/del",
				"type" : "post",
				"data" : {"id" : id},
				"success" : function(data){
					alert("삭제가 완료됐습니다. 메인페이지로 이동합니다.");
					location.href = '${pageContext.request.contextPath}/fboard/list';
				}
			})
		}
	}
	
	function mod(id){
		if(confirm("수정하시겠습니까?")){
			location.href = '${pageContext.request.contextPath}/fboard/update?id='+id;
		}
	}
	
</script>
<style>
	.table{
	width: 100%;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/include/nav.jsp" />
<header class="masthead" style="background-image: url('/img/board.png') ">
      <div class="overlay"></div>
</header>
<div class="container">
	<div class="header">
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
			onclick="location.href='${pageContext.request.contextPath}/fboard/list'">목록</button>
			<button type="button" class="btn btn-lg btn-primary" 
			onclick="location.href='${pageContext.request.contextPath}/fboard/reply?id=${board.id }'">답글</button>
			<c:if test="${board.mvo.id == loginMemberId}">
			<button type="button" style="text-align: right;" class="btn btn-lg btn-success"
			onclick="mod(${board.id});">수정</button>
			<button type="button" style="text-align: right" class="btn btn-lg btn-danger"
			onclick="del(${board.id});">삭제</button>
			</c:if>
		</div>
	</div>
	
	<%-- <div class="footer">
		<div class="reply">
			<form method="post">
				<input type="hidden" name="b_id" value="${board.id }"/>
				<table class="board-view">
					<caption>:::comment:::</caption>
					<tr>
						<th width="30%">이름</th>
						<td><input type="text" name="name"/></td>
					</tr>
					<tr>
						<th width="30%">내용</th>
						<td><input type="text" name="content"/></td>
					</tr>
					<tr>
						<th>
							<button type="button" onclick="replySend(this.form);">댓글등록</button>
						</th>
					</tr>
				</table>
			</form> --%>
			<%-- <table class="board-view">
			<c:if test="${empty board.replyList}">
				<tr>
					<th colspan="2">
						댓글이 존재하지 않습니다.
					</th>				
				</tr>
			</c:if>
			<c:forEach var="reply" items="${board.replyList }">
				<tr>
					<th width="30%">${reply.name }</th>
					<td>${reply.content }</td>
				</tr>
			</c:forEach>
			</table> --%>
			
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>
</html>