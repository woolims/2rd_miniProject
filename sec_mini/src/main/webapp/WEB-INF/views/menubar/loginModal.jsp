
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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

@media ( max-width : 768px) {
	.login-container {
		margin-top: 50px;
	}
}

#loginModal {
    position: fixed;
    left: 81%; 
    top: 52%; 
    transform: translate(-50%, -50%);
}

</style>
</head>
<body>
	<!-- Modal -->
	<div class="modal fade" id="loginModal" role="dialog"
		style="width: 100%; height: 100%;">
		<div class="modal-dialog modal-sm">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="pop_mem_name">로그인</h4>
				</div>

				<!-- 본문 -->
				<div class="modal-body">

					<form class="login-form">
						<div class="form-group">
							<input type="text" class="form-control" id="userId" name="userId"
								placeholder="아이디" required>
						</div>
						<div class="form-group">
							<input type="password" class="form-control" id="userPwd"
								name="userPwd" placeholder="비밀번호" required>
						</div>
						<button type="button" onclick="send(this.form)"
							class="btn btn-primary btn-block">로그인</button>


						<div style="text-align: center; margin-top: 20px;">
							<input class="btn btn-success" type="button" value="홈으로"
								onclick="location.href='home.do'"> <input
								class="btn btn-primary" type="button" value="회원가입"
								onclick="location.href='register_form.do'">
						</div>
					</form>

				</div>

			</div>

		</div>
	</div>
	<script>
		function send(f) {
			// 아이디 비밀번호 
			let userId = document.getElementById('userId');
			let userPwd = document.getElementById('userPwd');
			f.method = "post";
			f.action="login.do";
			f.submit();
		}
	
	</script>
</body>
</html>