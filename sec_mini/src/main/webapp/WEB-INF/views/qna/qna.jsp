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

  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- 커스텀 CSS -->
<style>
body, html {
      height: 100%;
      margin: 0;
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


	function find() {
	    let search = $("#search").val();
	    let search_text = $("#search_text").val().trim();

	    if (search === "all") {
	        location.href = "qna.do";
	        return;
	    }

	    if (search_text === "") {
	        alert("검색어를 입력하세요!!");
	        $("#search_text").focus();
	        return;
	    }

	    // JavaScript에서 직접 사용
	    location.href = "qna.do?search=" + search + "&search_text=" + search_text;
	}

      function changeFilter() {
        let search = $("#search").val();
        if (search === "all") {
          location.href = "qna.do";
        }
      }
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

	<div class="container div-size" style="min-height: 1000px;">
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

				<!-- 상단 검색 창 -->
			    <%-- <div class="search-container">
			      <form class="form-inline search-box">
			        <select id="search" class="form-control" onchange="changeFilter()">
			          <option value="all" <c:if test="${param.search == 'all'}">selected</c:if>>전체</option>
			          <option value="userName" <c:if test="${param.search == 'userName'}">selected</c:if>>이름</option>
			          <option value="qnaTitle" <c:if test="${param.search == 'qnaTitle'}">selected</c:if>>제목</option>
			          <option value="name_title" <c:if test="${param.search == 'name_title'}">selected</c:if>>이름+제목</option>
			        </select>
			        <input id="search_text" class="form-control" placeholder="검색어 입력" value="${param.search_text != 'null' ? param.search_text : ''}">
			        <button onclick="find()">검색</button>
			      </form>
			    </div> --%>

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
						<c:if test="${empty user}">
							</table>
							<h1 style="text-align: center; margin-top: 50px;">로그인 후에 이용해주세요.</h1>
							
						</c:if>
						<c:if test="${not empty user}">
						    <c:forEach var="vo" items="${list}">
						        <tr onclick="check_user('${vo.qnaNo}', '${vo.userNo}');">
						            <td style="text-align: center;">${vo.qnaNo}</td>
						            <td style="width: 45%; text-align: left;">${vo.qnaTitle}</td>
						            <td style="width: 25%; text-align: center;">
						                <fmt:formatDate value="${vo.qnaCreateAt}" pattern="yyyy-MM-dd HH:mm:ss" />
						            </td>
						            <td style="width: 20%; text-align: center;">
						                <c:choose>
						                    <c:when test="${answerMap[vo.qnaNo] eq true}">답변 완료</c:when>
						                    <c:otherwise>답변 미완료</c:otherwise>
						                </c:choose>
						            </td>
						        </tr>
						    </c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		<c:if test="${not empty user}">
			<!-- 페이지 메뉴 -->
			<div class="pagination-container" style="text-align: center;">
				<nav aria-label="Page navigation">
					<ul class="pagination">${pageMenu}
					</ul>
				</nav>
			</div>
		</c:if>
	</div>

	<%@ include file="../menubar/footer.jsp"%>

	<script>
		$(function() {
			$('#QnA').attr('class', 'active');
		});
	</script>

</body>
</html>
