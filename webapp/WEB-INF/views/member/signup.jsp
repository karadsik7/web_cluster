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
<header class="masthead" style="background-image: url('/img/signup.jpg') ">
	<div class="overlay"></div>
</header>

	<div class="container">
		<form:form action="/member/signup" method="post" class="form-horizontal" modelAttribute="memberVo">
			<div class="form-group">
				<label for="id" class="control-label col-sm-2">아이디</label>
				<div class="col-sm-6">
					<form:input type="text" class="form-control" path="id" id="id"/>
					<form:errors path="id" class="errors" value=""/>
				</div>
				<div class="col-sm-4">
					<button type="button" class="btn btn-info" onclick="dualCheck();">중복 확인</button>
				</div>
			</div>
			
			<div class="form-group">
				<label for="password" class="control-label col-sm-2">비밀번호</label>
				<div class="col-sm-6">
					<form:input type="password" path="password" class="form-control" />
					<form:errors path="password" class="errors"/>
				</div>
			</div>
			
			<div class="form-group">
				<label for="passwordConfirm" class="control-label col-sm-2">비밀번호 확인</label>
				<div class="col-sm-6">
					<form:input type="password" path="passwordConfirm" class="form-control" />
					<form:errors path="passwordConfirm" class="errors"/>
				</div>
			</div>
			
			<div class="form-group">
				<label for="name" class="control-label col-sm-2">이름</label>
				<div class="col-sm-6">
					<form:input type="text" path="name" class="form-control" />
					<form:errors path="name" class="errors"/>
				</div>
			</div>
			
			<div class="form-group">
				<label for="email" class="control-label col-sm-2">이메일</label>
				<div class="col-sm-5">
					<form:input type="text" class="form-control" path="email" id="email"/>
					<form:errors path="email" class="errors" />
					<span id="email-error" class="errors"></span>
				</div>
				<div class="col-sm-3">
					<button type="button" onclick="mailSend();" class="btn btn-primary">인증 메일 발송</button>
				</div>
			</div>
			
			<div class="form-group">
				<label for="emailCode" class="control-label col-sm-2">이메일 인증번호</label>
				<div class="col-sm-5">
					<form:input type="text" class="form-control" path="emailCode" placeholder="인증번호를 입력하세요" />
					<form:errors path="emailCode" class="errors"/>
				</div>
			</div>
			
			<div class="form-group">
				<label for="gender" class="control-label col-sm-2">성별</label>
				<div class="col-sm-6">
					<div class="radio-inline">
						<input type="radio" name="gender" value="m" checked/>남성
					</div>
					<div class="radio-inline">
						<input type="radio" name="gender" value="f" />여성
					</div>
					<form:errors path="gender" class="errors"/>
				</div>
			</div>
			<br />
			<br />
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-6">
					<button class="btn btn-primary btn-block btn-lg">회원 가입</button>
				</div>
			</div>
		</form:form>
	</div>

<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>

<script>
	
	function dualCheck(id){
		$.ajax({
			url : '/member/dualCheck',
			type : 'post',
			data : {id : $("#id").val()},
			success : function(data){
				if(data == 'denied'){
					alert("이미 가입된 아이디입니다.");
				}else if(data == 'allowed'){
					alert("사용 가능한 아이디입니다.");
				}else{
					alert("서버 오류입니다. 잠시 후 다시 시도하세요.");
				}
			}
		})
	}
	
	function mailSend(){
		$("#email-error").text("");
		var email = $("#email").val();
		console.log(email);
		$.ajax({
			url : "/member/mailSend",
			type : "post",
			data : {email : $("#email").val()},
			success : function(data){
				if(data == 'null'){
					$("#email-error").text("이메일을 입력해주세요.");
				}else if(data == 'dual'){
					$("#email-error").text("중복된 이메일입니다.")
				}else if(data == 'inconsistence'){
					$("#email-error").text("이메일을 형식에 맞게 입력해주세요.");
				}else if(data == 'error'){
					$("#email-error").text("예기치 않은 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
				}else{
					alert("인증메일을 전송했습니다. 인증번호를 입력해주세요.");
					$("email-error").val("");
				}
			}
		});
		
	}
	
</script>

</html>