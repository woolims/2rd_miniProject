<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>마이 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 부트스트랩 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- 부트스트랩 JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
	<!-- 주소검색 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 커스텀 CSS -->
<style>

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
	width: 70px;
	padding-left: 5px;
	
	}
	

@media (max-width: 768px) {
	.signup-container {
		margin-top: 50px;
	}
}

</style>

<script type="text/javascript">
   
   function find_addr(){
	   
	   new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요. 위에 데이타가 존코드에 들가 이 존코드를 addr 인풋태그 id에 
	            $("#userAddr").val(data.address); 	  //선택한 정보의 주소 넣기
	        }
	    }).open();
   }//end:find_addr()
</script>

<script type="text/javascript">

function modify(f){
	//사용자가 입력한 값을 변수 userName에 저장! 사용자가 입력한 값을 서버로 보내기위해 변수에 저장!
	let userName = f.userName.value.trim();
    let userPwd  = f.userPwd.value.trim();
	let userAddr  = f.userAddr.value.trim();
	   //칸이 비어있으면 이 알럿이 뜨게 하는거
	   if(userName==''){
		   alert("이름을 입력하세요");
		   f.userName.value="";
		   f.userName.focus();
		   return;
	   }
	   
	   if(userPwd==''){
		   alert("비밀번호를 입력하세요");
		   f.userPwd.value="";
		   f.userPwd.focus();
		   return;
	   }
	   
	   //악용방지, URL창에 정보 노출되지 않게 보내기위해 post 사용
	   f.method = "post";
	   f.action="modify.do"; //폼 데이터를 modify.do로 전송!
	   f.submit();	//전송
	   
	   
	   
  }//end:modify()
  
  function  redirectToDeletePage(){
	  window.location.href = "delete_form.do";
  }


</script>
</head>
<body>
	<%@ include file="../menubar/menubar.jsp"%>
	
	<div class="container" style="min-height: 900px;">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="signup-container">
					<h2>프로필 수정</h2>
					<form class="mypage-form">
						<input type="hidden" name="userNo" value="${ user.userNo }" />
						
						<div class="form-group form-group-flex">
								<label>이름</label>
							<input type="text" class="form-control" name="userName" value="${ user.userName }">
						</div>

						<div class="form-group form-group-flex">
							<label>아이디</label>
							<input type="text" class="form-control" name="userId"
							id="userId" value="${ user.userId }" readonly="readonly">
						</div>

						<div class="form-group form-group-flex">
							<label>비밀번호</label>
							<input type="text" class="form-control" name="userPwd" value="${ user.userPwd }">
						</div>

						<div class="form-group form-group-flex">
							<label>주소</label>
							<input type="text" class="form-control" name="userAddr" id="userAddr" value="${ user.userAddr }">
						</div>
						<div><input class="btn btn-info" type= "button" style="margin-left: 90px" value="주소검색" onclick="find_addr()"></div>
						
						<div class="form-group">
							<label>전화번호</label>
							<input type="text" class="form-control" id="phone" name="phone" value="${ user.phone }">
						</div>
						
						<div class="form-group">
							<label>닉네임</label>
							<input type="text" class="form-control" id="nickName" name="nickName" value="${ user.nickName }">
						</div>
						
						<div class="form-group">
							<label>포인트</label>
							<input type="text" class="form-control" id="myCash" name="myCash" value="${ user.myCash }" readonly="readonly">
						</div>
						<div><input class="btn btn-warning" type="button" value="충전하기" onclick="location.href='charge_form.do'"></div>
						
						<div style="text-align: center; margin-top: 20px;">
							<input class="btn btn-success" type="button" value="수정하기"
					    			onclick="modify(this.form);" >
						<c:choose>
						    <c:when test="${user.userName eq '관리자'}">
						        <input class="btn btn-primary" type="button" value="관리자 페이지"
						               onclick="location.href='${pageContext.request.contextPath}/member_list.do'">
						    </c:when>
						    <c:otherwise>
						        <input class="btn btn-primary" type="button" value="마이옥션"
						               onclick="location.href='${pageContext.request.contextPath}/myauction.do'">
						    </c:otherwise>
						</c:choose>
				
						</div>
						<div style="text-align: right;">
							<a href="${ pageContext.request.contextPath }/delete_form.do">회원탈퇴</a>	
					    </div> 		
						 </form>
						</div>
				</div>
			</div>
		</div>
<%@ include file="../menubar/footer.jsp"%>
</body>

</html>