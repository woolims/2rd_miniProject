<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>글 수정</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <!-- Quill CSS -->
  <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
  <style>
    body, html {
      height: 100%;
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif !important;
    }
    .container {
      display: flex;
      flex-direction: column;
      height: 100vh;
      margin-top: 20px;
    }
    .header {
      display: flex;
      justify-content: flex-start;
      align-items: center;
      margin-bottom: 20px;
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
    
    .btn-black {
	color: white !important;
	border-color: black !important;
	background-color: black !important;
	}
	
	.btn-white {
	color: black !important;
	border-color: black !important;
	background-color: white !important;
	}
    
    
    
    
    
    
  </style>
</head>
<body>

<%@ include file="../menubar/menubar.jsp"%>

<div class="container">
  <div class="header">
    <button class="btn btn-default" onclick="goBack()">
      <i class="fas fa-arrow-left"></i>
    </button>
    <h3 style="font-weight: bold; margin-left: 5px">글을 수정하는 공간입니다.</h3>
  </div>
  
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
      <input class="btn btn-info btn-black" type="button" value="목록보기" onclick="location.href='freetalk.do'">
      <input class="btn btn-primary btn-white " type="button" value="글수정" onclick="send(this.form);">
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

  function send(f) {
    let form = document.getElementById('modifyForm');
    let title = form.title.value.trim();
    let boardContent = quill.root.innerHTML.trim();

    if (title === '') {
      alert("제목을 입력하세요!!");
      form.title.value = "";
      form.title.focus();
      return;
    }
    
    if (boardContent === '' || boardContent === '<p><br></p>') {
      alert("내용을 입력하세요!!");
      quill.focus();
      return;
    }
    
    document.getElementById('boardContent').value = boardContent;
    form.submit();
  }

  function goBack() {
    if (confirm("수정화면에서 나가시겠습니까?\n변경사항이 저장되지 않을 수 있습니다")) {
      window.history.back();
    }
  }
</script>

</body>
</html>
