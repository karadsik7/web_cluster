<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/include/header.jsp" />
<link href="/css/board.css" rel="stylesheet">
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
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
		<h1 class="title text_center">게시글 수정</h1>
	</div>
	<div class="body">
	<form:form action="/board/update" method="post" modelAttribute="boardVo">
	<form:hidden path="id" value="${boardVo.id }" />
		<table class="board-view table table-bordered table-hover">
			<tr class="info">
				<th width="30%">제목</th>
				<td>
					<form:input type="text" path="title" value="${boardVo.title }"/>
					<form:errors path="title" class="errors"/>
				</td>
			</tr>
			<tr class="active">
				<th>이름</th>
				<td>
					<form:input type="text" path="name" value="${boardVo.name }"/>
					<form:errors path="name" class="errors"/>
				</td>
			</tr>
			<tr class="warning">
				<th>내용</th>
				<td colspan="2" class="content">
					<form:textarea path="content" id="content" value="${boardVo.content}"></form:textarea>
					<form:errors path="content" class="errors"/>
				</td>
			</tr>
		</table>
		<div class="buttons">
			<button class="btn btn-priamry btn-lg">수정</button>
			<button class="btn btn-danger btn-lg" type="button" onclick="location.href='/board/view?id='+${boardVo.id}">취소</button>
		</div>
	</form:form>
	</div>
	<div class="footer">
	
	</div>
</div>
<jsp:include page="/WEB-INF/include/footer.jsp" />
	<!-- summernote -->
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/lang/summernote-ko-KR.min.js"></script>
	<script>
		$("#content").summernote({
			height: 300,
			focus: true,
			lang: "ko-KR",
			callbacks: {
				onImageUpload : function(files, editor, welEditable){
					sendFile(files[0], editor, welEditable);
				}
			}
		});
	</script>
</body>
</html>