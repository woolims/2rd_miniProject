<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>자유게시판</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
/* CSS 스타일 */
body, html {
	height: 100%;
	margin: 0;
	font-family: 'Noto Sans KR', sans-serif !important;
}

.wrapper {
	width: 80%;
	max-width: 1200px;
	margin: 0 auto;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
	padding: 25px;
	border-bottom: 1px solid #000000;
	margin-top: 30px;
	margin-bottom: 40px;
	position: relative;
}

.header .title {
	font-size: 3em;
	font-weight: bolder;
}

.header .subtitle {
	margin-top: 10px;
	font-size: 1.1em;
	color: #666;
}

.header-image {
	position: absolute;
	right: 0;
	bottom: -20px;
	max-width: 140px;
	height: auto;
}

.container {
	display: flex;
	flex-direction: column;
	height: 80vh;
	margin-top: 20px;
}

.content {
	flex: 1;
	overflow-y: auto;
}

.table-container {
	flex: 1;
	overflow-y: auto;
	width: 100%;
}

.table {
	margin-top: 20px;
	width: 100%;
	border-collapse: collapse;
	font-size: 0.9em;
}

.table th, .table td {
	text-align: center;
	padding: 12px;
	border-top: 1px solid #ddd;
	vertical-align: middle;
}

.table th {
	font-weight: bold;
	background-color: #333;
	color: white;
}

.table td {
	color: #333;
}

.table tr:not(:last-child) {
	border-bottom: 1px solid #ddd;
}

.table td, .table th {
	border-right: none;
}

.table td:last-child, .table th:last-child {
	border-right: none;
}

.table a {
	color: #333; /* 링크 색상을 검정색으로 변경 */
	text-decoration: none; /* 밑줄 제거 */
}

.table a:hover {
	color: #000; /* 링크에 마우스를 올렸을 때 색상 */
}

.pinned-post {
	background-color: #f5f5f5;
}

.search-box {
	display: flex;
	align-items: center;
}

.search-box select {
	margin-right: 5px;
}

