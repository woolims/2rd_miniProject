<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 커스텀 CSS -->
<style>

.modal-title{
	color: black !important;
}

.modal-body{
	color: black !important;
}

#mypageModal {
    position: fixed;
    left: 71%; 
    top: 52%; 
    transform: translate(-50%, -50%);
}

</style>

</head>
<body>
		<!-- Modal -->
  <div class="modal fade mypage" id="mypageModal" role="dialog" style="width: 100%; height: 100%;">
    <div class="modal-dialog modal-sm">
	  
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title" id="pop_mem_name">마이 페이지</h4>
	      </div>

		<!-- 본문 -->
		<div class="modal-body">

			<form class="mypage-form">
				<input type="hidden" name="userNo" value="${ user.userNo }" />

				<div class="form-group">
					<label>닉네임</label>
					<input type="text" class="form-control" id="nickName" name="nickName" value="${ user.nickName }" readonly="readonly">
				</div>

				<div class="form-group">
					<label>아이디</label> <input type="text" class="form-control"
						name="userId" id="userId" value="${ user.userId }"
						readonly="readonly">
				</div>

				<div class="form-group">
					<label>포인트</label> <input type="text" class="form-control"
						id="myCash" name="myCash" value="${ user.myCash }"
						readonly="readonly">
				</div>

				<div style="text-align: center; margin-top: 20px;">
					<input class="btn btn-success" type="button" value="홈으로"
						onclick="location.href='home.do'"> <input
						class="btn btn-primary" type="button" value="마이페이지"
						onclick="location.href='mypage.do'">
				</div>
			</form>

		</div>

	    </div>
	    
	  </div>
	</div>
</body>
</html>

