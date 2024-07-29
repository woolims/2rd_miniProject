<%@page import="board.vo.BoardVo"%>
<%@page import="board.dao.BoardDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
SimpleDateFormat df = new SimpleDateFormat("YY-MM-dd HH:mm");

int pageSize = 10; // 한 페이지에 출력할 레코드 수

// 페이지 링크를 클릭한 번호 / 현재 페이지
String pageNum = request.getParameter("pageNum");
int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
String search = request.getParameter("search");

if (search == null) {
	search = "";
}

int count = 0;
BoardDao manager = BoardDao.getInstance();
if (search == "") {
	count = manager.getCount(categoryNo); // 데이터베이스에 저장된 총 갯수
} else {
	count = manager.getCount(categoryNo, search); // 데이터베이스에 저장된 총 갯수
}

if (pageNum == null) { // 클릭한게 없으면 1번 페이지
	pageNum = "1";
}
// 연산을 하기 위한 pageNum 형변환 / 현재 페이지
int currentPage = Integer.parseInt(pageNum);

// 해당 페이지에서 시작할 레코드 / 마지막 레코드
int startRow = count - (currentPage * 10) + 1;
int endRow = count - (currentPage - 1) * 10;

List<BoardVo> list3 = null;
if (count > 0) {
	// getList()메서드 호출 / 해당 레코드 반환

	if (search == "") {
		list3 = manager.boardPageList(categoryNo, startRow, endRow);
	} else {
		list3 = BoardDao.getInstance().boardTitleList(categoryNo, startRow, endRow, search);
	}

}
%>



<!DOCTYPE html>
<html>
<head>
<title>게시글 목록</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 커스텀 CSS -->
<style>
body {
	background-color: #f8f9fa;
}

.navbar {
	margin-bottom: 0;
	border-radius: 0;
}

.div-size {
	height: 680px;
}

.login-container {
	max-width: 400px;
	margin: 100px auto;
	padding: 30px;
	background-color: #fff;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
}

.login-container h2 {
	text-align: center;
	margin-bottom: 30px;
	font-weight: bold;
	color: #007bff;
}

.login-form .form-control {
	border-radius: 20px;
	margin-bottom: 15px;
}

.login-form button[type="submit"] {
	padding: 12px 20px;
	font-size: 18px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 20px;
	cursor: pointer;
}

.login-form button[type="submit"]:hover {
	background-color: #0056b3;
}

.boardtitle {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	word-spacing: break-all;
}

.footer {
	background-color: #f2f2f2;
	padding: 25px;
	text-align: center;
}

a {
	color: black !important;
}

a:hover {
	color: black !important;
	text-decoration: none !important;
	text-shadow: 0.5px 0.5px 0.5px black;
}

@media ( max-width : 768px) {
	.login-container {
		margin-top: 50px;
	}
}

