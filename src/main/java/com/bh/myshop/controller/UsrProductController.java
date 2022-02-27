package com.bh.myshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bh.myshop.dto.Category;
import com.bh.myshop.dto.GenFile;
import com.bh.myshop.dto.Like;
import com.bh.myshop.dto.Product;
import com.bh.myshop.dto.Reply;
import com.bh.myshop.service.GenFileService;
import com.bh.myshop.service.LikeService;
import com.bh.myshop.service.ProductService;
import com.bh.myshop.service.ReplyService;

@Controller
public class UsrProductController extends BaseController {

	@Autowired
	private ProductService productService;

	@Autowired
	private GenFileService genFileService;

	@Autowired
	private LikeService likeService;

	@Autowired
	private ReplyService replyService;

	// 상품 상세보기
	@RequestMapping("/usr/product/detail")
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
		int totleItemsCountByLike = likeService.getLikeTotleCount("product", product.getId());

		List<Reply> replys = replyService.getForPrintReplies(id);

		product.getExtraNotNull().put("file__common__attachment", filesMap);
		req.setAttribute("product", product);
		req.setAttribute("replys", replys);
		req.setAttribute("like", like);
		req.setAttribute("totleItemsCountByLike", totleItemsCountByLike);
		req.setAttribute("loginMemberId", loginMemberId);

		return "/usr/product/detail";
	}

	// 상품 리스트
	@RequestMapping("/usr/product/list")
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

		return "/usr/product/list";
	}

}
