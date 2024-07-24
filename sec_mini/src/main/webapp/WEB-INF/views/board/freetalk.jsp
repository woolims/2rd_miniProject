<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    }
    .table {
      margin-top: 20px;
    }
    .table th, .table td {
      text-align: center;
    }
  </style>
  
   <script type="text/javascript">
    function insert_form(){
      //새글쓰기 폼 띄우기
      location.href = "<%=request.getContextPath()%>/board/insert_form.do";
    }
  </script>
  
</head>
<body>

<%@ include file="../menubar/menubar.jsp"%>

<div class="container">

  <!-- 상단 검색 창 및 글쓰기 버튼 -->
  <div class="row mb-4">
    <div class="col-sm-10">
      <form class="form-inline">
        <select id="search" class="form-control">
          <option value="all">전체보기</option>
          <option value="name">이름</option>
          <option value="content">내용</option>
          <option value="name_content">이름+내용</option>
        </select>
        <input type="text" class="form-control" placeholder="검색어를 입력하세요">
        <button class="btn btn-default" type="button">검색</button>
      </form>
    </div>
    <div class="col-sm-2 text-right">
      <c:if test="${ not empty sessionScope.user }">
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
          <th width="50%">제목</th>
          <th>글쓴이</th>
          <th>작성시간</th>
          <th>댓글수</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="vo" items="${list}">
          <tr>
            <td>${vo.boardNo}</td>
            <td><a href="view.do?boardNo=${vo.boardNo}">${vo.title}</a></td>
            <td>${vo.nickName}</td>
            <td>${vo.createAt}</td>
            <td>${vo.b_readhit}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

</div>

<%@ include file="../menubar/footer.jsp"%>

</body>
</html>
