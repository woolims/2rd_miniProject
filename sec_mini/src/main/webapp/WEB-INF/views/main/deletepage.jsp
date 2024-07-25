<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>마이 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">	
<!-- 주소검색 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

</script>
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
	max-width: 800px;
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

.form-group-flex {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
	margin-right : 10px;
}

.form-group-flex label {
	width: 80px;
	margin-right: 10px;
}

.form-group-flex input[type="text"] {
	flex: 1;
	margin-right: 20px;
	
}

.form-group-flex input[type="button"] {
	width: 40px;
	padding-left: 5px;
	
	}
	


@media (max-width: 768px) {
	.signup-container {
		margin-top: 50px;
	}
}
</style>
<script type="text/javascript">

//deletepage에 입력한 값 보내기 서버에서 처리위해.
function del(f){
	let userPwd = f.userPwd.value.trim();
	let c_userPwd = f.c_userPwd.value.trim();
	//칸 비어있으면 뜨게하기
	
	if(userPwd==''){
		   alert("비밀번호를 입력하세요");
		   f.userPwd.value="";
		   f.userPwd.focus();
		   return;
	   }
	
	if(c_userPwd==''){
		 alert("다시한번 입력하세요");
		   f.c_userPwd.value="";
		   f.c_userPwd.focus();
		   return;
	}
	
	if(userPwd != c_userPwd){
		alert("비밀번호가 일치하지 않습니다");
		f.c_userPwd.value="";
	    f.c_userPwd.focus();
		  return;
	}
	

	
	//삭제확인  : 확인(true) 취소(false)
	if(confirm("정말 삭제 하시겠습니까?")==false) return;
	
	f.method="post";
	f.action="delete.do";
	f.submit();
	
}//end delete(f)


	   
	   
 
  
  
 

</script>
</head>
<body>
	<%@ include file="../menubar/menubar.jsp"%>
	
	<div class="container" style="min-height: 900px;">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="signup-container">
					<h2>회원 탈퇴</h2>
					<form class="mypage-form">
						<input type="hidden" name="userNo" value="${ user.userNo }" />
						
	

						<div class="form-group form-group-flex">
							<label>비밀번호</label>
							<input type="text" class="form-control" name="userPwd" value="">
						</div>

						<div class="form-group form-group-flex">
							<label>비밀번호 확인</label>
							<input type="text" class="form-control" name="c_userPwd" value=" ">
						</div>

								
					    	<input  class="btn btn-primary" type="button" value="회원탈퇴"
					    	onclick="del(this.form)">
					    
					    			
						 </form>
						</div>
				</div>
			</div>
		</div>
	
	<%@ include file="../menubar/footer.jsp"%>

	
</body>
</html>