
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

<script type="text/javascript">
	
	function bid_main() {
		
		
		location.href='bid_start.do?bidNo=${bidNo}&userNo=${userNo}&pNo=${pNo}'
	}
	
	

</script>

</head>
<body>

<c:if test="${not empty vo.userNo}">
	<input type="button" value="입찰페이지로 가자" onclick="bid_main();">
</c:if>




</body>
</html>