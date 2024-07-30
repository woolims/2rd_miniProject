package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.UserDao;
import vo.UserVo;

@Controller
public class UserController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	UserDao user_dao;
	
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
	public String login(String userId, String userPwd) {
		
		UserVo user = user_dao.selectOne(userId);
		
		//아이디가 틀린 경우
		if(user == null) {
			session.setAttribute("alertMsg", "로그인 실패");
			return "redirect:login_form.do";
		}
		//비밀번호가 틀린 경우
		if(user.getUserPwd().equals(userPwd)==false) {
			session.setAttribute("alertMsg", "비밀번호가 틀렸습니다.");
			return "redirect:login_form.do";
		}
		
		//로그인 처리
		session.setAttribute("user", user);
		
		return "redirect:home.do";
	}
	
	@RequestMapping("/logout.do")
	public String logout() {
		session.removeAttribute("user");
		return "redirect:home.do";
	}
	
	@RequestMapping("/register_form.do")
	public String register_form() {
		
		return "main/register";
	}
	
	@RequestMapping("/register.do")
	public String register(UserVo vo) {
		
		int res = user_dao.insert(vo);
		
		if(res > 0) {
			session.setAttribute("alertMsg", "회원가입 성공");
			return "redirect:login_form.do";
		}else {
			return "redirect:register_form.do";
		}
	}
	
	@RequestMapping(value="/check_id.do", produces="application/json;charset=utf-8")
	@ResponseBody
	public String check_id(String userId) {
		
		UserVo vo = user_dao.selectOne(userId);
		
		boolean bResult = (vo==null);
		
		String json = String.format("{\"result\": %b}", bResult);
		
		return json;
	}
	
	@RequestMapping("/mypage.do")
	public String mypage() {
		
		UserVo user = (UserVo) session.getAttribute("user");
		
		if(user == null) {
			session.setAttribute("alertMsg", "로그인한 사용자만 접근 가능");
			return "home.do";
		}else {
			
			
			
			return "main/mypage";
		}
		
	}
	
	@RequestMapping("/modify_form.do")
	public String modify_form(int userNo) {
		
		UserVo vo = user_dao.selectOne(userNo);
		
		return "main/mypage";
	}
	
	@RequestMapping("/modify.do")
	public String modify(UserVo vo) {
		
		int res = user_dao.update(vo);
		
		if(res > 0) {
			session.removeAttribute("user");
			session.setAttribute("alertMsg", "수정되었습니다.");
			return "redirect:login_form.do";
		}else {
			session.setAttribute("alertMsg", "수정 실패했습니다.");
			return "retirect:mypage.do";
		}
	}
	
	@RequestMapping("/delete_form.do")
	public String delete_form() {
		return "main/deletepage";
	}
	
	@RequestMapping("/delete.do")
	public String delete(int userNo, String userPwd) {
		
		UserVo user = (UserVo) session.getAttribute("user");
		
		if(user.getUserPwd().equals(userPwd)) {
			int res = user_dao.deleteUser(userNo);
			
			if(res > 0) {
				session.removeAttribute("user");
				session.setAttribute("alertMsg", "탈퇴되었습니다.");
				return "redirect:home.do";
			}else {
				session.setAttribute("alertMsg", "탈퇴 실패했습니다.");
				return "redirect:delete_form.do";
			}
		}else {
			session.setAttribute("alertMsg", "비밀번호가 틀렸습니다.");
			return "redirect:delete_form.do";
		}
	}
	
	// 충전 폼 이동
	@RequestMapping("/charge_form.do")
	public String charge_form() {
		
		return "main/charge_form";
	}

	 @RequestMapping("/charge.do") 
	 public String charge(UserVo vo) {
	 
		UserVo vo1 = user_dao.selectOne(vo.getUserNo());vo.setMyCash(vo1.getMyCash() + vo.getMyCash());
		int res = user_dao.update_myCash(vo);
		 
		if(res > 0) {
			session.setAttribute("alertMsg", "포인트 충전되었습니다!");
			
			UserVo user = (UserVo) session.getAttribute("user");
			user = user_dao.selectOne(user.getUserNo());

			session.setAttribute("user", user);
			
			return "redirect:mypage.do";
		}else {
			
			session.setAttribute("alertMsg", "충전에 실패했습니다!");
			return "redirect:charge_form.do";
		}
	 
	 }
	 
	 
	 
}
	
	
