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
/* 사이드바 */
@media screen and (max-width: 767px) {
  .row-offcanvas {
    position: relative;
    -webkit-transition: all .25s ease-out;
         -o-transition: all .25s ease-out;
            transition: all .25s ease-out;
  }

  .row-offcanvas-right {
    right: 0;
  }

  .row-offcanvas-left {
    left: 0;
  }

  .row-offcanvas-right
  .sidebar-offcanvas {
    right: -60%; /* 6 columns */
  }

  .row-offcanvas-left
  .sidebar-offcanvas {
    left: -60%; /* 6 columns */
  }

  .row-offcanvas-right.active {
    right: 60%; /* 6 columns */
  }

  .row-offcanvas-left.active {
    left: 60%; /* 6 columns */
  }

  .sidebar-offcanvas {
    position: absolute;
    top: 0;
    width: 60%; /* 6 columns */
  }
}
</style>
<script>
	window.onload = function(){
		$('#addBtn').addClass('active');
		$('#del').hide();
		$('#boardAdd_Del').hide();
		$('[data-toggle="offcanvas"]').click(function () {
		    $('.row-offcanvas').toggleClass('active')
		  });
	}
	function addForm(){
		$('#del').hide();
		$('#boardAdd_Del').hide();
		$('#add').show();
		$('#delBtn').removeClass('active');
		$('#boardBtn').removeClass('active');
		$('#addBtn').addClass('active');
	}
	
	function delForm(){
		$('#add').hide();
		$('#boardAdd_Del').hide();
		$('#del').show();
		$('#addBtn').removeClass('active');
		$('#boardBtn').removeClass('active');
		$('#delBtn').addClass('active');
	}
	
	function boardForm(){
		$('#add').hide();
		$('#del').hide();
		$('#boardAdd_Del').show();
		$('#addBtn').removeClass('active');
		$('#delBtn').removeClass('active');
		$('#boardBtn').addClass('active');
	}
	
	function addAdmin(id){
		if(window.confirm(id+"님에게 관리자 권한을 부여하시겠습니까?")){
			$.ajax({
				url : "/admin/add",
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
				url : "/admin/del",
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
	
	function boardAdd(f){
		var name = f.boardName.value;
		$.ajax({
			url : "/admin/boardAdd",
			type : "post",
			data : {name : name},
			success : function(data){
				if(data == 'failVal'){
					alert("게시판의 제목이 15자를 초과하거나 중복입니다.");
					f.boardName.focus();
					return;
				}else if(data == 'error'){
					alert("서버 오류입니다. 잠시 후 다시 시도하세요");
					f.boardName.focus();
					return;
				}else if(data == 'done'){
					alert(name + " 추가가 완료됐습니다.");
					location.reload();
				}
			}
		}); 
	};
	
	function delBoard(id, name){
		if(confirm(name + "을 정말로 삭제하시겠습니까?\n해당 게시판의 모든 글은 삭제 됩니다.")){
			$.ajax({
				url : "/admin/delBoard",
				type : "post",
				data : {id : id},
				success : function(data){
					if(data == 'error'){
						alert("서버 오류입니다. 잠시 후 다시 시도하세요");
						return;
					}else if(data == 'done'){
						alert(name + " 삭제가 완료됐습니다.");
						location.reload();
					}
				}
			});	
		}
		 
	};
	
	function modBoard(id, prevName){
		var name = window.prompt(prevName + "의 수정할 이름을 입력해주세요.");
		$.ajax({
			url : "/admin/modBoard",
			type : "post",
			data : {id : id, name : name},
			success : function(data){
				if(data == 'failVal'){
					alert("게시판 이름이 중복되거나 15글자 이내가 아닙니다.");
					return;
				}else if(data == 'error'){
					alert("서버 오류입니다. 잠시 후 다시 시도하세요.");
					return;
				}else if(data == 'done'){
					alert("게시판 이름이 수정됐습니다.");
					location.reload();
				}
			}
			
		});
		
	}
	
	function adminSearch(f){
		var id = f.id.value;
		$.ajax({
			url : "/admin/adminSearch",
			type : "post",
			data : {id : id},
			success : function(adminList){
				console.log(adminList);
				$('#adminTable>tbody').empty();
				if(adminList.length == 0){
					$('#adminTable>tbody').append('<tr><td colspan="3">조회한 결과가 없습니다.</td></tr>');
				}
				for(var i of adminList){
					$('#adminTable>tbody').append('<tr><td>'+i.id+'</td><td>'+i.name+'</td><td><button type="button" class="btn btn-danger" onclick="delAdmin(\''+i.id+'\');">권한 제거</button></td></tr>');	
				}
			}
		})
	}
	
	function memberSearch(f){
		var id = f.id.value;
		$.ajax({
			url : "/admin/memberSearch",
			type : "post",
			data : {id : id},
			success : function(memberList){
				$('#memberTable>tbody').empty();
				if(memberList.length == 0){
					$('#memberTable>tbody').append('<tr><td colspan="3">조회한 결과가 없습니다.</td></tr>');
				}
				for(var i of memberList){
					$('#memberTable>tbody').append('<tr><td>'+i.id+'</td><td>'+i.name+'</td><td><button type="button" class="btn btn-danger" onclick="addAdmin(\''+i.id+'\');">권한 추가</button></td></tr>');	
				}
			}
		})
	}
	
	function boardStasisSearch(f){
		var name = f.name.value;
		$.ajax({
			url : "/admin/boardStasisSearch",
			type : "post",
			data : {name : name},
			success : function(boardStasisList){
				$('#boardStasisTable>tbody').empty();
				if(boardStasisList.length == 0){
					$('#boardStasisTable>tbody').append('<tr><td colspan="4">조회한 결과가 없습니다.</td></tr>');
				}
				for(var i of boardStasisList){
					$('#boardStasisTable>tbody').append('<tr><td>'+i.name+'</td><td>'+i.b_total_count+'</td><td>'+i.b_yesterday_count+'</td><td><button type="button" class="btn btn-success" onclick="modBoard('+i.id+', \''+i.name+'\');">이름 변경</button><button type="button" class="btn btn-danger" onclick="delBoard('+i.id+', \''+i.name+'\');">삭제</button></td></tr>');	
				}
			}
		})
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
			<div class="col-sm-2 sidebar-offcanvas" id="sidebar">
	          <div class="list-group">
	            <a href="javascript:addForm();" id="addBtn" class="list-group-item">관리자 추가</a>
	            <a href="javascript:delForm();" id="delBtn" class="list-group-item">관리자 제거</a>
	            <a href="javascript:boardForm();" id="boardBtn" class="list-group-item">게시판 관리</a>
	          </div>
        	</div>
			<div id="del" class="panel panel-success text-center col-sm-10">
				<div class="panel-heading">관리자 목록</div>
				<div class="panel-body">
						<table class="table table-sm table-bordered table-striped" id="adminTable">
							<thead>
								<th width="50%">아이디</th>
								<th width="30%">이름</th>
								<th width="20%"></th>
							</thead>
							<c:forEach var="admin" items="${adminList }">
							<c:if test="${myId != admin.id }">
							<tr>
								<td id="admin_id_td">
									${admin.id }
								</td>
								<td id="admin_name_td">
									${admin.name }
								</td>
								<td id="admin_button_td">
									<button type="button" class="btn btn-danger" onclick="delAdmin('${admin.id}');">권한 제거</button>
								</td>
							</tr>
							</c:if>
							</c:forEach>
						</table>
						<div class="adminpaging text-center">
						
						</div>
						<div class="adminSearch row">
							<form class="form-group text-center col-sm-offset-5">
								<input type="text" name="id" class="form-control col-sm-6" placeholder="아이디를 입력하세요."/>
								<div class="col-sm-2">
									<button type="button" onclick="adminSearch(this.form);" class="btn btn-success">검색</button>
								</div>
							</form>
						</div>
				</div>
			</div>
			<div id="add" class="panel panel-success text-center col-sm-10">
				<div class="panel-heading">멤버 목록</div>
				<div class="panel-body">
						<table class="table table-sm table-bordered table-striped" id="memberTable">
							<thead>
								<th width="50%">아이디</th>
								<th width="30%">이름</th>
								<th width="20%"></th>
							</thead>	
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
						<div class="memberpaging text-center">
							<ul class="pagination">
								${memberPaging}
							</ul>
						</div>
						<div class="memberSearch row">
							<form class="form-group text-center col-sm-offset-5">
								<input type="text" name="id" class="form-control col-sm-6" placeholder="아이디를 입력하세요."/>
								<div class="col-sm-2">
									<button type="button" onclick="memberSearch(this.form);" class="btn btn-success">검색</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				
				<div id="boardAdd_Del" class="panel panel-success text-center col-sm-10">
					<div class="panel-heading">게시판 관리</div>
					<div class="panel-body">
						<span class="text-center">게시판 추가</span>
						<form>
						<div class="form-group row col-sm-offset-2">
							<input type="text" name="boardName" placeholder="15자 이내로 작성하세요. (앞뒤 공백 비허용)" class="form-control col-sm-10"/>
							<div class="col-sm-2">
								<button type="button" onclick="boardAdd(this.form);" class="btn btn-primary btn-lg">추가</button>
							</div>
						</div>
						</form>
						<span class="text-center">게시판 수정/삭제</span>
						<table class="table table-sm table-bordered table-striped" id="boardStasisTable">
							<thead>
								<th width="50%">게시판명</th>
								<th width="15%">전체 게시글</th>
								<th width="15%">하루 작성글</th>
								<th width="20%"></th>
							</thead>	
							<c:forEach var="boardStasis" items="${boardStasisList }">
							<tr>
								<td>
									<!-- 게시판 이름 -->
									${boardStasis.name }
								</td>
								<td>
									<!-- 해당 타입의 게시판의 글 카운트 -->
									${boardStasis.b_total_count }
								</td>
								<td>
									<!-- 하루를 기준으로 작성된 게시글의 카운트 -->
									${boardStasis.b_yesterday_count }
								</td>
								<td>
									<button type="button" class="btn btn-success" onclick="modBoard(${boardStasis.id}, '${boardStasis.name}');">이름 변경</button>
									<button type="button" class="btn btn-danger" onclick="delBoard(${boardStasis.id}, '${boardStasis.name}');">삭제</button>
								</td>
							</tr>
							</c:forEach>
						</table>
						<div class="boardstasispaging text-center">
							<ul class="pagination">
								${boardStasisPaging}
							</ul>
						</div>
						<div class="boardStasisSearch row">
							<form class="form-group text-center col-sm-offset-5">
								<input type="text" name="name" class="form-control col-sm-6" placeholder="게시판 이름을 입력하세요."/>
								<div class="col-sm-2">
									<button type="button" onclick="boardStasisSearch(this.form);" class="btn btn-success">검색</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				
				
			</div>
		</div>



<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>
</html>