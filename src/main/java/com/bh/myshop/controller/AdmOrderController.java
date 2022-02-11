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
import com.bh.myshop.dto.Member;
import com.bh.myshop.dto.Order;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.service.GenFileService;
import com.bh.myshop.service.OrderService;
import com.bh.myshop.util.Util;

@Controller
public class AdmOrderController extends BaseController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private GenFileService genFileService;

	@RequestMapping("/adm/order/page")
	public String Page(HttpServletRequest req) {

		return "/adm/order/page";
	}

	@RequestMapping("/adm/order/modify")
	public String ShowModify(Integer id, HttpServletRequest req) {

		if (id == null) {
			return msgAndBack(req, "주문 번호를 입력해주세요.");
		}

		Order order = orderService.getForPrintorder(id);

		if (order == null) {
			return msgAndBack(req, "해당 주문은 존재하지 않습니다.");
		}

		List<GenFile> files = genFileService.getGenFiles("order", order.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		order.getExtraNotNull().put("file__common__attachment", filesMap);
		req.setAttribute("order", order);

		return "/adm/order/modify";
	}

	// 주문 수정
	@RequestMapping("/adm/order/doModify")
	@ResponseBody
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req) {

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		int id = Util.getAsInt(param.get("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "주문 번호를 입력해주세요.");
		}

		if (Util.isEmpty(param.get("name"))) {
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

		Order order = orderService.getorder(id);

		if (order == null) {
			return msgAndBack(req, "해당 주문은 존재하지 않습니다.");
		}

		ResultData actorCanModifyRd = orderService.getActorCanModifyRd(order, loginedMember);

		if (actorCanModifyRd.isFail()) {
			return Util.msgAndReplace(actorCanModifyRd.getMsg(), "../order/detail?id=" + order.getId());
		}

		ResultData modifyorderRd = orderService.modify(param);
		String redirectUrl = "../order/detail?id=" + order.getId();

		return Util.msgAndReplace(modifyorderRd.getMsg(), redirectUrl);
	}

	// 주문 삭제
	@RequestMapping("/adm/order/doDelete")
	@ResponseBody
	public String doDelete(Integer id, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		if (id == null) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		Order order = orderService.getorder(id);

		if (order == null) {
			return msgAndBack(req, "해당 주문은 존재하지 않습니다.");
		}

		ResultData actorCanDeleteRd = orderService.getActorCanDeleteRd(order, loginedMember);

		if (actorCanDeleteRd.isFail()) {
			return Util.msgAndReplace(actorCanDeleteRd.getMsg(), "../order/detail?id=" + order.getId());
		}

		ResultData deleteMemberRd = orderService.delete(id);
		String redirectUrl = "../order/list";

		return Util.msgAndReplace(deleteMemberRd.getMsg(), redirectUrl);
	}

	@RequestMapping("/adm/order/add")
	public String ShowAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		return "/adm/order/add";

	}

	// 주문명 생성의 조건
	@RequestMapping("/adm/order/getNameDup")
	@ResponseBody
	public ResultData getNameDup(String name) {

		if (name == null) {
			return new ResultData("F-1", "주문명을 입력해주세요.");
		}

		// 기존의 주문명 확인
		Order existingporder = orderService.getorderByName(name);

		if (existingporder != null) {
			return new ResultData("F-2", String.format("%s(은)는 이미 사용중인 주문 명 입니다.", name));
		}

		return new ResultData("S-1", String.format("%s(은)는 사용가능한 주문명 입니다.", name), "name", name);
	}

	// 주문 등록
	@RequestMapping("/adm/order/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("name") == null) {
			return msgAndBack(req, "주문명을 입력해주세요.");
		}
		
		Order existingorder = orderService.getorderByName((String) param.get("name"));

		if (existingorder != null) {
			return Util.msgAndBack("이미 사용 중인 아이디입니다.");
		}

		if (param.get("body") == null) {
			return msgAndBack(req, "주문설명을 입력해주세요.");
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

		ResultData addorderRd = orderService.doAdd(param);

		int neworderId = (int) addorderRd.getBody().get("id");

		return msgAndReplace(req, String.format("%d번 주문이 등록되었습니다.", neworderId),
				"../order/detail?id=" + neworderId);
	}

	// 주문 상세보기
	@RequestMapping("/adm/order/detail")
	public String showDetail(HttpServletRequest req, Integer id) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (id == null) {
			return msgAndBack(req, "주문 번호를 입력해주세요.");
		}

		Order order = orderService.getForPrintorder(id);

		if (order == null) {
			return msgAndBack(req, "해당 주문은 존재하지 않습니다.");
		}

		List<GenFile> files = genFileService.getGenFiles("order", order.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		order.getExtraNotNull().put("file__common__attachment", filesMap);
		req.setAttribute("order", order);
		req.setAttribute("loginMemberId", loginMemberId);

		return "/adm/order/detail";
	}

	// 주문 리스트
	@RequestMapping("/adm/order/list")
	public String showList(HttpServletRequest req, @RequestParam(defaultValue = "1") int categoryId,
			String searchKeywordType, String searchKeyword, @RequestParam(defaultValue = "1") int page) {

		Category category = orderService.getCategory(categoryId);

		req.setAttribute("category", category);

		if (category == null) {
			return msgAndBack(req, "해당 주문은 존재하지 않습니다.");
		}

		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "nameAndBodyAndColorAndPriceAndFee";
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

		// 한 페이지에 포함 되는 주문의 갯수
		int itemsInAPage = 30;

		// 총 주문의 갯수를 구하는
		int totleItemsCount = orderService.getordersTotleCount(categoryId, searchKeywordType, searchKeyword);

		List<Order> orders = orderService.getForPrintorders(categoryId, searchKeywordType, searchKeyword, page,
				itemsInAPage);

		// 총 페이지 갯수 (총 주문 수 / 한 페이지 안의 주문 갯수)
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
		req.setAttribute("orders", orders);

		return "/adm/order/list";
	}

}
