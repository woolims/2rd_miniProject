<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>2차 미니 프로젝트 경매화면</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style type="text/css">
/* 전체 어두운 테마 */
body {
	background-color: #1a1a1a; /* 어두운 배경 */
	color: #ccc; /* 명암 대비를 위한 밝은 텍스트 색상 */
	height: 5000px;
}

/* 경매 제목 스타일 */
.title_auction {
	margin-top: 50px;
	margin-bottom: 50px;
	color: #FFD700; /* 눈에 띄는 색상으로 강조 */
	font-family: 'Courier New', Courier, monospace; /* 거친, 타자기 스타일 폰트 */
}

/* 카테고리 섹션 */
.cate {
	width: 100%;
	background: #333; /* 더 어두운 회색 배경 */
	border-bottom: 2px solid #ff6666; /* 대비되는 하단 테두리 */
}

.cate_si {
	width: 25%;
	height: 40px;
	vertical-align: middle;
}

.cate_si>a {
	color: #ffcc00; /* 어두운 배경에서 눈에 띄는 밝은 색상 */
	font-weight: bold;
	text-transform: uppercase; /* 대문자로 하여 더 강렬한 느낌 */
}

/* 경매 품목 스타일 */
.auction_div {
	width: 100%;
	margin: auto;
	margin-top: 30px;
	text-align: center;
}

.product_auc {
	display: inline-block;
	width: 500px;
	height: 300px;
	text-align: center;
	margin: 10px;
	margin-left: 20px;
	margin-right: 20px;
	background: #444; /* 어두운 배경 */
	color: #ffcc00; /* 밝은 텍스트 색상 */
	border: 2px solid #ff6666; /* 눈에 띄는 테두리 */
	border-radius: 5px; /* 약간 둥근 모서리 */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.7); /* 깊이감을 위한 그림자 */
	font-family: 'Courier New', Courier, monospace; /* 일관된 폰트 */
	transition: transform 0.3s;
}

.product_auc:hover {
	transform: scale(1.05); /* 강조를 위한 호버 시 확대 */
	background: #555; /* 호버 시 더 어두운 배경 */
}

/* 노멀라이즈 시작 */
body, ul, li {
	margin: 0;
	padding: 0;
	list-style: none; /* 해당 태그의 list-style을 none으로 하는 것으로 ●을 제거한다 */
}

a {
	color: inherit; /* 부모 엘리먼트의 값을 물려받는다 */
	text-decoration: none !important;
	/* 해당 태그의 text-decoration 속성을 none 값으로 하는 것으로 밑줄을 제거한다 */
}
/* 노멀라이즈 끝 */

/* 커스텀 시작 */
.side-bar>ul ul {
	display: none;
}

/* 사이드바 시작 */

/* 사이드바의 너비와 높이를 변수를 통해 통제 */
:root {
	--side-bar-width: 180px;
	--side-bar-height: 90vh;
}

.side-bar {
	position: fixed; /* 스크롤을 따라오도록 지정 */
	background-color: #2b2b2b; /* 어두운 사이드바 배경 */
	color: #ffcc00; /* 밝은 텍스트 색상 */
	border-right: 2px solid #ff6666; /* 내용과 분리되는 테두리 */
	width: var(--side-bar-width);
	overflow: hidden; /* 넘치는 메뉴 요소 숨기기 */
	transform: translate(calc(var(--side-bar-width)* -0.8), 0);
	transition: 0.5s;
}

.col-sm-2.sidenav {
	background-color: #444444;
	color: #f1f1f1;
}

/* 아이콘 시작 */
.side-bar__icon-box {
	display: flex;
	justify-content: flex-end;
}

.side-bar__icon-1 {
	position: relative;
	width: 23px;
	height: 17px;
	margin: 15px;
	margin-top: 20px;
	transition: .5s;
}

.side-bar__icon-1>div {
	position: absolute;
	width: 100%;
	height: 20%;
	background-color: #ffcc00; /* 아이콘의 밝은 색상 */
	transition: all 0.5s;
}

.side-bar__icon-1>div:nth-of-type(1) {
	top: 0;
	width: auto;
	left: 0;
	right: 0;
	transition: all 0.5s, left 0.25s 0.25s, right 0.25s 0.25s, height 0.25s
		0s;
}

