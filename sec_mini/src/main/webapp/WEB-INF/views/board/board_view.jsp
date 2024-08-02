<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>게시글 보기</title>
  <meta charset="utf-8">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
 
  <style>
    body, html {
      height: 100%;
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif !important;
    }

	.container {
	  display: flex;
	  flex-direction: column;
	  margin-top: 20px;
	  color: #f1f1f1; /* 밝은 텍스트 색상 */
	}
	
	.header {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	}
	
    .content {
      margin-bottom: 20px;
    }
    .post-container {
      background-color: #ffffff;
      padding: 20px;
      border-radius: 5px;
      color: black; /* 글씨 색상 검정 */
    }
    .post-title {
      color: white;
      font-size: 2em;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .post-details {
      font-size: 0.9em;
      color: #bbb;
    }
    .post-content {
      margin-top: 0;
      padding-top: 0;
      width: auto;
      height: 600px;
      color: black !important;
      text-align: left;
      display: flex;
      flex-direction: column;
      justify-content: flex-start; /* 수직 정렬을 위쪽으로 설정 */
      font-size: large;
    }
    .comment-section {
      margin-top: 20px;
      border-top: 1px solid #ddd;
      padding-top: 20px;
      background-color: #303030;
      padding: 20px;
      position: relative;
      color: white; /* 댓글 섹션 텍스트 색상 흰색 */
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
      background-color: #444; /* 어두운 배경 */
      color: #f1f1f1; /* 밝은 텍스트 색상 */
      border: 1px solid #555; /* 어두운 테두리 */
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
      color: black; /* 댓글 텍스트 색상 검정 */
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
  padding: 0; /* 패딩 제거 */
  list-style: none; /* 리스트 스타일 제거 */
}

.pagination li {
  display: inline;
  margin: 0 2px; /* 마진 제거 */
}

.pagination li a,
.pagination li span {
  color: #888 !important; /* 기본 텍스트 색상 회색 */
  background-color: #f1f1f1 !important; /* 배경색 밝은 회색 */
  border: 1px solid #ccc !important; /* 테두리 색상 */
  padding: 5px 10px !important;
  text-decoration: none !important;
  margin: 0 !important; /* 마진 제거 */
  border-radius: 0 !important; /* 테두리 반경 제거 */
}

.pagination .active a,
.pagination .active span {
  color: #fff !important; /* 활성화된 페이지 텍스트 색상 흰색 */
  background-color: #888 !important; /* 활성화된 페이지 배경색 회색 */
  border-color: #888 !important; /* 활성화된 페이지 테두리 색상 회색 */
  cursor: default !important;
}

.pagination .disabled a,
.pagination .disabled span {
  color: #ccc !important; /* 비활성화된 페이지 텍스트 색상 연한 회색 */
  background-color: #f1f1f1 !important; /* 비활성화된 페이지 배경색 밝은 회색 */
  border-color: #ccc !important; /* 비활성화된 페이지 테두리 색상 연한 회색 */
  cursor: not-allowed !important;
}
    .like-button {
      background-color: white;
      border: 1px solid #ddd;
      color: black;
      cursor: pointer;
    }
    .like-button.liked {
      background-color: #ff6666;
      border: 1px solid #ff6666;
      color: white;
    }
    .btn-pinned {
      background-color: #ffd700;
      border: 1px solid #ffd700;
      color: black;
    }
    
    

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header > div:first-child {
  display: flex;
  align-items: center;
}

.header .post-title {
  margin-left: 8px;
  text-align: left;
  font-size: 2em;
  font-weight: bold;
  color: white;
}

.btn-group {
  margin-left: auto;
}


#pin-button {
  background: none;
  border: none;
  color: inherit;
  padding: 0;
  font: inherit;
  cursor: pointer;
  margin-left: 5px;
}

