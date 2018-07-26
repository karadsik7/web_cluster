<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/include/header.jsp" />
<link href="/css/board.css" rel="stylesheet">
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
<style>
.reply{
	width: 100%;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/include/nav.jsp" />
<header class="masthead" style="background-image: url('/img/board1.png') ">
      <div class="overlay"></div>
</header>

<div class="container">
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
		<hr />
	<form:form action="/board/reply" method="post" modelAttribute="boardVo">
	<form:hidden path="id" value="${board.id }" />
	<form:hidden path="type" value="${board.type }" />
		<table class="board-view table table-bordered table-hover reply">
			<tr class="info">
				<th width="30%">제목</th>
				<td>
					<form:input type="text" path="title" class="form-control"/>
					<form:errors class="errors" path="title"/>				
				</td>
			</tr>
			<tr class="active">
				<th>이름</th>
				<td>
					<form:input type="text" path="name" class="form-control"/>
					<form:errors class="errors" path="name"/>
				</td>
			</tr>
			<tr class="warning">
				<th>내용</th>
				<td colspan="2" class="">
					<form:textarea path="content" id="content" class="form-control"></form:textarea>
					<form:errors class="errors" path="content"/>
				</td>
			</tr>
			<tr class="active">
				<th>분류</th>
				<td>
					<c:forEach var="tag" items="${tagList}">
						<label class="radio-inline">
							<input type="radio" name="t_id" value="${tag.id}" <c:if test="${tag.id == 1}">checked="checked"</c:if>>${tag.name}
						</label>	
					</c:forEach>
				</td>
			</tr>
		</table>
		<div class="buttons">
			<button class="btn btn-primary btn-lg">등록</button>
			<button type="button" onclick="location.href='/board/list/${board.type}'" class="btn btn-danger btn-lg">취소</button>
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
		
		function sendFile(file, editor, welEditable){
			var data = new FormData();
			data.append('upload', file);
			$.ajax({
				url : "/board/imgUpload",
				cache: false,
				processData: false,
                contentType: false,
				data : data,
				type : "post",
				success : function(data){
					var $img = $("<img>").attr('src', data.url);
					$("#content").summernote("insertNode", $img[0]);
				}
			});
		} 
	</script>
</body>
</html>