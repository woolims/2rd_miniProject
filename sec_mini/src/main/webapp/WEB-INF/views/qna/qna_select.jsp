<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String pageNum = request.getParameter("pageNum");
	String categoryNo = request.getParameter("categoryNo");
	String search = request.getParameter("search");
%>
<!DOCTYPE html>
<html>
<head>
<title>게시글 상세</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 커스텀 CSS -->
<style>
body {
    background-color: #f8f9fa;
}

.navbar {
    margin-bottom: 0;
    border-radius: 0;
}

.login-container {
    max-width: 400px;
    margin: 100px auto;
    padding: 30px;
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
}

.login-container h2 {
    text-align: center;
    margin-bottom: 30px;
    font-weight: bold;
    color: #007bff;
}

.login-form .form-control {
    border-radius: 20px;
    margin-bottom: 15px;
}

.login-form button[type="submit"] {
    padding: 12px 20px;
    font-size: 18px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 20px;
    cursor: pointer;
}

.login-form button[type="submit"]:hover {
    background-color: #0056b3;
}

.footer {
    background-color: #f2f2f2;
    padding: 25px;
    text-align: center;
}

@media ( max-width : 768px) {
    .login-container {
        margin-top: 50px;
    }
}

.bw {
	display: inline-block;
	background-color: white;
}
</style>

<script type="text/javascript">

	function del(boardNo){
		
		//console.log(mem_idx,"삭제");
		if(confirm('정말 삭제 하시겠습니까?')==false) return;
		
		//삭제 요청
		location.href="delete.do?boardNo=" + boardNo +
		"&userNo="+${ vo.userNo }+"&categoryNo="+<%=categoryNo%>+"&pageNum="+<%=pageNum%>+"&search=<%=search%>";
		
	}

</script>

</head>
<body>

    <%@ include file="/common/menubar.jsp"%>

	<input type="hidden" name="boardNo" value="${ param.boardNo }">
	<input type="hidden" name="userNo" value="${ param.userNo }">
	<input type="hidden" name="search" value="${ param.search }">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-md-offset-0">
                <h1 class="bw">게시글 상세</h1>
                <div class="panel-heading">
                	<h3 class="panel-title bw" style="font-size: 30px;">${ vo.boardTitle }</h3>
                	<div style="display:inline-block; float:right;">
						<c:if test="${ (loginUser.userId eq 'admin') or (loginUser.userNo eq vo.userNo) }">
							<input class="btn btn-success" type="button" value="수정"
									onclick="location.href='board_modify_form.do?pageNum=<%= pageNum %>&boardNo=${ vo.boardNo }'">
							<input class="btn btn-danger" type="button" value="삭제"
									onclick="del(${ vo.boardNo });">
						</c:if>
                	</div>
                </div>
                <br>
                <div class="panel panel-default">
                    
                    <div class="panel-body">
                        <p><strong>작성자:</strong> ${ vo.userName }</p>
                        <p><strong>작성일:</strong> ${ vo.createdAt.substring(0,16) }</p>
                        <p><strong>조회수:</strong> ${ vo.boardCount }</p>
                        <hr>
                        <p>${ vo.boardContent }</p>
                    </div>
                </div>
                <button type="button" class="btn btn-default" onclick="location.href='${ pageContext.request.contextPath }/board/board.do?categoryNo=${ vo.categoryNo }&pageNum=<%=pageNum%>&search=<%=search%>'">목록으로 돌아가기</button>
            </div>
        </div>
        <%@ include file="/reply/selectReplyOfBoard.jsp" %>
    </div>

    <%@ include file="/common/footerbar.jsp" %>
<script>
	$(function(){
		if(${ vo.categoryNo } == 1){
			$('#kor-food').attr('class','active');
		} else if(${ vo.categoryNo } == 2){
			$('#ch-food').attr('class','active');
		} else if(${ vo.categoryNo } == 3){
			$('#jpn-food').attr('class','active');
		}
		
	});
</script>
</body>
</html>
