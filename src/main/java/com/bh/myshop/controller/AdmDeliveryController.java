package com.bh.myshop.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartRequest;

import com.bh.myshop.dto.ResultData;
import com.bh.myshop.service.DeliveryService;

@Controller
public class AdmDeliveryController extends BaseController {
	@Autowired
	private DeliveryService deliveryService;

	@RequestMapping("/adm/delivery/add")
	public String ShowAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		return "/adm/delivery/add";

	}

	// 배송상태
	@RequestMapping("/adm/delivery/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("company") == null) {
			return msgAndBack(req, "택배사를 입력해주세요.");
		}

		if (param.get("waybillNum") == null) {
			return msgAndBack(req, "운송장번호를 입력해주세요.");
		}

		param.put("memberId", loginMemberId);

		ResultData addDeliveryRd = deliveryService.doAdd(param);

		int newDeliveryId = (int) addDeliveryRd.getBody().get("id");

		return msgAndReplace(req, String.format("배송정보가 등록 되었습니다.(%d)", newDeliveryId), "../delivery/list");
	}

}
