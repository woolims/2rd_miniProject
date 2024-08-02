<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

<script type="text/javascript">
 	

		
		function updateRemainingTime() {
			console.log("123");
			//종료일자
			
		    var eventTimestamp = new Date("${vo.endDate}"); // 서버에서 제공한 타임스탬프
		    var now = new Date();
								//종료일자		//현재시간
		    var remainingTime = eventTimestamp - now;
				//남은 시간이 0보다 클때
		    if (remainingTime > 0) {
		        var hours = Math.floor((remainingTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
		        var minutes = Math.floor((remainingTime % (1000 * 60 * 60)) / (1000 * 60));
		        var seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);
		
		        document.getElementById("remaining_time").innerHTML = hours + "시간 " + minutes + "분 " + seconds + "초";
		    } else {	
		    	
		    	if(endAt=="${vo.endAt}"){
		    		document.getElementById("remaining_time").innerHTML = "이미 종료된 경매입니다.";
		    		location.href="sb_off.do?bidNo=${vo.bidNo}&pNo=${vo.pNo}";
		    	}
		    	//endAt이 N일 때 한
		        //종료가 됐을때 if 작성자 관리자 낙찰된 사람 3명제외하면 볼사람없으니까 저 3명만 구별하면된다
		        //endAt이 N일 때 낙찰된 사람 1명만 => 낙찰 처리가 딱 한번만 생
		        
		    }
		}
		
		setInterval(updateRemainingTime, 1000); // 매초 업데이트
		



</script>

</head>
<body>
<span id ="remaining_time">남은 시간 : </span>


</body>
</html>