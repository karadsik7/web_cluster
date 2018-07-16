<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/include/header.jsp" />
<style>
	.nav-sidebar { 
    width: 100%;
    padding: 8px 0; 
    border-right: 1px solid #ddd;
}
.nav-sidebar a {
    color: #333;
    -webkit-transition: all 0.08s linear;
    -moz-transition: all 0.08s linear;
    -o-transition: all 0.08s linear;
    transition: all 0.08s linear;
    -webkit-border-radius: 4px 0 0 4px; 
    -moz-border-radius: 4px 0 0 4px; 
    border-radius: 4px 0 0 4px; 
}
.nav-sidebar .active a { 
	width: 100%;
    cursor: default;
    background-color: #428bca; 
    color: #fff; 
    text-shadow: 1px 1px 1px #666; 
}
.nav-sidebar .active a:hover {
    background-color: #428bca;   
}
.nav-sidebar .text-overflow a,
.nav-sidebar .text-overflow .media-body {
    white-space: nowrap;
    overflow: hidden;
    -o-text-overflow: ellipsis;
    text-overflow: ellipsis; 
} 
</style>
<script>
	window.onload = function(){
		$('#delBtn').addClass('active');
		$('#add').hide();
	}
	function addForm(){
		$('#add').show();
		$('#del').hide();
		$('#delBtn').removeClass('active');
		$('#addBtn').addClass('active');
	}
	
	function delForm(){
		$('#add').hide();
		$('#del').show();
		$('#addBtn').removeClass('active');
		$('#delBtn').addClass('active');
	}
	
	function addAdmin(id){
		if(window.confirm(id+"님에게 관리자 권한을 부여하시겠습니까?")){
			$.ajax({
				url : "/member/addAdmin",
				type : "post",
				data : {"id" : id},
				success : function(data){
					if(data == 'error'){
						alert("서버 장애로 실패하였습니다. 다시 시도해주세요.");
					}else if(data == 'done'){
						alert(id+"님에게 관리자 권한을 부여했습니다.");
						location.reload();
					}else if(data == 'hack'){
						alert("비정상적 데이터 접근입니다.");
						location.href = "http://www.police.go.kr";
					}
				}
			})
		}
	}

	function delAdmin(id){
		if(window.confirm(id+"님에게 관리자 권한을 제거하시겠습니까?")){
			$.ajax({
				url : "/member/delAdmin",
				type : "post",
				data : {"id" : id},
				success : function(data){
					if(data == 'error'){
						alert("서버 장애로 실패하였습니다. 다시 시도해주세요.");
					}else if(data == 'done'){
						alert(id+"님에게 관리자 권한을 제거했습니다.");
						location.reload();
					}else if(data == 'hack'){
						alert("비정상적 데이터 접근입니다.");
						location.href = "http://www.police.go.kr";
					}
				}
			})
		}
	}
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/include/nav.jsp" />
<header class="masthead" style="background-image: url('/img/admin.jpg') ">
	<div class="overlay"></div>
</header>

	<div class="container">
		<div class="header">
		<h2>관리자 페이지</h2>
		</div>
		<div class="bod">
			<div class="col-sm-2">
				<nav class="nav-sidebar">
                <ul class="nav">
                    <li id="delBtn"><a href="javascript:delForm();"><span class="glyphicon glyphicon-remove"></span> 관리자 제거</a></li>
                    <li id="addBtn"><a href="javascript:addForm();"><span class="glyphicon glyphicon-ok"></span> 관리자 추가</a></li>
                </ul>
                </nav>
			</div>
			<div id="del" class="panel panel-success text-center col-sm-10">
				<div class="panel-heading">관리자 목록</div>
				<div class="panel-body">
						<table class="table table-sm table-bordered table-striped">
							<tr>
								<th width="50%">아이디</th>
								<th width="30%">이름</th>
								<th width="20%"></th>
							</tr>	
							<c:forEach var="admin" items="${adminList }">
							<c:if test="${myId != admin.id }">
							<tr>
								<td>
									${admin.id }
								</td>
								<td>
									${admin.name }
								</td>
								<td>
									<button type="button" class="btn btn-danger" onclick="delAdmin('${admin.id}');">권한 제거</button>
								</td>
							</tr>
							</c:if>
							</c:forEach>
						</table>
				</div>
			</div>
			<div id="add" class="panel panel-success text-center col-sm-10">
				<div class="panel-heading">멤버 목록</div>
				<div class="panel-body">
						<table class="table table-sm table-bordered table-striped">
							<tr>
								<th width="50%">아이디</th>
								<th width="30%">이름</th>
								<th width="20%"></th>
							</tr>	
							<c:forEach var="member" items="${memberList }">
							<tr>
								<td>
									${member.id }
								</td>
								<td>
									${member.name }
								</td>
								<td>
									<button type="button" class="btn btn-danger" onclick="addAdmin('${member.id}');">권한 추가</button>
								</td>
							</tr>
							</c:forEach>
						</table>
				</div>
			</div>
		</div>
	</div>



<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>
</html>