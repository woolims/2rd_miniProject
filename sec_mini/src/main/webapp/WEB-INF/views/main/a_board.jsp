<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>2차 미니 프로젝트 경매화면</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style type="text/css">
/* 기존 스타일 */
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
}
.p_info {
    margin-left: 100px;
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
	width: 150px !important;  /* 원하는 너비로 설정 */
	height: 50px;  /* 원하는 높이로 설정 */
	margin-left: 1055px !important;
}


</style>

<script type="text/javascript">

	//기존 스크립트 유지
	<c:set var="scrapState" value="${canc}"/>
	var scrapState = '${scrapState}'; // 문자열로 변환되어 전달됨

    function auc_scrap(f) {
        var button = document.getElementById('ScrapButton');
        var auctionBoardNo = f.auctionBoardNo.value;
        var userNo = f.userNo.value;
        
        if (scrapState === 'N') { // scrapState가 'N'이면
            button.value = '즐겨찾기';
        } else {
            button.value = '즐겨찾기 취소';
        }

        // AJAX 요청을 위한 scrap 변수 정의
        var scrap = scrapState === 'N' ? 'Y' : 'N'; // scrapState의 반대 값으로 설정

        $.ajax({
            url: 'a_board_insert_form.do',
            type: 'POST',
            data: { scrap: scrap },
            success: function(response) {
                console.log('Server updated successfully.');
                location.href="scrap.do?auctionBoardNo="+auctionBoardNo+"&userNo="+userNo+"&cancelAt="+scrap;
            },
            error: function(err) {
                console.log('Sorry. This Error.');
                // 오류 처리 로직 필요 시 여기에 작성
            }
        });
    }

    function delete_product(f) {
        if (confirm("정말 삭제 하시겠습니까?") == false) return;
        f.action = "aboard_delete.do";
        f.submit();
    }
    
	function bid_check() {
		
		//로그인 여부 체크
		if("${ empty user }"=="true"){
			
			if(confirm("입찰은 로그인후 가능합니다\n로그인 하시겠습니까?")==false) return;
			
			//로그인폼으로 이동
			location.href="login_form.do";
			
			return;
		}
		
		location.href='bid_start.do?bidNo=${vo.bidNo}&userNo=${user.userNo}&pNo=${vo.pNo}';
		
	}
	
	function sb_off() {
		if("${ empty user }"=="true"){
			
			if(confirm("로그인이 필요합니다.")==false) return;
			
			//로그인폼으로 이동
			location.href="login_form.do";
			
			return;
		}
		
		if(confirm('조기종료 하시겠습니까?')==true){
			alert('경매가 조기종료되었습니다');
			location.href='sb_off.do?bidNo=${vo.bidNo}&userNo=${user.userNo}&pNo=${vo.pNo}';
		}
	}	
		
</script>

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
		    	document.getElementById("remaining_time").innerHTML = "이미 종료된 경매입니다.";
		    	if("${vo.endAt}"=="N" && "${vo.userNo}"=="${user.userNo}"){
		    		
		    		location.href="sb_off.do?bidNo=${vo.bidNo}&pNo=${vo.pNo}";
		    	}
		    }
		}
		
		setInterval(updateRemainingTime, 1000); // 매초 업데이트



</script>

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
		        return;
		    } else {	
		    	
		    	if("${vo.endAt}"=="N" && "${vo.userNo}"=="${user.userNo}"){
		    		document.getElementById("remaining_time").innerHTML = "이미 종료된 경매입니다.";
		    		location.href="sb_off.do?bidNo=${vo.bidNo}&pNo=${vo.pNo}";
		    		return;
		    	}
		    }
		}
		
		setInterval(updateRemainingTime, 1000); // 매초 업데이트



