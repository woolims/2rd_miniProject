<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

.cate {
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

.p_info{
	 margin-left: 100px;
}
</style>
</head>
<body>

	<%@ include file="../menubar/menubar.jsp"%>

	<div class="container-fluid text-center">
		<div class="content">
			<div class="col-sm-2 sidenav"></div>
			<div class="col-sm-8 text-left">
				<div class="col-sm-12 text-right" style="height: 50px; margin-top: 25px;">
					<input type="button" value="목록으로 돌아가기" onclick="location.href='auction.do?categoryNo=${vo.categoryNo}'">
				</div>

				<div class="col-sm-1"><p style="text-align: center;"><<</p></div>
				<div class="col-sm-10" style="border:1px solid red; text-align: center; height: 300px;">
					<div class="pro_image" style="height: 100%; margin-top: 30px;">
						<img alt="상품 사진" src="">
					</div>
				</div>
				<div class="col-sm-1"><p style="text-align: center;">>></p></div>
				<div class="col-sm-12" style="font-weight:bold; height: 100%;">
					<p class="p_info">상품명 : ${ vo.pName }</p>
					<p class="p_info">카테고리 : ${ vo.categoryName }</p>
					<p class="p_info">상품 설명 : ${ vo.pDesc }</p>
					<p class="p_info">사용 정도 : ${ vo.useAt }점(5점 만점)</p>
					<p class="p_info">입찰 시작가 : ${ vo.startPrice }</p>
					<p class="p_info">현재 입찰가 : 체크중</p>
					<p class="p_info">종료 일자 : ${ vo.remaningTime.substring(0, 15) }</p>
					<p class="p_info">조회수 : ${ vo.viewCount }</p>
				</div>
				<input class="btn btn-primary" type="button" value="입찰하기" style="width:100%; height: 100px;">
			</div>
			<div class="col-sm-2 sidenav">side</div>
		</div>
	</div>

	<%@ include file="../menubar/footer.jsp"%>

	<script>
		$(function() {
			$('#auction').attr('class', 'active');
		});
	</script>
</body>
</html>