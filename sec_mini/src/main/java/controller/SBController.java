package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.SBDao;
import vo.BidVo;
import vo.SBVo;

@Controller
public class SBController {

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	SBDao sb_dao;
	


}
