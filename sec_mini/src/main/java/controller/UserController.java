package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.AboardDao;
import dao.UserDao;
import vo.AboardVo;
import vo.ScrapVo;
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
			return "redirect:home.do";
		}
		//비밀번호가 틀린 경우
		if(user.getUserPwd().equals(userPwd)==false) {
			session.setAttribute("alertMsg", "비밀번호가 틀렸습니다.");
			return "redirect:home.do";
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
	public String register(UserVo vo,
			@RequestParam(name="page", defaultValue = "all") String userId,
            @RequestParam(name="userPwdReg", defaultValue = "all") String userPwd) {
		
		UserVo vo1 = new UserVo();
	    vo1.setUserId(userId);
	    vo1.setUserPwd(userPwd);
		
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
			return "redirect:home.do";
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
	
	 @RequestMapping(value="/charge.do",
     produces="application/json; charset=utf-8")
	 @ResponseBody
	 public String charge(UserVo vo) {
	 
		UserVo vo1 = user_dao.selectOne(vo.getUserNo());
		 vo.setMyCash(vo1.getMyCash() + vo.getMyCash());
		 
		int res = user_dao.update_myCash(vo);

		 
		if(res > 0) {
			session.setAttribute("alertMsg", "포인트 충전되었습니다!");
			
			UserVo user = (UserVo) session.getAttribute("user");
			user = user_dao.selectOne(user.getUserNo());

			session.setAttribute("user", user);
			
			//{"result" : true}
			String json = String.format("{\"result\" : %d}", res);
			
			return json;
			
		}else {
			
			session.setAttribute("alertMsg", "충전에 실패했습니다!");
			return "redirect:mypage.do";
		}
	 
	 }
	 
	 
	@Autowired
	AboardDao aboard_dao;

	// 마이옥션 이동
	@RequestMapping("/myauction.do")
	public String myauction(Model model) {
		
		UserVo user = (UserVo) session.getAttribute("user");
		

		
		if(user == null) {
			session.setAttribute("alertMsg", "로그인한 사용자만 접근 가능");
			

			return "redirect:home.do";
		}else {
			
			//입찰 게시물 불러오기
			List<AboardVo> list = aboard_dao.selectListMyBid(user.getUserNo());
			//낙찰 게시물 불러오기
			List<AboardVo> list2 = aboard_dao.selectListMySb(user.getUserNo());
			//내가 올린 게시물 불러오기
			List<AboardVo> list3 = aboard_dao.selectListMyAuc(user.getUserNo());
			//즐겨찾기 게시물 불러오기
			List<AboardVo> list4 = aboard_dao.selectListMySc(user.getUserNo());
			
			model.addAttribute("list", list);
			model.addAttribute("list2", list2);
			model.addAttribute("list3", list3);
			model.addAttribute("list4", list4);
		
			return "main/myauction";
		}
			
	}
	 
}
	
	
