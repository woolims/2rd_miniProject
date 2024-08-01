package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dao.QnADao;
import util.MyCommon;
import util.Paging2;
import vo.QnACommentVo;
import vo.QnAVo;
import vo.UserVo;

@Controller
@RequestMapping("/qna/")
public class QnAController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	QnADao qna_dao;
	
	@RequestMapping("qna.do")
	public String qna(@RequestParam(name="search", defaultValue = "all") String search,
	                  @RequestParam(name="search_text", required = false) String search_text,
	                  @RequestParam(name="page", defaultValue = "1") int nowPage,
	                  Model model) {
	    
	    Map<String, Object> map = new HashMap<>();
	    
	    // 검색 조건 처리
	    if ("name_title".equals(search)) {
	        map.put("userName", search_text);
	        map.put("qnaTitle", search_text);
	    } else if ("userName".equals(search)) {
	        map.put("userName", search_text);
	    } else if ("qnaTitle".equals(search)) {
	        map.put("qnaTitle", search_text);
	    }
	    
	    // 페이지 네이션 설정
	    int start = (nowPage - 1) * MyCommon.Board.BLOCK_LIST + 1;
	    int end = start + MyCommon.Board.BLOCK_LIST - 1;
	    map.put("start", start);
	    map.put("end", end);
	    
	    // 총 게시물 수
	    int rowTotal = qna_dao.selectRowTotal(map);
	    
	    // 검색 정보 필터
	    String search_filter = String.format("search=%s&search_text=%s", search, search_text);

	    // 페이지 메뉴 생성
	    String pageMenu = Paging2.getPaging("qna.do", search_filter, nowPage, rowTotal, MyCommon.Board.BLOCK_LIST, MyCommon.Board.BLOCK_PAGE);

	    // 게시물 리스트 가져오기
	    List<QnAVo> list = qna_dao.qnaList(map);
	    
	    // 게시물의 답변 상태를 맵에 저장
	    Map<Integer, Boolean> answerMap = new HashMap<>();
	    List<QnACommentVo> comments = qna_dao.qnaCList();
	    for (QnACommentVo comment : comments) {
	        answerMap.put(comment.getQnaNo(), true); // 답변이 존재하면 true
	    }

	    // 모델에 데이터 설정
	    model.addAttribute("list", list);
	    model.addAttribute("answerMap", answerMap);
	    model.addAttribute("pageMenu", pageMenu);
	    model.addAttribute("search", search);
	    model.addAttribute("search_text", search_text);
	    
	    return "qna/qna";
	}
	
	//QnA 상세 조회
	@RequestMapping("qna_select.do")
	public String qna_select(int qnaNo, Model model) {
		
		QnAVo vo = qna_dao.selectOne(qnaNo);
		
		model.addAttribute("vo", vo);
		
		return "qna/qna_select";
	}
	
	//QnA 작성폼 이동
	@RequestMapping("qna_write_form.do")
	public String qna_write_form() {
		return "qna/qna_write";
	}
	
	//QnA 작성
	@RequestMapping("qna_write.do")
	public String qna_write(QnAVo vo) {
		UserVo user = (UserVo) session.getAttribute("user");
		
		// session timeout
		if (user == null) {
			return "redirect:../login_form.do";
		}
				
		vo.setUserNo(user.getUserNo());
		
		int res = qna_dao.write(vo);
		
		return "redirect:qna.do";
	}
	
	//QnA 삭제
	@RequestMapping("qna_delete.do")
	public String qna_delete(int qnaNo) {
		
		int res = qna_dao.delete(qnaNo);
		
		return "redirect:qna.do";
	}
	
	//QnA 수정폼 이동
	@RequestMapping("qna_modify_form.do")
	public String qna_modify_form(int qnaNo, Model model) {
		
		QnAVo vo = qna_dao.selectOne(qnaNo);
		
		model.addAttribute("vo", vo);
		
		return "qna/qna_modify_form";
	}
	
	//QnA 수정
	@RequestMapping("qna_modify.do")
	public String qna_modify(QnAVo vo) {
		
		int res = qna_dao.update(vo);
		
		return "redirect:qna.do";
	}
	
}
