<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

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
		console.log(${vo.entryBidPrice})
		console.log(${vo.startPrice})
		if(startPrice<entryBidPrice){	//입찰된 금액이 있는지 여부
			console.log('여기는 입찰금액이 있을때 트루인 이프문이야')
			if(playPrice > entryBidPrice){
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
				alert('현재 등록된 입찰가능한 가격보다 높게 등록해야합니다\n현재 최고입찰가:${vo.entryBidPrice}');
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
	여기는 if문을 통과한 입찰 메인페이지야
	<form>
		<div>
			<input type="hidden" value="${ userNo }">
			<input type="hidden" value="${ playPrice }">
			<input type="hidden" value="${ bidNo }">
			<input type="hidden" value="${ pNo }">
			<input type="hidden" value="${ startPrice }">
			<input type="hidden" value="${ user.myCash }">
			<input type="hidden" value="${ entryBidPrice }">
			<input type="number" name="playPrice">
			<input type="button" value="입찰하기" name="playPrice_btn" onclick="bid(this.form);">
		</div>
		<a href="home.do">메인화면</a>
	</form>

</body>
</html>