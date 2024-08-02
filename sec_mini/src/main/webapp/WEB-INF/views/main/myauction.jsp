<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

.active>a{
	color: black !important;
	font-weight: bold !important;
}

.disactive>a{
	color: white;
	font-weight: bold !important;
}

/* 커스텀 끝 */
</style>
</head>
<body style="background-color: #303030; color: #f1f1f1;">

	<%@ include file="../menubar/menubar.jsp"%>

	<div style="position: relative; z-index: 1;"
		class="container-fluid text-center">
		<div class="row content">
			<div style="position: relative; z-index: 2; background-color: #303030; color: #f1f1f1;"
			class="col-sm-2 sidenav">


			</div>
			<div class="col-sm-8 text-left"
				style="background-color: #303030; color: #f1f1f1;">
				<h2 class="title_auction" style="color: #FFD700;">마이옥션</h2>

				<div>
					<ul class="nav nav-tabs">
						<li class="disactive active"><a data-toggle="tab" href="#menu1">입찰내역</a>

						</li>
						<li class="disactive"><a data-toggle="tab" href="#menu2">낙찰내역</a></li>
						<li class="disactive"><a data-toggle="tab" href="#menu3">내가 올린 경매</a></li>
						<!-- 즐겨찾기 -->
						<!-- <li class="disactive"><a data-toggle="tab" href="#menu4">즐겨찾기</a></li> -->
					</ul>

					<div class="tab-content">
						<div id="menu1" class="tab-pane fade in active">
						
							<div class="auction_div">
								<c:choose>
								    <c:when test="${empty list}">
								        <!-- list2가 null이거나 비어있을 때 표시할 내용 -->
								        <h1>내역이 없습니다.</h1>
								    </c:when>
								    <c:otherwise>
								        <!-- list2가 null이 아니고 비어있지 않을 때 반복하여 출력 -->
								        <c:forEach var="vo" items="${list}">
								            <div class="col-sm-2 product_auc">
								                <div
								                    style="width: 100%; height: 50%; border: 1px solid black; margin: auto; margin-top: 10px;"
								                    onclick="location.href='a_board.do?auctionBoardNo=${vo.auctionBoardNo}'">
								                    <img alt="사진" src=""><br> <br>
								                </div>
								                <br>
								                <p style="text-align: left; margin: 0">상품명 : ${vo.pName}</p>
								                <p style="text-align: left; margin: 0">현재 입찰가 : ${vo.entryBidPrice}원</p>
								                <br>
								                <p style="text-align: left; margin: 0;">남은일자 :</p>
								                <fmt:formatDate value="${vo.endDate}" pattern="yyyy-MM-dd HH:mm:ss" />
								            </div>
								        </c:forEach>
								    </c:otherwise>
								</c:choose>
							</div>
							
						</div>
						
						<div id="menu2" class="tab-pane fade">
						
							<div class="auction_div">
								<c:choose>
								    <c:when test="${empty list2}">
								        <!-- list2가 null이거나 비어있을 때 표시할 내용 -->
								        <h1>내역이 없습니다.</h1>
								    </c:when>
								    <c:otherwise>
								        <!-- list2가 null이 아니고 비어있지 않을 때 반복하여 출력 -->
								        <c:forEach var="vo" items="${list2}">
								            <div class="col-sm-2 product_auc">
								                <div
								                    style="width: 100%; height: 50%; border: 1px solid black; margin: auto; margin-top: 10px;"
								                    onclick="location.href='a_board.do?auctionBoardNo=${vo.auctionBoardNo}'">
								                    <img alt="사진" src=""><br> <br>
								                </div>
								                <br>
								                <p style="text-align: left; margin: 0">상품명 : ${vo.pName}</p>
								                <p style="text-align: left; margin: 0">현재 입찰가 : ${vo.entryBidPrice}원</p>
								                <br>
								                <p style="text-align: left; margin: 0;">남은일자 :</p>
								                <fmt:formatDate value="${vo.endDate}" pattern="yyyy-MM-dd HH:mm:ss" />
								            </div>
								        </c:forEach>
								    </c:otherwise>
								</c:choose>
							</div>
							
						</div>
						
						<div id="menu3" class="tab-pane fade">
							
							<div class="auction_div">
								<c:choose>
								    <c:when test="${empty list3}">
								        <!-- list2가 null이거나 비어있을 때 표시할 내용 -->
								        <h1>내역이 없습니다.</h1>
								    </c:when>
								    <c:otherwise>
								        <!-- list2가 null이 아니고 비어있지 않을 때 반복하여 출력 -->
								        <c:forEach var="vo" items="${list3}">
								            <div class="col-sm-2 product_auc">
								                <div
								                    style="width: 100%; height: 50%; border: 1px solid black; margin: auto; margin-top: 10px;"
								                    onclick="location.href='a_board.do?auctionBoardNo=${vo.auctionBoardNo}'">
								                    <img alt="사진" src=""><br> <br>
								                </div>
								                <br>
								                <p style="text-align: left; margin: 0">상품명 : ${vo.pName}</p>
								                <p style="text-align: left; margin: 0">현재 입찰가 : ${vo.entryBidPrice}원</p>
								                <br>
								                <p style="text-align: left; margin: 0;">남은일자 :</p>
								                <fmt:formatDate value="${vo.endDate}" pattern="yyyy-MM-dd HH:mm:ss" />
								            </div>
								        </c:forEach>
								    </c:otherwise>
								</c:choose>
							</div>
							
						</div>

						<!-- 즐겨찾기 -->
						<%-- <div id="menu4" class="tab-pane fade">
							
							<div class="auction_div">
								<c:choose>
								    <c:when test="${empty list4}">
								        <!-- list2가 null이거나 비어있을 때 표시할 내용 -->
								        <h1>내역이 없습니다.</h1>
								    </c:when>
								    <c:otherwise>
								        <!-- list2가 null이 아니고 비어있지 않을 때 반복하여 출력 -->
								        <c:forEach var="vo" items="${list4}">
								            <div class="col-sm-2 product_auc">
								                <div
								                    style="width: 100%; height: 50%; border: 1px solid black; margin: auto; margin-top: 10px;"
								                    onclick="location.href='a_board.do?auctionBoardNo=${vo.auctionBoardNo}'">
								                    <img alt="사진" src=""><br> <br>
								                </div>
								                <br>
								                <p style="text-align: left; margin: 0">상품명 : ${vo.pName}</p>
								                <p style="text-align: left; margin: 0">현재 입찰가 : ${vo.entryBidPrice}원</p>
								                <br>
								                <p style="text-align: left; margin: 0;">남은일자 :</p>
								                <fmt:formatDate value="${vo.endDate}" pattern="yyyy-MM-dd HH:mm:ss" />
								            </div>
								        </c:forEach>
								    </c:otherwise>
								</c:choose>
							</div>
							
						</div> --%>

					</div>
					
					

				</div>



			</div>

		</div>
	</div>

	<%@ include file="../menubar/footer.jsp"%>

</body>
</html>