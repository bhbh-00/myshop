package com.bh.myshop.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bh.myshop.dto.Cart;
import com.bh.myshop.dto.Product;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.service.CartService;
import com.bh.myshop.util.Util;

@Controller
public class UsrCartController extends BaseController {
	@Autowired
	private CartService cartService;
	
	// 내 게시물 보기
	@RequestMapping("/usr/cart/myList")
	public String showMyList(HttpServletRequest req, @RequestParam(defaultValue = "1") int page) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");
		
		List<Product> products = cartService.getForPrintCartsByProduct(loginMemberId);

		List<Cart> cartrs = cartService.getForPrintCartsByMemberId(loginMemberId);

		// 한 페이지에 포함 되는 게시물의 갯수
		int itemsInAPage = 20;

		// 총 게시물의 갯수를 구하는
		int totleItemsCount = cartService.getCartsTotleCountByMyList(loginMemberId);

		cartrs = cartService.getForPrintCartsByMyList(loginMemberId, page, itemsInAPage);

		// 총 페이지 갯수 (총 게시물 수 / 한 페이지 안의 게시물 갯수)
		int totlePage = (int) Math.ceil(totleItemsCount / (double) itemsInAPage);

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
		req.setAttribute("cartrs", cartrs);
		req.setAttribute("products", products);

		return "/usr/cart/myList";
	}


	// 좋아요 취소
	@RequestMapping("/usr/cart/doDelete")
	@ResponseBody
	public String doDelete(@RequestParam Map<String, Object> param, HttpServletRequest req, String redirectUrl) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("relTypeCode") == null) {
			return msgAndBack(req, "relTypeCode를 입력해주세요.");
		}

		if (param.get("relId") == null) {
			return msgAndBack(req, "relId를 입력해주세요.");
		}

		req.setAttribute("loginMemberId", loginMemberId);

		ResultData dodeleteRd = cartService.delete(param);

		return Util.msgAndReplace(dodeleteRd.getMsg(), redirectUrl);
	}

	// 좋아요
	@RequestMapping("/usr/cart/doAdd")
	@ResponseBody
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req, String redirectUrl) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("relTypeCode") == null) {
			return msgAndBack(req, "relTypeCode를 입력해주세요.");
		}

		if (param.get("relId") == null) {
			return msgAndBack(req, "relId를 입력해주세요.");
		}

		param.put("memberId", loginMemberId);

		ResultData doAddRd = cartService.doAdd(param);

		return Util.msgAndReplace(doAddRd.getMsg(), redirectUrl);
	}
}