.side-bar__icon-1>div:nth-of-type(2) {
	top: 40%;
	transform-origin: bottom left;
}

.side-bar__icon-1>div:nth-of-type(3) {
	top: 80%;
	left: auto;
	right: 0;
	transform-origin: bottom right;
}

.side-bar:hover .side-bar__icon-1 {
	transform: translate(-198px, 0);
}

.side-bar:hover .side-bar__icon-1>div:nth-of-type(2) {
	transform: rotate(45deg);
	width: 70.5%;
	height: 25%;
}

.side-bar:hover .side-bar__icon-1>div:nth-of-type(3) {
	top: 40%;
	transform: rotate(-45deg);
	width: 70.5%;
	height: 25%;
}

.side-bar:hover .side-bar__icon-1>div:nth-of-type(1) {
	left: 41%;
	right: 41%;
	height: 100%;
	transition: all 0.5s, left 0.25s 0s, right 0.25s 0s, height 0.25s 0.25s;
}
/* 아이콘 끝 */

/* 모든 메뉴의 a에 속성값 부여 */
.side-bar ul>li>a {
	display: block;
	color: #ffcc00; /* 텍스트의 밝은 색상 */
	font-size: 1.4rem;
	font-weight: bold;
	transition: 0.5s;
	opacity: 0; /* 초기 상태에서 글자 숨김 */
	transform: translateX(-100px); /* 초기 상태에서 글자를 왼쪽으로 이동 */
	padding: 10px 20px; /* 항목의 패딩 조정 */
}

.side-bar:hover ul>li>a {
	opacity: 1; /* 사이드바에 마우스를 올렸을 때 글자 보임 */
	transform: translateX(0); /* 원래 위치로 이동 */
}

/* 자식의 position이 absolute일 때 자식을 영역 안에 가두어 준다 */
.side-bar>ul>li {
	position: relative;
}

/* 모든 메뉴가 마우스 인식 시 반응 */
.side-bar ul>li:hover>a {
	background-color: #ff6666; /* 배경 변경 */
	border-bottom: 1px solid #ffcc00; /* 강조를 위한 하단 테두리 */
}

/* 1차 메뉴의 항목이 마우스 인식 시에 2차 메뉴 등장 */
.side-bar>ul>li:hover>ul {
	margin-left: 2px;
	display: block;
	position: absolute;
	background-color: #333;
	opacity: 0.8; /* 하위 메뉴의 더 어두운 배경 */
	top: 0; /* 2차 메뉴의 상단을 1차 메뉴의 상단에 고정 */
	left: 100%; /* 2차 메뉴를 1차 메뉴의 너비만큼 이동 */
	width: 90%; /* 1차 메뉴의 너비를 상속 */
	border-right: 2px solid #ff6666; /* 내용과 분리되는 테두리 */
}

.side-bar>ul>li>a>span:last-child {
	opacity: 0;
	transition: .5s .1s;
}

/* 사이드바 너비의 80%만큼 왼쪽으로 이동 */
.side-bar {
	transform: translate(calc(var(--side-bar-width)* -0.8), 0);
	transition: .5s;
}

/* 마우스 인식 시 원래의 위치로 이동 */
.side-bar:hover {
	transform: translate(-20px, 0); /* 사이드바를 나타나게 함 */
	overflow: visible;
}

/* 사이드바 끝 */

/* 배경 이미지*/
body {
	height: 100vh;
	background: url(resources/images/.jpg) no-repeat center;
	background-size: cover;
}

/* 푸터 스타일 */
footer {
	background-color: #252525; /* 검은색 배경 */
	color: #fff; /* 흰색 텍스트 */
	padding: 20px; /* 여백 */
	text-align: center; /* 중앙 정렬 */
}

