<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../include/header.jsp" />
</head>
<body>
    <jsp:include page="../include/nav.jsp" />
    <header class="masthead" style="background-image: url('/img/main.jpg') ">
      <div class="overlay"></div>
    </header>

    <!-- Main Content -->
    <div class="container">
    	<div class="row">
    		<div class="mx-auto" style="margin-bottom: 20px;">
    			<label class="label label-danger text-center"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;최근 게시글</label>
    		</div>
    	</div>
      <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
          <c:forEach var="bvo" items="${boardList }" begin="0" end="2">
          <div class="post-preview">
            <h2 class="post-title">
            <a href="/board/view?id=${bvo.id}">
             ${bvo.title }
            </a>
            </h2>
            <p class="post-meta">Posted by
              ${bvo.name}
              on ${bvo.regdate}</p>
          </div>
          <hr>
          </c:forEach>
          <hr>
          <!-- Pager -->
          <div class="clearfix">
            <a class="btn btn-primary float-right" href="/board/list">Older Posts &rarr;</a>
          </div>
        </div>
      </div>
    </div>

    <hr>



	<jsp:include page="../include/footer.jsp" />
</body>
</html>