</script>
</head>
<body>

    <%@ include file="../menubar/menubar.jsp"%>

    <div style="background-color: #303030; color: #f1f1f1;" class="container-fluid text-center">
        <div class="content">
            <div class="col-sm-2 sidenav" style="background-color: #303030; color: #f1f1f1;">
				<!-- 좌측 사이드바 내용 -->
                <img src="resources/images/네모.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/루피.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/보스.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/소닉.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/스벅.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/네모.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/루피.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/보스.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/소닉.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/스벅.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/네모.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/루피.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/보스.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/소닉.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/스벅.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/네모.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/루피.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/보스.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/소닉.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
                <img src="resources/images/스벅.gif" alt="사진" style="width: 100%; height: auto; border-radius: 5px;">
			</div>
            <div class="col-sm-8 text-left">
                <div class="col-sm-12 text-right" style="height: 50px; margin-top: 25px; z-index: 10; position: relative;">
                    <input style="background-color: #303030; color: #f1f1f1;" type="button" value="목록으로 돌아가기" onclick="location.href='auction.do?categoryNo=${vo.categoryNo}'">
                </div>

				<!-- 업로드 이미지 -->
				<div class="banner">
					<div id="carousel-example-generic" class="carousel " data-ride="carousel">
						<div class="carousel-inner">
							<div class="item active">
								<img src="resources/images/${ vo.pImage }">
								<div class="carousel-caption">
									<h5>경매품목</h5>
								</div>
							</div>
						</div>
					</div>
				</div>

                <div class="col-sm-1"><p style="text-align: center;"></p></div>
                <div class="col-sm-6" style="font-weight:bold; height: 100%; margin-top: 20px;">
                    <p class="p_info">상품명 : ${ vo.pName }</p>
                    <p class="p_info">카테고리 : ${ vo.categoryName }</p>
                    <p class="p_info">상품 설명 : ${ vo.pDesc }</p>
                    <p class="p_info">사용 정도 : ${ vo.useAt }점(5점 만점)</p>
                    <p class="p_info">입찰 시작가 : ${ vo.startPrice }</p>
                    <p class="p_info">현재 입찰가 : ${ vo.entryBidPrice }</p>
                    <p class="p_info" style="display: inline-block;">남은 시간 :&nbsp;</p><p id="remaining_time" style="display: inline-block;"></p>
                    <p class="p_info">조회수 : ${ vo.viewCount }</p>
                </div>
                <form>
                    <input type="hidden" id="auctionBoardNo" name="auctionBoardNo" value="${ vo.auctionBoardNo }">
                    <input type="hidden" id="pNo" name="pNo" value="${ vo.pNo }">
                    <input type="hidden" id="userNo" name="userNo" value="${ user.userNo }">
                    <div class="col-sm-6 text-right">
                        <div style="margin-right: 100px;">
<<<<<<< HEAD
                            <c:if test="${ user.userNo eq 1 }">
                                <input class="btn btn-danger button-fixed-size" type="button" value="삭제하기" onclick="delete_product(this.form)">
                            </c:if>
                        </div>
                    </div>
                    <c:if test="${ user.userNo ne vo.userNo}">
                        <input class="btn btn-primary" type="button" value="입찰하기" style="width:100%; height: 100px; margin-top: 20px;" onclick="bid_check();">
======				</c:if>
                            <c:if test="${ user.userNo == 1 }">
                                <input class="btn btn-danger button-fixed-size" type="button" value="삭제하기" style="margin-left: 1025px !important;" onclick="delete_product(this.form)">
                            </c:if>
                        </div>
                    </div>
                    <c:if test="${ user.userNo ne vo.userNo }">
                        <input class="btn btn-primary" type="button" value="입찰하기" style="width:100%; height: 100px; margin-top: 20px; margin-bottom: 20px;" onclick="bid_check();">
>>>>>>> main
                    </c:if>
                    <c:if test="${ user.userNo eq vo.userNo }">
                        <input class="btn btn-danger" type="button" value="조기종료" style="width:100%; height: 100px; margin-top: 20px; margin-bottom: 20px;" onclick="sb_off();">
                    </c:if>
                    <!-- 즐겨찾기 -->
                    <!-- <input class="btn btn-primary" id="ScrapButton" type="button" value="즐겨찾기" style="width:100%; height: 100px; margin-top: 20px; margin-bottom: 20px; background: #cfcf00 !important; color: #0000ff !important;" onclick="auc_scrap(this.form);"> -->
                </form>
            </div>
           	<div class="col-sm-2 sidenav" style="background-color: #303030; color: #f1f1f1;">
				<h3>인기 경매 품목</h3>
				<c:forEach var="item" items="${mostViewList}">
				    <div class="product_auc" style="width: 100%; margin-bottom: 20px;">
				        <div style="width: 100%; height: 150px; overflow: hidden; margin: auto; cursor: pointer;"
				             onclick="location.href='a_board.do?auctionBoardNo=${item.auctionBoardNo}'">
				            <img src="resources/images/${item.pImage}" alt="사진" style="width: 100%; height: auto;">
				        </div>
				        <p style="text-align: left; margin: 0; color: #ffcc00;">상품명: ${item.pName}</p>
				        <p style="text-align: left; margin: 0; color: #ffcc00;">조회수: ${item.viewCount}</p>
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
