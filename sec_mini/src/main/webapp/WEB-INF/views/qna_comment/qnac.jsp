<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>답글 목록</title>
<meta charset="utf-8">
<style>
.qna_comment {
	margin-bottom: 10px;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background-color: #ffffff;
}

.comment-reply {
	margin-left: 40px;
}

.userName {
	font-weight: bold;
}

.createAt {
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

</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	var g_page = 1;

	function comment_delete(qnaCommentNo, btn) {
		if (confirm("정말 삭제하시겠습니까?") == false)
			return;

		$(btn).prop('disabled', true); // 버튼 비활성화하여 중복 클릭 방지

		console.log("Deleting comment with ID:", qnaCommentNo); // 디버그 로그 추가

		$.ajax({
			url : "${pageContext.request.contextPath}/qna_comment/delete.do",
			data : {
				"qnaCommentNo" : qnaCommentNo
			},
			dataType : "json",
			success : function(res_data) {
				$(btn).prop('disabled', false); // 버튼 다시 활성화
				console.log("Delete response:", res_data); // 디버그 로그 추가

				if (res_data.result == false) {
					alert("삭제 실패!!");
					return;
				}
				comment_list(g_page);
			},
			error : function(err) {
				$(btn).prop('disabled', false); // 버튼 다시 활성화
				console.error("Delete error:", err.responseText); // 디버그 로그 추가
				alert(err.responseText);
			}
		});
	}

	function comment_edit(qnaCommentNo) {
		$("#commentContent-" + qnaCommentNo).hide();
		$("#edit-comment-" + qnaCommentNo).show();
		$("#comment-actions-" + qnaCommentNo).hide();
		$("#edit-buttons-" + qnaCommentNo).show();
	}

	function comment_cancel(qnaCommentNo) {
		$("#edit-comment-" + qnaCommentNo).hide();
		$("#commentContent-" + qnaCommentNo).show();
		$("#edit-buttons-" + qnaCommentNo).hide();
		$("#comment-actions-" + qnaCommentNo).show();
	}

	function comment_save(qnaCommentNo) {
		var commentContent = $("#edit-comment-" + qnaCommentNo).val().trim();
		if (commentContent == "") {
			alert("내용을 입력하세요!!");
			$("#edit-comment-" + qnaCommentNo).focus();
			return;
		}

		$.ajax({
			url : "${pageContext.request.contextPath}/qna_comment/update.do",
			method : "POST",
			data : {
				qnaCommentNo : qnaCommentNo,
				commentContent : commentContent
			},
			dataType : "json",
			success : function(res_data) {
				if (res_data.result == false) {
					alert("댓글 수정에 실패했습니다.");
					return;
				}
				comment_list(g_page);
			},
			error : function() {
				alert("댓글 수정 중 오류가 발생했습니다.");
			}
		});
	}
</script>
</head>
<body>
	<c:forEach var="vo" items="${list}">
		<div class="qna_comment">
			<div class="userName">${vo.userName}</div>
			<div class="createAt">${vo.createAt}</div>
			<div class="commentContent" id="commentContent-${vo.qnaCommentNo}">${vo.commentContent}</div>
			<textarea class="form-control edit-area"
				id="edit-comment-${vo.qnaCommentNo}">${vo.commentContent}</textarea>
			<c:if
				test="${sessionScope.user.userNo eq vo.userNo || sessionScope.user.userName eq '관리자'}">
				<div class="comment-actions" id="comment-actions-${vo.qnaCommentNo}">
					<c:if test="${sessionScope.user.userNo eq vo.userNo}">
						<button type="button" class="btn btn-sm btn-primary"
							onclick="comment_edit('${vo.qnaCommentNo}')">수정</button>
					</c:if>
					<c:if
						test="${sessionScope.user.userNo eq vo.userNo || sessionScope.user.userName eq '관리자'}">
						<button type="button" class="btn btn-sm btn-danger"
							onclick="comment_delete('${vo.qnaCommentNo}', this)">삭제</button>
					</c:if>
				</div>
				<c:if test="${sessionScope.user.userNo eq vo.userNo}">
					<div class="edit-buttons" id="edit-buttons-${vo.qnaCommentNo}"
						style="display: none;">
						<button type="button" class="btn btn-sm btn-success"
							onclick="comment_save('${vo.qnaCommentNo}')">저장</button>
						<button type="button" class="btn btn-sm btn-secondary"
							onclick="comment_cancel('${vo.qnaCommentNo}')">취소</button>
					</div>
				</c:if>
			</c:if>
		</div>
	</c:forEach>
	<c:if test="${not empty list}">
		<div style="font-size: 10px;">${pageMenu}</div>
	</c:if>
</body>
</html>
