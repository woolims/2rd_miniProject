<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

<script type="text/javascript">



	function bid(f) {
		let bid_price = f.bid_price.value.trim();
		let startPrice = '${startPrice}';
		let myCash = '${user.myCash}';
		let entryBidPrice = '${entryBidPrice}';

		if(startPrice<entryBidPrice){
			if(bid_price > entryBidPrice){
				console.log("asdasdasd");
				if(myCash>bid_price){
					location.href="bid_success.do?pNo=${pNo}";
					alert('입찰성공!')
				}else{
					alert('보유금액보다 높은 입찰가는 입력할 수 없습니다')
					f.bid_price.value="";
					f.bid_price.focus();
				}
				
			}else{
				alert('현재 등록된 최고입찰가보다 높게 등록해야합니다\n최고입찰가: ${entryBidPrice}')
				f.bid_price.value="";
				f.bid_price.focus();
			}
			
		}else{
			if(bid_price > startPrice){
				if(myCash > bid_price){
					location.href="bid_success.do?pNo=${pNo}";
					alert('입찰성공!')
				}else{
					alert('보유금액보다 높은 입찰가는 입력할 수 없습니다')
					f.bid_price.value="";
					f.bid_price.focus();
				}
			}else{
				alert('현재 등록된 최소입찰가보다 높게 등록해야합니다\n현재 최소입찰가: ${startPrice}')
				f.bid_price.value="";
				f.bid_price.focus();
			}
		}
		
		
	}

</script>
</head>
<body>
	여기는 if문을 통과한 입찰 메인페이지야
	<form>
		<div>
			<input type="hidden" value="${ startPrice }">
			<input type="hidden" value="${ user.myCash }">
			<input type="hidden" value="${ entryBidPrice }">
			<input type="text" name="bid_price">
			<input type="button" value="입찰하기" name="bid_price_btn" onclick="bid(this.form);">
		</div>
	</form>

</body>
</html>