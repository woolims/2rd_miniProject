package controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.AboardDao;
import dao.BidDao;
import dao.BoardDao;
import dao.CategoryDao;
import dao.DetailCategoryDao;
import dao.ProductDao;
import vo.AboardVo;
import vo.BoardVo;
import vo.CategoryVo;
import vo.DetailCategoryVo;
import vo.ScrapVo;
import vo.UserVo;

@Controller
public class AuctionController {

	@Autowired
	ServletContext application;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	AboardDao aboard_dao;
	@Autowired
	BidDao bid_dao;
	@Autowired
	ProductDao product_dao;
	@Autowired
	BoardDao board_dao;

	@Autowired
	CategoryDao category_dao;

	@Autowired
	DetailCategoryDao d_category_dao;

	public AuctionController() {
		// TODO Auto-generated constructor stub
	}

	// main 페이지 이동
	@RequestMapping("/home.do")
	public String home(Model model) {

		// 상위 3개의 최신 게시글 가져오기
		List<BoardVo> topThreePosts = board_dao.selectTopThreeRecentPosts();
		
		List<AboardVo> mostViewList = aboard_dao.MostView();
		
		request.setAttribute("topThreePosts", topThreePosts);
		
		model.addAttribute("mostViewList", mostViewList);
		
		return "home";
	}

	// 경매 게시판 이동
	// /auction.do?category=computer
	@RequestMapping("/auction.do")
	public String auction(@RequestParam(name = "categoryNo", defaultValue = "0") int categoryNo, @RequestParam(name = "d_categoryNo", defaultValue = "0") int d_categoryNo, Model model) {

		session.removeAttribute("show");
		
		List<CategoryVo> category_list = category_dao.selectList();
		List<DetailCategoryVo> d_category_list = d_category_dao.selectList();
		List<AboardVo> mostViewList = aboard_dao.MostView();
		
		List<AboardVo> list = null;
		System.out.println("categoryNo = " + categoryNo + "/ d_categoryNo = " + d_categoryNo);
		
		if(categoryNo != 0) {
				list = aboard_dao.selectCate(categoryNo);
		}else if(d_categoryNo != 0) {
			list = aboard_dao.selectDCate(d_categoryNo);
		}else {
				list = aboard_dao.selectList();
		}
		
		model.addAttribute("category_list", category_list);
		model.addAttribute("d_category_list", d_category_list);
		model.addAttribute("list", list);
		model.addAttribute("mostViewList", mostViewList);

		return "main/auction";
	}

	// 상세 이동
	@RequestMapping("/a_board.do")
	public String auction_board(int auctionBoardNo, Model model) {

		List<AboardVo> mostViewList = aboard_dao.MostView();
		
		if (session.getAttribute("show") == null) {

			// 조회수 증가
			int res = aboard_dao.update_readhit(auctionBoardNo);

			session.setAttribute("show", true);

		}
		
		AboardVo vo = aboard_dao.selectOne(auctionBoardNo);
		/*
		 * Map<String, Object> map = new HashMap<>();
		 * 
		 * UserVo user = (UserVo) session.getAttribute("user"); if(user != null) {
		 * map.put("auctionBoardNo", auctionBoardNo); map.put("userNo",
		 * user.getUserNo()); }
		 * 
		 *  
		 * String canc = "N";
		 * ScrapVo sc = aboard_dao.selectOne(map); if(sc != null) { canc =
		 * sc.getCancelAt(); }
		 */
		
		model.addAttribute("vo", vo);
		model.addAttribute("mostViewList", mostViewList);
		/* model.addAttribute("canc", canc); */
		
		return "main/a_board";
	}

	// 경매글 작성
	@RequestMapping("/a_board_insert_form.do")
	public String a_board_insert_form(Model model) {

		List<CategoryVo> category_list = category_dao.selectList();

		model.addAttribute("category_list", category_list);

		return "main/a_board_insert_form";
	}

	@RequestMapping(value = "/d_category_list.do", produces = "application/json;charset=utf-8;")
	@ResponseBody
	public String d_category_list(int categoryNo) {

		List<DetailCategoryVo> d_category_list = d_category_dao.selectList(categoryNo);

		JSONArray jsonArray = new JSONArray();
		for (DetailCategoryVo dCategoryVo : d_category_list) {

			JSONObject json = new JSONObject();
			json.put("d_categoryNo", dCategoryVo.getD_categoryNo());
			json.put("d_categoryName", dCategoryVo.getD_categoryName());

			jsonArray.put(json);

		}

		return jsonArray.toString();
	}

