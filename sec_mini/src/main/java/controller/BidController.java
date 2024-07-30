package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.BidDao;
import vo.AboardVo;
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
					return "bid/bid_charging";
					// 충전페이지로 연결시키는 JSP로 이동
				}
			}
		} else {
			model.addAttribute("userNo", vo.getUserNo());
			return "bid/bid_charging";
			// 충전페이지로 연결시키는 JSP로 이동
		}
	}

//	충전페이지 연결용 페이지
	@RequestMapping("charge_form.do")
	public String bid_charging() {

		return "bid/bid_charging";
	}

//	테스트용 페이지
	@RequestMapping("bid_test.do")
	public String bid_test() {

		return "bid/bid_test";
	}

////	메인 입찰 페이지로 이동
//	@RequestMapping("bid_main.do")
//	public String bid_main() {
//		return "bid/bid_main";
//	}
//	int userNo, int bidNo, int pNo, int playPrice
//	유저가 입찰성공시 작동할 메소드
	@RequestMapping("bid_success.do")
	public String bid_success(BidVo vo, Model model) {

		BidVo userNoCheck = bid_dao.re_user_check(vo);
	
		if (userNoCheck==null) {
			System.out.println("여기는 컨트롤러 비드석세스안에 있는 이프문 안에 있는 트루의 결과야");
			model.addAttribute("vo",vo);
			int res = bid_dao.bid_success1(vo);
		} else {
			System.out.println("여기는 컨트롤러 비드석세스안에 있는 이프문 안에 있는 펄스의 결과야");
			model.addAttribute("vo",vo);
			int res = bid_dao.bid_success2(vo);
		}

		return "bid/bid_main";
	}

}
