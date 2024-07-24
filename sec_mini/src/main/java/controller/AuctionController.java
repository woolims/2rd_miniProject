package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller                      
public class AuctionController {

	public AuctionController() {
		// TODO Auto-generated constructor stub
	}
	
	@RequestMapping("/home.do")
	public String home() {
		return "index";
	}
	
	@RequestMapping("/auction.do")
	public String auction() {
		return "main/auction";
	}
	
	@RequestMapping("/freetalk.do")
	public String freetalk() {
		return "main/freetalk";
	}
	
	@RequestMapping("/qna.do")
	public String qna() {
		return "main/qna";
	}
	
	@RequestMapping("/login_form.do")
	public String login_form() {
		return "main/login_form";
	}
}
