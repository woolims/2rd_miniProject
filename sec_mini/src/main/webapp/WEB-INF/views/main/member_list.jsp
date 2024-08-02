<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">

	#box {
		width: 1200px;
		margin: auto;
		margin-top: 50px;
	}
	
	#title {
		text-align: center;
		font-weight: bold;
		font-size: 32px;
		color: skyblue;
		text-shadow: 1px 1px 1px black;
	}
	
	#empty_msg {
		text-align: center;
		color: red;
		margin-top: 150px;
		font-size: 26px;
	}
	
	td {
		vertical-align: middle !important;
	}
	
	th {
		text-align: center;
	}

</style>

<script type="text/javascript">

	function del(userNo) {
		
		// console.log(userNo, "삭제");
		if(confirm("정말 삭제하시겠습니까?") == false) {
			
			return;
		}
		// 삭제요청
		location.href = "delete.do?userNo=" + userNo; 
	}

</script>

<script type="text/javascript">
	
	// 초기화1
	// $(document).ready(function(){});
	
	// 초기화2
	$(function(){
		
		setTimeout(showMessage,100);
	});
	
	function showMessage(){
		
		// /member/list.do?reason=not_admin_delete
		if("${ param.reason eq 'not_admin_delete' }" == "true"){
			
			alert("관리자는 삭제할 수 없습니다.");
		}
	}

</script>

</head>
<body>
	<div id="box">
		<h1 id="title">회원 목록</h1>
		
		<span style="text-align: left; margin-bottom: 10px;">

			<input class="btn btn-info" type="button" value="홈으로" 
			onclick="location.href='home.do'">
			
		</span>
		
		
		<div style="float: inline-end; margin-bottom: 10px;">

			<b>${ sessionScope.user.userName }</b>님 환영합니다
			<input class="btn btn-primary" type="button" value="로그아웃" 
			onclick="location.href='logout.do'">
			
		</div>
		
			<table class="table" style="text-align: center;">
		
				<!-- 테이블 타이틀 -->
				<tr class="info">
						<th>회원번호</th>
						<th>회원명</th>
						<th>아이디</th>
						<th>비밀번호</th>
						<th>주소</th>
						<th>전화번호</th>
						<th>포인트</th>
						<th>편집</th>
				</tr>
				
				<!-- Data출력 -->
				<c:forEach var="vo" items="${ list }">
					<tr>
						<td>${ vo.userNo }</td>
						<td>${ vo.userName }</td>
						<td>${ vo.userId }</td>
						<td>${ vo.userPwd }</td>
						<td>${ vo.userAddr }</td>
						<td>${ vo.phone }</td>
						<td>${ vo.myCash }</td>
						<td>
							<!-- 				관리자				 또는			로그인한 유저		 -->
 							<%-- <c:if test="${ vo.userId eq 'admin' or ( user.userNo eq vo.userNo ) }"> --%>
								<input class="btn btn-primary" type="button" value="수정"
								onclick="location.href='modify_form.do?userNo=${ vo.userNo }'">
								<input class="btn btn-danger" type="button" value="삭제" 
								onclick="del('${ vo.userNo }');">
							<%-- </c:if> --%>
						</td>
					</tr>
				</c:forEach>
				
			</table>
			
			<!-- Data가 없는경우 -->
			<c:if test="${ empty requestScope.list }">
				<div id="empty_msg">등록된 회원정보가 없습니다</div>
			</c:if>
			
		</div>
</body>
</html>