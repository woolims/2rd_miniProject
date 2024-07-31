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

	@RequestMapping("bid_start.do") // 입찰페이지로 가는 버튼클릭시 실행
	public String bid_start(BidVo vo, Model model) {

		int startPrice = bid_dao.new_bid_price_select(vo.getpNo());
		int entryBidPrice = bid_dao.entry_bid_select(vo.getBidNo());
		int myCash = bid_dao.cashCheck(vo.getUserNo());
		String pName = bid_dao.p_name_select(vo.getpNo());
		
		vo.setEntryBidPrice(entryBidPrice);
		vo.setStartPrice(startPrice);
		vo.setpName(pName);
		
		if (startPrice < myCash) {
			// 유저가 가진 금액이 상품등록 금액보다 많을 경우 통과
			if (entryBidPrice == 0) {
				
				model.addAttribute("vo",vo);
				return "bid/bid_main"; // 진짜 입찰페이지로 이동
			} else {
				if (entryBidPrice < myCash) {
					// 유저가 가진 금액이 현재 최고가보다 높을 경우 통과
					model.addAttribute("vo",vo);
					return "bid/bid_main"; // 진짜 입찰페이지로 이동
				} else {
					model.addAttribute("userNo", vo.getUserNo());
					return "main/charge_form";
					// 충전페이지로 연결시키는 JSP로 이동
				}
			}
		} else {
			model.addAttribute("userNo", vo.getUserNo());
			return "main/charge_form";
			// 충전페이지로 연결시키는 JSP로 이동
		}
	}


//	테스트용 페이지
	@RequestMapping("bid_test.do")
	public String bid_test() {

		return "bid/bid_test";
	}


//	유저가 입찰성공시 작동할 메소드
	@RequestMapping("bid_success.do")
	public String bid_success(BidVo vo, Model model) {
		
		
		BidVo userNoCheck = bid_dao.re_user_check(vo);
		
		vo.setEntryBidPrice(vo.getPlayPrice());
		vo.setNowBid(vo.getPlayPrice());
		
		bid_dao.now_bid_update(vo);
		bid_dao.entry_bid_update(vo);
		
		int nowBid = vo.getNowBid();
		String pName = bid_dao.p_name_select(vo.getpNo());
		vo.setpName(pName);
		
		if(nowBid<200000) {
			nowBid = vo.getEntryBidPrice()+5000;		//20만원 미만 금액은 최소입찰단위가 5000원
		}else if(nowBid>=200000 && nowBid < 1000000) {
			nowBid = vo.getEntryBidPrice()+15000;	//20만원 이상 100만원 미만 금액은 최소입찰단위가 15000원
		}else if(nowBid>=1000000 && nowBid < 5000000) {
			nowBid = vo.getEntryBidPrice()+30000;	//100만원 이상 500만원 미만 금액은 최소입찰단위가 30000원
		}else if(nowBid>=5000000) {
			nowBid = vo.getEntryBidPrice()+100000;	//500만원 이상 금액은 최소입찰단위가 100000만원
		}
		
		vo.setNowBid(nowBid);
		
		if (userNoCheck==null) {
			
			model.addAttribute("vo",vo);
			bid_dao.bid_success1(vo);
		} else {
			
			model.addAttribute("vo",vo);
			bid_dao.bid_success2(vo);
		}

		return "bid/bid_main";
	}

}
