<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <title>2차 미니 프로젝트 메인화면</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {min-height: 900px;}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
      min-height: 900px;
    }
    
    .sidemenu {
    	height: 150px;
    	vertical-align: center;
    	text-align: center;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
  </style>
</head>
<body>

<!-- 알러창 띄워주기 -->
<c:if test="${ not empty alertMsg }">
	<script>
		alert('${ alertMsg }');
	</script>
	<c:remove var="alertMsg" scope="session"/>
</c:if>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
  	<div class="col-sm-2"></div>
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
    </div>
    <div class="col-sm-8" id="myNavbar">
      <ul class="nav navbar-nav"> 
      	<!--  context 경로 상대경로 -->
        <li id="home"><a href="${ pageContext.request.contextPath }/home.do">Home</a></li>
        <li id="auction"><a href="${ pageContext.request.contextPath }/auction.do">경매</a></li>
        <li id="freetalk"><a href="${ pageContext.request.contextPath }/board/freetalk.do">자유게시판</a></li>
        <li id="QnA"><a href="${ pageContext.request.contextPath }/qna/qna.do">문의</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<!-- 로그인이 안 된 경우 -->
      	<c:if test="${ empty user }">
        	<li><a href="${ pageContext.request.contextPath }/login_form.do"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        </c:if>
        <!-- 로그인 된 경우 -->
        <c:if test="${ not empty user }">
			<li><a href="${ pageContext.request.contextPath }/mypage.do">${ user.nickName } 님</a></li>
			<li><a href="${ pageContext.request.contextPath }/logout.do"><span class="glyphicon glyphicon-log-in"></span>Logout</a></li>
        </c:if>
      </ul>
    </div>
  </div>
</nav>

</body>
</html>
