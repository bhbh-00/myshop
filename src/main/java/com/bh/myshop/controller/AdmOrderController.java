package com.bh.myshop.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartRequest;

import com.bh.myshop.dto.ResultData;
import com.bh.myshop.service.OrderService;

@Controller
public class AdmOrderController extends BaseController {

	@Autowired
	private OrderService orderService;

	@RequestMapping("/adm/order/add")
	public String ShowAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		return "/adm/order/add";

	}

	// 상품 등록
	@RequestMapping("/adm/order/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("name") == null) {
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

		return msgAndReplace(req, String.format("주문이 완료 되었습니다.(%d)", newOrderId),
				"../order/detail?id=" + newOrderId);
	}

}
