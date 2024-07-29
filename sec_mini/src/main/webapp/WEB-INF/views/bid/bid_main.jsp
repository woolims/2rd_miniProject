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
		
		if("${vo.startPrice}"<"${vo.entryBidPrice}"){
			if(bid_price >= "${vo.entryBidPrice}"){
				location.href="bid_success.do?pNo=${vo.pNo}";
				alert('입찰성공!')
			}else{
				alert('현재 등록된 최고입찰가보다 높게 등록해야합니다\n최고입찰가: "${vo.entryBidPrice}"')
			}
			
		}else{
			if(bid_price >= "${vo.startPrice}"){
				location.href="bid_success.do?pNo=${vo.pNo}";
				alert('입찰성공!')
			}else{
				alert('현재 등록된 최소입찰가보다 높게 등록해야합니다\n현재 최소입찰가: "${vo.startPrice}"')
			}
		}
		
		
	}

</script>
</head>
<body>
	여기는 if문을 통과한 입찰 메인페이지야
	<form>
		<div>
			<input type="text" name="bid_price">
			<input type="button" value="입찰하기" name="bid_price_btn" onclick="bid(this.form);">
		</div>
	</form>

</body>
</html>