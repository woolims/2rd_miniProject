package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
	
	public UserController() {
		// TODO Auto-generated constructor stub
	}
	
	//로그인 폼 이동
	@RequestMapping("/login_form.do")
	public String login_form() {
		return "main/login_form";
	}
	
	//로그인 시도
	@RequestMapping("/login.do")
	public String login() {
		
		
		
		return "home";
	}
}
