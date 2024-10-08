package vo;

import java.sql.Timestamp;


public class BoardVo {
    private int boardNo;
    private String nickName;
    private int userNo;
    private String title;
    private String boardContent;
    private Timestamp createAt;
    private int b_readhit;
    private Timestamp updateAt;
    //추가
    private int isPinned;
    private int commentCount;  

    // getters and setters
    public int getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public int getUserNo() {
        return userNo;
    }

    public void setUserNo(int userNo) {
        this.userNo = userNo;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBoardContent() {
        return boardContent;
    }

    public void setBoardContent(String boardContent) {
        this.boardContent = boardContent;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public int getB_readhit() {
        return b_readhit;
    }

    public void setB_readhit(int b_readhit) {
        this.b_readhit = b_readhit;
    }

    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }

    // 새 속성에 대한 getter 및 setter 추가
    public int getIsPinned() {
        return isPinned;
    }

    public void setIsPinned(int isPinned) {
        this.isPinned = isPinned;
    }

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
    
    
    
    
    
}