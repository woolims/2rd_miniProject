<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

<script type="text/javascript">

window.onload= function() {
	//Timer		함수			시간
	setTimeout(display_time,0);		//1회만 호출
	
	
	//타이머 해제
	//clearInterval(timer);
};

let watch_color = true;
function display_time() {
	
	// 현재 시스템 시간
	const now = new Date();
	
	let hour 	= now.getHours();
	let minute  = now.getMinutes();
	let second  = now.getSeconds();
	
	let ampm = hour<12 ? "AM":"PM";
	
	if(hour>12){
		hour-=12;
	}
	//보완: 시간이 단자리일 경우 앞에 '0' 붙여라..(if or 3항연산자)
	//		AM or PM을 붙여서 출력
						//	   여기까지가 입력
	$('#hour').html(PM);  
	/*   = ampm; */
	$('#hour').html(14);  /*  = (hour<10)   ? '0'+hour : hour; */
	
	$('#minute').html(21); /* = (minute<10) ? '0'+minute : minute; */
	
	$('#second').html(13); /* = (second<10) ? '0'+second : second; */
	
	
	
	//toggle 처리
	watch_color = !watch_color;
	
	//class="colon" 인 Elements 정보 구하기
	
	let colons = document.getElementsByClassName("colon");
	//console.log(colons.length);
	colons[0].style.color = watch_color ? "black":"white";
	colons[1].style.color = watch_color ? "black":"white";
	
	
	 setTimeout(display_time,1000);
}
	

</script>
<style type="text/css">

*{font-size: 0;}

	span{
		display: inline-block;
		width: 60px;
		height: 70px;
		background: black;
		color:white;
		
		font-size: 48px;
		font-weight: bold;
		text-align: center;
	}
	
	.colon{
		width: 30px;
	}
	
	#ampm{
		width: 80px;
	}

</style>

</head>
<body>
<span id ="ampm"></span>
<span id ="hour"></span>
<span class ="colon">:</span>
<span id ="minute"></span>
<span class ="colon">:</span>
<span id ="second"></span>

</body>
</html>