	@RequestMapping("/a_board_insert.do")
	public String a_board_insert(AboardVo vo, @RequestParam(name = "photo") MultipartFile photo, RedirectAttributes ra)
			throws Exception, IOException {

		UserVo user = (UserVo) session.getAttribute("user");

		//System.out.println(user.getUserNo());

		// session timeout
		if (user == null) {

			return "redirect:login_form.do";
		}
		
		// 파일업로드
		String absPath = application.getRealPath("resources/images/");

		String pImage = "no_file";
		System.out.println("photo = "+photo);
		System.out.println("absPath = "+absPath);
		 if (!photo.isEmpty()) {
		 
		 //업로드 파일이름 얻어오기 
		 pImage = photo.getOriginalFilename();
		 
		 File f = new File(absPath, pImage);
		 
		 if (f.exists()) { // 저장경로에 동일한 화일이 존재하면=>다른이름을 파일명 변경 // 변경파일명 = 시간_원래파일명
		 long tm = System.currentTimeMillis(); 
		 pImage = String.format("%d_%s", tm, pImage);
		 System.out.println("photo if 후 pImage" + pImage);
		 f = new File(absPath, pImage); }
		 
		 // 임시파일=>내가 지정한 위치로 복사 
		 photo.transferTo(f);
		 System.out.println("photo if 진행 후 photo = " + photo);
		 }
		 
		// 업로드된 파일이름
		vo.setpImage(pImage);

		vo.setUserNo(user.getUserNo());

		String pDesc = vo.getpDesc().replaceAll("\n", "<br>");
		vo.setpDesc(pDesc);
		System.out.println(vo.getpImage());
		int res = product_dao.insertProduct(vo);

		int pNo = product_dao.selectMaxPNo();

		vo.setpNo(pNo);

		res = bid_dao.insertBid(vo);

		res = aboard_dao.insertAboard(vo);

		return "redirect:auction.do";
	}


	// 게시물 삭제
	@RequestMapping("/aboard_delete.do")
	public String a_board_delete(int auctionBoardNo) {

		int res = aboard_dao.deleteAboard(auctionBoardNo);

		return "redirect:auction.do";
	}

	// 자유 게시판 이동
	@RequestMapping("/freetalk.do")
	public String freetalk() {
		return "board/freetalk";
	}

	@RequestMapping("/scrap.do")
	public String scrap(ScrapVo vo) {
	    if (vo == null) {
	        throw new IllegalArgumentException("ScrapVo 객체는 null일 수 없습니다.");
	    }

	    int res = 0;
	    String cancelAt = vo.getCancelAt();  // 초기 값 저장
	    
	    // 초기 map 구성
	    Map<String, Object> map = new HashMap<>();
	    map.put("auctionBoardNo", vo.getAuctionBoardNo());
	    map.put("userNo", vo.getUserNo());
	    
	    System.out.println(vo.getAuctionBoardNo());
	    System.out.println(vo.getUserNo());
	    System.out.println(vo.getCancelAt());
	    
	    // 데이터베이스에서 ScrapVo 조회
	    ScrapVo existingVo = aboard_dao.selectOne(vo);
	    
	    if (existingVo == null) {
	        // ScrapVo가 존재하지 않으면 삽입
	        res = aboard_dao.insertScrap(map);
	        // 새로 삽입한 후에 다시 조회
	        existingVo = aboard_dao.selectOne(vo);
	        if (existingVo == null) {
	            // 삽입 후에도 ScrapVo가 조회되지 않으면 예외 처리
	            throw new IllegalStateException("ScrapVo를 삽입 후 다시 조회했으나 여전히 null입니다.");
	        }
	    }

	    // 기존 ScrapVo가 존재할 경우
	    existingVo.setCancelAt(cancelAt);
	    res = aboard_dao.update_cancelAt(existingVo);
	    
	    return "redirect:a_board.do?auctionBoardNo=" + existingVo.getAuctionBoardNo();
	}
	// 문의 페이지 이동
//	@RequestMapping("/qna.do")
//	public String qna() {
//		return "qna/qna";
//	}

}