#pin-button i {
  font-size: 2.5em;
  vertical-align: middle;
}


  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script type="text/javascript">
    var g_page = 1;

    function comment_insert() {
    	
    	
      if ("${empty sessionScope.user}" === "true") {
      /*   if (confirm("로그인 후 댓글쓰기가 가능합니다. 로그인 하시겠습니까?") == false) return;
        location.href = "${pageContext.request.contextPath}/main/login_form.do?url=" + encodeURIComponent(location.href); */
        alert("로그인 후 좋아요를 누를 수 있습니다.");
        
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

    function toggleLike(cmt_idx, btn) {
      if ("${empty sessionScope.user}" === "true") {
        alert("로그인 후 좋아요를 누를 수 있습니다.");
        return;
      }

      $.ajax({
        url: "${pageContext.request.contextPath}/comment/likes/toggle.do",
        type: "POST",
        data: { cmt_idx: cmt_idx },
        dataType: "json",
        success: function(response) {
          if (response.result === "success") {
            if (response.action === "added") {
              $(btn).addClass("liked");
            } else {
              $(btn).removeClass("liked");
            }
            updateLikeCount(cmt_idx);
          } else {
            alert(response.message || "좋아요 처리 중 오류가 발생했습니다.");
          }
        },
        error: function(xhr, status, error) {
          alert("좋아요 처리 중 오류가 발생했습니다: " + error);
        }
      });
    }

    function comment_delete(cmt_idx, btn) {
      if (confirm("정말 삭제하시겠습니까?") == false) return;

      $(btn).prop('disabled', true); // 버튼 비활성화하여 중복 클릭 방지

      $.ajax({
        url: "${pageContext.request.contextPath}/comment/delete.do",
        data: { "cmt_idx": cmt_idx },
        dataType: "json",
        success: function(res_data) {
          $(btn).prop('disabled', false); // 버튼 다시 활성화

          if (res_data.result == false) {
            alert("삭제 실패!!");
            return;
          }
          comment_list(g_page);
        },
        error: function(err) {
          $(btn).prop('disabled', false); // 버튼 다시 활성화
          alert(err.responseText);
        }
      });
    }

    function updateLikeCount(cmt_idx) {
      $.ajax({
        url: "${pageContext.request.contextPath}/comment/likes/count.do",
        data: { cmt_idx: cmt_idx },
        dataType: "json",
        success: function(response) {
          $("#like-count-" + cmt_idx).text(response.count);
        }
      });
    }

    function togglePin(boardNo, isPinned) {
      $.post("pin.do", { boardNo: boardNo, isPinned: isPinned }, function(response) {
        location.reload(); // 핀 상태가 변경된 후 페이지 새로고침
      });
    }

    $(document).ready(function() {
      comment_list(1);
    });
  </script>
</head>
<body style="background-color: #303030;">

<%@ include file="../menubar/menubar.jsp"%>

<div class="container">
  <div class="header">
  <div>
  	 <button class="btn btn-default" onclick="location.href='freetalk.do'">
      <i class="fas fa-arrow-left"></i>
    </button>
    </div>
    <h3 class="post-title">${vo.title}</h3>
    <div class="btn-group">
     <!--  <button type="button" class="btn btn-primary" onclick="location.href='freetalk.do'">목록으로</button> -->
      <c:if test="${not empty sessionScope.user && sessionScope.user.userNo == vo.userNo}">
        <div class="btn-group">
          <button type="button" class="btn btn-default" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            설정 <span class="caret"></span>
          </button>
          <ul class="dropdown-menu dropdown-menu-right">
            <li><a href="modify_form.do?boardNo=${vo.boardNo}">수정</a></li>
            <li><a href="#" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='delete.do?boardNo=${vo.boardNo}'">삭제</a></li>
          </ul>
        </div>
      </c:if>
      <c:if test="${sessionScope.user.nickName eq '관리자'}">
<button type="button" class="btn btn-info" id="pin-button" onclick="togglePin(${vo.boardNo}, ${vo.isPinned == 0 ? 1 : 0})">
  <i class="fas fa-thumbtack" style="color: ${vo.isPinned == 0 ? 'white' : 'yellow'};"></i>
</button>
      </c:if>
    </div>
  </div>

  <div class="content">
    <div class="post-container">
      <div class="post-details">
        <p><span class="comment-author" style="color: black;">${vo.nickName}</span></p>
        <p class="comment-date">${vo.createAt}</p>
        <hr>
        <div class="post-content">${vo.boardContent}</div>
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
      <button class="btn btn-secondary" onclick="comment_insert();" style="align-self: flex-end; color: black;">등록</button>
    </div>

    <!-- 댓글 목록 -->
    <div id="comment_display"></div>
  </div>
</div>

<%@ include file="../menubar/footer.jsp"%>

</body>
</html>