<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        @media (max-width: 768px) {
            .login-container {
                margin-top: 50px;
            }
        }
        .comment-section {
            background-color: #fff;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .comment-section-header {
            margin-bottom: 15px;
        }
        .comment-form {
            margin-bottom: 20px;
        }
    </style>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javascript">
        function del(qnaNo) {
            if (confirm('정말 삭제 하시겠습니까?') == false) return;
            location.href = "qna_delete.do?qnaNo=" + encodeURIComponent(qnaNo);
        }

        var g_page = 1;

        function comment_insert() {
            if ("${empty sessionScope.user}" == "true") {
                if (confirm("로그인 후 댓글쓰기가 가능합니다. 로그인 하시겠습니까?") == false) return;
                location.href = "${pageContext.request.contextPath}/main/login_form.do?url=" + encodeURIComponent(location.href);
                return;
            }

            let commentContent = $("#commentContent").val().trim();
            if (commentContent == '') {
                alert("댓글 내용을 입력하세요!!");
                $("#commentContent").val("");
                $("#commentContent").focus();
                return;
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/qna_comment/insert.do",
                data: {
                    commentContent: commentContent,
                    qnaNo: "${vo.qnaNo}",
                    userNo: "${sessionScope.user.userNo}",
                    userName: "${sessionScope.user.userName}"
                },
                dataType: "json",
                success: function(res_data) {
                    $("#commentContent").val("");
                    if (res_data.result == false) {
                        alert("댓글 등록 실패!!");
                        return;
                    }
                    comment_list(g_page); // 댓글 등록 후 목록 새로고침
                },
                error: function(err) {
                    alert(err.responseText);
                }
            });
        }

        function comment_list(page) {
            g_page = page;

            $.ajax({
                url: "${pageContext.request.contextPath}/qna_comment/list.do",
                data: { "qnaNo": "${vo.qnaNo}", "page": page },
                success: function(res_data) {
                    console.log('서버 응답 데이터:', res_data); // 서버 응답 확인
                    $("#comment_display").html(res_data); // HTML로 댓글 목록 설정
                    // 페이지네이션을 클릭할 때만 스크롤 이동
                    if (page != 1) {
                        $('html, body').scrollTop($('.comment-section').offset().top);
                    }
                },
                error: function(err) {
                    alert("댓글 목록 로드 실패: " + err.responseText);
                }
            });
        }

        function comment_delete(qnaCommentNo, btn) {
            if (confirm("정말 삭제하시겠습니까?") == false) return;

            $(btn).prop('disabled', true); // 버튼 비활성화하여 중복 클릭 방지

            $.ajax({
                url: "${pageContext.request.contextPath}/qna_comment/delete.do",
                data: { "qnaCommentNo": qnaCommentNo },
                dataType: "json",
                success: function(res_data) {
                    $(btn).prop('disabled', false); // 버튼 다시 활성화

                    if (res_data.result == false) {
                        alert("삭제 실패!!");
                        return;
                    }
                    comment_list(g_page); // 댓글 삭제 후 목록 새로고침
                },
                error: function(err) {
                    $(btn).prop('disabled', false); // 버튼 다시 활성화
                    alert(err.responseText);
                }
            });
        }

        $(document).ready(function() {
            comment_list(1); // 페이지 로드 시 첫 페이지 댓글 목록을 로드
        });
    </script>
</head>
<body>

    <%@ include file="../menubar/menubar.jsp" %>

    <div class="container">
        <div class="row">
            <div class="col-md-12 col-md-offset-0" style="margin-bottom: 50px;">
                <div class="panel-heading" style="margin-bottom: 20px; margin-top: 50px;">
                    <h3 class="panel-title" style="font-size: 30px;">제목 : ${ vo.qnaTitle }</h3>
                    <div style="display: inline-block; float: right;">
                        <c:if test="${ (user.userId eq 'admin') or (user.userNo eq vo.userNo) }">
                            <input class="btn btn-success" type="button" value="수정" onclick="location.href='qna_modify_form.do?qnaNo=${ vo.qnaNo }'">
                            <input class="btn btn-danger" type="button" value="삭제" onclick="del(${ vo.qnaNo });">
                        </c:if>
                    </div>
                </div>
                <br>
                <div class="panel panel-default">
                    <div class="panel-body" style="min-height: 500px;">
                        <p><strong>작성자:</strong> ${ vo.userName }</p>
                        <p><strong>작성일:</strong> ${ vo.qnaCreateAt }</p>
                        <hr>
                        <p>${ vo.qnaContent }</p>
                    </div>
                </div>
                <button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/qna/qna.do'">목록으로 돌아가기</button>
            </div>
        </div>
        <!-- 댓글 섹션 -->
        <div class="comment-section">
            <div class="comment-section-header">
                <h5 style="font-weight: bold; margin-bottom: 10px;">댓글</h5>
                <ul class="pagination">
                    <c:forEach begin="1" end="${pageTotal}" var="pageNum">
                        <li><a href="#" onclick="comment_list(${pageNum}); return false;">${pageNum}</a></li>
                    </c:forEach>
                </ul>
            </div>

            <!-- 댓글 작성 폼 -->
            <div class="comment-form">
                <textarea class="form-control" id="commentContent" placeholder="댓글을 작성하세요"></textarea>
                <button class="btn btn-primary" onclick="comment_insert();" style="align-self: flex-end;">등록</button>
            </div>

            <!-- 댓글 목록 -->
            <div id="comment_display"></div>
        </div>
    </div>

    <%@ include file="../menubar/footer.jsp" %>
    <script>
        $(function() {
            $('#QnA').attr('class', 'active');
        });
    </script>
</body>
</html>