#board-page-area {
	
}
</style>
</head>
<body>

	<%@ include file="/common/menubar.jsp"%>

	<div class="container div-size">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="row">
					<div class="col-md-6">
						<h2>${ list2.categoryName }게시글 목록</h2>
					</div>
					<div class="col-md-6 text-right">
						<c:if test="${ (loginUser.userId eq 'admin')}">
							<button type="button" class="btn btn-primary"
								onclick="location.href='board_write_form.do?categoryNo=<%=categoryNo%>'">게시글
								등록</button>
						</c:if>
					</div>
				</div>

				<!-- 검색 폼 -->
				<form method="GET" action="board.jsp" style="margin-top: 20px;">
					<input type="hidden" name="categoryNo" value="<%=categoryNo%>">
					<div class="input-group">
						<input type="text" class="form-control" name="search"
							placeholder="검색어를 입력하세요"
							value="<%=request.getParameter("search") != null ? request.getParameter("search") : ""%>">
						<span class="input-group-btn">
							<button class="btn btn-default" type="submit">검색</button>
						</span>
					</div>
				</form>

				<table class="table table-striped"
					style="margin-top: 20px; table-layout: fixed;">
					<thead>
						<tr>
							<th>번호</th>
							<th style="width: 35%; text-align: center;">제목</th>
							<th style="width: 15%;">작성자</th>
							<th style="width: 25%; text-align: center;">작성일</th>
							<th style="text-align: center;">조회수</th>
						</tr>
					</thead>
					<tbody style="background-color: white;">
						<%
						if (count > 0) { // 데이터베이스에 데이터가 있으면
							int number = count - (currentPage - 1) * pageSize; // 글 번호 순번 
							for (int i = 0; i < list3.size(); i++) {
								BoardVo board = list3.get(i); // 반환된 list에 담긴 참조값 할당
						%>
						<tr>
							<td><%=number--%></td>
							<td style="width: 40%; text-align: center;" class="boardtitle">
								<%-- 제목을 클릭하면 get 방식으로 해당 항목의 no값과 pageNum을 갖고 content.jsp로 이동 --%>
								<a
								href="board_select.do?boardNo=<%=board.getBoardNo()%>&categoryNo=<%=categoryNo%>&pageNum=<%=currentPage%>&search=<%=search%>"><%=board.getBoardTitle()%></a>
							</td>
							<td style="width: 15%;"><%=board.getUserName()%></td>
							<td style="width: 25%; text-align: center;"><%=(board.getCreatedAt()).substring(0, 16)%></td>
							<td style="text-align: center;"><%=board.getBoardCount()%></td>
						</tr>
						<%
						}
						} else { // 데이터가 없으면
						%>
						<tr>
							<td colspan="5" align="center">게시글이 없습니다.</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<div style="text-align: center;">
					<ul class='pagination'>
						<%
						// 페이징  처리
						if (count > 0) {
							// 총 페이지의 수
							int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
							// 한 페이지에 보여줄 페이지 블럭(링크) 수
							int pageBlock = 10;
							// 한 페이지에 보여줄 시작 및 끝 번호(예 : 1, 2, 3 ~ 10 / 11, 12, 13 ~ 20)
							int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
							int endPage = startPage + pageBlock - 1;

							// 마지막 페이지가 총 페이지 수 보다 크면 endPage를 pageCount로 할당
							if (endPage > pageCount) {
								endPage = pageCount;
							}

							if (startPage > pageBlock) { // 페이지 블록수보다 startPage가 클경우 이전 링크 생성
						%>
						<li><a
							href="board.do?categoryNo=<%=categoryNo%>&pageNum=<%=startPage - 10%>&search=<%=search%>"><</a></li>
						<%
						}

						for (int i = startPage; i <= endPage; i++) { // 페이지 블록 번호
						if (i == currentPage) { // 현재 페이지에는 링크를 설정하지 않음
						%>
						<li class='active'><a><%=i%></a></li>
						<%
						} else { // 현재 페이지가 아닌 경우 링크 설정
						%>
						<li><a
							href="board.do?categoryNo=<%=categoryNo%>&pageNum=<%=i%>&search=<%=search%>"><%=i%></a></li>
						<%
						}
						} // for end

						if (endPage < pageCount) { // 현재 블록의 마지막 페이지보다 페이지 전체 블록수가 클경우 다음 링크 생성
						%>
						<li><a
							href="board.do?categoryNo=<%=categoryNo%>&pageNum=<%=startPage + 10%>&search=<%=search%>">></a></li>
						<%
						}
						}
						%>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/common/footerbar.jsp"%>

	<script>
	$(function(){
		if(${ list2.categoryNo } == 1){
			$('#kor-food').attr('class','active');
		} else if(${ list2.categoryNo } == 2){
			$('#ch-food').attr('class','active');
		} else if(${ list2.categoryNo } == 3){
			$('#jpn-food').attr('class','active');
		}
		
	});
</script>

</body>
</html>
