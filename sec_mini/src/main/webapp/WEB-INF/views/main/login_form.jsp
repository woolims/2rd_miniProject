<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>2차 미니 프로젝트 로그인화면</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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

@media ( max-width : 768px) {
	.login-container {
		margin-top: 50px;
	}
}
</style>
</head>
<body>

	<%@ include file="../menubar/menubar.jsp"%>

	<div class="container" style="min-height: 900px;">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="login-container">
					<h2>로그인</h2>
					<form class="login-form">
						<div class="form-group">
							<input type="text" class="form-control" id="userId"
								name="userId" placeholder="아이디" required>
						</div>
						<div class="form-group">
							<input type="password" class="form-control" id="userPwd"
								name="userPwd" placeholder="비밀번호" required>
						</div>
						<button type="button" onclick="login(this.form)" class="btn btn-primary btn-block">로그인</button>
					</form>
					<p class="text-center">
						아직 회원이 아니세요? <a href="${ pageContext.request.contextPath }/register_form.do">회원가입</a>
					</p>
				</div>
			</div>
		</div>
	</div>
		<script>
		function login(f) {
			// 아이디 비밀번호 
			let userId = document.getElementById('userId');
			let userPwd = document.getElementById('userPwd');
			f.method = "post";
			f.action="login.do";
			f.submit();
		}
	
	</script>

	<%@ include file="../menubar/footer.jsp"%>
</body>
</html>