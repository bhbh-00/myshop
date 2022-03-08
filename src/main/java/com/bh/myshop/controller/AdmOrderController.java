package com.bh.myshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartRequest;

import com.bh.myshop.dto.Delivery;
import com.bh.myshop.dto.GenFile;
import com.bh.myshop.dto.Order;
import com.bh.myshop.dto.Product;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.service.GenFileService;
import com.bh.myshop.service.OrderService;

@Controller
public class AdmOrderController extends BaseController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private GenFileService genFileService;

	// 회원 리스트
	@RequestMapping("/adm/order/list")
	public String showList(HttpServletRequest req, @RequestParam Map<String, Object> param,
			@RequestParam(defaultValue = "1") int page) {

		String searchKeywordType = (String) param.get("searchKeywordType");

		String searchKeyword = (String) param.get("searchKeyword");

		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "regDate";
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

		// 한 페이지에 포함 되는 게시물의 갯수
		int itemsInAPage = 20;

		// 총 게시물의 갯수를 구하는
		int totleItemsCount = orderService.getOrderTotleCount(searchKeywordType, searchKeyword);

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

		List<Order> orders = orderService.getForPrintOrders(searchKeywordType, searchKeyword, itemsInAPage,
				itemsInAPage, param);

		req.setAttribute("totleItemsCount", totleItemsCount);
		req.setAttribute("totlePage", totlePage);
		req.setAttribute("pageMenuArmSize", pageMenuArmSize);
		req.setAttribute("pageMenuStrat", pageMenuStrat);
		req.setAttribute("pageMenuEnd", pageMenuEnd);
		req.setAttribute("page", page);
		req.setAttribute("orders", orders);

		return "adm/order/list";
	}

	// 내 게시물 보기
	@RequestMapping("/adm/order/myList")
	public String showMyList(HttpServletRequest req, @RequestParam(defaultValue = "1") int page) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		List<Order> orders = orderService.getForPrintOrdersByMemberId(loginMemberId);

		// 한 페이지에 포함 되는 게시물의 갯수
		int itemsInAPage = 20;

		// 총 게시물의 갯수를 구하는
		int totleItemsCount = orderService.getOrdersTotleCountByMyList(loginMemberId);

		orders = orderService.getForPrintOrdersByMyList(loginMemberId, page, itemsInAPage);

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
		req.setAttribute("orders", orders);

		return "/adm/order/myList";
	}

	@RequestMapping("/adm/order/history")
	public String Showhistory(@RequestParam Integer id, HttpServletRequest req) {

		if (id == 0) {
			return msgAndBack(req, "구매내역 번호를 입력해주세요.");
		}

		Order orderHistory = orderService.getForPrintOrderHistory(id);

		Product orderProduct = orderService.getForPrintOrderProduct(id);

		Delivery orderDelivery = orderService.getForPrintOrderDelivery(id);

		req.setAttribute("order", orderHistory);
		req.setAttribute("product", orderProduct);
		req.setAttribute("delivery", orderDelivery);

		return "/adm/order/history";
	}

	@RequestMapping("/adm/order/product")
	public String ShowProduct(@RequestParam Integer productId, HttpServletRequest req) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (productId == 0) {
			return msgAndBack(req, "제품 번호를 입력해주세요.");
		}

		Product product = orderService.getForPrintProduct(productId);

		List<GenFile> files = genFileService.getGenFiles("product", product.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		product.getExtraNotNull().put("file__common__attachment", filesMap);

		req.setAttribute("loginMemberId", loginMemberId);
		req.setAttribute("product", product);

		return "/adm/order/product";
	}

	@RequestMapping("/adm/order/add")
	public String ShowAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		return "/adm/order/add";

	}

	// 주문하기
	@RequestMapping("/adm/order/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("orderName") == null) {
			return msgAndBack(req, "이름을 입력해주세요.");
		}

		if (param.get("cellphoneNo") == null) {
			return msgAndBack(req, "연락처을 입력해주세요.");
		}

		if (param.get("address") == null) {
			return msgAndBack(req, "주소을 입력해주세요.");
		}

		if (param.get("email") == null) {
			return msgAndBack(req, "이메일을 입력해주세요.");
		}

		if (param.get("payment") == null) {
			return msgAndBack(req, "결제 방식을 선택해주세요.");
		}

		param.put("memberId", loginMemberId);

		ResultData addOrderRd = orderService.doAdd(param);

		int newOrderId = (int) addOrderRd.getBody().get("id");

		return msgAndReplace(req, String.format("주문이 완료 되었습니다.(%d)", newOrderId), "../order/history?id=" + newOrderId);
	}

}
