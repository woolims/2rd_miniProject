<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>2차 미니 프로젝트 경매화면</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<%@ include file="../menubar/menubar.jsp" %>
  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
    </div>
    <div class="col-sm-8 text-left"> 
      <h1>경매 페이지</h1>
      <p>들어갈 요소 : 경매물품 리스트(페이징X) / 카테고리 / 정렬 방식 / 검색(상세 검색)</p>
    </div>
    <div class="col-sm-2 sidenav">
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