<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>입찰 페이지</title>
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
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

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
	margin-right: 10px;
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

@media ( max-width : 768px) {
	.signup-container {
		margin-top: 50px;
	}
}
</style>
<script type="text/javascript">

	function bid(f) {
		
		//로그인 여부 체크
		if("${ empty user }" == "true"){
				
			if(confirm("입찰은 로그인후 가능합니다\n로그인 하시겠습니까?")==false) return;
				
			//로그인폼으로 이동
			location.href="login_form.do";
		
			return;
		}
		
		let playPrice   	= parseInt(f.playPrice.value);
		let startPrice  	= parseInt(${vo.startPrice});
		let myCash 			= parseInt(${user.myCash});
		let entryBidPrice   = parseInt(${vo.entryBidPrice});
		let nowBid			= parseInt(${vo.nowBid});
		
		
		if(startPrice<nowBid){	//입찰된 금액이 있는지 여부
			console.log('여기는 입찰금액이 있을때 트루인 이프문이야')
			if(playPrice > nowBid){
				if(myCash>playPrice){
					alert('입찰성공!');
					location.href="bid_success.do?userNo=${vo.userNo}&bidNo=${vo.bidNo}&pNo=${vo.pNo}&playPrice="+playPrice;					
					
					return;
				}else{
					alert('보유금액보다 높은 입찰가는 입력할 수 없습니다')
					f.playPrice.value="";
					f.playPrice.focus();
					return;
				}
			}else{
				alert('현재 입찰가능한 가격보다 높게 등록해야합니다\n현재 입찰가능한 가격 : ${vo.nowBid}');
				f.playPrice.value="";
				f.playPrice.focus();
				return;
			}
		}else{
			console.log('여기는 입찰금액이 없을때 이프문이야')
			if(playPrice > startPrice){
				if(myCash > playPrice){
					alert('입찰성공!');
					location.href="bid_success.do?userNo=${vo.userNo}&bidNo=${vo.bidNo}&pNo=${vo.pNo}&playPrice="+playPrice;
					return;
					
				}else{
					alert('보유금액보다 높은 입찰가는 입력할 수 없습니다');
					f.playPrice.value="";
					f.playPrice.focus();
					return;
				}
			}else{
				alert('현재 등록된 최소입찰가보다 높게 등록해야합니다\n현재 최소입찰가:${vo.startPrice}');
				f.playPrice.value="";
				f.playPrice.focus();
				return;
			}
		}
		
		
	}

</script>


</head>
<body>
	<%@ include file="../menubar/menubar.jsp"%>
	<div class="container" style="min-height: 900px;">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="signup-container">
					<h2>입찰페이지</h2>
					<form class="mypage-form" name="pgForm">
						<input type="hidden" name="userNo" value="${ user.userNo }" />

						<div class="form-group form-group-flex">
							<label>상품이름</label> <input type="text" class="form-control"
								name="pName" value="${ vo.pName }" readonly="readonly">
						</div>

						<div class="form-group">
							<label>입찰에 참여중인 인원 수</label> <input type="text" class="form-control"
								id="bid_person" name="bid_person" value="추가예정" readonly="readonly">
						</div>
						<div class="form-group" style="text-align: right;font-size: 20px;">
						<label>현재 입찰가 : </label>
						<c:if test="${vo.startPrice gt vo.entryBidPrice}">
							<fmt:formatNumber type="number" maxFractionDigits="3" value="${vo.startPrice}"/>원
						</c:if>
						<c:if test="${vo.startPrice lt vo.entryBidPrice}">
							<fmt:formatNumber type="number" maxFractionDigits="3" value="${vo.entryBidPrice}"/>원
						</c:if>
						</div>

						<div class="form-group" style="text-align: right; font-size: 20px;">
							<label>보유 포인트 : </label>
							<fmt:formatNumber type="number" maxFractionDigits="3" value="${ user.myCash }"/>원
						</div>

						<div class="form-group">
								<input type="text" class="form-control" name="playPrice" placeholder="입찰할 가격을 입력하세요"> 
								<input type="button" class="btn btn-success" value="입찰하기" name="playPrice_btn" onclick="bid(this.form);"
								style="margin-top: 3px; text-align: center;">
						</div>

						<div style="text-align: center; margin-top: 20px;">
							<input class="btn btn-primary" type="button" value="돌아가기"
								onclick="location.href='home.do'"> 
							<input class="btn btn-warning" type="button" value="충전하기"
								onclick="location.href='charge_form.do'">
						</div>
					</form>
					<form>
						
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../menubar/footer.jsp"%>
</body>
</html>