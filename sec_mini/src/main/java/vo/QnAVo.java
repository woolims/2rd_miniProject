package vo;

import java.sql.Timestamp;

public class QnAVo {
	
	int qnaNo;
	int userNo;
	String qnaTitle;
	String qnaContent;
	Timestamp qnaCreateAt;
	String userName;
	
	public int getQnaNo() {
		return qnaNo;
	}
	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getQnaTitle() {
		return qnaTitle;
	}
	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}
	public String getQnaContent() {
		return qnaContent;
	}
	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}
	public Timestamp getQnaCreateAt() {
		return qnaCreateAt;
	}
	public void setQnaCreateAt(Timestamp qnaCreateAt) {
		this.qnaCreateAt = qnaCreateAt;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}
