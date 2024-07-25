package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AuctionController {

	public AuctionController() {
		// TODO Auto-generated constructor stub
	}
	
	//main 페이지 이동
	@RequestMapping("/home.do")
	public String home() {
		return "home";
	}
	
	//경매 게시판 이동
	@RequestMapping("/auction.do")
	public String auction() {
		return "main/auction";
	}
	
	//자유 게시판 이동
	@RequestMapping("/freetalk.do")
	public String freetalk() {
		return "main/freetalk";
	}
	
	//문의 페이지 이동
	@RequestMapping("/qna.do")
	public String qna() {
		return "main/qna";
	}
	
}
