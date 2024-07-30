package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.QnADao;
import vo.QnAVo;

@Controller
@RequestMapping("/qna/")
public class QnAController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	QnADao qna_dao;
	
	//QnA 전체 조회
	@RequestMapping("qna.do")
	public String qna(Model model) {
			
		List<QnAVo> list = qna_dao.qnaList();
		
		model.addAttribute("list", list);
		
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
		
		int res = qna_dao.write(vo);
		
		return "redirect:qna.do";
	}
	
	//QnA 삭제
	@RequestMapping("qna_delete.do")
	public String qna_delete(int qnaNo) {
		
		int res = qna_dao.delete(qnaNo);
		
		return "redirect:qna.do";
	}
	
}
