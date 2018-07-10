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
.loader {
  margin-top: 10%;
  margin-left: 35%;
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid #3498db;
  width: 100px;
  height: 100px;
  -webkit-animation: spin 2s linear infinite; /* Safari */
  animation: spin 2s linear infinite;
}

/* Safari */
@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
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
			<div class="panel panel-info text-center">
				<div class="panel-heading">패스워드 찾기</div>
				<div class="panel-body">
					<form action="/member/passFind" method="post">
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
			        	<div id="loader"></div>
			          <p id="result"></p>
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
		$('#loader').addClass('loader');
		$.ajax({
			url : '/member/passFind',
			type : 'post',
			data : {email : $('#email').val()},
			success : function(data){
				$('#loader').removeClass('loader');
				if(data == 'notFind'){
					$('#result').text('조회 결과 일치하는 회원이 없습니다.');
				}else if(data == 'error'){
					$('#result').text('서버에 에러가 발생했습니다. 잠시 후 다시 시도해주세요.');
				}else if(data == 'success'){
					$('#result').text('인증메일을 전송했습니다. 메일을 확인하고 로그인해주세요.');
				}
			}
		})
	}
</script>
</html>