package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.AboardDao;
import dao.BidDao;
import dao.CategoryDao;
import dao.DetailCategoryDao;
import dao.ProductDao;
import vo.AboardVo;
import vo.CategoryVo;
import vo.DetailCategoryVo;
import vo.UserVo;

@Controller
public class AuctionController {

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	AboardDao aboard_dao;
	@Autowired
	BidDao bid_dao;
	@Autowired
	ProductDao product_dao;

	@Autowired
	CategoryDao category_dao;

	@Autowired
	DetailCategoryDao d_category_dao;

	public AuctionController() {
		// TODO Auto-generated constructor stub
	}

	// main 페이지 이동
	@RequestMapping("/home.do")
	public String home() {
		return "home";
	}

	// 경매 게시판 이동
	// /auction.do?category=computer
	@RequestMapping("/auction.do")
	public String auction(Model model) {

		List<CategoryVo> category_list = category_dao.selectList();
		List<DetailCategoryVo> d_category_list = d_category_dao.selectList();
		List<AboardVo> list = aboard_dao.selectList();

		model.addAttribute("category_list", category_list);
		model.addAttribute("d_category_list", d_category_list);
		model.addAttribute("list", list);

		return "main/auction";
	}

	// 상세 이동
	@RequestMapping("/a_board.do")
	public String auction_board(int auctionBoardNo, Model model) {

		AboardVo vo = aboard_dao.selectOne(auctionBoardNo);

		model.addAttribute("vo", vo);

		return "main/a_board";
	}

	// 경매글 작성
	@RequestMapping("/a_board_insert_form.do")
	public String a_board_insert_form() {

		return "main/a_board_insert_form";
	}

	@RequestMapping("/a_board_insert.do")
	public String a_board_insert(AboardVo vo) {

		UserVo user = (UserVo) session.getAttribute("user");

		// session timeout
		if (user == null) {

			return "redirect:../member/login_form.do";
		}
		vo.setUserNo(user.getUserNo());

		String pDesc = vo.getpDesc().replaceAll("\n", "<br>");
		vo.setpDesc(pDesc);

		int pNo = product_dao.insertProduct(vo);
		vo.setpNo(pNo);
		System.out.println(vo.getAutoExtension());
		int b_res = bid_dao.insertBid(vo);

		int res = aboard_dao.insertAboard(vo);

		return "redirect:auction.do";
	}

	// 게시물 삭제
	@RequestMapping("/aboard_delete.do")
	public String a_board_delete(int auctionBoardNo) {

		int res = aboard_dao.deleteAboard(auctionBoardNo);

		return "redirect:auction.do";
	}

	// 자유 게시판 이동
	@RequestMapping("/freetalk.do")
	public String freetalk() {
		return "board/freetalk";
	}

	// 문의 페이지 이동
//	@RequestMapping("/qna.do")
//	public String qna() {
//		return "qna/qna";
//	}

}
