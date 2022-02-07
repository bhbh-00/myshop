package com.bh.myshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import com.bh.myshop.dto.Board;
import com.bh.myshop.dto.GenFile;
import com.bh.myshop.dto.Like;
import com.bh.myshop.dto.Member;
import com.bh.myshop.dto.Product;
import com.bh.myshop.dto.Reply;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.service.GenFileService;
import com.bh.myshop.service.LikeService;
import com.bh.myshop.service.ProductService;
import com.bh.myshop.service.ReplyService;
import com.bh.myshop.util.Util;

@Controller
public class AdmProductController extends BaseController {
	@Autowired
	private ProductService productService;
	
	@Autowired
	private GenFileService genFileService;
	
	@Autowired
	private LikeService likeService;
	
	@Autowired
	private ReplyService replyService;

	@RequestMapping("/adm/product/modify")
	public String ShowModify(Integer id, HttpServletRequest req) {

		if (id == null) {
			return msgAndBack(req, "상품 번호를 입력해주세요.");
		}

		Product product = productService.getForPrintproduct(id);

		if (product == null) {
			return msgAndBack(req, "해당 상품은 존재하지 않습니다.");
		}

		List<GenFile> files = genFileService.getGenFiles("product", product.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		product.getExtraNotNull().put("file__common__attachment", filesMap);
		req.setAttribute("product", product);

		return "/adm/product/modify";
	}
	
	// 상품 수정
	@RequestMapping("/adm/product/doModify")
	@ResponseBody
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req) {

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		int id = Util.getAsInt(param.get("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "상품 번호를 입력해주세요.");
		}

		if (Util.isEmpty(param.get("name"))) {
			return msgAndBack(req, "제품명을 입력해주세요.");
		}

		if (Util.isEmpty(param.get("body"))) {
			return msgAndBack(req, "내용을 입력해주세요.");
		}

		Product product = productService.getproduct(id);

		if (product == null) {
			return msgAndBack(req, "해당 상품은 존재하지 않습니다.");
		}

		ResultData actorCanModifyRd = productService.getActorCanModifyRd(product, loginedMember);

		if (actorCanModifyRd.isFail()) {
			return Util.msgAndReplace(actorCanModifyRd.getMsg(), "../product/detail?id=" + product.getId());
		}

		ResultData modifyproductRd = productService.modify(param);
		String redirectUrl = "../product/detail?id=" + product.getId();

		return Util.msgAndReplace(modifyproductRd.getMsg(), redirectUrl);
	}
	
	// 상품 삭제
	@RequestMapping("/adm/product/doDelete")
	@ResponseBody
	public String doDelete(Integer id, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		if (id == null) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		Product product = productService.getproduct(id);

		if (product == null) {
			return msgAndBack(req, "해당 상품은 존재하지 않습니다.");
		}

		ResultData actorCanDeleteRd = productService.getActorCanDeleteRd(product, loginedMember);

		if (actorCanDeleteRd.isFail()) {
			return Util.msgAndReplace(actorCanDeleteRd.getMsg(), "../product/detail?id=" + product.getId());
		}

		ResultData deleteMemberRd = productService.delete(id);
		String redirectUrl = "../product/list";

		return Util.msgAndReplace(deleteMemberRd.getMsg(), redirectUrl);
	}

	@RequestMapping("/adm/product/add")
	public String ShowAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		return "/adm/product/add";

	}
	
	// 상품 작성
	@RequestMapping("/adm/product/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {
		// String name, String body이 null이면 내용이 없는 거!!

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		/*
		 * HttpSession 말고 Http서블릿리쿼스트 req로 바꿔주기 Util.getAsInt 필요 없음 (int로 형변환 필요함)
		 * !!로그인과 회원가입은 세션이 필요함
		 */

		if (param.get("name") == null) {
			return msgAndBack(req, "제품명을 입력해주세요.");
		}

		if (param.get("body") == null) {
			return msgAndBack(req, "내용을 입력해주세요.");
		}

		param.put("memberId", loginMemberId);

		ResultData addproductRd = productService.doAdd(param);

		int newproductId = (int) addproductRd.getBody().get("id");

		return msgAndReplace(req, String.format("%d번 상품이 작성되었습니다.", newproductId),
				"../product/detail?id=" + newproductId);
	}
	
