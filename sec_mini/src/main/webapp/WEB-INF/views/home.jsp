<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>암시장 메인 페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<style>
.banner {
	margin-bottom: 20px;
}

.auction-item {
	border: 1px solid #ddd;
	padding: 15px;
	margin-bottom: 20px;
	border-radius: 5px;
	text-align: center;
}

.auction-item img {
	max-width: 100%;
	height: auto;
	border-radius: 5px;
}

.forum-post {
	border: 1px solid #ddd;
	padding: 15px;
	margin-bottom: 15px;
	border-radius: 5px;
	background-color: #f9f9f9;
}

.forum-post h5 {
	margin: 0 0 10px;
}
</style>
</head>
<body>

	<%@ include file="menubar/menubar.jsp"%>

	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm-2 sidenav">
				<!-- 좌측 사이드바 내용 -->
			</div>
			<div class="col-sm-8 text-left">
				<h1>암시장 메인 페이지</h1>

				<!-- 배너 섹션 -->
				<div class="banner">
					<div id="carouselExampleIndicators" class="carousel slide"
						data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carouselExampleIndicators" data-slide-to="0"
								class="active"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
						</ol>
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img class="d-block w-100" src="banner1.jpg" alt="First slide">
								<div class="carousel-caption d-none d-md-block">
									<h5>배너 1</h5>
									<p>홍보 내용 1</p>
								</div>
							</div>
							<div class="carousel-item">
								<img class="d-block w-100" src="banner2.jpg" alt="Second slide">
								<div class="carousel-caption d-none d-md-block">
									<h5>배너 2</h5>
									<p>홍보 내용 2</p>
								</div>
							</div>
							<div class="carousel-item">
								<img class="d-block w-100" src="banner3.jpg" alt="Third slide">
								<div class="carousel-caption d-none d-md-block">
									<h5>배너 3</h5>
									<p>홍보 내용 3</p>
								</div>
							</div>
						</div>
						<a class="carousel-control-prev" href="#carouselExampleIndicators"
							role="button" data-slide="prev"> <span
							class="carousel-control-prev-icon" aria-hidden="true"></span> <span
							class="sr-only">Previous</span>
						</a> <a class="carousel-control-next"
							href="#carouselExampleIndicators" role="button" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>
				</div>

				<!-- 인기 경매 물품 박스 -->
				<h2>인기 있는 경매 물품</h2>
				<div class="row">
					<div class="col-md-3">
						<div class="auction-item">
							<img src="item1.jpg" alt="Item 1">
							<h4>경매 물품 1</h4>
							<p>설명: 경매 물품 1의 설명</p>
						</div>
					</div>
					<div class="col-md-3">
						<div class="auction-item">
							<img src="item2.jpg" alt="Item 2">
							<h4>경매 물품 2</h4>
							<p>설명: 경매 물품 2의 설명</p>
						</div>
					</div>
					<div class="col-md-3">
						<div class="auction-item">
							<img src="item3.jpg" alt="Item 3">
							<h4>경매 물품 3</h4>
							<p>설명: 경매 물품 3의 설명</p>
						</div>
					</div>
					<div class="col-md-3">
						<div class="auction-item">
							<img src="item4.jpg" alt="Item 4">
							<h4>경매 물품 4</h4>
							<p>설명: 경매 물품 4의 설명</p>
						</div>
					</div>
				</div>

				<!-- 자유게시판 최신글 목록 -->
				<h2>자유게시판 최신 글</h2>
				<div class="forum-post">
					<h5>
						<a href="#">자유게시판 글 제목 1</a>
					</h5>
					<p>내용 요약: 글 내용의 요약...</p>
					<small>작성일: 2024-07-29</small>
				</div>
				<div class="forum-post">
					<h5>
						<a href="#">자유게시판 글 제목 2</a>
					</h5>
					<p>내용 요약: 글 내용의 요약...</p>
					<small>작성일: 2024-07-28</small>
				</div>
				<div class="forum-post">
					<h5>
						<a href="#">자유게시판 글 제목 3</a>
					</h5>
					<p>내용 요약: 글 내용의 요약...</p>
					<small>작성일: 2024-07-27</small>
				</div>
				<div class="forum-post">
					<h5>
						<a href="#">자유게시판 글 제목 4</a>
					</h5>
					<p>내용 요약: 글 내용의 요약...</p>
					<small>작성일: 2024-07-26</small>
				</div>
				<div class="forum-post">
					<h5>
						<a href="#">자유게시판 글 제목 5</a>
					</h5>
					<p>내용 요약: 글 내용의 요약...</p>
					<small>작성일: 2024-07-25</small>
				</div>
			</div>
			<div class="col-sm-2 sidenav">
				<!-- 우측 사이드바 내용 -->
			</div>
		</div>
	</div>

	<%@ include file="menubar/footer.jsp"%>

	<script>
		$(function() {
			$('#home').attr('class', 'active');
		});
	</script>
</body>
</html>
