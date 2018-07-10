<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/include/header.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/include/nav.jsp" />
<header class="masthead" style="background-image: url('/img/search.jpg') ">
	<div class="overlay"></div>
</header>

	<div class="container">
		<div class="header">
		
		</div>
		<div class="bod">
			<div class="panel panel-success text-center">
				<div class="panel-heading">아이디 찾기</div>
				<div class="panel-body">
					<form action="/member/idFind" method="post">
					<div class="form-group">
						<label for="" class="control-label col-sm-3">이메일</label>
						<div class="col-sm-6">
							<input type="text" id="email" class="form form-control"/>
						</div>
						<div class="col-sm-3">
							<button class="btn btn-success btn-lg" type="button" data-toggle="modal" data-target="#idModal" onclick="search()">찾기</button>
						</div>
					</div>
					</form>
				</div>
			</div>
			<!-- Modal -->
			<div class="modal fade" id="idModal" role="dialog">
	    		<div class="modal-dialog">
			      <div class="modal-content">
			        <div class="modal-header">
			          <h4 class="modal-title text-left">결과</h4>
			          <button type="button" class="close" data-dismiss="modal">&times;</button>
			        </div>
			        <div class="modal-body">
			          <p>이메일 조회 결과 아이디는 <span id="result"></span>입니다.</p>
			        </div>
			        <div class="modal-footer">
			          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			        </div>
			      </div>
    			</div>
  			</div>	
  			 
		</div>
	</div>



<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>
<script>
	function search(){
		$.ajax({
			url : '/member/idFind',
			type : 'post',
			data : {email : $('#email').val()},
			success : function(data){
				console.log("data:",data);
				if(data == ""){
					$('#result').text('없음');
				}else{
					$('#result').text(data);
				}
			}
		})
	}
</script>
</html>