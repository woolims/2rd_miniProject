<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>글 수정</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <!-- Quill CSS -->
  <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
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
    .content {
      flex: 1;
      overflow-y: auto;
    }
    .form-group {
      margin-bottom: 15px;
    }
    .btn {
      margin-top: 10px;
    }
    #editor-container {
      height: 50vh; /* 화면의 50% 높이로 설정 */
      overflow-y: auto;
    }
  </style>
</head>
<body>

<%@ include file="../menubar/menubar.jsp"%>

<div class="container">
  <h2>글을 수정하는 공간입니다.</h2>
  
  <form id="modifyForm" action="${pageContext.request.contextPath}/board/modify.do" method="post" enctype="multipart/form-data" class="content">
    <input type="hidden" name="boardNo" value="${vo.boardNo}">
    <!-- 제목 -->
    <div class="form-group">
      <label for="title">제목:</label>
      <input type="text" class="form-control" id="title" name="title" value="${vo.title}" required>
    </div>

    <!-- 내용 -->
    <div class="form-group">
      <label for="content">내용:</label>
      <div id="editor-container"></div>
      <textarea name="boardContent" id="boardContent" style="display:none;"></textarea>
    </div>

    <!-- 글 수정 버튼 -->
    <div style="margin-top: 10px;">
      <input class="btn btn-info" type="button" value="목록보기" onclick="location.href='freetalk.do'">
      <input class="btn btn-primary" type="button" value="글수정" onclick="send();">
    </div>
  </form>
</div>

<%@ include file="../menubar/footer.jsp"%>

<!-- Quill JS -->
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<script>
  var quill = new Quill('#editor-container', {
    theme: 'snow'
  });

  // Quill 에디터에 기존 내용 설정
  quill.root.innerHTML = `${vo.boardContent}`;

  function send() {
    let form = document.getElementById('modifyForm');
    let title = form.title.value.trim();
    let boardContent = quill.root.innerHTML.trim();

    if (title === '') {
      alert("제목을 입력하세요!!");
      form.title.value = "";
      form.title.focus();
      return;
    }
    
    if (boardContent === '') {
      alert("내용을 입력하세요!!");
      quill.focus();
      return;
    }
    
    document.getElementById('boardContent').value = boardContent;
    form.submit();
  }
</script>

</body>
</html>
