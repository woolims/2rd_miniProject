package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.BoardDao;
import vo.BoardVo;
import vo.UserVo;

@Controller
@RequestMapping("/board/")
public class BoardController {

    public BoardController() {
        System.out.println("--BoardController()_mini--");
    }

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    BoardDao board_dao;

    // 전체 목록 조회
    @RequestMapping("freetalk.do")
    public String list(Model model) {
    	
        List<BoardVo> list = board_dao.selectList();
        System.out.println(list.size());
        
        model.addAttribute("list", list);
        return "board/freetalk";
    }

    // 새글쓰기 폼 띄우기
    @RequestMapping("insert_form.do")
    public String insert_form() {
        return "board/board_insert_form";
    }

	// /board/insert.do?b_subject=제목&b_content=내용
    // 새글쓰기 
	@RequestMapping("insert.do")
	public String insert(BoardVo vo,RedirectAttributes ra) {
		
		
		//로그인 유저정보 얻어온다
		UserVo user = (UserVo) session.getAttribute("user");
		
		if(user==null) {
			
			ra.addAttribute("reason", "session_timeout");
			
			return "redirect:../main/login_form.do";
		}
		
		//사용자정보 vo에 등록
		vo.setUserNo(user.getUserNo());
		vo.setNickName(user.getNickName());
			
		
		// \n -> <br>
		String boardContent = vo.getBoardContent().replaceAll("\n", "<br>");
		vo.setBoardContent(boardContent);
		
		//DB insert
		int res = board_dao.insert(vo);
		
		return "redirect:freetalk.do";
	}
	
	
    // 게시글 상세 조회
	// /board/view.do?boardNo=5
    @RequestMapping("view.do")
    public String view(@RequestParam("boardNo") int boardNo, Model model) {
    	
    	//b_idx에 해당되는 게시물 1건 얻어오기
    	BoardVo vo = board_dao.selectOne(boardNo);
    	
    	//결과적으로 request binding
    	model.addAttribute("vo", vo);
        return "board/board_view";

    }
    
 // 게시글 수정 폼으로 이동
    @RequestMapping("modify_form.do")
    public String modify_form(@RequestParam("boardNo") int boardNo, Model model) {
        // boardNo에 해당되는 게시물 1건 얻어오기
        BoardVo vo = board_dao.selectOne(boardNo);
        
        // 결과적으로 request binding
        model.addAttribute("vo", vo);
        return "board/board_modify_form";
    }

    // 게시글 수정
    @RequestMapping(value = "modify.do", method = RequestMethod.POST)
    public String modify(BoardVo vo, RedirectAttributes ra) {
        // 로그인 유저정보 얻어온다
        UserVo user = (UserVo) session.getAttribute("user");

        if (user == null) {
            ra.addAttribute("reason", "session_timeout");
            return "redirect:../main/login_form.do";
        }

        // 사용자정보 vo에 등록
        vo.setUserNo(user.getUserNo());
        vo.setNickName(user.getNickName());

        // 제목과 내용이 NULL이 아닌지 확인
        if (vo.getTitle() == null || vo.getTitle().trim().isEmpty()) {
            ra.addFlashAttribute("message", "제목을 입력해주세요.");
            return "redirect:modify_form.do?boardNo=" + vo.getBoardNo();
        }

        if (vo.getBoardContent() == null || vo.getBoardContent().trim().isEmpty()) {
            ra.addFlashAttribute("message", "내용을 입력해주세요.");
            return "redirect:modify_form.do?boardNo=" + vo.getBoardNo();
        }

        // \n -> <br>
        String boardContent = vo.getBoardContent().replaceAll("\n", "<br>");
        vo.setBoardContent(boardContent);

        // DB update
        int res = board_dao.update(vo);

        return "redirect:view.do?boardNo=" + vo.getBoardNo();
    }
    
    // 게시글 삭제
    @RequestMapping("delete.do")
    public String delete(@RequestParam("boardNo") int boardNo, RedirectAttributes ra) {
        // 로그인 유저정보 얻어온다
        UserVo user = (UserVo) session.getAttribute("user");

        if (user == null) {
            ra.addAttribute("reason", "session_timeout");
            return "redirect:../main/login_form.do";
        }

        // DB delete
        int res = board_dao.delete(boardNo);

        return "redirect:freetalk.do";
    }
}
    
    
