<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>2차 미니 프로젝트 경매화면</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
/* 기존 스타일은 그대로 유지 */
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
.banner {
    position: relative; /* 배너의 위치를 상대적으로 설정 */
    width: 100%;
    margin-bottom: 0; /* 마진 제거 */
}
.carousel-inner .item img {
    width: 100%; /* 이미지의 너비를 컨테이너에 맞게 설정 */
    height: auto; /* 높이는 자동으로 조정 */
    max-height: 600px; /* 최대 높이 제한 */
    object-fit: contain; /* 이미지를 비율에 맞게 조정 */
}
.carousel-caption {
    position: absolute; /* 절대 위치 설정 */
    bottom: 0 !important; /* 배너 하단에 붙이기 */
    background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
    color: #fff; /* 텍스트 색상 */
    padding: 20px; /* 패딩 추가 */
    border-radius: 5px; /* 모서리 둥글게 */
    text-align: center; /* 텍스트 중앙 정렬 */
}
.carousel-indicators {
	margin-bottom: 0px !important;
}
.button-fixed-size {
	width: 200px !important;  /* 원하는 너비로 설정 */
	height: 50px;  /* 원하는 높이로 설정 */
	margin-left: 290px !important;
		
}

.bm {
	margin-top: 330px !important;
}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    // 기존 스크립트 유지
    <c:set var="autoState" value="false"/>
    var autoState = ${autoState};
    function turnAuto() {
        autoState = !autoState;
        var button = document.getElementById('autoButton');
        if (autoState) {
            button.value = '자동연장 ON';
            button.className = 'btn btn-primary button-fixed-size bm';
        } else {
            button.value = '자동연장 OFF';
            button.className = 'btn btn-danger button-fixed-size bm';
        }
        $.ajax({
            url: 'a_board_insert_form.do',
            type: 'POST',
            data: { autoState: autoState },
            success: function(response) {
                console.log('Server updated successfully.');
            },
            error: function(err){
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
        
        function select_d_category(){
        	 const categoryNo = $("#categoryNo").val();
        	 
        	 $.ajax({
        		 url		: "d_category_list.do",
        		 data		: {"categoryNo": categoryNo},
        		 dataType	: "json",
        		 success	: function(res_data){
        			 // res_data = [{"d_categoryNo":1,"d_categoryName":"중고차"},{"d_categoryNo":2,"d_categoryName":"신차"},{"d_categoryNo":3,"d_categoryName":"전기차"},{"d_categoryNo":4,"d_categoryName":"오토바이"},{"d_categoryNo":5,"d_categoryName":"자동차 용품"}]
        			 
        			 //이전 옵션 제거
        			 $("#d_categoryNo option").remove();
        			 for(let dCategory of res_data){
        				 
        				 //console.log(dCategory.d_categoryName);
        				 $("#d_categoryNo").append(`<option value='\${dCategory.d_categoryNo}'>\${dCategory.d_categoryName}</option>`);
        				 
        			 }
        			 
        		 },
        		 error		: function(err){
        			 alert(err.responseText);
        		 }
        	 });
        	 
        	 
        	 
        	 
        }
    </script>
</head>
<body>
    <%@ include file="../menubar/menubar.jsp"%>
    <div style="background-color: #303030; color: #F1F1F1;" class="container-fluid text-center">
        <div class="content">
            <div style="background-color: #303030; color: #F1F1F1;" class="col-sm-2 sidenav"></div>
            <div class="col-sm-8 text-left">
                <!-- 목록으로 돌아가기 버튼 위치 변경 -->
                <div class="col-sm-12 text-right" style="height: 50px; margin-top: 25px; z-index: 10; position: relative;">
                    <input style="background-color: #303030; color: #F1F1F1;" type="button" value="목록으로 돌아가기" onclick="location.href='auction.do?categoryNo=${vo.categoryNo}'">
                </div>
                <!-- 업로드 이미지 -->
				<div class="banner">
					<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
							<li data-target="#carousel-example-generic" data-slide-to="1"></li>
							<li data-target="#carousel-example-generic" data-slide-to="2"></li>
						</ol>
						<div class="carousel-inner">
							<div class="item active">
								<img src="resources/images/따봉도치.jpg" alt="First slide">
								<div class="carousel-caption">
									<h5>상품 사진</h5>
								</div>
							</div>
							<div class="item">
								<img src="resources/images/따봉도치.jpg" alt="Second slide">
								<div class="carousel-caption">
									<h5>상품 사진</h5>
								</div>
							</div>
							<div class="item">
								<img src="resources/images/따봉도치.jpg" alt="Third slide">
								<div class="carousel-caption">
									<h5>상품 사진</h5>
								</div>
							</div>
						</div>
						<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
							<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a>
						<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
							<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>
				</div>
                <form class="">
                    <input type="hidden" id="autoExtension" name="autoExtension" value="N">
                    <div class="col-sm-6" style="font-weight:bold; height: 100%; margin-top: 20px;">
                        <table class="p_info">
                            <!-- 기존 상품 정보 입력 폼 유지 -->
                            <tr>
                                <td>상품 사진</td>
                                <td><input type="file" class="n" id="pImage" name="pImage"></td>
                            </tr>
                            <tr>
                                <td>상품명</td>
                                <td><input style="color: black;" type="text" class="n" id="pName" name="pName"></td>
                            </tr>
                            <tr>
                                <td>카테고리</td>
                                <td>
                                    <select class="n" style="color: black;" id="categoryNo" name="categoryNo" onchange="select_d_category();">
                                        <option value="0">:::: 대분류항목을 선택하세요 ::::</option>
                                    	<c:forEach var="category" items="${ category_list }">
                                    		<option value="${ category.categoryNo }">${ category.categoryName }</option>
                                    	</c:forEach>
                                    </select>
                                    <select style="color: black; width: 100px;" id="d_categoryNo" name="d_categoryNo">
                                    	
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>상품 설명</td>
                                <td><input style="color: black;" type="text" class="n" id="pDesc" name="pDesc" value="간단한 상품 설명"></td>
                            </tr>
                            <tr>
                                <td>사용 정도</td>
                                <td>
                                    <select class="n" style="width: 100px; color: black;" id="useAt" name="useAt">
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
                                <td><input style="color: black;" type="text" class="n" id="startPrice" name="startPrice"></td>
                            </tr>
                            <tr>
                                <td>종료 일자</td>
                                <td>
                                    <select class="n" style="width: 100px; color: black;" id="endDate" name="remaningTime">
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
							<tr>
						        <td>
						            <input class="btn btn-danger button-fixed-size bm" id="autoButton"type="button" value="자동연장 OFF" onclick="turnAuto();">
						        </td>
						    </tr>
						    <tr>
						        <td>
						            <input class="btn btn-info button-fixed-size" type="button" value="경매등록" onclick="send(this.form);">
						        </td>
						    </tr>
						</table>
                    </div>
                </form>
            </div>
            <div class="col-sm-2 sidenav" style="background-color: #303030; color: #F1F1F1;">
                <h3>인기 경매 품목</h3>
                <img src="resources/images/따봉도치.jpg" alt="사진" style="width: 300px; height: 300px;">
                <c:forEach var="item" items="${ mostViewedList }">
                    <div class="product_auc" style="width: 100%; margin-bottom: 20px;">
                        <div style="width: 100%; height: 150px; overflow: hidden; margin: auto; cursor: pointer;"
                             onclick="location.href='a_board.do?auctionBoardNo=${item.auctionBoardNo}'">
                            <img src="${item.imagePath}" alt="사진" style="width: 100%; height: auto;">
                        </div>
                        <p style="text-align: left; margin: 0; color: #FFCC00;">상품명: ${item.pName}</p>
                        <p style="text-align: left; margin: 0; color: #FFCC00;">조회수: ${item.viewCount}</p>
                    </div>
                </c:forEach>
            </div>
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