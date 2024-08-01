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

<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>

<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

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


	var IMP = window.IMP;
	IMP.init("imp33361271");
	
	var merchant_uid = "O" + new Date().getTime(); // 고유한 주문번호 생성
	
	
	function requestPay() {
		
	//로그인이 안되었으면
	if("${ empty user }" == "true"){
	 
	 if(confirm("로그인후 충전이 가능합니다\n로그인 하시겠습니까?")==false) return;
	 
	 //alert(location.href);
	 // 로그인폼으로 이동
	 location.href="login_form.do?url=" + encodeURIComponent(location.href) ;
	 
	 return;
	}

	//radio value 값 받아오기
	var cash = $("input[name='myCash']:checked").val();
		
    IMP.request_pay({
      pg: "html5_inicis",
      pay_method : 'card',
      merchant_uid: merchant_uid, 
      name : '포인트충전',
      amount : cash,
      buyer_email : '${ user.userNo }',
      buyer_name : '${ user.userName }',
      buyer_tel : '${ user.phone }',
      buyer_addr : '${ user.userAddr }',
      buyer_postcode : ''
    },  function (rsp) {
    	
    	console.log(rsp);
        console.log(rsp.buyer_email);
      	console.log(rsp.paid_amount);
        if (rsp.success) {
        	 alert("결제 완료하였습니다.");
            // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
            // jQuery로 HTTP 요청
            jQuery.ajax({
              url: "charge.do", 
              method: "post",
              //headers: { "Content-Type": "application/json" },
              data: {
  				userNo 	 : rsp.buyer_email,
				//userName : rsp.buyer_name,
				//phone 	 : rsp.buyer_tel,
				myCash 	 : rsp.paid_amount
/*              imp_uid		: rsp.imp_uid,       // 결제 고유번호
                merchant_uid: rsp.merchant_uid   // 주문번호 */      
              },
              	dataType :	"json",
              	success :  function(res){
              		
    				if(res.result > 0) {
    					
    					location.href = "charge_form.do";
						
    					return;
    					
    				}
              	}
                       	
            }).done(function (data) {
              // 가맹점 서버 결제 API 성공시 로직
            }) 

            
          } else {
        	  
            alert("결제에 실패하였습니다.\n에러 내용: " + rsp.error_msg);
          }
    });//end:rsp
    
}//end:requestPay()

</script>

<!--             jQuery.ajax({
            	
            	url		:	"cahrge.do",
            	method	: 	"POST",
            	/* headers	: 	{ "Content-Type": "application/json" }, */
            	data	:	{ 
            				"userNo" 	: rsp.userNo,
            				"userName" 	: rsp.userName,
            				"phone" 	: rsp.phone,
            				"myCash" 	: rsp.myCash,
            				"imp_uid" 	: rsp.imp_uid,
            				"merchant_uid" : rsp.merchant_uid
            				},
            	dataTpye : "json",
            	success : function(res_data){
            		
            		location.href="modify_form.do";
            	},
            	error : function(err) {
            		
            		alert(err.responseText);
            	}
            })  -->

<!-- <script type="text/javascript">

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

</script> -->

</head>
<body>
	<%@ include file="../menubar/menubar.jsp"%>
	<div class="container" style="min-height: 900px;">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="signup-container">
					<h2>충전페이지</h2>
					<form class="mypage-form" name="pgForm">
						<input type="hidden" name="userNo" value="${ user.userNo }" />
						
						<div class="form-group form-group-flex">
								<label>이름</label>
							<input type="text" class="form-control" name="userName" value="${ user.userName }" readonly="readonly">
						</div>
						
						<div class="form-group">
							<label>전화번호</label>
							<input type="text" class="form-control" id="phone" name="phone" value="${ user.phone }" readonly="readonly">
						</div>
						
						<div class="form-group">
							<label>보유 포인트</label>
							<input type="text" class="form-control" id="myCash" name="myCash" value="${ user.myCash }" readonly="readonly">
						</div>
						
						<div class="form-group">
							<label>충전 금액</label> <br>
							<input type="radio" id="ac1" name="myCash" value="100" checked="checked"><label for="ac1">100원</label> &nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="ac2" name="myCash" value="50000"><label for="ac2">50000원</label>  &nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="ac3" name="myCash" value="100000"><label for="ac3">100,000원</label>  &nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="ac4" name="myCash" value="1000000"><label for="ac4">1,000,000원</label>  &nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="ac5" name="myCash" value="5000000"><label for="ac5">5,000,000원</label> 
						</div>
						
						<div style="text-align: center; margin-top: 20px;">
							<input class="btn btn-primary" type="button" value="돌아가기"
					    			onclick="location.href='home.do'" >
					    	<!-- <input  class="btn btn-warning" type="button" value="충전하기"
					    	 onclick="send(this.form)"> -->
					    	 <input  class="btn btn-warning" type="button" value="충전하기"
					    	 onclick="requestPay()">
						</div>					    				
						 </form>
				</div>
				</div>
			</div>
		</div>
<%@ include file="../menubar/footer.jsp"%>
</body>
</html>
