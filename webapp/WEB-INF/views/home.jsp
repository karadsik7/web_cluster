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
  .body{
  	background-color: #F8F9EC;
  }
  .eachBoard{
  	border : 1px solid gray;
  	border-radius: 5px;
  	background-color: white;
  }
  .oneline{
  	margin-top: 5%;
  }
  
 @media screen and (max-width: 768px) { .ads { display: none; } }

  
  
  
  </style>
</head>
<body>
    <jsp:include page="../include/nav.jsp" />
    <header class="masthead" style="background-image: url('/img/main1.jpg') ">
      <div class="overlay"></div>
    </header>

    <!-- Main Content -->
    <div class="container-fluid">
      <div class="col-sm-10">
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
    	
    	
    <div class="body-content">
    	
    	
      <div class="row justify-content-sm-center oneline">
        <div class="col-sm-3">
        	<div class="eachBoard">
	          <div class="row">
	    		<div class="mx-auto" style="margin-bottom: 20px;">
	    			<h4>자유 게시판</h4>
	    			<label class="label label-danger text-center"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;최근 게시글</label>
	    		</div>
	    	  </div>
	          <c:forEach var="bvo" items="${freeboardList }" begin="0" end="2">
	          
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
	          <div class="clearfix">
	            <a class="btn btn-primary float-right" href="/board/list/1">더보기 &rarr;</a>
	          </div>
	       </div>
	     </div>
	     
	     <div class="col-sm-3">
        	<div class="eachBoard">
	          <div class="row">
	    		<div class="mx-auto" style="margin-bottom: 20px;">
	    			<h4>유머 게시판</h4>
	    			<label class="label label-danger text-center"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;최근 게시글</label>
	    		</div>
	    	  </div>
	          <c:forEach var="bvo" items="${humorboardList }" begin="0" end="2">
	          
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
	          <div class="clearfix">
	            <a class="btn btn-primary float-right" href="/board/list/2">더보기 &rarr;</a>
	          </div>
	       </div>
	     </div>
	     
	     <div class="col-sm-3">
        	<div class="eachBoard">
	          <div class="row">
	    		<div class="mx-auto" style="margin-bottom: 20px;">
	    			<h4>LOL 게시판</h4>
	    			<label class="label label-danger text-center"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;최근 게시글</label>
	    		</div>
	    	  </div>
	          <c:forEach var="bvo" items="${lolboardList }" begin="0" end="2">
	          
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
	          <div class="clearfix">
	            <a class="btn btn-primary float-right" href="/board/list/1">더보기 &rarr;</a>
	          </div>
	       </div>
	     </div>
	     
	   </div> <!-- row -->
	     
	     
      
      <div class="row justify-content-sm-center oneline">
      	
      	  <div class="col-sm-3">
        	<div class="eachBoard">
	          <div class="row">
	    		<div class="mx-auto" style="margin-bottom: 20px;">
	    			<h4>배그 게시판</h4>
	    			<label class="label label-danger text-center"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;최근 게시글</label>
	    		</div>
	    	  </div>
	          <c:forEach var="bvo" items="${bgboardList }" begin="0" end="2">
	          
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
	          <div class="clearfix">
	            <a class="btn btn-primary float-right" href="/board/list/1">더보기 &rarr;</a>
	          </div>
	       </div>
	     </div>
	     
	       <div class="col-sm-3">
        	<div class="eachBoard">
	          <div class="row">
	    		<div class="mx-auto" style="margin-bottom: 20px;">
	    			<h4>오버워치 게시판</h4>
	    			<label class="label label-danger text-center"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;최근 게시글</label>
	    		</div>
	    	  </div>
	          <c:forEach var="bvo" items="${owboardList }" begin="0" end="2">
	          
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
	          <div class="clearfix">
	            <a class="btn btn-primary float-right" href="/board/list/1">더보기 &rarr;</a>
	          </div>
	       </div>
	     </div>
	     
	       <div class="col-sm-3">
        	<div class="eachBoard">
	          <div class="row">
	    		<div class="mx-auto" style="margin-bottom: 20px;">
	    			<h4>던파 게시판</h4>
	    			<label class="label label-danger text-center"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;최근 게시글</label>
	    		</div>
	    	  </div>
	          <c:forEach var="bvo" items="${dfboardList }" begin="0" end="2">
	          
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
	          <div class="clearfix">
	            <a class="btn btn-primary float-right" href="/board/list/1">더보기 &rarr;</a>
	          </div>
	       </div>
	     </div>
     
        
      	</div> <!-- row -->
      </div>
     </div>
     <div class="col-sm-2 ads hidden-sm-down">
     
     	<div class="well ad">
     		<img src="/img/rightbanner1.jpg" />
     	</div>
     </div>
   </div>
 
    <hr>



	<jsp:include page="../include/footer.jsp" />
</body>
</html>