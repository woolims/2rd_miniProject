<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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



@media ( max-width : 768px) {
	.login-container {
		margin-top: 50px;
	}
}
</style>

<script type="text/javascript">

	function check_user(qnaNo, userNo){
		
		if((userNo == ${user.userNo} || ${user.userNo} == 1) && ${not empty user}){
			
			location.href = "qna_select.do?qnaNo="+qnaNo;
			
		}else{
			alert("해당 내용은 관리자와 본인만 확인 가능합니다.");
		}
		
	}

</script>
</head>
<body>

	<%@ include file="../menubar/menubar.jsp"%>
	<%@include file="../menubar/mypageModal.jsp" %>
	<%@include file="../menubar/loginModal.jsp" %>

	<div class="container div-size">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="row">
					<div class="col-md-6">
						<h2>게시글 목록</h2>
					</div>
					<div class="col-md-6 text-right" style="margin-top: 20px;">
						<c:if test="${ not empty user }">
							<button type="button" class="btn btn-primary" onclick="location.href='qna_write_form.do'">게시글 등록</button>
						</c:if>
					</div>
				</div>

				<!-- 검색 폼 -->
				<form method="GET" action="board.jsp" style="margin-top: 20px;">
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
							<th style="text-align: center;">번호</th>
							<th style="width: 45%; text-align: center;">제목</th>
							<th style="width: 25%; text-align: center;">작성일</th>
							<th style="width: 20%; text-align: center;">답변 여부</th>
						</tr>
					</thead>
					<tbody style="background-color: white;">
						<c:if test="${not empty user}">
							<c:forEach var="vo" items="${list}">
							    <tr onclick="check_user('${vo.qnaNo}', '${vo.userNo}');">
							        <td style="text-align: center;">${ vo.qnaNo }</td>
							        <td style="width: 45%; text-align: left;">${ vo.qnaTitle }</td>
							        <td style="width: 25%; text-align: center;"><fmt:formatDate value="${vo.qnaCreateAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							        <td style="width: 20%; text-align: center;">미구현</td>
							    </tr>
						    </c:forEach>
						</c:if>
						<c:if test="${empty user}">
						    <tr>
						        <td colspan="4" style="text-align: center;">로그인 후 조회할 수 있습니다.</td>
						    </tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<%@ include file="../menubar/footer.jsp"%>

	<script>
		$(function() {
			$('#QnA').attr('class', 'active');
		});
	</script>

</body>
</html>
