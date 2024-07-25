<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>게시글 보기</title>
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
      height: 100vh;
      margin-top: 20px;
    }
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .content {
      flex: 1;
      overflow-y: auto;
      margin-bottom: 20px; /* Footer와의 간격을 위해 추가 */
    }
    .panel {
      margin-top: 20px;
    }
    .panel-body {
      min-height: 400px; /* 게시글 본문의 높이를 키움 */
    }
    .comment-section {
      margin-top: 20px;
      border-top: 2px solid #ddd;
      padding-top: 20px;
      background-color: #eeeeee;
      padding: 20px;
    }
    .comment-form {
      margin-top: 20px;
    }
    .comment {
      margin-bottom: 10px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
      background-color: #ffffff;
    }
    .comment-reply {
      margin-left: 40px;
    }
    .comment-form textarea {
      height: 100px; /* 고정 높이 설정 */
      resize: none; /* 크기 조정 불가 */
    }
    .comment-author {
      font-weight: bold;
    }
    .comment-date {
      font-size: 0.9em;
      color: #888;
    }
    .dropdown-menu-right {
      right: 0;
      left: auto;
    }
  </style>
</head>
<body>

<%@ include file="../menubar/menubar.jsp"%>

<div class="container">
  <div class="header">
    <h2>게시글 상세 보기</h2>
    <div class="btn-group">
      <c:if test="${not empty sessionScope.user && sessionScope.user.userNo == vo.userNo}">
        <button type="button" class="btn btn-warning" onclick="location.href='modify_form.do?boardNo=${vo.boardNo}'">수정</button>
      </c:if>
      <button type="button" class="btn btn-primary" onclick="location.href='freetalk.do'">목록으로</button>
      <c:if test="${not empty sessionScope.user && sessionScope.user.userNo == vo.userNo}">
        <button type="button" class="btn btn-danger" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='delete.do?boardNo=${vo.boardNo}'">삭제</button>
      </c:if>
    </div>
  </div>

  <div class="content">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">${vo.title}</h3>
      </div>
      <div class="panel-body">
        <p><span class="comment-author">${vo.nickName}</span></p>
        <p class="comment-date">${vo.createAt}</p>
        <hr>
        <p class="board-content">${vo.boardContent}</p>
      </div>
    </div>
  </div>

  <!-- 댓글 섹션 -->
  <div class="comment-section">
    <h5>댓글</h5>
    
    <!-- 댓글 목록 -->
    <c:forEach var="comment" items="${comments}">
      <div class="comment">
        <p><span class="comment-author">${comment.nickName}</span></p>
        <p>${comment.content}</p>
        <p class="comment-date">${comment.createAt}</p>
        <button class="btn btn-default btn-sm">답글</button>
      </div>
      
      <!-- 대댓글 -->
      <c:forEach var="reply" items="${comment.replies}">
        <div class="comment comment-reply">
          <p><span class="comment-author">${reply.nickName}</span></p>
          <p>${reply.content}</p>
          <p class="comment-date">${reply.createAt}</p>
          <button class="btn btn-default btn-sm">답글</button>
        </div>
      </c:forEach>
    </c:forEach>

    <!-- 댓글 작성 폼 -->
    <div class="comment-form">
      <form action="${pageContext.request.contextPath}/comment/insert.do" method="post">
        <div class="form-group">
          <textarea class="form-control" id="content" name="content" rows="3"
            <c:if test="${empty sessionScope.user}">disabled placeholder="로그인이 필요합니다."</c:if>
            <c:if test="${not empty sessionScope.user}">placeholder="댓글을 작성하세요"</c:if>
            required></textarea>
        </div>
        <input type="hidden" name="boardNo" value="${vo.boardNo}">
        <c:if test="${not empty sessionScope.user}">
          <button type="submit" class="btn btn-primary">등록</button>
        </c:if>
      </form>
    </div>
  </div>
  
</div>

<%@ include file="../menubar/footer.jsp"%>

</body>
</html>
