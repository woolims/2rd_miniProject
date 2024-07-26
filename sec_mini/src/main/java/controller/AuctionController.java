package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dao.CategoryDao;
import dao.DetailCategoryDao;
import vo.CategoryVo;
import vo.DetailCategoryVo;

@Controller
public class AuctionController {

	
	@Autowired
	CategoryDao category_dao;
	
	@Autowired
	DetailCategoryDao d_category_dao;
	
	public AuctionController() {
		// TODO Auto-generated constructor stub
	}
	
	//main 페이지 이동
	@RequestMapping("/home.do")
	public String home() {
		return "home";
	}
	
	//경매 게시판 이동
	// /auction.do?category=computer
	@RequestMapping("/auction.do")
	public String auction(Model model) {
		
		List<CategoryVo> category_list = category_dao.selectList();
		List<DetailCategoryVo> d_category_list = d_category_dao.selectList();
		
		model.addAttribute("category_list", category_list);
		model.addAttribute("d_category_list", d_category_list);
		
		
		return "main/auction";
	}
	
	
	
	//자유 게시판 이동
	@RequestMapping("/freetalk.do")
	public String freetalk() {
		return "board/freetalk";
	}
	
	//문의 페이지 이동
	@RequestMapping("/qna.do")
	public String qna() {
		return "main/qna";
	}
	
}
