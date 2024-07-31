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
import dao.CommentDao;
import dao.CommentLikesDao;
import util.MyCommon;
import util.Paging;
import vo.CommentVo;
import vo.UserVo;

@Controller
@RequestMapping("/comment/")
public class CommentController {

    @Autowired
    CommentDao comment_dao;
    
    @Autowired
    CommentLikesDao commentLikesDao;

    @Autowired
    HttpServletRequest request;

    public CommentController() {
        System.out.println("--CommentController()--");
    }

    @RequestMapping("list.do")
    public String list(int boardNo, @RequestParam(name="page",defaultValue="1") int nowPage, Model model) {
        int start = (nowPage-1) * MyCommon.Comment.BLOCK_LIST + 1;
        int end = start + MyCommon.Comment.BLOCK_LIST - 1;
        Map<String, Object> map = new HashMap<>();
        map.put("boardNo", boardNo);
        map.put("start", start);
        map.put("end", end);
        List<CommentVo> list = comment_dao.selectList(map);
        int rowTotal = comment_dao.selectRowTotal(boardNo);
        String pageMenu = Paging.getCommentPaging(nowPage, rowTotal, MyCommon.Comment.BLOCK_LIST, MyCommon.Comment.BLOCK_PAGE);
        model.addAttribute("list", list);
        model.addAttribute("pageMenu", pageMenu);
        return "comment/comment_list";
    }

    @RequestMapping(value="insert.do", produces="application/json; charset=utf-8;")
    @ResponseBody
    public String insert(CommentVo vo) {
        String cmt_ip = request.getRemoteAddr();
        vo.setCmt_ip(cmt_ip);
        String cmt_content = vo.getCmt_content().replaceAll("\n", "<br>");
        vo.setCmt_content(cmt_content);
        int res = comment_dao.insert(vo);
        JSONObject json = new JSONObject();
        json.put("result", res == 1); 
        return json.toString();
    }

    @RequestMapping(value="delete.do", produces="application/json; charset=utf-8;")
    @ResponseBody
    public String delete(int cmt_idx, HttpSession session) {
        UserVo user = (UserVo) session.getAttribute("user");  // "loggedInUser" -> "user"로 변경
        
        System.out.println("Logged in user: " + user); // 로그 추가

        JSONObject json = new JSONObject();
        
        if (user == null) {
            json.put("result", "failure");
            json.put("message", "로그인이 필요합니다.");
            return json.toString();
        }

        CommentVo comment = comment_dao.selectByIdx(cmt_idx);

        System.out.println("Comment: " + comment); // 로그 추가
        
        if (comment == null) {
            json.put("result", "failure");
            json.put("message", "댓글을 찾을 수 없습니다.");
            return json.toString();
        }

        if (user.getUserNo() == comment.getUserNo()) {
            // 자신의 댓글인 경우 실제로 삭제
            commentLikesDao.deleteByComment(cmt_idx); // 댓글의 모든 좋아요 삭제
            int res = comment_dao.delete(cmt_idx);
            json.put("result", res == 1);
        } else if ("관리자".equals(user.getNickName())) {
            // 관리자인 경우 is_deleted 플래그 업데이트
            int res = comment_dao.markCommentAsDeleted(cmt_idx);
            json.put("result", res == 1);
        } else {
            json.put("result", "failure");
            json.put("message", "삭제 권한이 없습니다.");
        }

        return json.toString();
    }

    @RequestMapping(value="update.do", produces="application/json; charset=utf-8;")
    @ResponseBody
    public String update(CommentVo vo) {
        String cmt_ip = request.getRemoteAddr();
        vo.setCmt_ip(cmt_ip);
        String cmt_content = vo.getCmt_content().replaceAll("\n", "<br>");
        vo.setCmt_content(cmt_content);
        int res = comment_dao.update(vo);
        JSONObject json = new JSONObject();
        json.put("result", res == 1);
        return json.toString();
    }
}
