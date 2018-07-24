<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/include/header.jsp" />

<style>
  .carousel-inner > .item > img,
  .carousel-inner > .item > a > img {
      margin: 0 auto;
  }
  </style>
</head>
<body>
    <jsp:include page="../include/nav.jsp" />
    <header class="masthead" style="background-image: url('/img/main.jpg') ">
      <div class="overlay"></div>
    </header>

    <!-- Main Content -->
    <div class="container-fluid">
    	<!-- 캐러셀 -->
    	<div class="row">
    		<div id="myCarousel" class="carousel slide col-sm-offset-3" data-ride="carousel">
			   
			
			    <div class="carousel-inner">
			
			      <div class="item active">
			       <a href="/board/list/1"><img src="/img/freeboard.jpg" width="800" height="150"></a>
			      </div>
			
			      <div class="item">
			        <a href="/board/list/2"><img src="/img/humor.jpg" width="800" height="150"></a>
			      </div>
			    
			      <div class="item">
			        <a href="/board/list/3"><img src="/img/lol.jpg" width="800" height="150"></a>
			      </div>
			
			      <div class="item">
			        <a href="/board/list/4"><img src="/img/pubg.jpg" width="800" height="150"></a>
			      </div>
			      
			      <div class="item">
			        <a href="/board/list/5"><img src="/img/overwatch.jpg" width="800" height="150"></a>
			      </div>
			      
			      <div class="item">
			        <a href="/board/list/6"><img src="/img/df.jpg" width="800" height="150"></a>
			      </div>
			      
			      <div class="item">
			        <a href="/board/list/7"><img src="/img/maple.jpg" width="800" height="150"></a>
			      </div>
			      
			      <div class="item">
			        <a href="/board/list/8"><img src="/img/bd.jpg" width="800" height="150"></a>
			      </div>
			      
			  
			    </div>
			
			    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
			      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			      <span class="sr-only">Previous</span>
			    </a>
			    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
			      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			      <span class="sr-only">Next</span>
			    </a>
			  </div>	
    	</div>
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