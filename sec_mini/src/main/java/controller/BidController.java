package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.BidDao;
import vo.BidVo;

@Controller
public class BidController {
	
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	
	
	@Autowired
	BidDao bid_dao;
	
	@RequestMapping("bid_start.do")		//입찰페이지로 가는 버튼클릭시 실행
	public String bid_start(int pNo,int bidNo, int userNo) {		
		int startPrice = bid_dao.new_bid_price_select(pNo);
		int entryBidPrice = bid_dao.entry_bid_select(bidNo);
		int userCash = bid_dao.cashCheck(userNo);
		
		if(startPrice < userCash) {
			// 유저가 가진 금액이 상품등록 금액보다 많을 경우 통과
			if(entryBidPrice < userCash) {
				// 유저가 가진 금액이 현재 최고가보다 높을 경우 통과
				return "bid_main.do"; //진짜 입찰페이지로 이동
			}else {
				return "bid_charging.do";
				// 충전페이지로 연결시키는 JSP로 이동
			}
		}else {
			return "bid_charging.do";
			// 충전페이지로 연결시키는 JSP로 이동
		}
	}
	
	@RequestMapping("bid_charging.do")
	public String bid_charging() {
		
		return "bid/bid_charging";
	}
	
	@RequestMapping("bid.do")
	public String bid() {
		
		return "bid/bid_test";
	}
}
