<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>2차 미니 프로젝트 메인화면</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

	<%@ include file="menubar/menubar.jsp"%>

	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm-2 sidenav"></div>
			<div class="col-sm-8 text-left">
				<h1>메인 페이지</h1>
				<p>들어갈 요소 : 배너(홍보용 배너 2~3장) / 인기있는 경매물품 박스로 4개 정도(조회수에 따라 최신화) /
					자유게시판 최신글 목록 5개정도</p>
			</div>
			<div class="col-sm-2 sidenav"></div>
		</div>
	</div>

	<%@ include file="menubar/footer.jsp"%>
	
	<script>
		$(function(){
			$('#home').attr('class','active');
		});
	</script>

</body>
</html>
