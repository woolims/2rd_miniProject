<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>자유게시판</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style>
    body, html {
      height: 100%;
      margin: 0;
    }
    .container {
      display: flex;
      flex-direction: column;
      height: 100vh; /* 전체 화면 높이에 맞추기 */
      margin-top: 20px;
    }
    .content {
      flex: 1;
      overflow-y: auto;
    }
    .table-container {
      flex: 1;
      overflow-y: auto;
      width: 100%; /* 전체 브라우저 크기에 맞추기 */
    }
    .table {
      margin-top: 20px;
      width: 100%; /* 테이블이 브라우저 너비에 맞추기 */
    }
    .table th, .table td {
      text-align: center;
    }
    .pinned-post {
      background-color: pink; /* 고정된 게시글을 위한 배경색 */
    }
    .pagination-container {
      margin-top: 10px; /* 페이지네이션 위 간격 줄이기 */
    }
  </style>
  <script type="text/javascript">
    function insert_form(){
      // 새글쓰기 폼 띄우기
      location.href = "<%=request.getContextPath()%>/board/insert_form.do";
    }

    function pinPost(boardNo, isPinned) {
      $.post("pin.do", { boardNo: boardNo, isPinned: isPinned }, function(response) {
        location.reload(); // 핀 상태가 변경된 후 페이지 새로고침
      });
    }

    // 검색 버튼 클릭 시 동작
    function find() {
      let search = $("#search").val();
      let search_text = $("#search_text").val().trim();

      if (search === "all") {
        // "전체보기"를 선택하면 페이지를 리로드하고 검색어를 지움
        location.href = "freetalk.do";
        return;
      }

      if (search !== "all" && search_text === "") {
        alert("검색어를 입력하세요!!");
        $("#search_text").val(""); // 지우기
        $("#search_text").focus(); // 포커스
        return;
      }

      location.href = "freetalk.do?search=" + search + "&search_text=" + encodeURIComponent(search_text, "utf-8");
    }

    // 필터 변경 시 동작
    function changeFilter() {
      let search = $("#search").val();
      if (search === "all") {
        location.href = "freetalk.do";
      }
    }
  </script>
</head>
<body>

<%@ include file="../menubar/menubar.jsp"%>

<div class="container">

  <!-- 상단 검색 창 -->
  <div class="row mb-4">
    <div class="col-sm-10">
      <form class="form-inline">
        <select id="search" class="form-control" onchange="changeFilter()">
          <option value="all" <c:if test="${param.search == 'all'}">selected</c:if>>전체보기</option>
          <option value="nickName" <c:if test="${param.search == 'nickName'}">selected</c:if>>이름</option>
          <option value="boardContent" <c:if test="${param.search == 'boardContent'}">selected</c:if>>내용</option>
          <option value="name_content" <c:if test="${param.search == 'name_content'}">selected</c:if>>이름+내용</option>
        </select>
        <input id="search_text" class="form-control" value="${param.search_text != 'null' ? param.search_text : ''}">
        <input type="button" class="btn btn-primary" value="검색" onclick="find();">
      </form>
    </div>
    
    <!-- 글쓰기 버튼 -->
    <div class="col-sm-2 text-right">
      <c:if test="${not empty sessionScope.user}">
        <button class="btn btn-primary" type="button" onclick="insert_form();">글쓰기</button>
      </c:if>
    </div>
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
          <th>댓글수</th>
        </tr>
      </thead>
      <tbody>
        <!-- 게시글 표시 -->
        <c:forEach var="vo" items="${list}">
          <tr id="post-${vo.boardNo}" class="${vo.isPinned == 1 ? 'pinned-post' : ''}">
            <td class="post-no">${vo.isPinned == 1 ? '<span class="glyphicon glyphicon-pushpin"></span>' : vo.boardNo}</td>
            <td><a href="view.do?boardNo=${vo.boardNo}">${vo.title}</a></td>
            <td>${vo.nickName}</td>
            <td>${vo.createAt}</td>
            <td>${vo.b_readhit}</td>
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
    
    <!-- 페이지 메뉴 -->
    <div class="pagination-container" style="text-align: center; margin-top: 10px;">
      <nav aria-label="Page navigation">
        <ul class="pagination">
          ${pageMenu}
        </ul>
      </nav>
    </div>
  </div>
</div>

<%@ include file="../menubar/footer.jsp"%>

</body>
</html>