.search-box input[type="text"] {
	width: 200px;
	margin-right: 5px;
	margin-left: 5px;
	padding: 5px 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.search-box .search-icon {
	cursor: pointer;
	font-size: 1.5em;
	color: #ffffff;
	margin-left: 5px;
	padding: 4.3px;
	background-color: #000000;
	border: 1px solid #000000;
	border-radius: 4px;
}

.search-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.btn-black {
	color: white !important;
	border-color: black !important;
	background-color: black !important;
}

.pagination-container {
	margin-top: 10px;
	text-align: center;
}

.pagination > li > a, .pagination > li > span {
	color: #000 !important; /* 검정색 텍스트 */
	background-color: #fff !important; /* 흰색 배경 */
	border: 1px solid #000 !important; /* 검정색 테두리 */
	margin: 0 0.5px !important; /* 간격 추가 */
}

.pagination > li > a:hover, .pagination > li > span:hover,
.pagination > li > a:focus, .pagination > li > span:focus {
	color: #fff !important; /* 흰색 텍스트 */
	background-color: #000 !important; /* 검정색 배경 */
	border-color: #000 !important; /* 검정색 테두리 */
}

.pagination > .active > a, .pagination > .active > span,
.pagination > .active > a:hover, .pagination > .active > span:hover,
.pagination > .active > a:focus, .pagination > .active > span:focus {
	z-index: 3 !important;
	color: #fff !important; /* 흰색 텍스트 */
	background-color: #000 !important; /* 검정색 배경 */
	border-color: #000 !important; /* 검정색 테두리 */
	cursor: default !important;
}

.pagination > .disabled > span, .pagination > .disabled > span:hover,
.pagination > .disabled > span:focus, .pagination > .disabled > a,
.pagination > .disabled > a:hover, .pagination > .disabled > a:focus {
	color: #777 !important; /* 회색 텍스트 */
	background-color: #fff !important; /* 흰색 배경 */
	border-color: #000 !important; /* 검정색 테두리 */
	cursor: not-allowed !important;
}
</style>

<script type="text/javascript">
function insert_form() {
	location.href = "<%=request.getContextPath()%>/board/insert_form.do";
}

function pinPost(boardNo, isPinned) {
	$.post("pin.do", { boardNo: boardNo, isPinned: isPinned }, function(response) {
		location.reload();
	});
}

function find() {
	let search = $("#search").val();
	let search_text = $("#search_text").val().trim();

	if (search === "all") {
		location.href = "freetalk.do";
		return;
	}

	if (search !== "all" && search_text === "") {
		alert("검색어를 입력하세요!!");
		$("#search_text").val("");
		$("#search_text").focus();
		return;
	}

	location.href = "freetalk.do?search=" + search + "&search_text=" + encodeURIComponent(search_text, "utf-8");
}

function changeFilter() {
	let search = $("#search").val();
	if (search === "all") {
		location.href = "freetalk.do";
	}
}

function formatDate(dateStr) {
	return dateStr.substring(0, 16); // 'YYYY-MM-DD HH:MI'까지 자르기
}

$(document).ready(function() {
	$(".post-date").each(function() {
		let originalDate = $(this).text();
		let formattedDate = formatDate(originalDate);
		$(this).text(formattedDate);
	});
});
</script>
</head>
<body>

	<%@ include file="../menubar/menubar.jsp"%>

	<div class="wrapper">
		<div class="header">
			<div>
				<div class="title">자유게시판</div>
				<div class="subtitle">다양한 정보와 새로운 소식을 공유해보세요.</div>
			</div>
			<img src="${ pageContext.request.contextPath }/resources/images/freetalk_1.png" alt="Header Image" class="header-image">
		</div>

		<div class="container">
			<!-- 상단 검색 창 -->
			<div class="search-container">
				<form class="form-inline search-box">
					<select id="search" class="form-control" onchange="changeFilter()">
						<option value="all" <c:if test="${param.search == 'all'}">selected</c:if>>전체</option>
						<option value="nickName" <c:if test="${param.search == 'nickName'}">selected</c:if>>이름</option>
						<option value="boardContent" <c:if test="${param.search == 'boardContent'}">selected</c:if>>내용</option>
						<option value="name_content" <c:if test="${param.search == 'name_content'}">selected</c:if>>이름+내용</option>
					</select>
					<input id="search_text" class="form-control" placeholder="검색어 입력" value="${param.search_text != 'null' ? param.search_text : ''}">
					<i class="fas fa-search search-icon" onclick="find()"></i>
				</form>
				<c:if test="${not empty sessionScope.user}">
					<button class="btn btn-black btn-primary" type="button" onclick="insert_form();">글쓰기</button>
				</c:if>
			</div>

			<!-- 게시글 테이블 -->
			<div class="table-container">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>No</th>
							<th width="40%">제목</th>
							<th>글쓴이</th>
							<th>작성시간</th>
							<th>댓글수</th> <!-- 댓글수 컬럼 추가 -->
						</tr>
					</thead>
					<tbody>
						<!-- 게시글 표시 -->
						<c:forEach var="vo" items="${list}">
							<tr id="post-${vo.boardNo}" class="${vo.isPinned == 1 ? 'pinned-post' : ''}">
								<td class="post-no">${vo.isPinned == 1 ? '<span class="badge" style="background-color: red; color: white;">공지</span>' : vo.boardNo}</td>
								<td><a href="view.do?boardNo=${vo.boardNo}" style="color: black; ">${vo.title}</a></td>
								<td>${vo.nickName}</td>
								<td class="post-date">${vo.createAt}</td>
								<td>${vo.commentCount}</td> <!-- 댓글수 데이터 표시 -->
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 내용이 없을 경우 -->
				<c:if test="${empty requestScope.list}">
					<div id="empty_msg" style="text-align: center; font-size: 40px;">
						등록된 게시물이 없습니다
					</div>
				</c:if>
			</div>
		</div>

		<!-- 페이지 메뉴 -->
		<div class="pagination-container" style="text-align: center;">
			<nav aria-label="Page navigation">
				<ul class="pagination">${pageMenu}</ul>
			</nav>
		</div>
	</div>

	<%@ include file="../menubar/footer.jsp"%>

</body>
</html>
