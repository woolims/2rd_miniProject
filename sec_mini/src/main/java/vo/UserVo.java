package vo;

public class UserVo {

	int userNo;
	String userName;
	String userId;
	String userPwd;
	String userAddr;
	String phone;
	String nickName;
	int myCash;
	String creatAt;
	int myCash;
	
	public UserVo() {
		// TODO Auto-generated constructor stub
	}
	
	public UserVo(String userName, String userId, String userPwd, String userAddr, String phone, String nickName) {
		super();
		this.userName = userName;
		this.userId = userId;
		this.userPwd = userPwd;
		this.userAddr = userAddr;
		this.phone = phone;
		this.nickName = nickName;
	}
	
	public UserVo(int userNo, String userName, String userId, String userPwd, String userAddr, String phone,
			String nickName) {
		super();
		this.userNo = userNo;
		this.userName = userName;
		this.userId = userId;
		this.userPwd = userPwd;
		this.userAddr = userAddr;
		this.phone = phone;
		this.nickName = nickName;
	}
	

	public UserVo(int userNo, String userName, String userId, String userPwd, String userAddr, String phone,
			String nickName, int myCash, String creatAt) {
		super();
		this.userNo = userNo;
		this.userName = userName;
		this.userId = userId;
		this.userPwd = userPwd;
		this.userAddr = userAddr;
		this.phone = phone;
		this.nickName = nickName;
		this.myCash = myCash;
		this.creatAt = creatAt;
	}
	
	

	public int getMyCash() {
		return myCash;
	}

	public void setMyCash(int myCash) {
		this.myCash = myCash;
	}

	public int getMyCash() {
		return myCash;
	}

	public void setMyCash(int myCash) {
		this.myCash = myCash;
	}

	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserAddr() {
		return userAddr;
	}
	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getCreatAt() {
		return creatAt;
	}
	public void setCreatAt(String creatAt) {
		this.creatAt = creatAt;
	}
	
    public boolean isAdmin() {
        return "관리자".equals(this.nickName);
    }
	
	
}
