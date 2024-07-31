package vo;

public class CommentLikesVo {
    private int c_likeNo;
    private int cmt_idx;
    private int userNo;

    // Constructors, getters, and setters
    public CommentLikesVo() {}

    public CommentLikesVo(int cmt_idx, int userNo) {
        this.cmt_idx = cmt_idx;
        this.userNo = userNo;
    }

    public int getC_likeNo() {
        return c_likeNo;
    }

    public void setC_likeNo(int c_likeNo) {
        this.c_likeNo = c_likeNo;
    }

    public int getCmt_idx() {
        return cmt_idx;
    }

    public void setCmt_idx(int cmt_idx) {
        this.cmt_idx = cmt_idx;
    }

    public int getUserNo() {
        return userNo;
    }

    public void setUserNo(int userNo) {
        this.userNo = userNo;
    }
}