	// 상품 상세보기
	@RequestMapping("/adm/product/detail")
	public String showDetail(HttpServletRequest req, Integer id) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (id == null) {
			return msgAndBack(req, "상품 번호를 입력해주세요.");
		}

		Product product = productService.getForPrintproduct(id);

		if (product == null) {
			return msgAndBack(req, "해당 상품은 존재하지 않습니다.");
		}

		List<GenFile> files = genFileService.getGenFiles("product", product.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		Like like = likeService.getLikeByproduct(id);

		int totleItemsCountByLike = likeService.getLikeTotleCountByproduct(id);

		List<Reply> replys = replyService.getForPrintReplies(id);

		product.getExtraNotNull().put("file__common__attachment", filesMap);
		req.setAttribute("product", product);
		req.setAttribute("replys", replys);
		req.setAttribute("like", like);
		req.setAttribute("totleItemsCountByLike", totleItemsCountByLike);
		req.setAttribute("loginMemberId", loginMemberId);

		return "/adm/product/detail";
	}
	
	// 상품 리스트
	@RequestMapping("/adm/product/list")
	// @ResponseBody가 없으면 return /adm/product/list.jps로 가야함
	public String showList(HttpServletRequest req, @RequestParam(defaultValue = "1") int boardId,
			String searchKeywordType, String searchKeyword, @RequestParam(defaultValue = "1") int page) {
		// @RequestParam(defaultValue = "1") -> page를 입력하지 않아도 1page가 되도록

		Board board = productService.getBoard(boardId);

		req.setAttribute("board", board);

		if (board == null) {
			return msgAndBack(req, "해당 상품은 존재하지 않습니다.");
		}

		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "nameAndBody";
		}

		if (searchKeyword != null && searchKeyword.length() == 0) {
			searchKeyword = null;
		}

		if (searchKeyword != null) {
			searchKeyword = searchKeyword.trim();
		}

		if (searchKeyword == null) {
			searchKeywordType = null;
		}

		// 한 페이지에 포함 되는 상품의 갯수
		int itemsInAPage = 30;

		// 총 상품의 갯수를 구하는
		int totleItemsCount = productService.getproductsTotleCount(boardId, searchKeywordType, searchKeyword);

		List<Product> products = productService.getForPrintproducts(boardId, searchKeywordType, searchKeyword, page,
				itemsInAPage);

		// 총 페이지 갯수 (총 상품 수 / 한 페이지 안의 상품 갯수)
		int totlePage = (int) Math.ceil(totleItemsCount / (double) itemsInAPage);

		/*
		 * 반지름이라고 생각하면 됌. 현재 페이지가 10일 때 pageMenuArmSize가 5이면 10을 기준으로 왼쪽은 4 5 6 7 8 9 10
		 * 오른쪽은 10 11 12 13 14 15 16 페이지네이션의 총 갯수는 11 (기준인 10도 포함 해야함)
		 */
		int pageMenuArmSize = 5;

		// 시작 페이지 번호
		int pageMenuStrat = page - pageMenuArmSize;

		// 시작 페이지가 1보다 작다면 시작 페이지는 1
		if (pageMenuStrat < 1) {
			pageMenuStrat = 1;
		}

		// 끝 페이지 페이지 번호
		int pageMenuEnd = page + pageMenuArmSize;

		if (pageMenuEnd > totlePage) {
			pageMenuEnd = totlePage;
		}

		// req.setAttribute( "" , ) -> 이게 있어야지 jsp에서 뜸!
		req.setAttribute("totleItemsCount", totleItemsCount);
		req.setAttribute("totlePage", totlePage);
		req.setAttribute("pageMenuArmSize", pageMenuArmSize);
		req.setAttribute("pageMenuStrat", pageMenuStrat);
		req.setAttribute("pageMenuEnd", pageMenuEnd);
		req.setAttribute("page", page);
		req.setAttribute("products", products);

		return "/adm/product/list";
	}

}
