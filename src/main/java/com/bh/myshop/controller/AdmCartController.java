package com.bh.myshop.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bh.myshop.dto.ResultData;
import com.bh.myshop.service.CartService;
import com.bh.myshop.service.LikeService;
import com.bh.myshop.util.Util;

@Controller
public class AdmCartController extends BaseController {
	@Autowired
	private CartService cartService;
	
	// 좋아요 취소
	@RequestMapping("/adm/cart/doDelete")
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
	@RequestMapping("/adm/cart/doAdd")
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