/* 커스텀 끝 */
</style>
</head>
<body style="background-color: #303030; color: #f1f1f1;">

	<%@ include file="../menubar/menubar.jsp"%>

	<div style="position: relative; z-index: 1;"
		class="container-fluid text-center">
		<div class="row content">
			<div
				style="position: relative; z-index: 2; background-color: #444444; color: #f1f1f1;"
				class="col-sm-2 sidenav">
				<!-- Sidebar -->
				<aside class="side-bar">
					<section class="side-bar__icon-box">
						<section class="side-bar__icon-1">
							<div></div>
							<div></div>
							<div></div>
						</section>
					</section>
					<ul>
						<c:forEach var="category" items="${ category_list }">
							<li><a href="?categoryno=${ category.categoryNo }">${ category.categoryName }</a>

								<ul>
									<c:forEach var="d_category" items="${ d_category_list }">
										<c:if test="${ category.categoryNo == d_category.categoryNo }">
											<li><a href="?d_categoryno=${ d_category.d_categoryNo }">${ d_category.d_categoryName }</a></li>
										</c:if>
									</c:forEach>
								</ul></li>
							<br>
						</c:forEach>
					</ul>
				</aside>


				<%-- <div class="w3-sidebar w3-light-grey w3-bar-block" style="width: 80%; text-align: left;">
					<h3 class="w3-bar-item" style="margin-left: 20px; margin-bottom: 30px;">Menu</h3>
					<ul>
						<c:forEach var="category" items="${ category_list }">
							<li><a href="?categoryno=${ category.categoryNo }">${ category.categoryName }</a></li><br>
						</c:forEach>
					</ul>
				</div> --%>

			</div>
			<div class="col-sm-8 text-left"
				style="background-color: #333333; color: #f1f1f1;">
				<h2 class="title_auction" style="color: #FFD700;">암시장</h2>
				<div style="text-align: right;">
					<c:if test="${ not empty user }">
						<input class="btn btn-primary" type="button" value="경매 올리기"
							onclick="location.href='a_board_insert_form.do'">
					</c:if>
					<%--     <ul>
				      <c:forEach var="category" items="${ category_list }">
				          <li><a href="?categoryno=${ category.categoryNo }">${ category.categoryName }</a></li>
				      </c:forEach> 
				    </ul> --%>

					<!-- <table class="cate">
						<tr>
							<td class="cate_si"><a href="?category=computer">컴퓨터</a></td>
							<td class="cate_si"><a href="?category=electronic">가전제품</a></td>
							<td class="cate_si"><a href="?category=music">음악</a></td>
							<td class="cate_si"><a href="?category=movie">영화</a></td>
						</tr>
						<tr>
							<td class="cate_si"><a href="#">음식</a></td>
							<td class="cate_si"><a href="#">이용권</a></td>
							<td class="cate_si"><a href="#">여행</a></td>
							<td class="cate_si"><a href="#">기타</a></td>
						</tr>
					</table> -->
				</div>


				<div class="auction_div">
					<c:forEach var="vo" items="${ list }">
				      	<div class="col-sm-2 product_auc">
				      		<div style="width:100%; height: 50%; border: 1px solid black; margin: auto; margin-top: 10px;" onclick="location.href='a_board.do?auctionBoardNo=${vo.auctionBoardNo}'">
				      			<img alt="사진" src=""><br><br>
				      		</div><br>
				      		<p style="text-align: left; margin: 0">상품명 : ${ vo.pName }</p>
				      		<p style="text-align: left; margin: 0">현재 입찰가 : ${ vo.entryBidPrice }원</p><br>
				      		<p style="text-align: left; margin: 0;">남은일자 : </p> <fmt:formatDate value="${vo.endDate}" pattern="yyyy-MM-dd HH:mm:ss" />
				      	</div>
			      	</c:forEach>
				</div>
			</div>
			<div class="col-sm-2 sidenav" style="background-color: #444444; color: #f1f1f1;">
				<h3>인기 경매 품목</h3>
				<img src="resources/images/따봉도치.jpg" alt="사진" style="width: 300px; height: 300px;">
				<c:forEach var="item" items="${ mostViewedList }">
					<div class="product_auc" style="width: 100%; margin-bottom: 20px;">
						<div style="width: 100%; height: 150px; overflow: hidden; margin: auto; cursor: pointer;"
							 onclick="location.href='a_board.do?auctionBoardNo=${item.auctionBoardNo}'">
							<img src="${item.imagePath}" alt="사진" style="width: 100%; height: auto;">
						</div>
						<p style="text-align: left; margin: 0; color: #ffcc00;">상품명: ${item.pName}</p>
						<p style="text-align: left; margin: 0; color: #ffcc00;">조회수: ${item.viewCount}</p>
					</div>
				</c:forEach>
			</div>
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