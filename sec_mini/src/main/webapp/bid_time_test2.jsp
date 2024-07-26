<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
/* span tag 사이 엔터로 인한 공백제거할 목적 */
*{font-size: 0;}

	span{
		/* 크기조정하기 위해 */
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

<script type="text/javascript">
/* 자바스크립트 함수선언 방법 */


 //1.선언적 방식
 function 함수명1(){};
 
 //2. 리터럴방식
 const 함수명2=function(){};
 
 //	  상수 = 리터럴
 const PI=3.141592;
 
 //3. Arrow Function
 const 함수명3=() => {};


	/* Browser에 모든 요소(Element)가 배치가 완료되면 호출하는 이벤트 
		바디에 작성한 모든 코드의 배치가 완료된 이후에 작동한다.
	
	*/
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
		document.getElementById("hour").innerHTML = ampm;
		
		document.getElementById("hour").innerHTML = (hour<10) ? '0'+hour : hour;
		
		document.getElementById("minute").innerHTML = (minute<10) ? '0'+minute : minute;
		
		document.getElementById("second").innerHTML = (second<10) ? '0'+second : second;
		
		
		
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
</head>
<body>
<span id="ampm">PM</span>
<span id="hour">14</span>
<span class="colon">:</span>
<span id="minute">40</span>
<span class="colon">:</span>
<span id="second">30</span>



</body>
</html>