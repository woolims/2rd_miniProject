package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.QnACommentDao;
import util.MyCommon;
import util.Paging;
import vo.CommentVo;
import vo.QnACommentVo;
import vo.UserVo;

@Controller
@RequestMapping("/qna_comment/")
public class QnACommentController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	QnACommentDao qnac_dao;
	
	//QnAComment 전체 조회
    @RequestMapping("list.do")
    public String list(int qnaNo, @RequestParam(name="page",defaultValue="1") int nowPage, Model model) {
        int start = (nowPage-1) * MyCommon.Comment.BLOCK_LIST + 1;
        int end = start + MyCommon.Comment.BLOCK_LIST - 1;
        Map<String, Object> map = new HashMap<>();
        map.put("qnaNo", qnaNo);
        map.put("start", start);
        map.put("end", end);
        List<QnACommentVo> list = qnac_dao.selectList(map);
        int rowTotal = qnac_dao.selectRowTotal(qnaNo);
        String pageMenu = Paging.getCommentPaging(nowPage, rowTotal, MyCommon.Comment.BLOCK_LIST, MyCommon.Comment.BLOCK_PAGE);
        model.addAttribute("list", list);
        model.addAttribute("pageMenu", pageMenu);
        return "qna_comment/qnac";
    }
    
    //QnA 답글 작성
    @RequestMapping(value="insert.do", produces="application/json; charset=utf-8;")
    @ResponseBody
    public String insert(QnACommentVo vo) {
        String commentContent = vo.getCommentContent().replaceAll("\n", "<br>");
        vo.setCommentContent(commentContent);
        int res = qnac_dao.insert(vo);
        JSONObject json = new JSONObject();
        json.put("result", res == 1); 
        return json.toString();
    }
    
    //QnA 답글 삭제
    @RequestMapping(value="delete.do", produces="application/json; charset=utf-8;")
    @ResponseBody
    public String delete(int qnaCommentNo) {
        UserVo user = (UserVo) session.getAttribute("user");
        
        JSONObject json = new JSONObject();
        
        if (user == null) {
            json.put("result", "failure");
            json.put("message", "로그인이 필요합니다.");
            return json.toString();
        }

        QnACommentVo vo = qnac_dao.selectOneQCN(qnaCommentNo);
        
        if (vo == null) {
            json.put("result", "failure");
            json.put("message", "댓글을 찾을 수 없습니다.");
            return json.toString();
        }

        if (user.getUserNo() == vo.getUserNo() || user.getUserNo() == 1) {
            // 자신의 댓글인 경우 실제로 삭제
            int res = qnac_dao.delete(qnaCommentNo);
            json.put("result", res == 1);
        } else {
            json.put("result", "failure");
            json.put("message", "삭제 권한이 없습니다.");
        }

        return json.toString();
    }
    
    //QnA 답글 수정
    @RequestMapping(value="update.do", produces="application/json; charset=utf-8;")
    @ResponseBody
    public String update(QnACommentVo vo) {
        String commentContent = vo.getCommentContent().replaceAll("\n", "<br>");
        vo.setCommentContent(commentContent);
        int res = qnac_dao.update(vo);
        JSONObject json = new JSONObject();
        json.put("result", res == 1);
        return json.toString();
    }
	
}
