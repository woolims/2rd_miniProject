<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>댓글 목록</title>
  <meta charset="utf-8">
  <style>
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
    .comment-actions, .edit-buttons {
      text-align: right;
    }
    .edit-area {
      display: none;
      width: 100%;
      height: 100px;
      resize: none;
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
  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script type="text/javascript">
    var g_page = 1;

    function comment_delete(cmt_idx) {
      if (confirm("정말 삭제하시겠습니까?") == false) return;

      $.ajax({
        url: "${pageContext.request.contextPath}/comment/delete.do",
        data: { "cmt_idx": cmt_idx },
        dataType: "json",
        success: function(res_data) {
          if (res_data.result == false) {
            alert("삭제 실패!!");
            return;
          }
          comment_list(g_page);
        },
        error: function(err) {
          alert(err.responseText);
        }
      });
    }

    function comment_edit(cmt_idx) {
      $("#comment-content-" + cmt_idx).hide();
      $("#edit-comment-" + cmt_idx).show();
      $("#comment-actions-" + cmt_idx).hide();
      $("#edit-buttons-" + cmt_idx).show();
    }

    function comment_cancel(cmt_idx) {
      $("#edit-comment-" + cmt_idx).hide();
      $("#comment-content-" + cmt_idx).show();
      $("#edit-buttons-" + cmt_idx).hide();
      $("#comment-actions-" + cmt_idx).show();
    }

    function comment_save(cmt_idx) {
      var content = $("#edit-comment-" + cmt_idx).val().trim();
      if (content == "") {
        alert("내용을 입력하세요!!");
        $("#edit-comment-" + cmt_idx).focus();
        return;
      }

      $.ajax({
        url: "${pageContext.request.contextPath}/comment/update.do",
        method: "POST",
        data: {
          cmt_idx: cmt_idx,
          cmt_content: content
        },
        dataType: "json",
        success: function(res_data) {
          if (res_data.result == false) {
            alert("댓글 수정에 실패했습니다.");
            return;
          }
          comment_list(g_page);
        },
        error: function() {
          alert("댓글 수정 중 오류가 발생했습니다.");
        }
      });
    }

    function toggleLike(cmt_idx, btn) {
      if ("${empty sessionScope.user}" == "true") {
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

    $(document).ready(function() {
      // 초기화 작업 수행
      $(".like-button").each(function() {
        var cmt_idx = $(this).data("cmt-idx");
        var btn = this;
        $.ajax({
          url: "${pageContext.request.contextPath}/comment/likes/isLiked.do",
          data: { cmt_idx: cmt_idx },
          dataType: "json",
          success: function(response) {
            if (response.isLiked) {
              $(btn).addClass("liked");
            }
          }
        });
        updateLikeCount(cmt_idx);
      });
    });
  </script>
</head>
<body>
  <c:if test="${not empty list}">
    <div style="font-size: 10px;">
      ${pageMenu}
    </div>
  </c:if>
  <c:forEach var="vo" items="${list}">
    <div class="comment">
      <div class="comment-author">${vo.nickName}</div>
      <div class="comment-date">${vo.cmt_regdate}</div>
      <div class="comment-content" id="comment-content-${vo.cmt_idx}">${vo.cmt_content}</div>
      <textarea class="form-control edit-area" id="edit-comment-${vo.cmt_idx}">${vo.cmt_content}</textarea>
      <c:if test="${sessionScope.user.userNo eq vo.userNo}">
        <div class="comment-actions" id="comment-actions-${vo.cmt_idx}">
          <button type="button" class="btn btn-sm btn-primary" onclick="comment_edit('${vo.cmt_idx}')">수정</button>
          <button type="button" class="btn btn-sm btn-danger" onclick="comment_delete('${vo.cmt_idx}')">삭제</button>
        </div>
        <div class="edit-buttons" id="edit-buttons-${vo.cmt_idx}" style="display: none;">
          <button type="button" class="btn btn-sm btn-success" onclick="comment_save('${vo.cmt_idx}')">저장</button>
          <button type="button" class="btn btn-sm btn-secondary" onclick="comment_cancel('${vo.cmt_idx}')">취소</button>
        </div>
      </c:if>
      <div>
        <button type="button" class="like-button" data-cmt-idx="${vo.cmt_idx}" onclick="toggleLike('${vo.cmt_idx}', this)">좋아요</button>
        <span id="like-count-${vo.cmt_idx}">${vo.likeCount}</span>
      </div>
    </div>
  </c:forEach>
</body>
</html>
