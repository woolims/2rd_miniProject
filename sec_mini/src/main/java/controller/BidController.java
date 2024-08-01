package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;

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

		LocalDateTime now = LocalDateTime.now();
		int startPrice = bid_dao.new_bid_price_select(vo.getpNo());
		int entryBidPrice = bid_dao.entry_bid_select(vo.getBidNo());
		int myCash = bid_dao.cashCheck(vo.getUserNo());
		String pName = bid_dao.p_name_select(vo.getpNo());
		int nowBid = bid_dao.now_bid_select(vo.getBidNo());
		int bid_count = bid_dao.bid_count_select();
		
		String end_date = bid_dao.end_date_check(vo.getBidNo());
		String now_time = now.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"));
		
		Date end_date_check = new SimpleDateFormat("yyyy/MM/dd/hh/mm/ss").parse(end_date);
		Date now_time_check = new SimpleDateFormat("yyyy/MM/dd/hh/mm/ss").parse(now_time);
		
		long end_check = end_date_check.getTime();	//종료시간
		long now_check = now_time_check.getTime();	//현재시간
		
		vo.setNowBid(nowBid);
		vo.setEntryBidPrice(entryBidPrice);
		vo.setStartPrice(startPrice);
		vo.setpName(pName);

		if (startPrice < myCash) {
			// 유저가 가진 금액이 상품등록 금액보다 많을 경우 통과
			if (entryBidPrice == 0) { //입찰자가 없다면 통과
				model.addAttribute(bid_count);
				model.addAttribute("vo", vo);
				model.addAttribute(end_check);
				model.addAttribute(now_check);
				
				System.out.println(bid_count);
				return "bid/bid_main"; // 진짜 입찰페이지로 이동
			} else {
				if (entryBidPrice < myCash) {
					// 유저가 가진 금액이 현재 최고가보다 높을 경우 통과
					model.addAttribute("vo", vo);
					model.addAttribute(bid_count);
					System.out.println(bid_count);
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

		int bid_count = bid_dao.bid_count_select();
		BidVo userNoCheck = bid_dao.re_user_check(vo);

		vo.setEntryBidPrice(vo.getPlayPrice());
		vo.setNowBid(vo.getPlayPrice());

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

		return "bid/bid_main";
	}

	@RequestMapping("sb_off.do")	//조기종료버튼을 눌렀을때 작동 판매자를 위한 코드
	public String sb_off(BidVo bid_vo) {
//		낙찰됐을때는 가장 큰 금액을 넣은 유저의 정보를 저장한다.
		
		int startPrice = bid_dao.new_bid_price_select(bid_vo.getpNo());
		int entryBidPrice = bid_dao.entry_bid_select(bid_vo.getBidNo());
		int pNo = bid_dao.p_no_select_one(bid_vo.getBidNo());
		sb_dao.end_at_update(pNo);
		

		System.out.println(startPrice);
		System.out.println(entryBidPrice);
		if (startPrice < entryBidPrice) {	//낙찰자가 있을 경우
			//낙찰된 유저검색
			int bidNo = bid_vo.getBidNo();
			
			//입찰된 최고금액을 검색
			int user_playPrice = bid_dao.user_playPrice(bidNo);
			BidVo user_sb = bid_dao.user_sb(user_playPrice);
			
			//낙찰된 유저정보를 낙찰DB에 저장
			SBVo sb_vo = new SBVo();
			
			sb_vo.setUserNo(user_sb.getUserNo());
			sb_vo.setBidNo(bid_vo.getBidNo());
			
			
			sb_dao.insert_user_sb(sb_vo);
			System.out.println("여기는 이프문을 통과한곳이야");
			return "sb/sb_off";
			
		}else {	//낙찰된 유저가 없다면
			System.out.println("여기는 엘스야");
			return "sb/sb_off";
		}
	}
}
