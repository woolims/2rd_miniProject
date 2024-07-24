<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  		width: 500px;
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
  <div class="row content">
    <div class="col-sm-2 sidenav">
    </div>
    <div class="col-sm-8 text-left"> 
      <h2 class="title_auction">암시장</h2>
      <div style="text-align: center;">
      	<table class="cate">
      		<tr>
      			<td class="cate_si"><a href="#">컴퓨터</a></td>
      			<td class="cate_si"><a href="#">가전제품</a></td>
      			<td class="cate_si"><a href="#">음악</a></td>
      			<td class="cate_si"><a href="#">영화</a></td>
      		</tr>
      		<tr>
      			<td class="cate_si"><a href="#">음식</a></td>
      			<td class="cate_si"><a href="#">이용권</a></td>
      			<td class="cate_si"><a href="#">여행</a></td>
      			<td class="cate_si"><a href="#">기타</a></td>
      		</tr>
      	</table>
      </div>
      <div class="auction_div">
      	<div class="col-sm-2 product_auc">
      		작품1
      	</div>
      	<div class="col-sm-2 product_auc">
      		작품2
      	</div>
      	<div class="col-sm-2 product_auc">
      		작품3
      	</div>
      	<div class="col-sm-2 product_auc">
      		작품4
      	</div>
      	<div class="col-sm-2 product_auc">
      		작품5
      	</div>
      	<div class="col-sm-2 product_auc">
      		작품6
      	</div>
      	<div class="col-sm-2 product_auc">
      		작품7
      	</div>
      	<div class="col-sm-2 product_auc">
      		작품8
      	</div>
      	<div class="col-sm-2 product_auc">
      		작품9
      	</div>
      	<div class="col-sm-2 product_auc">
      		작품10
      	</div>
      	<div class="col-sm-2 product_auc">
      		작품11
      	</div>
      	<div class="col-sm-2 product_auc">
      		작품12
      	</div>
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