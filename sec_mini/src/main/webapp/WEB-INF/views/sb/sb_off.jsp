<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

<script>
var endDate = ${vo.endDate} 
        function updateRemainingTime() {
        						
        	//종료일자
        	
            var eventTimestamp = new Date("${}"); // 서버에서 제공한 타임스탬프
            var now = new Date();
								//종료일자		//현재시간
            var remainingTime = eventTimestamp - now;
				//남은 시간이 0보다 클때
            if (remainingTime > 0) {
                var hours = Math.floor((remainingTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((remainingTime % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);

                document.getElementById("remaining-time").innerHTML =
                    hours + "시간 " + minutes + "분 " + seconds + "초";
            } else {	
            	//endAt이 N일 때 한
                //종료가 됐을때 if 작성자 관리자 낙찰된 사람 3명제외하면 볼사람없으니까 저 3명만 구별하면된다
                //endAt이 N일 때 낙찰된 사람 1명만 => 낙찰 처리가 딱 한번만 생
                
            }
        }
if
        setInterval(updateRemainingTime, 1000); // 매초 업데이트
    </script>

</head>
<body>
	sadfadasdsadasdasdasdasdsad
</body>
</html>