<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<title>암시장 메인 페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>
body {
    background-color: #2c2c2c; /* 어두운 회색 배경 */
    color: #f1f1f1; /* 밝은 텍스트 색상 */
    font-family: 'Arial', sans-serif; /* 일반적인 글꼴 */
}

.banner {
    position: relative; /* 배너의 위치를 상대적으로 설정 */
    width: 100%;
    margin-bottom: 0; /* 마진 제거 */
}

.carousel-inner .item img {
    width: 100%; /* 이미지의 너비를 컨테이너에 맞게 설정 */
    height: auto; /* 높이는 자동으로 조정 */
    max-height: 600px; /* 최대 높이 제한 */
    object-fit: contain; /* 이미지를 비율에 맞게 조정 */
}

.carousel-caption {
    position: absolute; /* 절대 위치 설정 */
    bottom: 0 !important; /* 배너 하단에 붙이기 */
    background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
    color: #fff; /* 텍스트 색상 */
    padding: 20px; /* 패딩 추가 */
    border-radius: 5px; /* 모서리 둥글게 */
    text-align: center; /* 텍스트 중앙 정렬 */
}

.auction-item {
    border: 1px solid #444; /* 더 어두운 테두리 */
    padding: 15px;
    margin-bottom: 20px;
    border-radius: 5px;
    text-align: center;
    background-color: #333; /* 어두운 배경 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5); /* 그림자 추가 */
}

.auction-item img {
    max-width: 100%;
    height: 200px;
    object-fit: contain; /* 이미지가 완전히 보이도록 조정 */
    border-radius: 5px;
    border: 2px solid #555;
}

.forum-post {
    border: 1px solid #555; /* 더 어두운 테두리 */
    padding: 15px;
    margin-bottom: 15px;
    border-radius: 5px;
    background-color: #444; /* 어두운 배경 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5); /* 그림자 추가 */
}

.forum-post h5 {
    margin: 0 0 10px;
}

.sidenav {
    background-color: #2c2c2c; /* 어두운 회색 배경 */
    color: #f1f1f1; /* 밝은 텍스트 색상 */
}

.sidenav a {
    color: #f1f1f1; /* 사이드바 링크 색상 */
}

.sidenav a:hover {
    color: #ff9800; /* 사이드바 링크 호버 색상 */
}

.btn-custom {
    background-color: #ff5722; /* 버튼 배경색 */
    color: #fff; /* 버튼 텍스트 색상 */
    border: none; /* 버튼 테두리 제거 */
}

.btn-custom:hover {
    background-color: #e64a19; /* 버튼 호버 색상 */
}

.carousel-control {
    width: 5%; /* 버튼 너비 조정 */
}
.carousel-indicators {
    margin-bottom: 0px !important;
}

.carousel-control .glyphicon-chevron-left,
.carousel-control .glyphicon-chevron-right {
    color: #ffffff; /* 아이콘 색상 변경 */
    font-size: 2rem; /* 아이콘 크기 조정 */
}
</style>
</head>
<body>

    <%@ include file="menubar/menubar.jsp"%>

    <div class="container-fluid text-center">
        <div class="row content">
            <div class="col-sm-2 sidenav" style="background-color: #303030; color: #f1f1f1;">
                <!-- 좌측 사이드바 내용 -->
                <h4>카테고리</h4>
                <ul class="list-unstyled">
                    <li><a href="#">집에 가고 싶다</a></li>
                    <li><a href="#">집에 가고 싶다</a></li>
                    <li><a href="#">집에 가고 싶다</a></li>
                </ul>
            </div>
            <div class="col-sm-8 text-left">
                <h1>암시장 메인 페이지</h1>

                <!-- 배너 섹션 -->
                <div class="banner">
                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="item active">
                                <img src="resources/images/따봉도치.jpg" alt="First slide">
                                <div class="carousel-caption">
                                    <p>홍보 내용 1</p>
                                </div>
                            </div>
                            <div class="item">
                                <img src="resources/images/따봉도치.jpg" alt="Second slide">
                                <div class="carousel-caption">
                                    <p>홍보 내용 2</p>
                                </div>
                            </div>
                            <div class="item">
                                <img src="resources/images/따봉도치.jpg" alt="Third slide">
                                <div class="carousel-caption">
                                    <p>홍보 내용 3</p>
                                </div>
                            </div>
                        </div>
                        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev"> 
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> 
                            <span class="sr-only">Previous</span>
                        </a> 
                        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>

                <!-- 인기 경매 물품 박스 -->
                <h2>인기 있는 경매 물품</h2>
                <div class="row">
                    <div class="col-md-3">
                        <div class="auction-item">
                            <img src="resources/images/따봉도치.jpg" alt="Item 1">
                            <h4>경매 물품 1</h4>
                            <p>설명: 경매 물품 1의 설명</p>
                            <button class="btn btn-custom">입찰하기</button>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="auction-item">
                            <img src="resources/images/따봉도치.jpg" alt="Item 2">
                            <h4>경매 물품 2</h4>
                            <p>설명: 경매 물품 2의 설명</p>
                            <button class="btn btn-custom">입찰하기</button>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="auction-item">
                            <img src="resources/images/따봉도치.jpg" alt="Item 3">
                            <h4>경매 물품 3</h4>
                            <p>설명: 경매 물품 3의 설명</p>
                            <button class="btn btn-custom">입찰하기</button>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="auction-item">
                            <img src="resources/images/따봉도치.jpg" alt="Item 4">
                            <h4>경매 물품 4</h4>
                            <p>설명: 경매 물품 4의 설명</p>
                            <button class="btn btn-custom">입찰하기</button>
                        </div>
                    </div>
                </div>

				<!-- 자유게시판 최신글 목록 -->
				<h2>자유게시판 최신 글</h2>
				<c:forEach var="post" items="${topThreePosts}">
				    <div class="forum-post">
				        <h5>
				            <a href="board/view.do?boardNo=${post.boardNo}">${post.title}</a>
				        </h5>
				        <p>내용 요약: ${fn:substring(post.boardContent, 0, 100)}...</p> <!-- 내용 요약 -->
				        <small>작성일: <fmt:formatDate value="${post.createAt}" pattern="yyyy-MM-dd HH:mm:ss"/></small> <!-- 포맷팅된 날짜 -->
				    </div>
				</c:forEach>
            </div>
            <div class="col-sm-2 sidenav" style="background-color: #303030; color: #f1f1f1;">
                <!-- 우측 사이드바 내용 -->
                <h4>인기 품목</h4>
                <ul class="list-unstyled">
                    <li><a href="#">집에 가고 싶다</a></li>
                    <li><a href="#">집에 가고 싶다</a></li>
                    <li><a href="#">집에 가고 싶다</a></li>
                </ul>
            </div>
        </div>
    </div>

    <%@ include file="menubar/footer.jsp"%>

    <script>
        $(function() {
            $('#home').addClass('active');
        });
    </script>
</body>
</html>
