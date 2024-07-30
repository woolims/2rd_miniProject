<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>2차 미니 프로젝트 경매화면</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style type="text/css">
.title_auction {
	margin-top: 50px;
	margin-bottom: 50px;
}

.cate {
	width: 100%;
	background: gray;
}

.cate_si {
	width: 25%;
	height: 40px;
	vertical-align: middle;
}

.cate_si>a {
	color: white;
}

.auction_div {
	width: 100%;
	margin: auto;
	margin-top: 30px;
	/* background: green; */
}

.product_auc {
	display: inline-block;
	width: 200px !important;
	height: 300px;
	border: 1px solid red;
	text-align: center;
	margin: auto;
	margin-top: 10px;
	margin-bottom: 10px;
	background: yellow;
}

.p_info{
	 margin-left: 100px;
	 margin-bottom: 50px;
}

.n {
	margin-top: 20px;
	margin-bottom: 20px;
	margin-left: 20px;
}

#autoButton{
	width: 300px;
	height: 50px;
	margin-top: 20px;
}
</style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    
    	<c:set var="autoState" value="false"/>
        var autoState = ${autoState};

        function turnAuto() {
            autoState = !autoState;
            var button = document.getElementById('autoButton');
            
            // Update button text and class based on autoState
            if (autoState) {
                button.value = '자동연장 ON';
                button.className = 'btn btn-primary';
            } else {
                button.value = '자동연장 OFF';
                button.className = 'btn btn-danger';
            }

            // Optional: Send an AJAX request to update the state on the server
            $.ajax({
                url: 'a_board_insert_form.do', // Adjust URL as needed
                type: 'POST',
                data: { autoState: autoState },
                success: function(response) {
                    console.log('Server updated successfully.');
                },
                error:	function(err){
                	console.log('Sorry. This Error.');
                }
            });
        }
        
        function send(f){
        	
        	let pName = f.pName.value.trim();
        	let pDesc = f.pDesc.value.trim();
        	let startPrice = f.startPrice.value.trim();
        	
        	if(pName==''){
     		   alert("상품명을 입력하세요");
    		   f.pName.value="";
    		   f.pName.focus();
    		   return;
        	}
        	if(pDesc==''){
      		   alert("상품 설명을 입력하세요");
     		   f.pDesc.value="";
     		   f.pDesc.focus();
     		   return;
         	}
        	if(startPrice==''){
      		   alert("시작가를 입력하세요");
     		   f.startPrice.value="";
     		   f.startPrice.focus();
     		   return;
         	}
        	if(autoState){
        		f.autoExtension.value = "Y";
        	}
        	
        	
			f.action="a_board_insert.do";
			f.submit();
        }
    </script>
</head>
<body>
	<%@ include file="../menubar/menubar.jsp"%>

	<div class="container-fluid text-center">
		<div class="content">
			<div class="col-sm-2 sidenav"></div>
			<div class="col-sm-8 text-left">
				<div class="col-sm-12 text-right" style="height: 50px; margin-top: 25px;">
					<input type="button" value="목록으로 돌아가기" onclick="location.href='auction.do?categoryNo=${vo.categoryNo}'">
				</div>

				<div class="col-sm-1"><p style="text-align: center;"><<</p></div>
				<div class="col-sm-10" style="border:1px solid red; text-align: center; height: 300px;">
					<div class="pro_image" style="height: 100%; margin-top: 30px;">
						<img alt="상품 사진" src="">
					</div>
				</div>
				<div class="col-sm-1"><p style="text-align: center;">>></p></div>
				
				
				<form >
					<input type="hidden" id="autoExtension" name="autoExtension" value="N">
					<div class="col-sm-6" style="font-weight:bold; height: 100%; margin-top: 20px;">
						<table class="p_info">
							
							<tr>
								<td>상품 사진</td>
								<td><!-- <input type="file" class="n" id="pImage" name="pImage"> --></td>
							</tr>
							<tr>
								<td>상품명</td>
								<td><input type="text" class="n" id="pName" name="pName"></td>
							</tr>
							<tr>
								<td>카테고리</td>
								<td>
									<select class="n" style="width: 100px;" id="categoryNo" name="categoryNo">
										<option value="1">대분류1</option>
										<option value="2">대분류2</option>
										<option value="3">대분류3</option>
										<option value="4">대분류4</option>
									</select>
									<select style="width: 100px;" id="d_categoryNo" name="d_categoryNo">
										<option value="1">소분류1</option>
										<option value="2">소분류2</option>
										<option value="3">소분류3</option>
										<option value="4">소분류4</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>상품 설명</td>
								<td><input type="text" class="n" id="pDesc" name="pDesc" value="간단한 상품 설명"></td>
							</tr>
							<tr>
								<td>사용 정도</td>
								<td>
									<select class="n" style="width: 100px;" id="useAt" name="useAt">
										<option value="5">5점</option>
										<option value="4">4점</option>
										<option value="3">3점</option>
										<option value="2">2점</option>
										<option value="1">1점</option>
									</select>
									(5점 만점)
								</td>
							</tr>
							<tr>
								<td>입찰 시작가</td>
								<td><input type="text" class="n" id="startPrice" name="startPrice"></td>
							</tr>
							<tr>
								<td>종료 일자</td>
								<td>
									<select class="n" style="width: 100px;" id="remaningTime" name="remaningTime">
										<option value="0.5">12시간</option>
										<option value="1">하루</option>
										<option value="2">이틀</option>
										<option value="7">일주일</option>
									</select>
								</td>
							</tr>
						</table>
					</div>
					<div class="col-sm-6" style="font-weight:bold; height: 100%; margin-top: 20px;">
						<table class="p_info">
							
							<!-- 자동연장 여부, 조기종료 여부, 글등록버튼 -->
							<tr>
								<td>
									<input id="autoButton" class="btn btn-danger" type="button" value="자동연장 OFF" onclick="turnAuto();">
								</td>
							</tr>
							<tr>
								<td>
									<input id="autoButton" class="btn btn-info" type="button" value="경매등록" onclick="send(this.form);">
								</td>
							</tr>
							
						</table>
					</div>
				</form>
			</div>
			<div class="col-sm-2 sidenav">side</div>
		</div>
	</div>

	<%@ include file="../menubar/footer.jsp"%>

	<script>
		$(function() {
			$('#auction').attr('class', 'active');
		});
	</script>
</body>
</html>