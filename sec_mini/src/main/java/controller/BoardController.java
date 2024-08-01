package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.BoardDao;
import util.MyCommon;
import util.Paging;
import vo.BoardVo;
import vo.UserVo;

@Controller
@RequestMapping("/board/")
public class BoardController {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    BoardDao board_dao;

    // 전체 목록 조회 및 검색, 페이징 처리
    @RequestMapping("freetalk.do")
    public String list(
        @RequestParam(name="search", defaultValue = "all") String search,
        @RequestParam(name="search_text", required = false) String search_text,
        @RequestParam(name = "page", defaultValue = "1") int nowPage,
        Model model) {

        Map<String, Object> map = new HashMap<String, Object>();

        // 검색 조건 처리
        if("name_content".equals(search)) {
            map.put("nickName", search_text);
            map.put("boardContent", search_text);
        } else if("nickName".equals(search)) {
            map.put("nickName", search_text);
        } else if("boardContent".equals(search)) {
            map.put("boardContent", search_text);
        }

        // 페이지 네이션 설정
        int start = (nowPage - 1) * MyCommon.Board.BLOCK_LIST + 1;
        int end = start + MyCommon.Board.BLOCK_LIST - 1;
        map.put("start", start);
        map.put("end", end);

        // 총 게시물 수
        int rowTotal = board_dao.selectRowTotal(map);

        // 검색 정보 필터
        String search_filter = String.format("search=%s&search_text=%s", search, search_text);

        // 페이지 메뉴 생성
        String pageMenu = Paging.getPaging("freetalk.do", search_filter, nowPage, rowTotal, MyCommon.Board.BLOCK_LIST, MyCommon.Board.BLOCK_PAGE);

        // 게시물 리스트 가져오기
        List<BoardVo> list = board_dao.selectList(map);
        
        // 모델에 데이터 설정
        model.addAttribute("list", list);
        model.addAttribute("pageMenu", pageMenu);
        model.addAttribute("search", search);
        model.addAttribute("search_text", search_text);

        return "board/freetalk";
    }

    // 새글쓰기 폼 띄우기
    @RequestMapping("insert_form.do")
    public String insert_form() {
        return "board/board_insert_form";
    }

    // 새글쓰기
    @RequestMapping("insert.do")
    public String insert(BoardVo vo, RedirectAttributes ra) {
        // 로그인 유저정보 얻어온다
        UserVo user = (UserVo) session.getAttribute("user");

        if (user == null) {
            ra.addAttribute("reason", "session_timeout");
            return "redirect:../main/login_form.do";
        }

        // 사용자정보 vo에 등록
        vo.setUserNo(user.getUserNo());
        vo.setNickName(user.getNickName());

        // \n -> <br>
        String boardContent = vo.getBoardContent().replaceAll("\n", "<br>");
        vo.setBoardContent(boardContent);

        // DB insert
        int res = board_dao.insert(vo);

        return "redirect:freetalk.do";
    }

    // 게시글 상세 조회
    @RequestMapping("view.do")
    public String view(@RequestParam("boardNo") int boardNo, int b_idx, Model model) {
        // boardNo에 해당되는 게시물 1건 얻어오기
        BoardVo vo = board_dao.selectOne(boardNo);
        
        BoardVo vo2 = board_dao.selectOne(b_idx);
        
        if(session.getAttribute("show")==null) {
    		
			//조회수 증가
			int res = board_dao.update_readhit(b_idx);
			
			session.setAttribute("show", true);
		
		}
        // 디버그 출력
        if (vo == null) {
            System.out.println("BoardVo is null for boardNo: " + boardNo);
        } else {
            System.out.println("BoardVo: " + vo.toString());
        }
        
        
        // 결과적으로 request binding
        model.addAttribute("vo", vo);
        model.addAttribute("vo2", vo2);
        
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
    @RequestMapping("modify.do")
    public String modify(BoardVo vo, 
                         @RequestParam(name="page", defaultValue = "1") int page,
                         @RequestParam(name="search", defaultValue = "all") String search,
                         @RequestParam(name="search_text", required = false) String search_text,
                         RedirectAttributes ra) throws Exception {
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

        // RedirectAttributes: redirect parameter정보 담는 객체
        ra.addAttribute("page", page);
        ra.addAttribute("search", search);
        ra.addAttribute("search_text", search_text);

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
    
    
    // 게시글 고정/해제
    @PostMapping("pin.do")
    public String pinPost(@RequestParam("boardNo") int boardNo, @RequestParam("isPinned") int isPinned, RedirectAttributes ra) {
        // 로그인 유저정보 얻어온다
        UserVo user = (UserVo) session.getAttribute("user");

        if (user == null) {
            ra.addAttribute("reason", "session_timeout");
            return "redirect:../main/login_form.do";
        }

        // 고정 상태 업데이트
        int res = board_dao.updatePinStatus(boardNo, isPinned);

        return "redirect:freetalk.do";
    }
    
}
