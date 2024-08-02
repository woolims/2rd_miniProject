package controller;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.BidDao;
import dao.SBDao;
import vo.BidVo;
import vo.SBVo;

@Controller
public class BidController {

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	BidDao bid_dao;
	
	@Autowired
	SBDao sb_dao;
	
	
	

	@RequestMapping("bid_start.do") // 입찰페이지로 가는 버튼클릭시 실행
	public String bid_start(BidVo vo, Model model) throws Exception {
		
		System.out.println("입찰시작한다");
//		LocalDateTime now = LocalDateTime.now()
				;
		int startPrice = bid_dao.new_bid_price_select(vo.getpNo());
		int entryBidPrice = bid_dao.entry_bid_select(vo.getBidNo());
		int myCash = bid_dao.cashCheck(vo.getUserNo());
		String pName = bid_dao.p_name_select(vo.getpNo());
		int nowBid = bid_dao.now_bid_select(vo.getBidNo());
		int bid_count = bid_dao.bid_count_select();
		String endAt = bid_dao.bid_end_at(vo.getpNo());
		Timestamp endDate = bid_dao.bid_end_date(vo.getBidNo());
		
		
		
		vo.setNowBid(nowBid);
		vo.setEntryBidPrice(entryBidPrice);
		vo.setStartPrice(startPrice);
		vo.setpName(pName);
		vo.setEndDate(endDate);
		vo.setEndAt(endAt);
		

		System.out.println(vo.getEndAt());
		if (startPrice < myCash) {
			// 유저가 가진 금액이 상품등록 금액보다 많을 경우 통과
			if (entryBidPrice == 0) { //입찰자가 없다면 통과
				
				System.out.println("여긴 입찰자가 없는 스타트.do야");
				model.addAttribute(bid_count);
				model.addAttribute("vo", vo);
				
				System.out.println(bid_count);
				return "bid/bid_main"; // 진짜 입찰페이지로 이동
			} else {
				System.out.println("여긴 입찰자가 있는 스타트.do야");
				if (entryBidPrice < myCash) {
					// 유저가 가진 금액이 현재 최고가보다 높을 경우 통과
					
					model.addAttribute("vo", vo);
					model.addAttribute(bid_count);
					return "bid/bid_main"; // 진짜 입찰페이지로 이동
				} else {
					model.addAttribute("userNo", vo.getUserNo());
					return "redirect:charge_form.do";
					// 충전페이지로 연결시키는 JSP로 이동
				}
			}
		} else {
			model.addAttribute("userNo", vo.getUserNo());
			return "redirect:charge_form.do";
			// 충전페이지로 연결시키는 JSP로 이동
		}
	}


//	유저가 입찰성공시 작동할 메소드
	@RequestMapping("bid_success.do")
	public String bid_success(BidVo vo, Model model) {
		
		String endAt = bid_dao.bid_end_at(vo.getpNo());
		Timestamp endDate = bid_dao.bid_end_date(vo.getBidNo());
		int bid_count = bid_dao.bid_count_select();
		BidVo userNoCheck = bid_dao.re_user_check(vo);

		vo.setEntryBidPrice(vo.getPlayPrice());
		vo.setNowBid(vo.getPlayPrice());
		vo.setEndDate(endDate);
		vo.setEndAt(endAt);

		bid_dao.now_bid_update(vo);
		bid_dao.entry_bid_update(vo);

		int nowBid = vo.getNowBid();
		String pName = bid_dao.p_name_select(vo.getpNo());
		vo.setpName(pName);

		if (nowBid < 200000) {
			nowBid = vo.getEntryBidPrice() + 5000; // 20만원 미만 금액은 최소입찰단위가 5000원
		} else if (nowBid >= 200000 && nowBid < 1000000) {
			nowBid = vo.getEntryBidPrice() + 15000; // 20만원 이상 100만원 미만 금액은 최소입찰단위가 15000원
		} else if (nowBid >= 1000000 && nowBid < 5000000) {
			nowBid = vo.getEntryBidPrice() + 30000; // 100만원 이상 500만원 미만 금액은 최소입찰단위가 30000원
		} else if (nowBid >= 5000000) {
			nowBid = vo.getEntryBidPrice() + 100000; // 500만원 이상 금액은 최소입찰단위가 100000만원
		}

		vo.setNowBid(nowBid);

		if (userNoCheck == null) {

			model.addAttribute("vo", vo);
			bid_dao.bid_success1(vo);
		} else {

			model.addAttribute("vo", vo);
			bid_dao.bid_success2(vo);
		}

		model.addAttribute(bid_count);
		model.addAttribute("vo",vo);

		return "bid/bid_main";
	}
	
	

	@RequestMapping("sb_off.do")	//시간이 끝나거나 조기종료버튼을 눌렀을때 작동
	public String sb_off(BidVo bid_vo,Model model) {
//		낙찰됐을때는 가장 큰 금액을 넣은 유저의 정보를 저장한다.
		
		int startPrice = bid_dao.new_bid_price_select(bid_vo.getpNo());
		int entryBidPrice = bid_dao.entry_bid_select(bid_vo.getBidNo());
		int pNo = bid_dao.p_no_select_one(bid_vo.getBidNo());
		
		

		System.out.println("입찰시작가 : "+startPrice);
		System.out.println("최고입찰가 : "+entryBidPrice);
		if (startPrice < entryBidPrice) {	//낙찰자가 있을 경우
			//낙찰된 유저검색
			int bidNo = bid_vo.getBidNo();
			
			//입찰된 최고금액을 검색
			int user_playPrice = bid_dao.user_playPrice(bidNo);
			bid_vo.setPlayPrice(user_playPrice);
			bid_vo.setBidNo(bidNo);
			
			//최고금액을 이용해 낙찰자 특정하기
			BidVo user_sb = bid_dao.user_sb(bid_vo);
			
			//낙찰된 유저정보를 낙찰DB에 저장
			SBVo sb_vo = new SBVo();
			
			sb_vo.setUserNo(user_sb.getUserNo());
			sb_vo.setBidNo(bid_vo.getBidNo());
			
			model.addAttribute(sb_vo);
			sb_dao.insert_user_sb(sb_vo);
			System.out.println("여기는 낙찰자가 있는 곳이야");
			sb_dao.end_at_update(pNo);
			return "redirect:auction.do";
			
		}else {	//낙찰된 유저가 없다면
			System.out.println("여기는 낙찰자가 없는 곳이야");
			SBVo sb_vo = new SBVo();
			sb_vo.setUserNo(bid_vo.getUserNo());
			sb_vo.setBidNo(bid_vo.getBidNo());
			
			sb_dao.insert_user_sb(sb_vo);
			
			sb_dao.end_at_update(pNo);
			return "redirect:auction.do";
		}
	}
	
	
	
	
}
