<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>글 작성</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <!-- Quill CSS Library-->
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
    .content {
      flex: 1;
      overflow-y: auto;
    }
    .form-group {
      margin-bottom: 15px;
      margin-top: 10px;
    }
    .btn {
      margin-top: 10px;
    }
    #editor-container {
      height: 50vh; /* 화면의 50% 높이로 설정 */
      overflow-y: auto;
    }
    label {
      font-size: 1.2em; /* 레이블 폰트 크기 키움 */
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
  
  <script type="text/javascript">
    function send(f){
      // Quill editor의 내용을 hidden textarea에 동기화
      document.querySelector('#boardContent').value = quill.root.innerHTML.trim();
      
      let title = f.title.value.trim();
      let boardContent = quill.root.innerHTML.trim();

      if (title === '') {
        alert("제목을 입력하세요!!");
        f.title.value = "";
        f.title.focus();
        return;
      }
      
      if (boardContent === '' || boardContent === '<p><br></p>') {
        alert("내용을 입력하세요!!");
        quill.focus();
        return;
      }

      // 폼을 제출
      f.submit();
    }
  </script>
</head>
<body>

<%@ include file="../menubar/menubar.jsp"%>

<div class="container">
  <h3 style="font-weight: bold;">글을 쓰는 공간입니다.</h3>
  
  <form id="insertForm" action="${pageContext.request.contextPath}/board/insert.do" method="post" enctype="multipart/form-data" class="content">
    <!-- 제목 -->
    <div class="form-group">
      <label for="title">Title:</label>
      <input type="text" class="form-control" id="title" name="title" required>
    </div>

    <!-- 내용 -->
    <div class="form-group">
      <label for="content">Content:</label>
      <div id="editor-container"></div>
      <textarea name="boardContent" id="boardContent" style="display:none;"></textarea>
    </div>

    <!-- 글 작성/목록 버튼 -->
    <div style="margin-top: 10px;">
      <input class="btn btn-info btn-white" type="button" value="목록보기" onclick="location.href='freetalk.do'">
      <input class="btn btn-primary btn-black" type="button" value="글 작성" onclick="send(this.form);">
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

  document.querySelector('form').onsubmit = function() {
    // Sync content to hidden textarea before submitting form
    document.querySelector('#boardContent').value = quill.root.innerHTML;
  };
</script>

</body>
</html>
