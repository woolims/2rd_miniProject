<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>게시글 보기</title>
  <meta charset="utf-8">
  <style>
    body, html {
      height: 100%;
      margin: 0;
    }
    .container {
      display: flex;
      flex-direction: column;
      margin-top: 20px;
    }
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .content {
      margin-bottom: 20px;
    }
    .panel {
      margin-top: 20px;
    }
    .panel-body {
      min-height: 400px;
    }
    .comment-section {
      margin-top: 20px;
      border-top: 2px solid #ddd;
      padding-top: 20px;
      background-color: #eeeeee;
      padding: 20px;
      position: relative;
    }
    .comment-section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .comment-form {
      display: flex;
      flex-direction: column;
      margin-bottom: 20px;
    }
    .comment-form textarea {
      height: 100px;
      resize: none;
      margin-bottom: 10px;
    }
    .comment-form button {
      align-self: flex-end;
      padding: 5px 10px;
      font-size: 14px;
    }
    .comment {
      margin-bottom: 10px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
      background-color: #ffffff;
    }
    .comment-reply {
      margin-left: 40px;
    }
    .comment-author {
      font-weight: bold;
    }
    .comment-date {
      font-size: 0.9em;
      color: #888;
    }
    .dropdown-menu-right {
      right: 0;
      left: auto;
    }
    .pagination {
      display: flex;
      justify-content: flex-end;
      margin-top: 10px;
      position: absolute;
      right: 0;
      top: 0;
    }
    .pagination li {
      display: inline;
      margin: 0 2px;
    }
  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script type="text/javascript">
    var g_page = 1;

    function comment_insert() {
      if ("${empty sessionScope.user}" == "true") {
        if (confirm("로그인 후 댓글쓰기가 가능합니다. 로그인 하시겠습니까?") == false) return;
        location.href = "${pageContext.request.contextPath}/main/login_form.do?url=" + encodeURIComponent(location.href);
        return;
      }

      let cmt_content = $("#cmt_content").val().trim();
      if (cmt_content == '') {
        alert("댓글 내용을 입력하세요!!");
        $("#cmt_content").val("");
        $("#cmt_content").focus();
        return;
      }

      $.ajax({
        url: "${pageContext.request.contextPath}/comment/insert.do",
        data: {
          cmt_content: cmt_content,
          boardNo: "${vo.boardNo}",
          userNo: "${sessionScope.user.userNo}",
          nickName: "${sessionScope.user.nickName}"
        },
        dataType: "json",
        success: function(res_data) {
          $("#cmt_content").val("");
          if (res_data.result == false) {
            alert("댓글 등록 실패!!");
            return;
          }
          comment_list(1);
        },
        error: function(err) {
          alert(err.responseText);
        }
      });
    }

    function comment_list(page) {
      g_page = page;

      $.ajax({
        url: "${pageContext.request.contextPath}/comment/list.do",
        data: { "boardNo": "${vo.boardNo}", "page": page },
        success: function(res_data) {
          $("#comment_display").html(res_data);
          // 페이지네이션을 클릭할 때만 스크롤 이동
          if (page != 1) {
            $('html, body').scrollTop($('.comment-section').offset().top);
          }
        },
        error: function(err) {
          alert(err.responseText);
        }
      });
    }

    function likeComment(cmt_idx) {
        // 세션에서 사용자 정보가 존재하는지 확인
        const user = ${sessionScope.user != null ? 'true' : 'false'};
        
        if (!user) {
            alert("로그인 후 좋아요를 누를 수 있습니다.");
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/comment/likes/add.do",
            type: "POST",
            data: { cmt_idx: cmt_idx },
            dataType: "json", // 서버 응답을 JSON으로 자동 파싱
            success: function(response) {
                if (response.result === true) {
                    alert("좋아요가 성공적으로 반영되었습니다.");
                    comment_list(g_page);
                } else {
                    alert(response.message || "좋아요 처리 중 오류가 발생했습니다.");
                }
            },
            error: function(xhr, status, error) {
                alert("좋아요 처리 중 오류가 발생했습니다: " + error);
            }
        });
    }

    $(document).ready(function() {
      comment_list(1);
    });
  </script>
</head>
<body>

<%@ include file="../menubar/menubar.jsp"%>

<div class="container">
  <div class="header">
    <h2>게시글 상세 보기</h2>
    <div class="btn-group">
      <button type="button" class="btn btn-primary" onclick="location.href='freetalk.do'">목록으로</button>
      <c:if test="${not empty sessionScope.user && sessionScope.user.userNo == vo.userNo}">
        <div class="btn-group">
          <button type="button" class="btn btn-warning" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            설정 <span class="caret"></span>
          </button>
          <ul class="dropdown-menu dropdown-menu-right">
            <li><a href="modify_form.do?boardNo=${vo.boardNo}">수정</a></li>
            <li><a href="#" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='delete.do?boardNo=${vo.boardNo}'">삭제</a></li>
          </ul>
        </div>
      </c:if>
    </div>
  </div>

  <div class="content">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">${vo.title}</h3>
      </div>
      <div class="panel-body">
        <p><span class="comment-author">${vo.nickName}</span></p>
        <p class="comment-date">${vo.createAt}</p>
        <hr>
        <p class="board-content">${vo.boardContent}</p>
      </div>
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
      <textarea class="form-control" id="cmt_content" placeholder="댓글을 작성하세요"></textarea>
      <button class="btn btn-primary" onclick="comment_insert();" style="align-self: flex-end;">등록</button>
    </div>

    <!-- 댓글 목록 -->
    <div id="comment_display"></div>
  </div>
</div>

<%@ include file="../menubar/footer.jsp"%>

</body>
</html>

