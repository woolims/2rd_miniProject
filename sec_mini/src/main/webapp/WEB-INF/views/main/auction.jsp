<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <title>2차 미니 프로젝트 경매화면</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <style type="text/css">
  
  	.title_auction {
  		margin-top: 50px;
  		margin-bottom: 50px;
  	}
  	.cate{
  		width: 100%;
  		background: gray;
  	}
  	.cate_si {
  		width: 25%;
  		height: 40px;
  		vertical-align: middle;
  	}
  	.cate_si>a {
  		color: white;
  	}
  	.auction_div {
  		width: 100%;
 		margin: auto;
 		margin-top: 30px;
  		/* background: green; */
  	}
  	.product_auc {
  		display: inline-block;
  		width: 200px !important;
  		height: 300px;
  		border: 1px solid red;
  		text-align: center;
  		margin: auto;
  		margin-top: 10px;
  		margin-bottom: 10px;
  		background: yellow;
  	}
  </style>
</head>
<body>

<%@ include file="../menubar/menubar.jsp" %>
  
<div class="container-fluid text-center">    
  <div class="content">
    <div class="col-sm-2 sidenav">
    </div>
    <div class="col-sm-8 text-left"> 
      <h2 class="title_auction">암시장</h2>
      <div style="text-align: right;">
      		<c:if test="${ not empty user }">
				<input class="btn btn-primary" type="button" value="경매 올리기" onclick="location.href='a_board_insert_form.do'">
			</c:if>
      </div>
      <div class="auction_div">
      	<c:forEach var="vo" items="${ list }">
	      	<div class="col-sm-2 product_auc">
	      		<div style="width:100%; height: 50%; border: 1px solid black; margin: auto; margin-top: 10px;" onclick="location.href='a_board.do?auctionBoardNo=${vo.auctionBoardNo}'">
	      			<img alt="사진" src=""><br><br>
	      		</div><br>
	      		<p style="text-align: left; margin: 0">상품명 : ${ vo.pName }</p>
	      		<p style="text-align: left; margin: 0">현재 입찰가 : ${ vo.entryBidPrice }원</p><br>
	      		<p style="text-align: left; margin: 0;">남은일자 :</p> ${ vo.endDate.substring(0,15) }
	      	</div>
      	</c:forEach>
      		
      </div>
    </div>
    <div class="col-sm-2 sidenav">
    	side
    </div>
  </div>
</div>

<%@ include file="../menubar/footer.jsp" %>

<script>
$(function(){
	$('#auction').attr('class','active');
});
</script>
</body>
</html>