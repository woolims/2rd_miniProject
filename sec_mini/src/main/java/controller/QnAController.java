package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.QnADao;
import vo.QnAVo;

@RequestMapping("/qna/")
public class QnAController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	QnADao qna_dao;
	
	@RequestMapping("qna.do")
	public String qna(Model model) {
			
		List<QnAVo> list = qna_dao.qnaList();
		
		model.addAttribute("list", list);
		
		return "qna/qna";
	}
	
}
