	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 커스텀 CSS -->
<style>
body {
	background-color: #f8f9fa;
}

.navbar {
	margin-bottom: 0;
	border-radius: 0;
}

.signup-container {
	max-width: 400px;
	margin: 100px auto;
	padding: 30px;
	background-color: #fff;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
}

.signup-container h2 {
	text-align: center;
	margin-bottom: 30px;
	font-weight: bold;
	color: #007bff;
}

.signup-form .form-control {
	border-radius: 20px;
	margin-bottom: 15px;
}

.signup-form button[type="submit"] {
	padding: 12px 20px;
	font-size: 18px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 20px;
	cursor: pointer;
}

.signup-form button[type="submit"]:hover {
	background-color: #0056b3;
}

.footer {
	background-color: #f2f2f2;
	padding: 25px;
	text-align: center;
}

@media ( max-width : 768px) {
	.signup-container {
		margin-top: 50px;
	}
}


</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

function check_id(){
	 //회원가입 버튼은 비활성화
 	 // <input id="btn_register" type="button" ...  disabled="disabled">
	  $("#btn_register").prop("disabled", true);
	  
	  let userIdReg = $("#userIdReg").val();
	  
	  if(userIdReg.length==0){
	   		
	   		$("#id_msg").html("");
	   		return;
	   	}
	  
	  if(userIdReg.length<3){
	    	
	    	$("#id_msg").html("id는 3자리 이상 입력하세요").css("color","red");
	    	return;
	    }
	  
	  $.ajax({
	    	url		:	"check_id.do",     //MemberCheckIdAction
	    	data	:	{"userId":userIdReg}, //parameter   => check_id.do?mem_id=one
	    	dataType:	"json",
	    	success	:	function(res_data){
	    		// res_data = {"result": true}  or {"result": false}
	    		if(res_data.result){//json으로 받은거 이게 통과가 되면 활성화
	    			$("#id_msg").html("사용가능한 아이디 입니다").css("color","blue");
	    		
	    			//가입버튼 활성화
	    			 $("#btn_register").prop("disabled", false);
	    			
	    		}else{
	    			$("#id_msg").html("이미 사용중인 아이디 입니다").css("color","red");
	    		}
	    	},
	    	error	:	function(err){
	    		alert(err.responseText);
	    	}
	    });	   	  
}//end:check_id

function find_addr(){
	   
	   new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요. 위에 데이타가 존코드에 들가 이 존코드를 addr 인풋태그 id에 
	            $("#userAddr").val(data.address); 	  //선택한 정보의 주소 넣기
	        }
	    }).open();
}//end:find_addr()

	
	
	
	function register(f) {
		// 입력한 값 검증하기.
		if( !f.checkValidity() ) {
			// 필수 입력 하나라도 입력 안 했을 경우
			alert('모두 입력해주세요!');
			return;
		}
		
		
		let userPwdReg = document.getElementById('userPwdReg');
		let checkPwd = document.getElementById('confirm-password');
		
		if( userPwdReg.value != checkPwd.value ){
			alert('비밀번호를 확인해주세요'+userPwdReg.value+"/"+checkPwd.value);
			checkPwd.value='';
			checkPwd.focus();
			return;
		}
		
		if( userPwdReg.value == checkPwd.value) {
			 f.method="post";
			 f.action="register.do";
			 f.submit();
		}
	}

</script>

</head>
<body>
	<%@ include file="../menubar/menubar.jsp" %>
	
	<nav>
	</nav>

	<div class="container" style="min-height: 900px;">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="signup-container">
					<h2>회원가입</h2>
					<form class="signup-form-inline-block">
						<div class="form-group">
							<input type="text" class="form-control" id="userName" name="userName"
								placeholder="이름" required>
						</div>
						<div class="form-group">
							<input type="text" class="form-control" id="userIdReg"
								name="userId" placeholder="아이디" required
									  onkeyup="check_id()">
									  <span id="id_msg"></span>	
						</div>
						<div class="form-group">
							<input type="password" class="form-control" id="userPwdReg"
								name="userPwd" placeholder="비밀번호" required>
						</div>
						<div class="form-group">
							<input type="password" class="form-control" id="confirm-password"
								 placeholder="비밀번호 확인" required>
						</div>
						<div class="form-group">
							<input type="text" class="form-control" id="userAddr"
							name="userAddr" placeholder="주소" required onclick="find_addr()">
							<input class="btn btn-info" type="button" value="주소검색" onclick="find_addr()"
								>
						</div>
						<div class="form-group">
							<input type="text" class="form-control" id="phone"
								name="phone" placeholder="전화번호" required>
						</div>
						<div class="form-group">
							<input type="text" class="form-control" id="nickName" name="nickName"
								placeholder="닉네임" required>
						</div>
						<input id="btn_register" type="button" onclick="register(this.form);" 
						class="btn btn-primary btn-block" disabled="disabled"  value="가입하기">
					</form>
<!-- 					<p class="text-center"> -->
<!-- 						이미 회원이세요? <a href="login_form.do">로그인</a> -->
<!-- 					</p> -->
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../menubar/footer.jsp" %>

</body>
</html>