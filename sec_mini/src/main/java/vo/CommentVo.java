package vo;

import java.sql.Timestamp;

public class CommentVo {

	int cmt_idx;
	String cmt_content;
	String cmt_ip;
	Timestamp cmt_regdate;
	Timestamp cmt_update;
	int boardNo;
	int userNo;
	String nickName;
	private int likeCount; // likeCount 필드 추가
	private int is_deleted; // is_deleted 필드 추가

	// Getters and Setters

	public int getCmt_idx() {
		return cmt_idx;
	}

	public void setCmt_idx(int cmt_idx) {
		this.cmt_idx = cmt_idx;
	}

	public String getCmt_content() {
		return cmt_content;
	}

	public void setCmt_content(String cmt_content) {
		this.cmt_content = cmt_content;
	}

	public String getCmt_ip() {
		return cmt_ip;
	}

	public void setCmt_ip(String cmt_ip) {
		this.cmt_ip = cmt_ip;
	}

	public Timestamp getCmt_regdate() {
		return cmt_regdate;
	}

	public void setCmt_regdate(Timestamp cmt_regdate) {
		this.cmt_regdate = cmt_regdate;
	}

	public Timestamp getCmt_update() {
		return cmt_update;
	}

	public void setCmt_update(Timestamp cmt_update) {
		this.cmt_update = cmt_update;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public int getIs_deleted() {
		return is_deleted;
	}

	public void setIs_deleted(int is_deleted) {
		this.is_deleted = is_deleted;
	}
}
