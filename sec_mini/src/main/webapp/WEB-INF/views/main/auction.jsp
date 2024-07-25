<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	width: 500px;
	height: 300px;
	text-align: center;
	margin: auto;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: 10px;
	margin-right: 10px;
	background: yellow;
}

/* 노멀라이즈 시작 */
body, ul, li {
	margin: 0;
	padding: 0;
	list-style: none; /* 해당 태그의 list-style을 none으로 하는 것으로 ●을 제거한다 */
}

a {
	color: inherit; /* 부모 엘리먼트의 값을 물려받는다 */
	text-decoration: none;
	/* 해당 태그의 text-decoration 속성을 none 값으로 하는 것으로 밑줄을 제거한다 */
}
/* 노멀라이즈 끝 */

/* 커스텀 시작 */
.side-bar>ul ul {
	display: none;
}

/* 사이트의 높이를 5000px로 만들어 스크롤 생성 */
body {
	height: 5000px;
	background-color: #444;
}

/* 사이드바 시작 */

/* 사이드바의 너비와 높이를 변수를 통해 통제 */
:root {
	--side-bar-width: 240px;
}

.side-bar {
	position: fixed; /* 스크롤을 따라오도록 지정 */
	background-color: black;
	width: var(--side-bar-width);
	/* 사이드바 위와 아래의 마진을 동일하게 지정 */
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

:root {
	--side-bar__icon: .5s;
}

.side-bar__icon-1>div {
	position: absolute;
	width: 100%;
	height: 20%;
	background-color: white;
	transition: all var(--side-bar__icon);
}

.side-bar__icon-1>div:nth-of-type(1) {
	top: 0;
	width: auto;
	left: 0;
	right: 0;
	transition: all var(--side-bar__icon), left calc(var(--side-bar__icon)/2)
		calc(var(--side-bar__icon)/2), right calc(var(--side-bar__icon)/2)
		calc(var(--side-bar__icon)/2), height calc(var(--side-bar__icon)/2) 0s;
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
	transition: all var(--side-bar__icon), left calc(var(--side-bar__icon)/2)
		0s, right calc(var(--side-bar__icon)/2) 0s, height
		calc(var(--side-bar__icon)/2) calc(var(--side-bar__icon)/2);
}
/* 아이콘 끝 */

/* 모든 메뉴의 a에 속성값 부여 */
.side-bar ul>li>a {
	display: block;
	color: white;
	font-size: 1.4rem;
	font-weight: bold;
	transition: .5s;
}

/* 자식의 position이 absolute일 때 자식을 영역 안에 가두어 준다 */
.side-bar>ul>li {
	position: relative;
}

/* 모든 메뉴가 마우스 인식 시 반응 */
.side-bar ul>li:hover>a {
	background-color: #555;
	border-bottom: 1px solid #999;
}

/* 1차 메뉴의 항목이 마우스 인식 시에 2차 메뉴 등장 */
.side-bar>ul>li:hover>ul {
	display: block;
	position: absolute;
	background-color: #888;
	top: 0; /* 2차 메뉴의 상단을 1차 메뉴의 상단에 고정 */
	left: 100%; /* 2차 메뉴를 1차 메뉴의 너비만큼 이동 */
	width: 100%; /* 1차 메뉴의 너비를 상속 */
}

/* 사이드바 너비의 80%만큼 왼쪽으로 이동 */
.side-bar {
	transform: translate(calc(var(--side-bar-width)* -0.8), 0);
	transition: .5s;
}

/* 마우스 인식 시 원래의 위치로 이동 */
.side-bar:hover {
	transform: translate(-20px, 0); /* 둥근 모서리의 너비만큼 숨겨주기 */
}
/* 사이드바 끝 */

/* 커스텀 끝 */
</style>
</head>
<body>



	<%@ include file="../menubar/menubar.jsp"%>

	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm-2 sidenav">
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
							<li>
								<a href="?categoryno=${ category.categoryNo }">${ category.categoryName }</a>
								<ul>
									<li><a href="#">text1</a></li>
									<li><a href="#">text2</a></li>
									<li><a href="#">text3</a></li>
									<li><a href="#">text4</a></li>
								</ul>
							</li>
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
			<div class="col-sm-8 text-left">
				<h2 class="title_auction">암시장</h2>
				<div style="text-align: center;">

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
					<div class="product_auc">작품1</div>
					<div class="product_auc">작품2</div>
					<div class="product_auc">작품3</div>
					<div class="product_auc">작품4</div>
					<div class="product_auc">작품5</div>
					<div class="product_auc">작품6</div>
				</div>
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