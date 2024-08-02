package controller;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.CommentLikesDao;
import vo.CommentLikesVo;
import vo.UserVo;

@Controller
@RequestMapping("/comment/likes/")
public class CommentLikesController {

    @Autowired
    CommentLikesDao commentLikesDao;

    @Autowired
    HttpServletRequest request;

    public CommentLikesController() {
        System.out.println("--CommentLikesController()--");
    }

    @RequestMapping(value = "toggle.do", produces = "application/json; charset=utf-8;")
    @ResponseBody
    public String toggle(@RequestParam("cmt_idx") int cmt_idx) {
        //Integer userNo = (Integer) request.getSession().getAttribute("userNo"); // 세션에서 userNo 가져오기
        UserVo user = (UserVo) request.getSession().getAttribute("user");
        
        JSONObject json = new JSONObject();
        if (user == null) {
            json.put("result", "failure");
            json.put("message", "로그인이 필요합니다.");
            return json.toString();
        }

        CommentLikesVo vo = new CommentLikesVo();
        vo.setCmt_idx(cmt_idx);
        vo.setUserNo(user.getUserNo());

        boolean isLiked = commentLikesDao.isLikedByUser(cmt_idx, user.getUserNo());
        int res;

        if (isLiked) {
            res = commentLikesDao.delete(vo);
            json.put("action", "removed");
        } else {
            res = commentLikesDao.insert(vo);
            json.put("action", "added");
        }

        json.put("result", res == 1 ? "success" : "failure");
        return json.toString();
    }

    @RequestMapping(value = "count.do", produces = "application/json; charset=utf-8;")
    @ResponseBody
    public String count(@RequestParam("cmt_idx") int cmt_idx) {
        int count = commentLikesDao.count(cmt_idx);

        JSONObject json = new JSONObject();
        json.put("count", count);
        return json.toString();
    }

    @RequestMapping(value = "isLiked.do", produces = "application/json; charset=utf-8;")
    @ResponseBody
    public String isLiked(@RequestParam("cmt_idx") int cmt_idx) {
        Integer userNo = (Integer) request.getSession().getAttribute("userNo"); // 세션에서 userNo 가져오기

        JSONObject json = new JSONObject();
        if (userNo == null) {
            json.put("isLiked", false);
            return json.toString();
        }

        boolean isLiked = commentLikesDao.isLikedByUser(cmt_idx, userNo);

        json.put("isLiked", isLiked);
        return json.toString();
    }
}
