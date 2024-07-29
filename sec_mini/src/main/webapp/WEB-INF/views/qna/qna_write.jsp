<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>게시글 등록</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- <script src="https://cdn.ckeditor.com/ckeditor5/42.0.0/ckeditor5.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/42.0.0/"></script>
<script src="https://cdn.ckeditor.com/ckeditor5-premium-features/42.0.0/ckeditor5-premium-features.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5-premium-features/42.0.0/"></script> -->
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<!-- <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script> -->
<script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
<!-- 커스텀 CSS -->
<style>
body {
    background-color: #f8f9fa;
}

.navbar {
    margin-bottom: 0;
    border-radius: 0;
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

.footer {
    background-color: #f2f2f2;
    padding: 25px;
    text-align: center;
}

.ck-editor__editable {
            min-height: 800px;
}

@media ( max-width : 768px) {
    .login-container {
        margin-top: 50px;
    }
}
</style>

	<script type="text/javascript">
			
  			function send(f){
  				
  				console.log(editor.getData());
  				
  				//입력값 검증
  				let boardTitle 	= f.boardTitle.value.trim();
  				let boardContent	= editor.getData();
  				
  				f.boardContent.value = boardContent;
  				
  				console.log(f.boardContent.value);
  				
  				if(boardTitle==''){
  					alert("제목을 입력하세요.");
  					f.boardTitle.value=""; //지우기
  					f.boardTitle.focus();
  					return;
  				}
  				
  				if(boardContent==''){
  					alert("내용을 입력하세요.");
  					f.boardContent.value=""; //지우기
  					f.boardContent.focus();
  					return;
  				}
  				
  				f.action = "qna_write.do"; //전송대상
  				f.submit(); //전송
  				
  			}
  		</script>
</head>
<body>

	<%@ include file="../menubar/menubar.jsp"%>

    <div class="container">
        <div class="row">
            <div class="col-md-12 col-md-offset-0">
                <h2>게시글 등록</h2>
                <form>
                    <div class="form-group">
                        <label for="title">제목</label>
                        <input type="text" class="form-control" id="boardTitle" name="boardTitle" required>
                    </div>
                    <div class="form-group">
                        <label for="content">내용</label>
                        <div id="editor">
                        	<textarea name="boardContent"></textarea>
                        </div>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="send(this.form)">등록</button>
                </form>
            </div>
        </div>
    </div>

	<%@ include file="../menubar/footer.jsp"%>
	<script>
		let editor;
        // Classic Editor를 생성하고 설정
        ClassicEditor
            .create( document.querySelector( '#editor' ), {removePlugins: [ '' ], language: 'ko'} )
            .then(newEditor => {
                editor = newEditor;
            })
            .catch( error => {
                console.error( '에디터 로드 중 오류가 발생했습니다.', error );
            } );
    </script>
	<script>
		$(function() {
			$('#QnA').attr('class', 'active');
		});
	</script>
</body>
</html>
