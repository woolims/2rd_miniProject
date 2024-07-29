package vo;

import java.sql.Timestamp;

public class AboardVo {

	int auctionBoardNo;
	int pNo;
	int userNo;
	Timestamp createAt;
	String deleteAt;
	String endAt;
	int viewCount;
	
	int bidNo;
	int entryBidPrice;
	Timestamp remaningTime;
	Timestamp registrationTime;
	String autoExtension;
	String earlyTermination;
	int minBidUnit;
	Timestamp endDate;
	

	String pName;
	int categoryNo;
	int d_categoryNo;
	String pImage;
	String pDesc;
	int useAt;
	int startPrice;
	int pPieces;
	
	String categoryName;
	String d_categoryName;
	
	
	public int getAuctionBoardNo() {
		return auctionBoardNo;
	}
	public void setAuctionBoardNo(int auctionBoardNo) {
		this.auctionBoardNo = auctionBoardNo;
	}
	public int getBidNo() {
		return bidNo;
	}
	public void setBidNo(int bidNo) {
		this.bidNo = bidNo;
	}
	public Timestamp getCreateAt() {
		return createAt;
	}
	public void setCreateAt(Timestamp createAt) {
		this.createAt = createAt;
	}
	public String getDeleteAt() {
		return deleteAt;
	}
	public void setDeleteAt(String deleteAt) {
		this.deleteAt = deleteAt;
	}
	public String getEndAt() {
		return endAt;
	}
	public void setEndAt(String endAt) {
		this.endAt = endAt;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public int getEntryBidPrice() {
		return entryBidPrice;
	}
	public void setEntryBidPrice(int entryBidPrice) {
		this.entryBidPrice = entryBidPrice;
	}
	public Timestamp getRemaningTime() {
		return remaningTime;
	}
	public void setRemaningTime(Timestamp remaningTime) {
		this.remaningTime = remaningTime;
	}
	public Timestamp getRegistrationTime() {
		return registrationTime;
	}
	public void setRegistrationTime(Timestamp registrationTime) {
		this.registrationTime = registrationTime;
	}
	public String getAutoExtension() {
		return autoExtension;
	}
	public void setAutoExtension(String autoExtension) {
		this.autoExtension = autoExtension;
	}
	public String getEarlyTermination() {
		return earlyTermination;
	}
	public void setEarlyTermination(String earlyTermination) {
		this.earlyTermination = earlyTermination;
	}
	public int getMinBidUnit() {
		return minBidUnit;
	}
	public void setMinBidUnit(int minBidUnit) {
		this.minBidUnit = minBidUnit;
	}
	public Timestamp getEndDate() {
		return endDate;
	}
	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}
	public int getpNo() {
		return pNo;
	}
	public void setpNo(int pNo) {
		this.pNo = pNo;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public int getD_categoryNo() {
		return d_categoryNo;
	}
	public void setD_categoryNo(int d_categoryNo) {
		this.d_categoryNo = d_categoryNo;
	}
	public String getpImage() {
		return pImage;
	}
	public void setpImage(String pImage) {
		this.pImage = pImage;
	}
	public String getpDesc() {
		return pDesc;
	}
	public void setpDesc(String pDesc) {
		this.pDesc = pDesc;
	}
	public int getUseAt() {
		return useAt;
	}
	public void setUseAt(int useAt) {
		this.useAt = useAt;
	}
	public int getStartPrice() {
		return startPrice;
	}
	public void setStartPrice(int startPrice) {
		this.startPrice = startPrice;
	}
	public int getpPieces() {
		return pPieces;
	}
	public void setpPieces(int pPieces) {
		this.pPieces = pPieces;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getD_categoryName() {
		return d_categoryName;
	}
	public void setD_categoryName(String d_categoryName) {
		this.d_categoryName = d_categoryName;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	
	
}
