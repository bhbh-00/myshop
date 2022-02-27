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

import com.bh.myshop.dto.Category;
import com.bh.myshop.dto.GenFile;
import com.bh.myshop.dto.Like;
import com.bh.myshop.dto.Member;
import com.bh.myshop.dto.Product;
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

	@RequestMapping("/adm/product/page")
	public String Page(HttpServletRequest req) {

		return "/adm/product/page";
	}

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

		if (Util.isEmpty(param.get("productName"))) {
			return msgAndBack(req, "제품명을 입력해주세요.");
		}

		if (Util.isEmpty(param.get("body"))) {
			return msgAndBack(req, "내용을 입력해주세요.");
		}

		if (Util.isEmpty(param.get("color"))) {
			return msgAndBack(req, "색상을 입력해주세요.");
		}

		if (Util.isEmpty(param.get("price"))) {
			return msgAndBack(req, "가격을 입력해주세요.");
		}

		if (Util.isEmpty(param.get("fee"))) {
			return msgAndBack(req, "배송비를 입력해주세요.");
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

	// 상품명 생성의 조건
	@RequestMapping("/adm/product/getNameDup")
	@ResponseBody
	public ResultData getNameDup(String productName) {

		if (productName == null) {
			return new ResultData("F-1", "상품명을 입력해주세요.");
		}

		// 기존의 상품명 확인
		Product existingpProduct = productService.getProductByName(productName);

		if (existingpProduct != null) {
			return new ResultData("F-2", String.format("%s(은)는 이미 사용중인 상품 명 입니다.", productName));
		}

		return new ResultData("S-1", String.format("%s(은)는 사용가능한 상품명 입니다.", productName), "productName", productName);
	}

	// 상품 등록
	@RequestMapping("/adm/product/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("productName") == null) {
			return msgAndBack(req, "상품명을 입력해주세요.");
		}

		Product existingProduct = productService.getProductByName((String) param.get("productName"));

		if (existingProduct != null) {
			return Util.msgAndBack("이미 사용 중인 아이디입니다.");
		}

		if (param.get("body") == null) {
			return msgAndBack(req, "상품설명을 입력해주세요.");
		}

		if (param.get("color") == null) {
			return msgAndBack(req, "색상을 입력해주세요.");
		}

		if (param.get("price") == null) {
			return msgAndBack(req, "가격을 입력해주세요.");
		}

		if (param.get("fee") == null) {
			return msgAndBack(req, "배송비을 입력해주세요.");
		}

		param.put("memberId", loginMemberId);

		ResultData addProductRd = productService.doAdd(param);

		int newProductId = (int) addProductRd.getBody().get("id");

		return msgAndReplace(req, String.format("%d번 상품이 등록되었습니다.", newProductId),
				"../product/detail?id=" + newProductId);
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
		
		Like like = likeService.getLike("product", product.getId());
		// http://localhost:8021/adm/like/dolike?relTypeCode=product&relId=1&memberId=1

		product.getExtraNotNull().put("file__common__attachment", filesMap);
		req.setAttribute("product", product);
		req.setAttribute("like", like);
		req.setAttribute("loginMemberId", loginMemberId);

		return "/adm/product/detail";
	}

	// 상품 리스트
	@RequestMapping("/adm/product/list")
	public String showList(HttpServletRequest req, @RequestParam(defaultValue = "1") int categoryId,
			String searchKeywordType, String searchKeyword, @RequestParam(defaultValue = "1") int page) {

		Category category = productService.getCategory(categoryId);

		req.setAttribute("category", category);

		if (category == null) {
			return msgAndBack(req, "해당 상품은 존재하지 않습니다.");
		}

		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "productNameAndBodyAndColorAndPriceAndFee";
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
		int totleItemsCount = productService.getproductsTotleCount(categoryId, searchKeywordType, searchKeyword);

		List<Product> products = productService.getForPrintproducts(categoryId, searchKeywordType, searchKeyword, page,
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
