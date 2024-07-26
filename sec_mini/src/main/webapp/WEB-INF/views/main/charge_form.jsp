<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>충전 페이지</title>
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

	function send(f) {
		
		
	   //로그인이 안되었으면
	   if("${ empty user }" == "true"){
		   
		   if(confirm("로그인후 충전이 가능합니다\n로그인 하시겠습니까?")==false) return;
		   
		   //alert(location.href);
		   // 로그인폼으로 이동
		   location.href="login_form.do?url=" + encodeURIComponent(location.href) ;
		   
		   return;
	   }
		
	    f.method = "post";
		f.action = "charge.do";
		f.submit();
	}

</script>

</head>
<body>
	<%@ include file="../menubar/menubar.jsp"%>
	
	<div class="container" style="min-height: 900px;">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="signup-container">
					<h2>충전페이지</h2>
					<form class="mypage-form">
						<input type="hidden" name="userNo" value="${ user.userNo }" />
						
						<div class="form-group form-group-flex">
								<label>이름</label>
							<input type="text" class="form-control" name="userName" value="${ user.userName }" readonly="readonly">
						</div>
						
						<div class="form-group">
							<label>전화번호</label>
							<input type="text" class="form-control" id="phone" name="phone" value="${ user.phone }">
						</div>
						
						<div class="form-group">
							<label>포인트</label>
							<input type="text" class="form-control" id="point" name="point" value="1000" readonly="readonly">
						</div>
						
						<div style="text-align: center; margin-top: 20px;">
							<input class="btn btn-primary" type="button" value="돌아가기"
					    			onclick="location.href='home.do'" >
					    	<input  class="btn btn-warning" type="button" value="충전하기"
					    	 onclick="send(this.form)">
						</div>
					    	
					    <!-- <input type="button" id="kaobtn" 
					    		style="background: #fee500; color:#000; border-radius: 12px; padding: 10px 20px;" 
					    		value="카카오페이"
					    		onclick="send(this.form)"> -->
					    			
						 </form>
						</div>
				</div>
			</div>
		</div>
<%@ include file="../menubar/footer.jsp"%>
</body>

</html>